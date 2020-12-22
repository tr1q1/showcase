package data;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import entities.ActividadAgvs;
import entities.ActividadAgvsBC;
import entities.ActividadAgvsCR;
import entities.EstadoCR;
import entities.FenixLog;
import entities.ServicioEstado;
import general.Log;

public class FenixDB {
	
	Connection conn = null;	
		
	public FenixDB(Connection conn){
		this.conn = conn;
	}	

	public List<FenixLog> getLog(){
		List<FenixLog> records = new ArrayList<>();		
		Statement stmt = null;
		
		// Params
		String anno = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
		String mes = String.valueOf(Calendar.getInstance().get(Calendar.MONTH) + 1);
		String dia = String.valueOf(Calendar.getInstance().get(Calendar.DATE));
		
		try{
			stmt = this.conn.createStatement();
			String query = "select * from LOG_Fenix with (nolock) where year(fecha) = " + anno + " and month(fecha) = " + mes + " and day(fecha) = " + dia + " order by fecha desc";
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()){
				FenixLog fLog = new FenixLog(rs.getTimestamp("fecha"), rs.getString("area"), rs.getString("titulo"), rs.getString("mensaje"), rs.getString("accion"));
				records.add(fLog);				
			}
			
		}catch(Exception ex){
			Log.message("Error al obtener datos del Log de Fénix", Log.ERROR_MESSAGE);
		}
		
		return records;
	}


	public List<ServicioEstado> getServiciosEstado(){
		List<ServicioEstado> records = new ArrayList<>();		
		Statement stmt = null;
			
		try{
			stmt = this.conn.createStatement();
			String query = "select descriptor,estadoServicio from RegistroEstadoETC with (nolock)";
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()){
				ServicioEstado servicioEstado = new ServicioEstado(rs.getString("descriptor"), rs.getString("estadoServicio"));
				records.add(servicioEstado);
			}
			
		}catch(Exception ex){
			Log.message("Error al obtener datos del Log de Nautilus", Log.ERROR_MESSAGE);			
		}
		
		return records;
	}
	
	public EstadoCR getEstadoCR(){
		EstadoCR estadoCR = null;
		Statement stmt = null;
			
		try{
			stmt = this.conn.createStatement();
			String query = "select descriptor, estadoTarea, fechaActualizacion from RegistroEstadoTarea with (nolock) where descriptor = 'MonitorCR'";
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()){				
				estadoCR = new EstadoCR(rs.getString("descriptor"), rs.getString("estadoTarea"), rs.getTimestamp("fechaActualizacion"));				
			}
			
		}catch(Exception ex){
			Log.message("Error al obtener datos del Log de Nautilus", Log.ERROR_MESSAGE);			
		}
		
		return estadoCR;
	}
	
	public List<ActividadAgvs> getActividadesAGVs(){
		List<ActividadAgvs> records = new ArrayList<>();		
		Statement stmt = null;
			
		try{
			stmt = this.conn.createStatement();
			String query = "select top 100 * from RegistroServicioAGVs with (nolock) where year(timestamp) = year(getdate()) and month(timestamp) = month(getdate()) and day(timestamp) = day(getdate()) order by timestamp desc";
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()){
				ActividadAgvs actividadAgv = new ActividadAgvs(rs.getString("area"), rs.getTimestamp("timeStamp"), rs.getString("codigoItem"), rs.getString("clave"), rs.getInt("numeroProceso"), rs.getString("valor"), rs.getString("estado"));
				records.add(actividadAgv);
			}
			
		}catch(Exception ex){
			Log.message("Error al obtener datos del Log de Nautilus", Log.ERROR_MESSAGE);			
		}
		
		return records;
	}	

	public ActividadAgvs getLastActividadAGVs(){
		ActividadAgvs last = null;
		Statement stmt = null;
			
		try{
			stmt = this.conn.createStatement();
			String query = "select top 1 * from RegistroServicioAGVs with (nolock) where year(timestamp) = year(getdate()) and month(timestamp) = month(getdate()) and day(timestamp) = day(getdate()) order by timestamp desc";
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()){
				last = new ActividadAgvs(rs.getString("area"), rs.getTimestamp("timeStamp"), rs.getString("codigoItem"), rs.getString("clave"), rs.getInt("numeroProceso"), rs.getString("valor"), rs.getString("estado"));				
			}
			
		}catch(Exception ex){
			Log.message("Error al obtener datos del Log de Nautilus", Log.ERROR_MESSAGE);
		}
		
		return last;
	}	
	
	public List<ActividadAgvsBC> getActividadesAGVsBC(){
		List<ActividadAgvsBC> records = new ArrayList<>();		
		Statement stmt = null;
			
		try{
			stmt = this.conn.createStatement();
			String query = "select top 100 * from Fnx_ItemDemandaPapel with (nolock) where year(datea) = year(getdate()) and month(datea) = month(getdate()) and day(datea) = day(getdate()) order by datea desc";
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()){
				ActividadAgvsBC actividadAgvBC = new ActividadAgvsBC(rs.getTimestamp("timeStampEtricc"), rs.getString("codigoBarras"), rs.getFloat("pesoERP"), rs.getString("estado"), rs.getString("observaciones"));
				records.add(actividadAgvBC);
			}
			
		}catch(Exception ex){
			Log.message("Error al obtener datos de la actividad de los AgvsBC", Log.ERROR_MESSAGE);					
		}
		
		return records;
	}	

	
	public ActividadAgvsBC getLastActividadAGVsBC(){
		ActividadAgvsBC last = null;		
		Statement stmt = null;
			
		try{
			stmt = this.conn.createStatement();
			String query = "select top 1 * from Fnx_ItemDemandaPapel with (nolock) where year(datea) = year(getdate()) and month(datea) = month(getdate()) and day(datea) = day(getdate()) order by datea desc";
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()){
				last = new ActividadAgvsBC(rs.getTimestamp("timeStampEtricc"), rs.getString("codigoBarras"), rs.getFloat("pesoERP"), rs.getString("estado"), rs.getString("observaciones"));				
			}
			
		}catch(Exception ex){
			Log.message("Error al obtener datos de la actividad de los AgvsBC", Log.ERROR_MESSAGE);			
		}
		
		return last;

	}	

	public List<ActividadAgvsCR> getActividadesAGVsCR(){
		List<ActividadAgvsCR> records = new ArrayList<>();		
		Statement stmt = null;
			
		try{
			stmt = this.conn.createStatement();
			String query = "select top 100 * from Fenix.[dbo].[Fnx_ItemAlbaran] with (nolock) where year(datea) = year(getdate()) and month(datea) = month(getdate()) and day(datea) = day(getdate()) order by datea desc";
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()){
				ActividadAgvsCR actividadAgvBC = new ActividadAgvsCR(rs.getTimestamp("datea"), rs.getTimestamp("fechaCambioEstado"), rs.getString("cbPrincipal1"), rs.getString("cbOriginal1"), rs.getFloat("pesoReal"), rs.getFloat("pesoOriginal"), rs.getFloat("diametro"), rs.getString("estado"), rs.getString("ubicacion"));
				records.add(actividadAgvBC);
			}
			
		}catch(Exception ex){
			Log.message("Error al obtener datos de la actividad de los AgvsBC", Log.ERROR_MESSAGE);					
		}
		
		return records;
	}	

	public ActividadAgvsCR getLastActividadAGVsCR(){
		ActividadAgvsCR last = null;		
		Statement stmt = null;
			
		try{
			stmt = this.conn.createStatement();
			String query = "select top 1 * from Fenix.[dbo].[Fnx_ItemAlbaran] with (nolock) where year(datea) = year(getdate()) and month(datea) = month(getdate()) and day(datea) = day(getdate()) order by datea desc";
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()){
				last = new ActividadAgvsCR(rs.getTimestamp("datea"), rs.getTimestamp("fechaCambioEstado"), rs.getString("cbPrincipal1"), rs.getString("cbOriginal1"), rs.getFloat("pesoReal"), rs.getFloat("pesoOriginal"), rs.getFloat("diametro"), rs.getString("estado"), rs.getString("ubicacion"));				
			}
			
		}catch(Exception ex){
			Log.message("Error al obtener datos de la actividad de los AgvsBC", Log.ERROR_MESSAGE);					
		}
		
		return last;
	}	
	
}
