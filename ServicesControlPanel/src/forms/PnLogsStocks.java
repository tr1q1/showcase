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
import javax.swing.JTextArea;
import javax.swing.border.TitledBorder;

import data.DatabaseUtils;
import data.FenixDB;
import data.LogServicio;
import data.NautilusDB;
import entities.FenixLog;
import entities.NautilusLog;

public class PnLogsStocks extends JPanel {

	public PnLogsStocks(){
		
		this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));		
		
		// Log Stock		
		JTextArea txtLogStock = new JTextArea(2,30);	
		txtLogStock.setEditable(false);		
		fillLog(txtLogStock, LogServicio.SERVICIO_STOCK);		
		JScrollPane scrollStock = new JScrollPane(txtLogStock);
		scrollStock.setBorder(new TitledBorder("Log del Servicio de Stock - Última modificación: " + this.getLastModifiedLogDateStock()));
		this.add(scrollStock);

		// Log Monitor Stock
		JTextArea txtLogStockMonitor = new JTextArea(2,30);
		txtLogStockMonitor.setEditable(false);		
		fillLog(txtLogStockMonitor, LogServicio.SERVICIO_MONITOR_STOCK);		
		JScrollPane scrollStockMonitor = new JScrollPane(txtLogStockMonitor);		
		scrollStockMonitor.setBorder(new TitledBorder("Log del servicio StockMonitor - Última modificación: " + this.getLastModifiedLogDateStockMonitorStock()));
		this.add(scrollStockMonitor);
	}
	
	private void fillLog(JTextArea area, int log){
		List<String> lineas = new LogServicio(log).getContent();
		for(String linea : lineas)
			area.append(linea + "\n");				
	}


	private String getLastModifiedLogDateStock(){
		return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new LogServicio(LogServicio.SERVICIO_STOCK).getLastModified());
	}
	
	private String getLastModifiedLogDateStockMonitorStock(){
		return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new LogServicio(LogServicio.SERVICIO_MONITOR_STOCK).getLastModified());
	}
	
}
