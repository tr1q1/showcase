package es.pernasferreiro.gotham.model.persistence.notificacion;

import java.util.List;

import es.pernasferreiro.gotham.domain.beans.StatBean;
import es.pernasferreiro.gotham.model.persistence.ifrt.IGenericDAO;

/**
 * DAO para operaciones sobre Notificaciones
 */
public interface INotificacionDAO extends IGenericDAO<Notificacion, Long>
{
	public List<Notificacion> findAll();
	
	public Notificacion findById(Long id);
	
	public List<StatBean> getStats(boolean porDia);
}
