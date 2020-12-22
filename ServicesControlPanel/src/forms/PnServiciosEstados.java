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
import entities.ActividadAgvs;
import entities.EstadoCR;
import entities.ServicioEstado;

public class PnServiciosEstados extends JPanel {	
	
	public PnServiciosEstados(){
		
		this.setLayout(new GridLayout(2,1));
		
		JPanel pnSuperior = new JPanel();				
		pnSuperior.setLayout(new BoxLayout(pnSuperior, BoxLayout.LINE_AXIS));		

		// Estados
		JTable tbEstados = null;
		tbEstados = new JTable(getDatoServiciosEstados(), getColumnasServiciosEstados());		
		JScrollPane scrollServiciosEstados = new JScrollPane(tbEstados);
		scrollServiciosEstados.setBorder(BorderFactory.createTitledBorder("Estados de los servicios"));
		pnSuperior.add(scrollServiciosEstados);

		// Panel derecho
		JPanel pnResumenEstados = new JPanel();
		pnResumenEstados.setLayout(new BoxLayout(pnResumenEstados, BoxLayout.Y_AXIS));
		
		// EstadoCR		
		EstadoCR estadoCR = getEstadoCR();
		JPanel pnEstadoCR = new JPanel(new GridLayout(2,2));
		pnEstadoCR.setBorder(new TitledBorder("Último estado del Cadex"));		
		pnEstadoCR.add(new JLabel("Estado: "));
		pnEstadoCR.add(new JLabel(estadoCR.getEstado()));
		pnEstadoCR.add(new JLabel("Fecha: "));
		pnEstadoCR.add(new JLabel(new SimpleDateFormat("dd/MM/yyyy HH:mm:s").format(estadoCR.getFecha())));		
		
		pnResumenEstados.add(pnEstadoCR);
		
		// Ultima actividad
		ActividadAgvs act = getLastActividadAgvs();
		JPanel pnEstadoActividad = new JPanel(new GridLayout(0, 2));
		pnEstadoActividad.setBorder(new TitledBorder("Última actividad de AGVs (Cadex + Demandas)"));
		if(act != null){
			pnEstadoActividad.add(new JLabel("Fecha: "));
			pnEstadoActividad.add(new JLabel(new SimpleDateFormat("dd/MM/yy HH:mm:ss").format(act.getFecha())));
			pnEstadoActividad.add(new JLabel("Área: "));
			pnEstadoActividad.add(new JLabel(act.getArea()));
			pnEstadoActividad.add(new JLabel("Estado: "));
			pnEstadoActividad.add(new JLabel(act.getEstado()));
			pnEstadoActividad.add(new JLabel("Clave: "));
			pnEstadoActividad.add(new JLabel(act.getClave()));
			pnEstadoActividad.add(new JLabel("IFRA: "));
			pnEstadoActividad.add(new JLabel(act.getCodigoIfra()));
			pnEstadoActividad.add(new JLabel("Valor: "));
			JTextArea txtValor = new JTextArea(act.getValor(),1,1);		
			txtValor.setEditable(false);
			JScrollPane scroll = new JScrollPane(txtValor);
			pnEstadoActividad.add(scroll);
		}else{
			pnEstadoActividad.add(new JLabel("No hay datos"));
		}
		pnResumenEstados.add(pnEstadoActividad);
		
		pnSuperior.add(pnResumenEstados);
		this.add(pnSuperior);		
		
		// Actividad Agvs
		JPanel pnActividad = new JPanel();		
		JTable tbActividad = new JTable(getDatosActividadAgvs(), getColumnasActividadAgvs());		
		tbActividad.setFillsViewportHeight(true);
		JScrollPane scrollActividad = new JScrollPane(tbActividad);
		scrollActividad.setBorder(BorderFactory.createTitledBorder("Actividad de los AGVs (Cadex + Demandas) (max. 100 registros)"));
		scrollActividad.setAlignmentY(CENTER_ALIGNMENT);
		this.add(scrollActividad);
		
	}
	
	public Vector getDatoServiciosEstados(){
		
		Vector<Object> datos = new Vector<Object>();
		
		//DatabaseUtils dbUtil = new DatabaseUtils();
		Connection conn =  DatabaseUtils.getConnection(DatabaseUtils.FENIX_DATABASE);
		List<ServicioEstado>  estados = new FenixDB(conn).getServiciosEstado();
		for(ServicioEstado estado : estados){
			
			Vector<Object> linea = new Vector<Object>();
			linea.add(estado.getNombre());
			linea.add(estado.getEstado());			
			datos.add(linea);			
		}
		//dbUtil.closeConnection(conn);
		return datos;
		
	}
	
	private Vector<String> getColumnasServiciosEstados(){
		Vector<String> columns = new Vector<String>();
		columns.add("Nombre");
		columns.add("Estado");
		return columns;
	}
	
	private EstadoCR getEstadoCR(){
		EstadoCR result = null;
		//DatabaseUtils dbUtil = new DatabaseUtils();
		Connection conn =  DatabaseUtils.getConnection(DatabaseUtils.FENIX_DATABASE);
		result = new FenixDB(conn).getEstadoCR();
		//dbUtil.closeConnection(conn);
		return result;
	}
	
	public Vector getDatosActividadAgvs(){
		
		Vector<Object> datos = new Vector<Object>();
		
		//DatabaseUtils dbUtil = new DatabaseUtils();
		Connection conn =  DatabaseUtils.getConnection(DatabaseUtils.FENIX_DATABASE);
		List<ActividadAgvs>  actividades = new FenixDB(conn).getActividadesAGVs();
				
		for(ActividadAgvs actividad : actividades){
			
			Vector<Object> linea = new Vector<Object>();
			linea.add(actividad.getArea());
			linea.add(new SimpleDateFormat("dd/MM/yy HH:mm:ss").format(actividad.getFecha()));
			linea.add(actividad.getCodigoIfra());
			linea.add(actividad.getNumeroProceso());
			linea.add(actividad.getClave());
			linea.add(actividad.getValor());
			linea.add(actividad.getEstado());
			datos.add(linea);			
		}		
		//dbUtil.closeConnection(conn);
		return datos;
		
	}
	
	private Vector<String> getColumnasActividadAgvs(){
		Vector<String> columns = new Vector<String>();
		columns.add("Área");
		columns.add("Fecha");
		columns.add("CodigoIfra");
		columns.add("NumeroProceso");
		columns.add("clave");
		columns.add("valor");
		columns.add("estado");
		return columns;
	}
	
	private ActividadAgvs getLastActividadAgvs(){
		//DatabaseUtils dbUtil = new DatabaseUtils();
		Connection conn =  DatabaseUtils.getConnection(DatabaseUtils.FENIX_DATABASE);
		return new FenixDB(conn).getLastActividadAGVs();
	}
	
}
