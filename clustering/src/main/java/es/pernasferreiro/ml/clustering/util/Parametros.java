package es.pernasferreiro.ml.clustering.util;

import org.apache.spark.SparkConf;

import java.util.*;

public class Parametros {
    public static Properties getParametros(String[] args) {
        Properties parametros = new Properties();
        for (String s: args) {
            String[] pares = s.split("=");

            if (args[0].equalsIgnoreCase("-v") && (pares.length > 1)) {
                System.out.println("'" + pares[0] + "' -|- '" + pares[1] + "'");
            }

            if (pares.length > 1) {
                parametros.setProperty(pares[0], pares[1]);
            }
        }

        return parametros;
    }

    public static SparkConf setConfElastic(Properties parametros) {
        String sparkApp = parametros.getProperty("RESOURCE");
        if (parametros.containsKey("APP")) {
            sparkApp = parametros.getProperty("APP");
        }

        String server = "elasticsearch";
        if (parametros.containsKey("ES_SERVER")) {
            server = parametros.getProperty("ES_SERVER");
        }

        String port = "9200";
        if (parametros.containsKey("ES_PORT")) {
            port = parametros.getProperty("ES_PORT");
        }

        SparkConf conf = new SparkConf().setAppName(sparkApp);
        conf.set("es.nodes", server);
        conf.set("es.port", port);

        return conf;
    }

    public static boolean existsParametrosObligatorios(String[] parametrosObligatorios, Properties parametros) {
        boolean resultado = false;
        for(String parametro: parametrosObligatorios) {
            if (parametros.containsKey(parametro)) {
                resultado = true;
            } else {
                resultado = false;

                break;
            }
        }

        return resultado;
    }

    public static void printError(StringBuilder texto) {
        System.err.println("\n\n(" + (new Date()).toString() + ")");
        System.err.println(texto.toString());
    }
}
