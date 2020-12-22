package es.pernasferreiro.gotham.model.services.notificacion;

import java.util.List;

import es.pernasferreiro.gotham.controller.notificacion.NotificacionForm;
import es.pernasferreiro.gotham.domain.beans.StatBean;
import es.pernasferreiro.gotham.model.persistence.notificacion.Notificacion;

/**
 * Servicio sobre la entidad Notificacion 
 */
public interface INotificacionService
{
	/**
	 * Obtiene todas las notificaciones
	 * @return la lista de notificaciones Activas
	 */
	public List<Notificacion> findAll();
	
	/**
	 * Obtiene una notificacion concreta
	 * @return la notificacion correspondiente al id especificado
	 */
	public Notificacion findById(Long id);
	
	/**
	 * Se registra una nueva Alerta/Notificacion
	 * @return el identificador de la notificacion creada
	 */
	public Long insert(NotificacionForm notificacion);

	/**
	 * Se actualizan los datos de una nueva Alerta/Notificacion
	 * @return el identificador de la notificacion creada
	 */
	public Long update(NotificacionForm notificacion);
	
	/**
	 * Se procesan/envían las notificaciones activas o parcialmente completadas
	 * @return el número de notificaciones procesadas/enviadas
	 */
	public Long procesar();
	
	/**
	 * Obtiene las estadísticas completas
	 * @return la estadísticas completas de notificaciones
	 */
	public List<StatBean> getStats(boolean porDia);
} // interface
