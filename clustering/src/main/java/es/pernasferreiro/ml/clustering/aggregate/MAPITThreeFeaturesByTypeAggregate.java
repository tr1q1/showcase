package es.pernasferreiro.ml.clustering.aggregate;

import com.mongodb.spark.MongoSpark;
import es.pernasferreiro.ml.clustering.util.Parametros;
import org.apache.spark.SparkConf;
import org.apache.spark.sql.*;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

public class MAPITThreeFeaturesByTypeAggregate {
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
			.append("       - DATE_FIELD=<Nombre del campo de tipo a fecha por el cual filtrar>")
			.append("       - DATE_FROM=<Fecha desde en formato 'YYYY-MM-DD'>")
			.append("       - DATE_TO=<Fecha hasta en formato 'YYYY-MM-DD'>\n\n");

	public static void main(String[] args) throws java.text.ParseException {
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

				conf.set("spark.sql.crossJoin.enabled", "true");

				conf.set("spark.mongodb.input.uri", urlMongo.toString());
				conf.set("spark.mongodb.output.uri", urlMongo.toString());

				// 4bf58dd8d48988d1e0931735 -- COFFEE_SHOP (16469)
				// 4bf58dd8d48988d16e941735 -- FAST_FOOD_RESTAURANT (8406)
				// 4bf58dd8d48988d129951735 -- TRAIN_STATION (197389)
				// 4bf58dd8d48988d104951735 -- CLOTHING_STORE (590)
				// 4bf58dd8d48988d1fd931735 -- SUBWAY (51014)
				// String IDagregacion = "'4bf58dd8d48988d1e0931735'"; String sufijo = "_" + "COFFEE_SHOP";
				// String IDagregacion = "'4bf58dd8d48988d16e941735'"; String sufijo = "_" + "FAST_FOOD_RESTAURANT";
				// String IDagregacion = "'4bf58dd8d48988d129951735'"; String sufijo = "_" + "TRAIN_STATION";
				// String IDagregacion = "'4bf58dd8d48988d104951735'"; String sufijo = "_" + "CLOTHING_STORE";
				String IDagregacion = "'4bf58dd8d48988d1fd931735'"; String sufijo = "_" + "SUBWAY";
				// String IDagregacion = "'4bf58dd8d48988d1ed931735'"; String sufijo = "_" + "AIRPORT";

				conf.set("spark.mongodb.output.collection", parametrosEntrada.getProperty("MONGO_COLL") + sufijo);

				SparkSession session = SparkSession.builder().config(conf).getOrCreate();
				Dataset<Row> dataset = session.read().format("es").load(parametrosEntrada.getProperty("RESOURCE"));
				dataset.createOrReplaceTempView("visitas_IN");
				dataset.createOrReplaceTempView("visitas_OUT");

				String dateField = parametrosEntrada.getProperty("DATE_FIELD");
				String dateFrom = parametrosEntrada.getProperty("DATE_FROM");
				String dateTo = parametrosEntrada.getProperty("DATE_TO");

				String startDate = "01-01-2014";
				DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
				java.sql.Timestamp startTime = new java.sql.Timestamp(((java.util.Date)df.parse(startDate)).getTime());
				StringBuilder sql = new StringBuilder(0);
				sql.append("SELECT A.VenueCategoryID, A.UserID, COUNT(*) AS VisitasTotales, ");
				sql.append("(DATEDIFF(TO_DATE('");
				sql.append(startTime);
				sql.append("'), MAX(A.UTCTimeFin))) AS DiasDesdeUltimaVisita, ");
				sql.append("AVG((unix_timestamp(A.UTCTimeFin) - unix_timestamp(B.UTCTime)) / 60) AS MediaDuracionVisita ");
				sql.append("FROM visitas_OUT AS A ");
				sql.append("INNER JOIN visitas_IN AS B ON B.Action = 'IN' ");
				sql.append("							AND B.VenueCategoryID = A.VenueCategoryID ");
				sql.append("							AND B.VenueID = A.VenueID ");
				sql.append("							AND B.UserID = A.UserID ");
				sql.append("							AND (date_format(A.UTCTimeFin, 'yyyy-MM-dd HH')) = (date_format(B.UTCTime, 'yyyy-MM-dd HH')) ");
// TODO:				sql.append("							AND B.UTCTime = A.UTCTime ");
				sql.append("WHERE A." + dateField + " >= CAST('" + dateFrom.trim() + "' AS TIMESTAMP) ");
				sql.append("AND   A." + dateField + " <= CAST('" + dateTo.trim() + "' AS TIMESTAMP) ");
				sql.append("AND A.Action = 'OUT' ");
				sql.append("AND A.VenueCategoryID = ");
				sql.append(IDagregacion);
				sql.append("GROUP BY A.VenueCategoryID, A.UserID ");

				Dataset<Row> resultados = dataset.sqlContext().sql(sql.toString());
				System.out.println("\n\n\t\tResultados RESULTADOS = " + resultados.count() + "\n\n");
				resultados.show(10, false);

				MongoSpark.save(resultados);
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
