/**
 * 
 */
package es.pernasferreiro.gotham.model.persistence.notificable;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
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
@Repository("notificableDAO")
public final class NotificableDAOImpl extends GenericDAOImpl<Notificable, Long> implements INotificableDAO
{
	private static final Logger logger = LoggerFactory.getLogger(NotificableDAOImpl.class);
	
	/**
	 * se obtiene la lista de todos los usuarios notificables ACTIVOS
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Notificable> findAll()
	{
		logger.debug("obteniendo todos los usuarios notificables ACTIVOS");
		
		Criteria criteria = this.getSession().createCriteria(Notificable.class);
		criteria.add(Restrictions.eq("activo", 1));
		criteria.addOrder(Order.asc("nombre"));  
		
		return criteria.list();
	} // findAll
	
	/**
	 * se obtiene todos los datos del usuario notificable correspondiente al ID especificado 
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Notificable findById(Long id)
	{
		logger.debug("obteniendo el usuario TipoNotificacion '" + id + "'");

		Criteria criteria = this.getSession().createCriteria(Notificable.class);
		criteria.add(Restrictions.eq("id", id));
		
		List<Notificable> notificables = criteria.list();
        
		Notificable notificable = null;
        if (
        	(null != notificables) &&
        	(! notificables.isEmpty())
        )
        {
        	notificable = notificables.get(0);
        } // then
        
        return notificable;
	} // findById

	/**
	 * se obtienen la lista de los usuarios Notificables ACTIVOS asociados a una APP concreta
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Notificable> findByApp(String app)
	{
		logger.debug("obteniendo los usuarios Notificables para la app '" + app + "'");

		Criteria criteria = this.getSession().createCriteria(Notificable.class);
		criteria.add(Restrictions.or(
				Restrictions.like("apps", "%" + StringUtils.trimToEmpty(app) + "%"),
				Restrictions.like("apps", "ALL")
			));
		criteria.add(Restrictions.eq("activo", 1));
		criteria.addOrder(Order.asc("nombre"));
                
        return criteria.list();
	} // findByApp
} // class
