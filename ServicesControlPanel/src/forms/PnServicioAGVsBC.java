package forms;

import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

public class PnServicioAGVsBC extends JPanel {

	JTextArea txtLogServicioAGVsBC = null;
	
	public PnServicioAGVsBC(){
		this.setLayout(new BoxLayout(this, BoxLayout.PAGE_AXIS));
		txtLogServicioAGVsBC = new JTextArea();				
		JScrollPane scrollLogServicioAGVsBC = new JScrollPane(txtLogServicioAGVsBC);
		scrollLogServicioAGVsBC.setBorder(BorderFactory.createTitledBorder("Logs de Fénix"));
		this.add(scrollLogServicioAGVsBC);
	}
	
	public void cargarDatos(){
		//datos de prueba - BORRAR
		txtLogServicioAGVsBC.setText("hfjdhska\njfdsjkflñ\nfjdklsjfkñlsa");		
	}
	
}
