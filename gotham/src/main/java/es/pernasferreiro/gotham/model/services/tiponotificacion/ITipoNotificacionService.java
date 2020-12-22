package es.pernasferreiro.gotham.model.services.tiponotificacion;

import java.util.List;

import es.pernasferreiro.gotham.model.persistence.tiponotificacion.TipoNotificacion;

/**
 * Servicio sobre la entidad Notificacion 
 */
public interface ITipoNotificacionService
{
	/**
	 * Obtiene todos los tipos de notificación
	 */
	public List<TipoNotificacion> findAll();
	
	/**
	 * Obtiene un tipo de notificación concreta
	 */
	public TipoNotificacion findById(Long id);
	
	/**
	 * Obtiene todos los tipos de notificación disponibles para una app
	 */
	public List<TipoNotificacion> findByApp(String app);
} // interface
