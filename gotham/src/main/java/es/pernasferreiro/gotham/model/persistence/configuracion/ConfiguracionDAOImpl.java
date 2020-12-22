package es.pernasferreiro.gotham.model.persistence.configuracion;

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
@Repository("configuracionDAO")
public final class ConfiguracionDAOImpl extends GenericDAOImpl<Configuracion, Long> implements IConfiguracionDAO
{
	private static final Logger logger = LoggerFactory.getLogger(ConfiguracionDAOImpl.class);
	
	/**
	 * se obtiene la lista de todos los parametros de configuracion con los valores del entorno correspondiente
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Configuracion> findAll(String entorno)
	{
		logger.debug("obteniendo todos los grupo y parametros del entorno '" + entorno + "'");
		
		Criteria criteria = this.getSession().createCriteria(Configuracion.class);
		criteria.add(Restrictions.eq("entorno", entorno.trim()));
		criteria.addOrder(Order.asc("grupo")); 
		criteria.addOrder(Order.asc("parametro"));
		
		return criteria.list();
	} // findAll
	
	/**
	 * se obtiene todos los datos del parametro de configuracion especificado 
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Configuracion findById(Long id)
	{
		logger.debug("obteniendo el parametro de configuracion con id = '" + id + "'");

		Criteria criteria = this.getSession().createCriteria(Configuracion.class);
		criteria.add(Restrictions.eq("id", id));
		
		List<Configuracion> configuraciones = criteria.list();
        
        Configuracion configuracion = null;
        if (
        	(null != configuraciones) &&
        	(! configuraciones.isEmpty())
        )
        {
        	configuracion = configuraciones.get(0);
        } // then
        
        return configuracion;
	} // findById
	
	/**
	 * se obtienen todos los parametros de configuracion del grupo especificado para el entorno correspondiente
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Configuracion> findAllGrupo(String entorno, String grupo)
	{
		logger.debug("obteniendo todos los parametros de configuracion del grupo '" + grupo + "' en el entorno '" + entorno + "'");
		
		Criteria criteria = this.getSession().createCriteria(Configuracion.class);
		criteria.add(Restrictions.eq("entorno", entorno.trim()));
		criteria.add(Restrictions.eq("grupo", grupo.trim()));
		criteria.addOrder(Order.asc("grupo")); 
		criteria.addOrder(Order.asc("parametro"));
		
		return criteria.list();
	} // findAllGrupo
	
	/**
	 * se obtiene el parametro de configuracion especificado, del grupo indicado y con valor para el entorno correspondiente
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Configuracion findByParametro(String entorno, String grupo, String parametro)
	{
		logger.debug("obteniendo el parametro de configuracion con grupo = '" + grupo + "', parametro = '" + parametro + "' y del entorno = '" + entorno + "'");

		Criteria criteria = this.getSession().createCriteria(Configuracion.class);
		criteria.add(Restrictions.eq("entorno", entorno.trim()));
		criteria.add(Restrictions.eq("grupo", grupo.trim()));
		criteria.add(Restrictions.eq("parametro", parametro.trim()));
		
		List<Configuracion> configuraciones = criteria.list();
        
        Configuracion configuracion = null;
        if (
        	(null != configuraciones) &&
        	(! configuraciones.isEmpty())
        )
        {
        	configuracion = configuraciones.get(0);
        } // then
        
        return configuracion;
	} // findByParametro
} // class
