/**
 * 
 */
package es.pernasferreiro.gotham.model.persistence.notificable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author tino
 *
 */
@Entity
@Table(name = "Notificables")
public final class Notificable
{
	@Id
	@Column(name = "id")
	private Long id;
	
	@Column(name = "nombre")
	private String nombre;
	
	@Column(name = "user")
	private String user;
	
	@Column(name = "telefono")
	private String telefono;
	
	@Column(name = "aliasTelegram")
	private String aliasTelegram;
	
	@Column(name = "aliasTwitter")
	private String aliasTwitter;
	
	@Column(name = "email")
	private String email;
	
	@Column(name = "activo")
	private int activo;
	
	@Column(name = "apps")
	private String apps;
	
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
	 * @return the user
	 */
	public final String getUser() {
		return user;
	}
	/**
	 * @param user the user to set
	 */
	public final void setUser(String user) {
		this.user = user;
	}
	/**
	 * @return the telefono
	 */
	public final String getTelefono() {
		return telefono;
	}
	/**
	 * @param telefono the telefono to set
	 */
	public final void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	/**
	 * @return the aliasTelegram
	 */
	public final String getAliasTelegram() {
		return aliasTelegram;
	}
	/**
	 * @param aliasTelegram the aliasTelegram to set
	 */
	public final void setAliasTelegram(String aliasTelegram) {
		this.aliasTelegram = aliasTelegram;
	}
	/**
	 * @return the aliasTwitter
	 */
	public final String getAliasTwitter() {
		return aliasTwitter;
	}
	/**
	 * @param aliasTwitter the aliasTwitter to set
	 */
	public final void setAliasTwitter(String aliasTwitter) {
		this.aliasTwitter = aliasTwitter;
	}
	/**
	 * @return the email
	 */
	public final String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public final void setEmail(String email) {
		this.email = email;
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
	/**
	 * @return the apps
	 */
	public final String getApps() {
		return apps;
	}
	/**
	 * @param apps the apps to set
	 */
	public final void setApps(String apps) {
		this.apps = apps;
	}
} // class
