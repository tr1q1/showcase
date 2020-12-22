package entities;

import java.util.Date;

public class ServicioEstado {

	private String nombre;
	private String estado;
	
	public ServicioEstado(String nombre, String estado) {
		super();		
		this.nombre = nombre;
		this.estado = estado;
	}

	
	public String getNombre() {
		return nombre;
	}

	public String getEstado() {
		return estado;
	}
	
	
}
