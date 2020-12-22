package entities;

import java.util.Date;

public class ActividadAgvsCR {
	
	private Date fecha;
	private Date fechaCambioEstado;
	private String codigoIfra;
	private String codigoIfraOriginal;
	private float pesoReal;
	private float pesoOriginal;
	private float diametro;
	private String estado;
	private String ubicacion;
	
	public ActividadAgvsCR(Date fecha, Date fechaCambioEstado, String codigoIfra, String codigoIfraOriginal,
			float pesoReal, float pesoOriginal, float diametro, String estado, String ubicacion) {
		super();
		this.fecha = fecha;
		this.fechaCambioEstado = fechaCambioEstado;
		this.codigoIfra = codigoIfra;
		this.codigoIfraOriginal = codigoIfraOriginal;
		this.pesoReal = pesoReal;
		this.pesoOriginal = pesoOriginal;
		this.diametro = diametro;
		this.estado = estado;
		this.ubicacion = ubicacion;
	}

	public Date getFecha() {
		return fecha;
	}

	public Date getFechaCambioEstado() {
		return fechaCambioEstado;
	}

	public String getCodigoIfra() {
		return codigoIfra;
	}

	public String getCodigoIfraOriginal() {
		return codigoIfraOriginal;
	}

	public float getPesoReal() {
		return pesoReal;
	}

	public float getPesoOriginal() {
		return pesoOriginal;
	}

	public float getDiametro() {
		return diametro;
	}

	public String getEstado() {
		return estado;
	}

	public String getUbicacion() {
		return ubicacion;
	}

	
	
}
