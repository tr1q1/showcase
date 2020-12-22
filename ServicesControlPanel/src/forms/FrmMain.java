package forms;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Insets;

import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.border.Border;

import data.DatabaseUtils;
import data.LogServicio;

public class FrmMain extends JFrame {
	
	PnLogsERPs pnLogsERPs = null;
	PnAGVsBC pnServicioAGVsBC = null;
	PnAGVsCR pnServicioLogistica = null;
	PnServiciosEstados pnServiciosEstados = null;
	PnLogsStocks pnLogsStocks = null;
	PnHibu pnHibu = null;
	
	public FrmMain(){
		
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);
		
		// Importaciones
		pnLogsERPs = new PnLogsERPs();
		pnServicioAGVsBC = new PnAGVsBC();
		pnServicioLogistica = new PnAGVsCR();
		pnServiciosEstados = new PnServiciosEstados();
		pnLogsStocks = new PnLogsStocks();
		pnHibu = new PnHibu();
		
		
		// Ventana
		this.setMinimumSize(new Dimension(900, 600));
		this.setLayout(new BoxLayout(this.getContentPane(), BoxLayout.PAGE_AXIS));

		// Titulo
		JLabel lbTituloVentana = new JLabel("Panel de Control de los Servicios de EINSA",JLabel.CENTER);
		lbTituloVentana.setFont(new Font(lbTituloVentana.getFont().getName(), Font.BOLD, 26));
		lbTituloVentana.setBorder(BorderFactory.createEmptyBorder(15,15,15,15));
		lbTituloVentana.setAlignmentX(CENTER_ALIGNMENT);
		this.add(lbTituloVentana);
		
		// Panel principal (Tabs)
		JTabbedPane pnMain = new JTabbedPane();
		this.add(pnMain);

		// Tabs		
		pnMain.addTab("Estado Servicios", pnServiciosEstados);
		pnMain.addTab("Servicio AGVsBC", pnServicioAGVsBC);
		pnMain.addTab("Servicio AGVsCR", pnServicioLogistica);
		pnMain.addTab("Servicios de Stock", pnLogsStocks);
		pnMain.addTab("Servicio Hibu", pnHibu);
		pnMain.addTab("Logs ERPs", pnLogsERPs);		
		
		// Mostramos pantalla
		pack();
		this.setExtendedState(JFrame.MAXIMIZED_BOTH);
		this.setVisible(true);
		
		// Cerramos conexiones a la base de datos
		DatabaseUtils.closeConnection(DatabaseUtils.FENIX_DATABASE);
		DatabaseUtils.closeConnection(DatabaseUtils.NAUTILUS_DATABASE);		
	}
	

}
