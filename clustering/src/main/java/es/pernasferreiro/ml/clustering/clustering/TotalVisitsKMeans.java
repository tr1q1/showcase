package es.pernasferreiro.ml.clustering.clustering;

import com.mongodb.spark.MongoSpark;
import es.pernasferreiro.ml.clustering.util.Parametros;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.mllib.clustering.KMeansModel;
import org.apache.spark.mllib.linalg.Vector;
import org.apache.spark.mllib.linalg.Vectors;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;
import org.bson.Document;
import scala.Tuple2;

import java.text.SimpleDateFormat;
import java.util.*;

// calculo del cluster correspondiente para un conjunto de datos mediante KMeans
public class TotalVisitsKMeans {
	private static final StringBuilder CTE_ERR_MESSAGE = new StringBuilder()
			.append("ERROR: falta alguno de los parámetros: ")
			.append("       - ES_SERVER=<IP/Nombre del servidor de ES, por defecto elasticsearch>")
			.append("       - ES_PORT=<Puerto del servidor de ES, por defecto 9200>")
			.append("       - APP=<ID dentro de Spark como se identificará a este proceso de carga>")
			.append("       - RESOURCE=<indentificador de la colección de datos en ES>")
			.append("       - MONGO_SERVER=<IP/Nombre del servidor de MongoDB>")
			.append("       - MONGO_PORT=<Puerto del servidor de MongoDB, por defecto el 27017>")
			.append("       - MONGO_DB=<BD destino en MongoDB>")
			.append("       - MONGO_COLL=<Collecion destino de la agregación en MongoDB>")
			.append("       - K=<Valor a usar de K>")
			.append("       - ITERATIONS=<Número máximo de iteraciones a entrenar>")
			.append("       - MODEL=<Id del modelo ya entrenado a utilizar>\n\n");

	public static void main(String[] args) {
		if (args.length > 0) {
			Properties parametrosEntrada = Parametros.getParametros(args);

			if (
				Parametros.existsParametrosObligatorios(
					new String[]{"RESOURCE", "MODEL", "MONGO_SERVER", "MONGO_PORT", "MONGO_DB", "MONGO_COLL" },
					parametrosEntrada)
			) {
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
				conf.set("spark.mongodb.output.collection", parametrosEntrada.getProperty("MONGO_COLL") + "_" + (new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date())));

				SparkSession session = SparkSession.builder().config(conf).getOrCreate();
				Dataset<Row> dataset = MongoSpark.loadAndInferSchema(session);
				System.out.println("\n\n\t\tCount Total = " + dataset.count());

				JavaPairRDD<String, Vector> data = dataset.toJavaRDD().mapToPair(
						(in) -> {
							String par = in.getString(in.fieldIndex("VenueID")) + " " + in.getString(in.fieldIndex("UserID")) + " " + String.valueOf(in.getLong(in.fieldIndex("VisitasTotales")));
							Vector entities = Vectors.dense(new double[] { in.getLong(in.fieldIndex("VisitasTotales")) });

							return new Tuple2<>(par, entities);
						}
				).cache();

				KMeansModel model = KMeansModel.load(session.sparkContext(),"/tmp/data/model/" + parametrosEntrada.getProperty("MODEL"));
				JavaRDD<Document> clusteredData = data.map(
						(in) -> {
							Vector v = in._2;
							int cluster = model.predict(v);

							Document documento = new Document();
							String[] values = in._1.split(" ");
							documento.append("VenueID", values[0]);
							documento.append("UserID", values[1]);
							documento.append("VisitasTotales", Integer.valueOf(values[2]));
							documento.append("cluster", cluster);
							documento.append("timestamp", new Date());

							return documento;
						}
				).cache();

				MongoSpark.save(clusteredData);
				session.stop();
				session.close();
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
