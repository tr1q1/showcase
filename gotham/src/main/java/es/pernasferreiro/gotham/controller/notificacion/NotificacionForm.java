package es.pernasferreiro.gotham.controller.notificacion;

import org.apache.commons.lang3.StringUtils;

import es.pernasferreiro.gotham.domain.utils.Validation;
import es.pernasferreiro.gotham.model.persistence.notificacion.Notificacion;

/**
 * Representa un formulario de Alta de Notificacion 
 */
public class NotificacionForm
{
	private Long id;
	private String maquina;
	private String app;
	private Long idTipo;
	private String mensaje;
	private String stackTrace;
	private String estado;
	
	/**
	 * Crea una nueva instancia
	 */
	public NotificacionForm()
	{
		
	}
	
	/**
	 * Crea una nueva instancia a partir de una notificacion
	 * @param gasto Linea de gasto
	 */
	public NotificacionForm(Notificacion notificacion)
	{
		this.id = notificacion.getId();
		this.maquina = StringUtils.trimToEmpty(notificacion.getMaquina());
		this.app = StringUtils.trimToEmpty(notificacion.getApp());
		this.idTipo = notificacion.getTipo().getId();
		this.mensaje = StringUtils.trimToEmpty(notificacion.getMensaje());
		this.stackTrace = StringUtils.trimToEmpty(notificacion.getStackTrace());
		this.estado = StringUtils.trimToEmpty(notificacion.getEstado());
	}

	/**
	 * Valida el formulario
	 */
	public void validar()
	{
		Validation.validar("maquina", this.maquina);
		Validation.validar("app", this.app);
		Validation.validarObj("idTipo", this.idTipo);
		Validation.validar("mensaje", this.mensaje);
//		Validation.validar("stackTrace", this.stackTrace); // no es obligatorio enviar la traza completa del mensaje de error
	} // validar	

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
	 * @return the idTipo
	 */
	public final Long getIdTipo() {
		return idTipo;
	}

	/**
	 * @param idTipo the idTipo to set
	 */
	public final void setIdTipo(Long idTipo) {
		this.idTipo = idTipo;
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
}
