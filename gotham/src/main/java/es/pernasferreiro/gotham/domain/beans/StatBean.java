package es.pernasferreiro.gotham.domain.beans;

/**
 * Representa una estadística 
 */
public final class StatBean
{
	String nombre;
	String sistema;
	Long contador;
	
	/**
	 * Instancia un nuevo StatBean
	 */
	public StatBean(){}

	/**
	 * Instancia un nuevo StatBean
	 * @param 
	 */
	public StatBean(String nombre, String sistema, Long contador)
	{
		this.nombre = nombre;
		this.sistema = sistema;
		this.contador = contador;
	}

	/**
	 * @return the nombre
	 */
	public final String getNombre() {
		return nombre;
	}

	/**
	 * @param nombre the nombre to set
	 */
	public final void setNombre(String nombre) {
		this.nombre = nombre;
	}

	/**
	 * @return the sistema
	 */
	public final String getSistema() {
		return sistema;
	}

	/**
	 * @param sistema the sistema to set
	 */
	public final void setSistema(String sistema) {
		this.sistema = sistema;
	}

	/**
	 * @return the contador
	 */
	public final Long getContador() {
		return contador;
	}

	/**
	 * @param contador the contador to set
	 */
	public final void setContador(Long contador) {
		this.contador = contador;
	}
} // class
