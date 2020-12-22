package es.pernasferreiro.ml.clustering.aggregate;

import com.mongodb.spark.MongoSpark;
import es.pernasferreiro.ml.clustering.util.Parametros;
import org.apache.commons.lang3.StringUtils;
import org.apache.spark.SparkConf;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

import java.util.Properties;

public class LastVisitAggregate {
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
				conf.set("spark.mongodb.output.uri", urlMongo.toString());
				conf.set("spark.mongodb.output.collection", parametrosEntrada.getProperty("MONGO_COLL"));

				SparkSession session = SparkSession.builder().config(conf).getOrCreate();
				Dataset<Row> dataset = session.read().format("es").load(parametrosEntrada.getProperty("RESOURCE"));
				dataset.createOrReplaceTempView("visitas");

				// AGGREGATE
				String dateField = parametrosEntrada.getProperty("DATE_FIELD");
				String dateFrom = parametrosEntrada.getProperty("DATE_FROM");
				String dateTo = parametrosEntrada.getProperty("DATE_TO");

				StringBuilder sql = new StringBuilder(0);
				sql.append("SELECT VenueID, UserID, MAX(UTCTime) AS UTCTime ");
				sql.append("FROM visitas ");

				if (! StringUtils.isEmpty(dateFrom)) {
					sql.append("WHERE " + dateField + " >= CAST('" + dateFrom.trim() + "' AS TIMESTAMP) ");
				}

				if (! StringUtils.isEmpty(dateFrom) && ! StringUtils.isEmpty(dateTo) ) {
					sql.append("AND   " + dateField + " <= CAST('" + dateTo.trim() + "' AS TIMESTAMP) ");
				}

				sql.append("GROUP BY VenueID, UserID ");

				Dataset<Row> consulta = session.sql(sql.toString());
				Long totalResultados = consulta.count();
				Long numResultados = new Long(10);
				if (! StringUtils.isEmpty(parametrosEntrada.getProperty("NUM_RESULTS"))) {
					numResultados = Long.valueOf(parametrosEntrada.getProperty("NUM_RESULTS"));

					if (numResultados > totalResultados) {
						numResultados = totalResultados;
					}
				}
				else {
					if (totalResultados < 10) {
						numResultados = totalResultados;
					}
				}

				consulta.show(numResultados.intValue(), false);

				MongoSpark.save(consulta);
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
