package es.pernasferreiro.ml.clustering.load.es;

import es.pernasferreiro.ml.clustering.util.Parametros;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;
import org.elasticsearch.spark.rdd.api.java.JavaEsSpark;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

public class FromFileToES {
	private static final StringBuilder CTE_ERR_MESSAGE = new StringBuilder()
			.append("ERROR: falta alguno de los parámetros: ")
			.append("       - ES_SERVER=<IP/Nombre del servidor de ES, por defecto elasticsearch>")
			.append("       - ES_PORT=<Puerto del servidor de ES, por defecto 9200>")
			.append("       - FILE=<fichero a cargar>")
			.append("       - SCHEMA=<lista de campos del fichero>")
			.append("       - SCHEMA_TYPES=<lista de los tipos de dato correspondiente a los campos del fichero: string, int, dec, date>")
			.append("       - DATE_PATTERN=<patron de las fechas en el fichero>")
			.append("       - DATE_LOCALE=<locale de las fechas en el fichero>")
			.append("       - SEPARATOR=<caracter de separacion entre valores dentro del fichero de datos>")
			.append("       - APP=<ID dentro de Spark como se identificará a este proceso de carga>")
			.append("       - RESOURCE=<indentificador de la colección de datos en ES>\n\n");

	public static void main(String[] args) {
		if (args.length > 0) {
			Properties parametrosEntrada = Parametros.getParametros(args);

			if (Parametros.existsParametrosObligatorios(new String[] { "FILE", "SCHEMA", "SCHEMA_TYPES", "DATE_PATTERN", "DATE_LOCALE", "SEPARATOR", "RESOURCE" }, parametrosEntrada)) {
				SparkConf conf = Parametros.setConfElastic(parametrosEntrada);

				JavaSparkContext sc = new JavaSparkContext(conf);
				JavaRDD<String> textFile = sc.textFile(parametrosEntrada.getProperty("FILE"));

				String formatoFechas = parametrosEntrada.getProperty("DATE_PATTERN");
				String[] localeFechas = parametrosEntrada.getProperty("DATE_LOCALE").split("_");
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(formatoFechas, new Locale(localeFechas[0], localeFechas[1]));
				String[] schema = parametrosEntrada.getProperty("SCHEMA").split(",");
				String[] schemaTypes = parametrosEntrada.getProperty("SCHEMA_TYPES").split(",");

				JavaRDD<Map<String, ?>> fields = textFile.map(
						new Function<String, Map<String, ?>>() {
							private static final long serialVersionUID = 1L;

							public Map<String, ?> call(String line) throws Exception {
								try {
									Map<String, Object> elasticFields = new HashMap<>(0);
									String fieldSplit[] = line.split(parametrosEntrada.getProperty("SEPARATOR"));

									if (args[0].equalsIgnoreCase("-v")) {
										System.out.println("linea - " + line + " -------------------------------------------------------");
									}

									Random r = new Random();
									int min = 5;
									int max = 60;
									for (int i = 0; i < fieldSplit.length; i++) {
										if (args[0].equalsIgnoreCase("-v")) {
											System.out.println("valor - " + schema[i] + "(" + schemaTypes[i] + ")=" + fieldSplit[i]);
										}

										switch (schemaTypes[i]) {
											case "string":
												elasticFields.put(schema[i], fieldSplit[i]);
												break;
											case "int":
												elasticFields.put(schema[i], Integer.valueOf(fieldSplit[i]));
												break;
											case "dec":
												elasticFields.put(schema[i], new BigDecimal(fieldSplit[i]));
												break;
											case "date":
												elasticFields.put(schema[i], simpleDateFormat.parse(fieldSplit[i]));
// TODO: se añade esta linea para simular disponer de un campo de "checkout" del lugar visitado
												elasticFields.put("UTCTimeFin", DateUtils.addMinutes(simpleDateFormat.parse(fieldSplit[i]), r.nextInt((max - min) + 1) + min));
												break;
											default:
												elasticFields.put(schema[i], fieldSplit[i]);
												break;
										}
									} // for

									return elasticFields;
								}
								catch (Exception ex) {
									System.out.println("ERROR procesando los datos '" + line + "': " + ex.getMessage());

									return new HashMap<>(0);
								}
							}
						});

				if (args[0].equalsIgnoreCase("-v")) {
					System.out.println("Numero de datos a insertar en ES = " + fields.collect().size());
				}

				JavaEsSpark.saveToEs(fields, parametrosEntrada.getProperty("RESOURCE")); //, Parametros.setConfElastic(parametrosEntrada));
				sc.close();

				System.exit(0);
			}
			else {
				Parametros.printError(CTE_ERR_MESSAGE);

				System.exit(-666);
			}
		}
		else {
			Parametros.printError(CTE_ERR_MESSAGE);

			System.exit(-666);
		}
	} // main
} // class
