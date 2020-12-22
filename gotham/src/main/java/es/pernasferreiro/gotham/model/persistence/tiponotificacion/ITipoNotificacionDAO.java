package es.pernasferreiro.gotham.model.persistence.tiponotificacion;

import java.util.List;

import es.pernasferreiro.gotham.model.persistence.ifrt.IGenericDAO;

/**
 * DAO para operaciones sobre Tipos de Notificaciones
 */
public interface ITipoNotificacionDAO extends IGenericDAO<TipoNotificacion, Long>
{
	public List<TipoNotificacion> findAll();
	
	public TipoNotificacion findById(Long id);
	
	public List<TipoNotificacion> findByApp(String app);
} // interface
