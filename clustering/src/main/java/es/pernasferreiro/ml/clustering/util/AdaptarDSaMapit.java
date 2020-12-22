package es.pernasferreiro.ml.clustering.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;

public class AdaptarDSaMapit {
	public static void main(String args[]) {
		String ficheroIN = ".\\docker\\data\\dataset_TSMC2014_TKY_02.txt";
		try {
			FileReader fr = new FileReader(ficheroIN);
			BufferedReader br = new BufferedReader(fr);

			FileWriter fw = new FileWriter(ficheroIN + "_OUT");
			PrintWriter pw = new PrintWriter(fw);

			String linea;
			while((linea = br.readLine()) != null) {
				StringBuilder sb = new StringBuilder(linea);
				sb.append("\t");

				pw.println(linea + "	IN");
				pw.println(linea + "	OUT");
			}

			fw.close();
			fr.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
} // class
