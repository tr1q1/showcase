package forms;

import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.ScrollPane;
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
import javax.swing.ScrollPaneLayout;
import javax.swing.border.TitledBorder;

import data.DatabaseUtils;
import data.FenixDB;
import data.LogServicio;
import entities.ActividadAgvsBC;
import entities.FenixLog;

public class PnAGVsBC extends JPanel {
	
	public PnAGVsBC(){
		this.setLayout(new BoxLayout(this, BoxLayout.PAGE_AXIS));

		// Última actividad
		ActividadAgvsBC last = getLastActividadBC(); 
		JPanel pnUltimaActividad = new JPanel(new GridLayout(0, 2));
		if(last != null){
			pnUltimaActividad.setBorder(new TitledBorder("Última actividad"));
			pnUltimaActividad.add(new JLabel("Fecha:"));
			pnUltimaActividad.add(new JLabel(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(last.getFecha())));
			pnUltimaActividad.add(new JLabel("Estado:"));
			pnUltimaActividad.add(new JLabel(last.getEstado()));
			pnUltimaActividad.add(new JLabel("IFRA:"));
			pnUltimaActividad.add(new JLabel(last.getCodigoIfra()));		
			pnUltimaActividad.add(new JLabel("Peso:"));
			pnUltimaActividad.add(new JLabel(String.valueOf(last.getPeso())));				
			pnUltimaActividad.add(new JLabel("Observaciones:"));
			pnUltimaActividad.add(new JLabel(last.getObservaciones()));
		}else{
			pnUltimaActividad.add(new JLabel("No hay datos"));
		}
		this.add(pnUltimaActividad);
		
		
		// Lista de actividades
		JTable tbActividadesAgvsBC = new JTable(getDatosAGVsBC(), getColumnasAGVsBC());
		JScrollPane scrollLogServicioAGVsBC = new JScrollPane(tbActividadesAgvsBC);
		scrollLogServicioAGVsBC.setBorder(BorderFactory.createTitledBorder("Actividad de los AGVs de demandas de papel"));
		this.add(scrollLogServicioAGVsBC);
		
		// Log Servicio
		JTextArea txtLog = new JTextArea(2,30);
		txtLog.setEditable(false);
		fillLog(txtLog);
		JScrollPane scroll = new JScrollPane(txtLog);
		scroll.setBorder(new TitledBorder("Log de los AGVs de las demandas de papel - Última modificación: " + this.getLastModifiedLogDate()));
		this.add(scroll);
	}
	
	public Vector getDatosAGVsBC(){
		Vector<Object> datos = new Vector<Object>();
		
		//DatabaseUtils dbUtil = new DatabaseUtils();
		Connection conn =  DatabaseUtils.getConnection(DatabaseUtils.FENIX_DATABASE);
		List<ActividadAgvsBC>  actividades = new FenixDB(conn).getActividadesAGVsBC();		
		for(ActividadAgvsBC actividad : actividades){
			
			Vector<Object> linea = new Vector<Object>();
			linea.add(new SimpleDateFormat("dd/MM/yy HH:mm:ss").format(actividad.getFecha()));
			linea.add(actividad.getEstado());
			linea.add(actividad.getCodigoIfra());
			linea.add(actividad.getPeso());
			linea.add(actividad.getObservaciones());			
			datos.add(linea);			
		}
		//dbUtil.closeConnection(conn);
		return datos;		
	}
	
	private Vector<String> getColumnasAGVsBC(){
		Vector<String> columns = new Vector<String>();
		columns.add("Fecha");
		columns.add("Estado");
		columns.add("IFRA: ");
		columns.add("Peso");
		columns.add("Observaciones");
		return columns;
	}	
	
	private ActividadAgvsBC getLastActividadBC(){
		//DatabaseUtils dbUtil = new DatabaseUtils();
		Connection conn =  DatabaseUtils.getConnection(DatabaseUtils.FENIX_DATABASE);
		return new FenixDB(conn).getLastActividadAGVsBC();		
	}
	
	private void fillLog(JTextArea area){
		List<String> lineas = new LogServicio(LogServicio.SERVICIO_AGVS_BC).getContent();
		for(String linea : lineas)
			area.append(linea + "\n");				
	}
	
	private String getLastModifiedLogDate(){
		return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new LogServicio(LogServicio.SERVICIO_AGVS_BC).getLastModified());
	}
	
}
