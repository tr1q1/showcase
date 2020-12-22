package es.pernasferreiro.ml.clustering.clustering;

import com.mongodb.spark.MongoSpark;
import es.pernasferreiro.ml.clustering.util.Parametros;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.mllib.clustering.KMeans;
import org.apache.spark.mllib.clustering.KMeansModel;
import org.apache.spark.mllib.linalg.Vector;
import org.apache.spark.mllib.linalg.Vectors;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.RowFactory;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.StructField;
import org.apache.spark.sql.types.StructType;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import static org.apache.spark.sql.functions.col;

public class TrainModelOptimalK {
	private static final StringBuilder CTE_ERR_MESSAGE = new StringBuilder()
			.append("ERROR: falta alguno de los parámetros: ")
			.append("       - ES_SERVER=<IP/Nombre del servidor de ES, por defecto elasticsearch>")
			.append("       - ES_PORT=<Puerto del servidor de ES, por defecto 9200>")
			.append("       - APP=<ID dentro de Spark como se identificará a este proceso de carga>")
			.append("       - RESOURCE=<indentificador de la colección de datos en ES>")
			.append("       - K=<Numero de vueltas a intentar>")
			.append("       - ITERATIONS=<Numero de iteraciones>")
			.append("       - SAVE_RESULTS_FILE=<Guardar en ficheros .CSV y .PARQUET los resultados>")
			.append("       - FIELD_IDS=<Campo de selección>")
			.append("       - IDS=<3 IDS para entrenar el modelo a generar>")
			.append("       - MONGO_SERVER=<IP/Nombre del servidor de MongoDB>")
			.append("       - MONGO_PORT=<Puerto del servidor de MongoDB, por defecto el 27017>")
			.append("       - MONGO_DB=<BD destino en MongoDB>")
			.append("       - MONGO_COLL=<Collecion destino de la agregación en MongoDB>\n\n");

	public static void main(String[] args) {
		if (args.length > 0) {
			Properties parametrosEntrada = Parametros.getParametros(args);

			if (
				Parametros.existsParametrosObligatorios(
					new String[]{"RESOURCE", "FIELD_IDS", "IDS", "K", "ITERATIONS", "MONGO_SERVER", "MONGO_PORT", "MONGO_DB", "MONGO_COLL" },
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

				String outputCollection = parametrosEntrada.getProperty("MONGO_COLL") + "_MODELO";
				conf.set("spark.mongodb.output.collection", outputCollection);

				SparkSession session = SparkSession.builder().config(conf).getOrCreate();
				Dataset<Row> dataset = MongoSpark.loadAndInferSchema(session);
				System.out.println("\n\n\t\tCount Total = " + dataset.count());

				String fieldIdTrain = parametrosEntrada.getProperty("FIELD_IDS");
				String[] idsTrain = parametrosEntrada.getProperty("IDS").split(",");
				// lo entrenamos con las 3 VenueIDs de más visitas
				dataset = dataset.filter(
								col(fieldIdTrain).equalTo(idsTrain[0]).or(
								col(fieldIdTrain).equalTo(idsTrain[1])).or(
								col(fieldIdTrain).equalTo(idsTrain[2]))
				);
				System.out.println("\n\n\t\tCount Filtrado = " + dataset.count());

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
				int k = Integer.valueOf(parametrosEntrada.getProperty("K"));
				int it = Integer.valueOf(parametrosEntrada.getProperty("ITERATIONS"));
				int bestOf = 2;
				List<Row> resultados = new ArrayList<>(0);
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

				if ("S".equalsIgnoreCase(parametrosEntrada.getProperty("SAVE_RESULTS_FILE"))) {
					model.save(session.sparkContext(), "/tmp/data/model/" + outputCollection + "/");
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
