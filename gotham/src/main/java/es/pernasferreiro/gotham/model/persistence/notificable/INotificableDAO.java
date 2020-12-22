package es.pernasferreiro.gotham.model.persistence.notificable;

import java.util.List;

import es.pernasferreiro.gotham.model.persistence.ifrt.IGenericDAO;

/**
 * DAO para operaciones sobre Notificaciones
 */
public interface INotificableDAO extends IGenericDAO<Notificable, Long>
{
	public List<Notificable> findAll();
	
	public Notificable findById(Long id);
	
	public List<Notificable> findByApp(String app);
} // interface
