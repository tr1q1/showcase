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

public class PnHibu extends JPanel {
	
	public PnHibu(){
		this.setLayout(new BoxLayout(this, BoxLayout.PAGE_AXIS));
	
		// Log Servicio
		JTextArea txtLog = new JTextArea(2,30);
		txtLog.setEditable(false);
		fillLog(txtLog);
		JScrollPane scroll = new JScrollPane(txtLog);
		scroll.setBorder(new TitledBorder("Log del servicio de Hibu - Última modificación: " + this.getLastModifiedLogDate()));
		this.add(scroll);
	}
	
	private void fillLog(JTextArea area){
		List<String> lineas = new LogServicio(LogServicio.SERVICIO_HIBU).getContent();
		for(String linea : lineas)
			area.append(linea + "\n");
	}
	
	private String getLastModifiedLogDate(){
		return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new LogServicio(LogServicio.SERVICIO_HIBU).getLastModified());
	}
	
}
