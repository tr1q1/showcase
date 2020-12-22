package entities;

import java.util.Date;

public class ActividadAgvs {

	private String area;
	private Date fecha;
	private String codigoIfra;
	private String clave;
	private int numeroProceso;
	private String valor;	
	private String estado;
	
	public ActividadAgvs(String area, Date fecha, String codigoIfra, String clave, int numeroProceso, String valor, String estado) {
		super();
		this.area = area;
		this.fecha = fecha;
		this.codigoIfra = codigoIfra;
		this.clave = clave;
		this.numeroProceso = numeroProceso;
		this.valor = valor;
		this.estado = estado;
	}

	public String getArea() {
		return area;
	}

	public Date getFecha() {
		return fecha;
	}

	public String getCodigoIfra() {
		return codigoIfra;
	}

	public String getClave() {
		return clave;
	}

	public int getNumeroProceso() {
		return numeroProceso;
	}

	public String getValor() {
		return valor;
	}

	public String getEstado() {
		return estado;
	}


	
}
