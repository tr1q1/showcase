package es.pernasferreiro.gotham.model.services.notificable;

import java.util.List;

import es.pernasferreiro.gotham.model.persistence.notificable.Notificable;

/**
 * Servicio sobre la entidad Notificacion 
 */
public interface INotificableService
{
	/**
	 * Obtiene todas los usuarios notificables
	 */
	public List<Notificable> findAll();
	
	/**
	 * obtiene un usuario notificacion concreto
	 */
	public Notificable findById(Long id);
	
	/**
	 * Obtiene todos los usuarios notificables asociados a una determinada app
	 */
	public List<Notificable> findByApp(String app);
} // interface
