package data;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;

public class Config {
	
	// Constantes
	public static String DATABASE_CONNECTION_FENIX = null;
	public static String DATABASE_CONNECTION_NAUTILUS = null;
		
	public static String LOG_AGVS_BC = null;
	public static String LOG_AGVS_CR = null;
	public static String LOG_STOCK_MONITOR = null;
	public static String LOG_STOCK = null;
	public static String LOG_HIBU = null;
	
	// Variables (Login BBDD)
	public static String ususarioBaseDatos = "";
	public static String contrasenaBaseDatos = "";
	

	public Config(){
		try{
			InputStream in = this.getClass().getResourceAsStream("config.properties");
			Properties prop = new Properties();
			prop.load(in);
			
			// Fenix database
			DATABASE_CONNECTION_FENIX = "jdbc:sqlserver://";
			DATABASE_CONNECTION_FENIX += prop.getProperty("fenix_server") + ":1433;";
			DATABASE_CONNECTION_FENIX += "databaseName=" + prop.getProperty("fenix_database") + ";";								
			DATABASE_CONNECTION_FENIX += "user=" +ususarioBaseDatos + ";";
			DATABASE_CONNECTION_FENIX += "password=" + contrasenaBaseDatos + ";";
			DATABASE_CONNECTION_FENIX += "integratedSecurity=true;";
			
			// Nautilus database
			DATABASE_CONNECTION_NAUTILUS = "jdbc:sqlserver://";
			DATABASE_CONNECTION_NAUTILUS += prop.getProperty("nautilus_server") + ":1433;";
			DATABASE_CONNECTION_NAUTILUS += "databaseName=" + prop.getProperty("nautilus_database") + ";";			
			DATABASE_CONNECTION_NAUTILUS += "user=" + ususarioBaseDatos + ";";
			DATABASE_CONNECTION_NAUTILUS += "password=" + contrasenaBaseDatos + ";";
			DATABASE_CONNECTION_NAUTILUS += "integratedSecurity=true;";
			
			// Rutas de los ficheros LOG de los servicios
			LOG_AGVS_BC = prop.getProperty("log_agvs_bc");
			LOG_AGVS_CR = prop.getProperty("log_agvs_cr");
			LOG_STOCK_MONITOR = prop.getProperty("log_monitor_stock");
			LOG_STOCK = prop.getProperty("log_stock");
			LOG_HIBU = prop.getProperty("log_hibu");
			
			// Close Stream with properties file
			in.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
	}
	
}
