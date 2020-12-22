package entities;

import java.util.Date;

public class ActividadAgvsBC {
	
	private Date fecha;
	private String codigoIfra;
	private float peso;	
	private String estado;
	private String observaciones;
	
	public ActividadAgvsBC(Date fecha, String codigoIfra, float peso, String estado, String observaciones) {
		super();
		this.fecha = fecha;
		this.codigoIfra = codigoIfra;
		this.peso = peso;
		this.estado = estado;
		this.observaciones = observaciones;
	}

	public Date getFecha() {
		return fecha;
	}

	public String getCodigoIfra() {
		return codigoIfra;
	}

	public float getPeso() {
		return peso;
	}

	public String getEstado() {
		return estado;
	}

	public String getObservaciones() {
		return observaciones;
	}

	
	
}
