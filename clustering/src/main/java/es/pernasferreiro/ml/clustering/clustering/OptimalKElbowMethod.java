package es.pernasferreiro.ml.clustering.clustering;

import com.mongodb.spark.MongoSpark;
import es.pernasferreiro.ml.clustering.util.Parametros;
import org.apache.commons.lang.StringUtils;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.mllib.clustering.KMeans;
import org.apache.spark.mllib.clustering.KMeansModel;
import org.apache.spark.mllib.linalg.Vector;
import org.apache.spark.mllib.linalg.Vectors;
import org.apache.spark.sql.*;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.StructField;
import org.apache.spark.sql.types.StructType;

import java.text.SimpleDateFormat;
import java.util.*;

import static org.apache.spark.sql.functions.col;

public class OptimalKElbowMethod {
	private static final StringBuilder CTE_ERR_MESSAGE = new StringBuilder()
			.append("ERROR: falta alguno de los parámetros: ")
			.append("       - ES_SERVER=<IP/Nombre del servidor de ES, por defecto elasticsearch>")
			.append("       - ES_PORT=<Puerto del servidor de ES, por defecto 9200>")
			.append("       - APP=<ID dentro de Spark como se identificará a este proceso de carga>")
			.append("       - RESOURCE=<indentificador de la colección de datos en ES>")
			.append("       - LOOPS=<Numero de vueltas a intentar>")
			.append("       - ITERATIONS=<Numero de iteraciones>")
			.append("       - VENUEID=<VenueID a tratar>")
			.append("       - MONGO_SERVER=<IP/Nombre del servidor de MongoDB>")
			.append("       - MONGO_PORT=<Puerto del servidor de MongoDB, por defecto el 27017>")
			.append("       - MONGO_DB=<BD destino en MongoDB>")
			.append("       - MONGO_COLL=<Collecion destino de la agregación en MongoDB>\n\n");

	public static void main(String[] args) {
		if (args.length > 0) {
			Properties parametrosEntrada = Parametros.getParametros(args);

			if (
				Parametros.existsParametrosObligatorios(
					new String[]{"RESOURCE", "LOOPS", "ITERATIONS", "MONGO_SERVER", "MONGO_PORT", "MONGO_DB", "MONGO_COLL" },
					parametrosEntrada)
			) {
				long inicioProceso = (new Date()).getTime();
				SparkConf conf = Parametros.setConfElastic(parametrosEntrada);

				StringBuilder urlMongo = new StringBuilder("mongodb://");
				urlMongo.append(parametrosEntrada.getProperty("MONGO_SERVER"));
				urlMongo.append(":");
				urlMongo.append(parametrosEntrada.getProperty("MONGO_PORT"));
				urlMongo.append("/");
				urlMongo.append(parametrosEntrada.getProperty("MONGO_DB"));

				conf.set("spark.mongodb.input.uri", urlMongo.toString());
				conf.set("spark.mongodb.input.collection", parametrosEntrada.getProperty("MONGO_COLL"));
				conf.set("spark.mongodb.output.uri", urlMongo.toString());

				String outputCollection = parametrosEntrada.getProperty("MONGO_COLL") +
						"_OptimalK_" +
						parametrosEntrada.getProperty("LOOPS") +
						"_" +
						parametrosEntrada.getProperty("ITERATIONS");
				conf.set("spark.mongodb.output.collection", outputCollection);

				SparkSession session = SparkSession.builder().config(conf).getOrCreate();
				Dataset<Row> dataset = MongoSpark.loadAndInferSchema(session);
				System.out.println("\n\n\t\tCount Total = " + dataset.count());

				if (! StringUtils.isEmpty(parametrosEntrada.getProperty("VENUEID"))) {
//				      dataset = dataset.filter(col("VenueID").equalTo("4b19f917f964a520abe623e3").or(col("VenueID").equalTo("4b0587a6f964a5203d9e22e3")).or(col("VenueID").equalTo("4b243a7df964a520356424e3")));
					dataset = dataset.filter(col("VenueID").equalTo(parametrosEntrada.getProperty("VENUEID").trim()));
					System.out.println("\n\n\t\tCount Filtrado = " + dataset.count());
				}

				JavaRDD<Vector> points = dataset.toJavaRDD().map(
						(in) -> Vectors.dense(new double[] { in.getLong(in.fieldIndex("VisitasTotales")) })
				).cache();

				List<StructField> fieldList = new ArrayList<>(0);
				fieldList.add(DataTypes.createStructField("k",DataTypes.IntegerType,false));
				fieldList.add(DataTypes.createStructField("it",DataTypes.IntegerType,false));
				fieldList.add(DataTypes.createStructField("bestOf",DataTypes.IntegerType,false));
				fieldList.add(DataTypes.createStructField("model",DataTypes.StringType,false));
				fieldList.add(DataTypes.createStructField("ComputeCost",DataTypes.DoubleType,false));
				fieldList.add(DataTypes.createStructField("TrainingCost",DataTypes.DoubleType,false));
				fieldList.add(DataTypes.createStructField("DistanceMeasure",DataTypes.StringType,false));
				fieldList.add(DataTypes.createStructField("FormatVersion",DataTypes.StringType,false));
				fieldList.add(DataTypes.createStructField("numClusters", DataTypes.IntegerType,false));
				fieldList.add(DataTypes.createStructField("duration",DataTypes.LongType,false));
				fieldList.add(DataTypes.createStructField("timestamp",DataTypes.StringType,false));
				fieldList.add(DataTypes.createStructField("countData",DataTypes.LongType,false));
				StructType schema = DataTypes.createStructType(fieldList);

				Dataset<Row> resultadosDS = session.emptyDataFrame();
				int maxLoops = Integer.valueOf(parametrosEntrada.getProperty("LOOPS"));
				int it = Integer.valueOf(parametrosEntrada.getProperty("ITERATIONS"));
				int bestOf = 2;
				List<Row> resultados = new ArrayList<>(0);
				for (int k = 1; k <= maxLoops; k ++) {
					long inicio = (new Date()).getTime();
					KMeansModel model = KMeans.train(points.rdd(), k, it);
					long fin = (new Date()).getTime();
					long duracion = fin - inicio;
					resultados.add(RowFactory.create(
							k,
							it,
							bestOf,
							"K_MEANS_PARALLEL",
							model.computeCost(points.rdd()),
							model.trainingCost(),
							model.distanceMeasure(),
							model.formatVersion(),
							model.clusterCenters().length,
							duracion,
							(new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date())),
							dataset.count()
					));

					resultadosDS = session.createDataFrame(resultados, schema);
					MongoSpark.save(resultadosDS);

					resultadosDS = session.emptyDataFrame();
					resultados = new ArrayList<>(0);
				}

				session.stop();
				session.close();

				long finProceso = (new Date()).getTime();
				System.out.println("FIN OptimalKElbowMethod, tiempo = " + (finProceso - inicioProceso) + " ms.");
			} // then parametrosObligatorios
			else {
				Parametros.printError(CTE_ERR_MESSAGE);

				System.exit(-666);
			}
		} // then args
		else {
			Parametros.printError(CTE_ERR_MESSAGE);

			System.exit(-666);
		}
	}
}
