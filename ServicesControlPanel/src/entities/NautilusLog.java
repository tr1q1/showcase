package entities;

import java.util.Date;

public class NautilusLog {

	private Date fecha;	
	private String titulo;
	private String mensaje;
	private String accion;
	
	public NautilusLog(Date fecha, String titulo, String mensaje, String accion) {
		super();
		this.fecha = fecha;
		this.titulo = titulo;
		this.mensaje = mensaje;
		this.accion = accion;
	}

	public Date getFecha() {
		return fecha;
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
