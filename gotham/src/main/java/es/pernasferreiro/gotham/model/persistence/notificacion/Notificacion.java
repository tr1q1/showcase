/**
 * 
 */
package es.pernasferreiro.gotham.model.persistence.notificacion;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import es.pernasferreiro.gotham.model.persistence.tiponotificacion.TipoNotificacion;

/**
 * @author tino
 *
 */
@Entity
@Table(name = "Notificacion")
public final class Notificacion
{
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name = "maquina")
	private String maquina;
	
	@Column(name = "app")
	private String app;
	
	@Column(name = "mensaje")
	private String mensaje;
	
	@Column(name = "stacktrace")
	private String stackTrace;
	
	@Column(name = "fecha")
	private Timestamp fecha;
	
	@Column(name = "estado")
	private String estado;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idTipo", nullable = false, insertable = true, updatable = true)
	private TipoNotificacion tipo;
	
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
	 * @return the maquina
	 */
	public final String getMaquina() {
		return maquina;
	}
	/**
	 * @param maquina the maquina to set
	 */
	public final void setMaquina(String maquina) {
		this.maquina = maquina;
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
	 * @return the mensaje
	 */
	public final String getMensaje() {
		return mensaje;
	}
	/**
	 * @param mensaje the mensaje to set
	 */
	public final void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	/**
	 * @return the stackTrace
	 */
	public final String getStackTrace() {
		return stackTrace;
	}
	/**
	 * @param stackTrace the stackTrace to set
	 */
	public final void setStackTrace(String stackTrace) {
		this.stackTrace = stackTrace;
	}
	/**
	 * @return the fecha
	 */
	public final Timestamp getFecha() {
		return fecha;
	}
	/**
	 * @param fecha the fecha to set
	 */
	public final void setFecha(Timestamp fecha) {
		this.fecha = fecha;
	}
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
	/**
	 * @return the tipo
	 */
	public final TipoNotificacion getTipo() {
		return tipo;
	}
	/**
	 * @param tipo the tipo to set
	 */
	public final void setTipo(TipoNotificacion tipo) {
		this.tipo = tipo;
	}
} // class
