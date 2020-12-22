/**
 * 
 */
package es.pernasferreiro.gotham.model.persistence.tiponotificacion;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import es.pernasferreiro.gotham.model.persistence.ifrt.GenericDAOImpl;

/**
 * @author tino
 *
 */
@Repository("tipoNotificacionDAO")
public final class TipoNotificacionDAOImpl extends GenericDAOImpl<TipoNotificacion, Long> implements ITipoNotificacionDAO
{
	private static final Logger logger = LoggerFactory.getLogger(TipoNotificacionDAOImpl.class);
	
	/**
	 * se obtiene la lista de todos los usuarios notificables ACTIVOS
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<TipoNotificacion> findAll()
	{
		logger.debug("obteniendo todos los tipos de notificación ACTIVOS");
		
		Criteria criteria = this.getSession().createCriteria(TipoNotificacion.class);
		criteria.add(Restrictions.eq("activo", 1)); 
		criteria.addOrder(Order.asc("criticidad"));
		criteria.addOrder(Order.asc("prioridad"));
		
		return criteria.list();
	} // findAll
	
	/**
	 * se obtiene todos los datos del tipo de notificación correspondiente al ID especificado 
	 */
	@SuppressWarnings("unchecked")
	@Override
	public TipoNotificacion findById(Long id)
	{
		logger.debug("obteniendo el tipo de Notificación '" + id + "'");

		Criteria criteria = this.getSession().createCriteria(TipoNotificacion.class);
		criteria.add(Restrictions.eq("id", id));
		
		List<TipoNotificacion> tipos = criteria.list();
        
		TipoNotificacion tipo = null;
        if (
        	(null != tipos) &&
        	(! tipos.isEmpty())
        )
        {
        	tipo = tipos.get(0);
        } // then
        
        return tipo;
	} // findById

	/**
	 * se obtienen la lista de los tipos de Notificación ACTIVOS asociados a una APP concreta ordenados por criticidad y prioridad
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<TipoNotificacion> findByApp(String app)
	{
		logger.debug("obteniendo los tipos de Notificación para la app '" + app + "'");

		Criteria criteria = this.getSession().createCriteria(TipoNotificacion.class);
		criteria.add(Restrictions.eq("app", app));
		criteria.add(Restrictions.eq("activo", 1));
		criteria.addOrder(Order.asc("criticidad"));
		criteria.addOrder(Order.asc("prioridad"));
                
        return criteria.list();
	} // findByApp
} // class
