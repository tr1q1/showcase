/**
 * 
 */
package es.pernasferreiro.gotham.model.persistence.tiponotificacion;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author tino
 *
 */
@Entity
@Table(name = "TipoNotificacion")
public final class TipoNotificacion
{
	@Id
	@Column(name = "id")
	private Long id;
	
	@Column(name = "nombre")
	private String nombre;
	
	@Column(name = "criticidad")
	private String criticidad;
	
	@Column(name = "prioridad")
	private String prioridad;
	
	@Column(name = "sistema")
	private String sistema;
	
	@Column(name = "canal")
	private String canal;
	
	@Column(name = "app")
	private String app;
	
	@Column(name = "activo")
	private int activo;

	/**
	 * @return the id
	 */
	public final Long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public final void setId(Long id) {
		this.id = id;
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
	 * @return the criticidad
	 */
	public final String getCriticidad() {
		return criticidad;
	}

	/**
	 * @param criticidad the criticidad to set
	 */
	public final void setCriticidad(String criticidad) {
		this.criticidad = criticidad;
	}

	/**
	 * @return the prioridad
	 */
	public final String getPrioridad() {
		return prioridad;
	}

	/**
	 * @param prioridad the prioridad to set
	 */
	public final void setPrioridad(String prioridad) {
		this.prioridad = prioridad;
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
	 * @return the canal
	 */
	public final String getCanal() {
		return canal;
	}

	/**
	 * @param canal the canal to set
	 */
	public final void setCanal(String canal) {
		this.canal = canal;
	}

	/**
	 * @return the app
	 */
	public final String getApp() {
		return app;
	}

	/**
	 * @param app the app to set
	 */
	public final void setApp(String app) {
		this.app = app;
	}

	/**
	 * @return the activo
	 */
	public final int getActivo() {
		return activo;
	}

	/**
	 * @param activo the activo to set
	 */
	public final void setActivo(int activo) {
		this.activo = activo;
	}
	
} // class
