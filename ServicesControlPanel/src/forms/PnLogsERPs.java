package forms;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.DefaultListModel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;

import data.DatabaseUtils;
import data.FenixDB;
import data.NautilusDB;
import entities.FenixLog;
import entities.NautilusLog;

public class PnLogsERPs extends JPanel {

	JTable lstLogFenix = null;
	JTable lstLogNautilus = null; 
	
	public PnLogsERPs(){
		
		this.setLayout(new BoxLayout(this, BoxLayout.LINE_AXIS));		
		
		// Log Fenix		
		lstLogFenix = new JTable(getDatosFenix(), getColumnasFenix());
		JScrollPane scrollLogFenix = new JScrollPane(lstLogFenix);
		lstLogFenix.setFillsViewportHeight(true);
		scrollLogFenix.setBorder(BorderFactory.createTitledBorder("Logs de Fénix (max. 100 registros)"));
		this.add(scrollLogFenix);
		// Log Nautilus
		lstLogNautilus = new JTable(getDatosNautilus(), getColumnasNautilus());		
		JScrollPane scrollLogNautilus = new JScrollPane(lstLogNautilus);
		lstLogNautilus.setFillsViewportHeight(true);
		scrollLogNautilus.setBorder(BorderFactory.createTitledBorder("Logs de Nautilus (max. 100 registros)"));
		this.add(scrollLogNautilus);
	}
	
	public Vector getDatosFenix(){
		
		Vector<Object> datos = new Vector<Object>();
		
		//DatabaseUtils dbUtil = new DatabaseUtils();
		Connection conn =  DatabaseUtils.getConnection(DatabaseUtils.FENIX_DATABASE);
		List<FenixLog>  fenixLog = new FenixDB(conn).getLog();		
		for(FenixLog record : fenixLog){
			
			Vector<Object> linea = new Vector<Object>();
			linea.add(new SimpleDateFormat("dd/MM/yy HH:mm:ss").format(record.getFecha()));
			linea.add(record.getArea());
			linea.add(record.getTitulo());
			linea.add(record.getMensaje());
			linea.add(record.getAccion());
			
			datos.add(linea);
			
		}
		//dbUtil.closeConnection(conn);
		return datos;
		
	}
	
	private Vector getColumnasFenix(){
		Vector<String> columns = new Vector<String>();
		columns.add("Fecha");
		columns.add("Área");
		columns.add("Titulo");
		columns.add("Mensaje");
		columns.add("Acción");
		return columns;
	}

	public Vector getDatosNautilus(){
		
		Vector<Object> datos = new Vector<Object>();
		
		//DatabaseUtils dbUtil = new DatabaseUtils();
		Connection conn =  DatabaseUtils.getConnection(DatabaseUtils.NAUTILUS_DATABASE);
		List<NautilusLog> nautilusLog = new NautilusDB(conn).getLog();		
		for(NautilusLog record : nautilusLog){
			
			Vector<Object> linea = new Vector<Object>();
			linea.add(new SimpleDateFormat("dd/MM/yy HH:mm:ss").format(record.getFecha()));			
			linea.add(record.getTitulo());
			linea.add(record.getMensaje());
			linea.add(record.getAccion());
			
			datos.add(linea);
			
		}
		//dbUtil.closeConnection(conn);
		return datos;
		
	}
	
	private Vector getColumnasNautilus(){
		Vector<String> columns = new Vector<String>();
		columns.add("Fecha");		
		columns.add("Titulo");
		columns.add("Mensaje");
		columns.add("Acción");
		return columns;
	}
	
	
}
