package forms;

import java.awt.GridLayout;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Vector;

import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.border.TitledBorder;

import data.DatabaseUtils;
import data.FenixDB;
import data.LogServicio;
import entities.ActividadAgvsCR;
import entities.FenixLog;

public class PnAGVsCR extends JPanel {
	
	public PnAGVsCR(){
		this.setLayout(new BoxLayout(this, BoxLayout.PAGE_AXIS));

		// Última actividad
		ActividadAgvsCR last = getLastActividadBC(); 
		JPanel pnUltimaActividad = new JPanel(new GridLayout(0, 2));
		if(last != null){
			pnUltimaActividad.setBorder(new TitledBorder("Última actividad"));
			pnUltimaActividad.add(new JLabel("Fecha:"));
			pnUltimaActividad.add(new JLabel(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(last.getFecha())));
			pnUltimaActividad.add(new JLabel("Cambio de estado:"));
			pnUltimaActividad.add(new JLabel(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(last.getFechaCambioEstado())));
			pnUltimaActividad.add(new JLabel("Estado:"));
			pnUltimaActividad.add(new JLabel(last.getEstado()));
			pnUltimaActividad.add(new JLabel("IFRA:"));
			pnUltimaActividad.add(new JLabel(last.getCodigoIfra()));
			pnUltimaActividad.add(new JLabel("IFRA original:"));
			pnUltimaActividad.add(new JLabel(last.getCodigoIfraOriginal()));					
			pnUltimaActividad.add(new JLabel("Peso real:"));
			pnUltimaActividad.add(new JLabel(String.valueOf(last.getPesoReal())));
			pnUltimaActividad.add(new JLabel("Peso original:"));
			pnUltimaActividad.add(new JLabel(String.valueOf(last.getPesoOriginal())));							
			pnUltimaActividad.add(new JLabel("Diámetro:"));
			pnUltimaActividad.add(new JLabel(String.valueOf(last.getDiametro())));
			pnUltimaActividad.add(new JLabel("Ubicacion:"));
			pnUltimaActividad.add(new JLabel(last.getUbicacion()));
			
		}else{
			pnUltimaActividad.add(new JLabel("No hay datos"));
		}
		this.add(pnUltimaActividad);
		
		
		// Lista de actividades
		JTable tbActividadesAgvsCR = new JTable(getDatosAGVsBC(), getColumnasAGVsBC());
		JScrollPane scrollLogServicioAGVsCR = new JScrollPane(tbActividadesAgvsCR);
		scrollLogServicioAGVsCR.setBorder(BorderFactory.createTitledBorder("Actividad de los AGVs del Cadex (max. 100 registros)"));
		this.add(scrollLogServicioAGVsCR);
		
		// Log Servicio
		JTextArea txtLog = new JTextArea(2,30);	
		txtLog.setEditable(false);
		fillLog(txtLog);
		JScrollPane scroll = new JScrollPane(txtLog);
		scroll.setBorder(new TitledBorder("Log de los AGVs del camino de rodillos - Última modificación: " + this.getLastModifiedLogDate()));
		this.add(scroll);
	}
	
	public Vector getDatosAGVsBC(){
		Vector<Object> datos = new Vector<Object>();
		
		//DatabaseUtils dbUtil = new DatabaseUtils();
		Connection conn =  DatabaseUtils.getConnection(DatabaseUtils.FENIX_DATABASE);
		List<ActividadAgvsCR>  actividades = new FenixDB(conn).getActividadesAGVsCR();
		for(ActividadAgvsCR actividad : actividades){
			
			Vector<Object> linea = new Vector<Object>();
			linea.add(new SimpleDateFormat("dd/MM/yy HH:mm:ss").format(actividad.getFecha()));			
			linea.add(new SimpleDateFormat("dd/MM/yy HH:mm:ss").format(actividad.getFechaCambioEstado()));
			linea.add(actividad.getEstado());
			linea.add(actividad.getCodigoIfra());
			linea.add(actividad.getCodigoIfraOriginal());
			linea.add(actividad.getPesoReal());
			linea.add(actividad.getPesoOriginal());
			linea.add(actividad.getDiametro());
			linea.add(actividad.getUbicacion());
			datos.add(linea);			
		}
		//dbUtil.closeConnection(conn);
		return datos;		
	}
	
	private Vector<String> getColumnasAGVsBC(){
		Vector<String> columns = new Vector<String>();
		columns.add("Fecha");
		columns.add("Cambio de estado");
		columns.add("Estado");
		columns.add("IFRA: ");
		columns.add("IFRA original: ");
		columns.add("Peso real");
		columns.add("Peso original: ");
		columns.add("Diámetro");
		columns.add("Ubicación");
		return columns;
	}	
	
	private ActividadAgvsCR getLastActividadBC(){
		//DatabaseUtils dbUtil = new DatabaseUtils();
		Connection conn =  DatabaseUtils.getConnection(DatabaseUtils.FENIX_DATABASE);
		return new FenixDB(conn).getLastActividadAGVsCR();		
	}
	
	private void fillLog(JTextArea area){
		List<String> lineas = new LogServicio(LogServicio.SERVICIO_AGVS_CR).getContent();
		for(String linea : lineas)
			area.append(linea + "\n");				
	}
	
	private String getLastModifiedLogDate(){
		return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new LogServicio(LogServicio.SERVICIO_AGVS_CR).getLastModified());
	}
	
	
}
