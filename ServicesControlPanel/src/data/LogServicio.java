package data;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import general.Log;

/**
 * 
 * Esta clase copiará a la carpeta temp local, los archivos log de cada servicio, cuyas rutas estarán especificadas
 * en config.properties para después mostrar su contenido en un JTextArea no editable
 * Los copiamos a una carpeta local para evitar que los servicios queden bloqueados mientras tenemos abierto el fichero  
 *
 */
public class LogServicio {
	
	private String log_path = null;
	
	private static String TMP_FOLDER = System.getProperty("java.io.tmpdir");

	// Lista de servicios
	public static int SERVICIO_AGVS_BC = 0;
	public static int SERVICIO_AGVS_CR = 1;
	public static int SERVICIO_MONITOR_STOCK = 2;
	public static int SERVICIO_STOCK = 3;
	public static int SERVICIO_HIBU = 4;	
	
	/**
	 * El parámetro 'servicio' se puede asignar a través de las constantes staticas de esta misma clase --> SERVICIO_*
	 * @param servicio
	 */
	public LogServicio(int servicio){
		
		Config config = new Config();		
		
		switch(servicio){
		case 0: // SERVICIO_AGVS_BC
			log_path = config.LOG_AGVS_BC;			
			break;
		case 1: // SERVICIO_AGVS_CR
			log_path = config.LOG_AGVS_CR;
			break;
		case 2: // SERVICIO_MONITOR_STOCK
			log_path = config.LOG_STOCK_MONITOR;
			break;
		case 3: // SERVICIO_STOCK
			log_path = config.LOG_STOCK;
			break;
		case 4: // SERVICIO_HIBU
			log_path = config.LOG_HIBU;
			break;			
		}
		
	}
	
	public List<String> getContent(){
		List<String> lineas = new ArrayList<String>();
		try{
			FileReader fileReader = new FileReader(log_path);
			BufferedReader buf = new BufferedReader(fileReader);
			String linea = "";
			while((linea = buf.readLine()) != null){
				lineas.add(linea);
			}
			buf.close();
			fileReader.close();
		}catch(Exception ex){
			Log.message("Error al obtener el contenido del fichero LOG: " + log_path, Log.ERROR_MESSAGE);			
		}		
		return lineas;
	}
	
	public Date getLastModified(){
		try{
			File file = new File(log_path);
			return new Date(file.lastModified());			
		}catch(Exception ex){			
			return new Date(Long.MIN_VALUE);
		}
	}
	
}

