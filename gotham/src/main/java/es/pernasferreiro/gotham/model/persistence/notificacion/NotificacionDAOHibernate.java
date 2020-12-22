/**
 * 
 */
package es.pernasferreiro.gotham.model.persistence.notificacion;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import es.pernasferreiro.gotham.model.persistence.ifrt.GenericDAOHibernate;

/**
 * @author tino
 *
 */
@Repository("notificacionDAO")
public final class NotificacionDAOHibernate
	extends GenericDAOHibernate<Notificacion, Long>
	implements INotificacionDAO
{
	private static final Logger logger = LoggerFactory.getLogger(NotificacionDAOHibernate.class);
	
	/**
	 * se obtiene la lista de todas las notificaciones activas (pendientes de procesar)
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Notificacion> findAll()
	{
		logger.debug("obteniendo todas las notificaciones Pendientes de enviar");
		
		Criteria criteria = this.getSession().createCriteria(Notificacion.class);
//		criteria.add(Restrictions.eq("estado", "P"));
		criteria.addOrder(Order.asc("fecha"));
		
		List<Notificacion> resultados = criteria.list(); 
		
		return resultados;
	} // obtenerNotificaciones
	
	/**
	 * se obtiene todos los datos de la notificacion correspondiente al ID especificado 
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Notificacion findById(Long id)
	{
		logger.debug("obteniendo la notificacion '" + id + "'");

		Criteria criteria = this.getSession().createCriteria(Notificacion.class);
		criteria.add(Restrictions.eq("id", id));
		
		List<Notificacion> notificaciones = criteria.list();
        
        Notificacion notificacion = null;
        if (
        	(null != notificaciones) &&
        	(! notificaciones.isEmpty())
        )
        {
        	notificacion = notificaciones.get(0);
        } // then
        
        return notificacion;
	} // obtenerNotificacion
} // class
