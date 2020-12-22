package data;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import entities.FenixLog;
import entities.NautilusLog;
import general.Log;

public class NautilusDB {
	
	Connection conn = null;
		
	public NautilusDB(Connection conn){
		this.conn = conn;
	}
	
	public List<NautilusLog> getLog(){
		List<NautilusLog> records = new ArrayList<>();		
		Statement stmt = null;
		
		// Params
		String anno = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
		String mes = String.valueOf(Calendar.getInstance().get(Calendar.MONTH) + 1);
		String dia = String.valueOf(Calendar.getInstance().get(Calendar.DATE));
		
		try{
			stmt = this.conn.createStatement();			
			String query = "select * from LOG_Nautilus with (nolock) where year(fecha) = " + anno + " and month(fecha) = " + mes + " and day(fecha) = " + dia + " order by fecha desc";
			ResultSet rs = stmt.executeQuery(query);			
			while(rs.next()){
				NautilusLog nLog = new NautilusLog(rs.getTimestamp("fecha"), rs.getString("titulo"), rs.getString("mensaje"), rs.getString("accion"));
				records.add(nLog);
			}
			
		}catch(Exception ex){
			Log.message("Error al obtener datos del Log de Nautilus:" + ex.getMessage(), Log.ERROR_MESSAGE);			
		}
		
		return records;
	}

}
