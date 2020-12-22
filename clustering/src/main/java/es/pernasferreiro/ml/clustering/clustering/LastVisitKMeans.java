package es.pernasferreiro.ml.clustering.clustering;

import com.mongodb.spark.MongoSpark;
import es.pernasferreiro.ml.clustering.util.Parametros;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.mllib.clustering.KMeans;
import org.apache.spark.mllib.clustering.KMeansModel;
import org.apache.spark.mllib.feature.HashingTF;
import org.apache.spark.mllib.feature.IDF;
import org.apache.spark.mllib.feature.IDFModel;
import org.apache.spark.mllib.linalg.Vector;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;
import org.bson.Document;
import scala.Tuple2;

import java.text.SimpleDateFormat;
import java.util.*;

public class LastVisitKMeans {
	private static final StringBuilder CTE_ERR_MESSAGE = new StringBuilder()
			.append("ERROR: falta alguno de los parámetros: ")
			.append("       - ES_SERVER=<IP/Nombre del servidor de ES, por defecto elasticsearch>")
			.append("       - ES_PORT=<Puerto del servidor de ES, por defecto 9200>")
			.append("       - APP=<ID dentro de Spark como se identificará a este proceso de carga>")
			.append("       - RESOURCE=<indentificador de la colección de datos en ES>")
			.append("       - MONGO_SERVER=<IP/Nombre del servidor de MongoDB>")
			.append("       - MONGO_PORT=<Puerto del servidor de MongoDB, por defecto el 27017>")
			.append("       - MONGO_DB=<BD destino en MongoDB>")
			.append("       - MONGO_COLL=<Collecion destino de la agregación en MongoDB>\n\n");

	public static void main(String[] args) {
		if (args.length > 0) {
			Properties parametrosEntrada = Parametros.getParametros(args);

			if (
				Parametros.existsParametrosObligatorios(
					new String[]{"RESOURCE", "MONGO_SERVER", "MONGO_PORT", "MONGO_DB", "MONGO_COLL" },
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
				conf.set("spark.mongodb.output.collection", parametrosEntrada.getProperty("MONGO_COLL") + "_" + (new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())));

				SparkSession session = SparkSession.builder().config(conf).getOrCreate();
				Dataset<Row> dataset = MongoSpark.loadAndInferSchema(session);

				// TODO: CLUSTERING con K-Mean model
				HashingTF tf = new HashingTF(100); // TODO: a optimizar matemáticamente/estadísticamente
				JavaPairRDD<String, Vector> data = dataset.toJavaRDD().mapToPair(
						(in) -> {
							String par = in.getString(in.fieldIndex("VenueID")) + " " + in.getString(in.fieldIndex("UserID"));
							StringBuilder sb = new StringBuilder(0);
//							sb.append(in.getString(in.fieldIndex("VenueID")));
//							sb.append(" ");
							sb.append(in.getString(in.fieldIndex("UserID")));
							sb.append(" ");
							sb.append(String.valueOf(in.getTimestamp(in.fieldIndex("UTCTime"))));

							List<String> annotations = new ArrayList<String>();
							annotations.addAll(Arrays.asList(sb.toString().split(" ")));

							// Transform to a vector with tf as weights
							Vector entities = tf.transform(annotations);

							return new Tuple2<String, Vector>(par, entities);
						}
				).cache();

				JavaRDD<Vector> points = data.values();
				final IDFModel idf = new IDF().fit(points);

				// Transform to a vector with tf-idf as weights
				JavaRDD<Vector> idfVectors = idf.transform(points).cache();

				// Run Kmeans with K as 5, 100 iterations,  best of two runs, parallel kmeans++ to initialize centroids
				final KMeansModel model = KMeans.train(idfVectors.rdd(), 5, 100, 2, KMeans.K_MEANS_PARALLEL());
				double computeCost = model.computeCost(points.rdd());
				double trainingCost = model.trainingCost();
				String distanceMeasure = model.distanceMeasure();
				String formatVersion = model.formatVersion();

				// Predict the clusters and write the output to a file
				JavaRDD<Document> clusteredData = data.map(
						(in) -> {
							Vector v = in._2;
							Vector idfvec = idf.transform(v);
							int cluster = model.predict(idfvec);

							Document documento = new Document();
							String[] values = in._1.split(" ");
							documento.append("VenueID", values[0]);
							documento.append("UserID", values[1]);
//							documento.append("VisitasTotales", values[2]);
							documento.append("ComputeCost", computeCost);
							documento.append("TrainingCost", trainingCost);
							documento.append("DistanceMeasure", distanceMeasure);
							documento.append("FormatVersion", formatVersion);
							documento.append("cluster", cluster);

							return documento;
						}
					).cache();

				MongoSpark.save(clusteredData);
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
