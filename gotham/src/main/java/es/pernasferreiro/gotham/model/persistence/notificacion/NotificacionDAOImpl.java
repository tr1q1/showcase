package es.pernasferreiro.gotham.model.persistence.notificacion;

import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import es.pernasferreiro.gotham.domain.beans.StatBean;
import es.pernasferreiro.gotham.domain.utils.DateUtils;
import es.pernasferreiro.gotham.domain.utils.EstadoNotificacion;
import es.pernasferreiro.gotham.model.persistence.ifrt.GenericDAOImpl;

/**
 * @author tino
 *
 */
@Repository("notificacionDAO")
public final class NotificacionDAOImpl extends GenericDAOImpl<Notificacion, Long> implements INotificacionDAO
{
	private static final Logger logger = LoggerFactory.getLogger(NotificacionDAOImpl.class);
	
	/**
	 * se obtiene la lista de todas las notificaciones activas (pendientes de procesar)
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Notificacion> findAll()
	{
		logger.debug("obteniendo todas las notificaciones Pendientes o Parcialmente Procesadas de enviar");
		
		Criteria criteria = this.getSession().createCriteria(Notificacion.class);
		criteria.add(Restrictions.in(
						"estado",
						new String[] {
							EstadoNotificacion.PENDIENTE.getEstado(),
							EstadoNotificacion.PARCIALMENTE_PROCESADA.getEstado()
						}));
		criteria.addOrder(Order.asc("fecha")); 
		
		return criteria.list();
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
	
	/**
	 * se obtienen las estadísticas completas
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<StatBean> getStats(boolean porDia)
	{
		logger.debug("obteniendo todas las estadísticas");
		
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT DISTINCT tipo.nombre AS nombre, tipo.sistema AS sistema, COUNT(*) AS contador ");
		sb.append("FROM Notificacion AS notificacion inner join notificacion.tipo AS tipo ");
		sb.append("WHERE notificacion.estado = 'C' ");	
		if (porDia)
		{
			sb.append("AND notificacion.fecha >= :FECHA ");
		} // then
		sb.append("GROUP BY tipo.nombre, tipo.sistema ");
		
		Query query = this.getSession().createQuery(sb.toString());
		if (porDia)
		{
			query.setString("FECHA", DateUtils.dateToString(new Date(), DateUtils.FORMATO_INGLES));
		} // then
		query.setResultTransformer(Transformers.aliasToBean(StatBean.class));
		
		return query.list();
	} // getStats
} // class
