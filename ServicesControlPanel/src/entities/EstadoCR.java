package entities;

import java.util.Date;

public class EstadoCR {

	private String nombre;
	private String estado;
	private Date fecha;
	
	public EstadoCR(String nombre, String estado, Date fecha) {
		super();		
		this.nombre = nombre;
		this.estado = estado;
		this.fecha = fecha;
	}



	public String getNombre() {
		return nombre;
	}

	public String getEstado() {
		return estado;
	}
	
	public Date getFecha() {
		return fecha;
	}
	
}
