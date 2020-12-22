package entities;

import java.util.Date;

public class FenixLog {

	private Date fecha;
	private String area;
	private String titulo;
	private String mensaje;
	private String accion;
	
	public FenixLog(Date fecha, String area, String titulo, String mensaje, String accion) {
		super();
		this.fecha = fecha;
		this.area = area;
		this.titulo = titulo;
		this.mensaje = mensaje;
		this.accion = accion;
	}

	public Date getFecha() {
		return fecha;
	}

	public String getArea() {
		return area;
	}

	public String getTitulo() {
		return titulo;
	}

	public String getMensaje() {
		return mensaje;
	}

	public String getAccion() {
		return accion;
	}
	
	
}
