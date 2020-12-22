/**
 * 
 */
package es.pernasferreiro.gotham.domain.utils;

/**
 * @author tino
 *
 */
public enum EstadoNotificacion
{
	PENDIENTE ("P"),
	COMPLETADA ("C"),
	PARCIALMENTE_PROCESADA ("A");
	
	private String estado;

	/**
	 * @return the estado
	 */
	public final String getEstado() {
		return estado;
	}

	/**
	 * @param estado the estado to set
	 */
	public final void setEstado(String estado) {
		this.estado = estado;
	}
	
	EstadoNotificacion(String estado)
	{
		this.estado = estado;
	}
} // enum
