package es.pernasferreiro.gotham.model.persistence.ifrt;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import es.pernasferreiro.gotham.domain.exceptions.InstanceNotFoundException;

/**
 * Implementacion de IGenericDao para el ORM Hibernate
 * 
 * @param <E> Tipo de la entidad que representa
 * @param <PK> Tipo de la clave primaria de la entidad
 */
public class GenericDAOImpl<E, PK extends Serializable> implements IGenericDAO<E, PK>
{
	private SessionFactory sessionFactory;
	private Class<E> entityClass;

	/**
	 * Inicializa el DAO
	 */
	@SuppressWarnings("unchecked")
	public GenericDAOImpl()
	{
		this.entityClass = (Class<E>) ((ParameterizedType) getClass()
				.getGenericSuperclass()).getActualTypeArguments()[0];
	}

	/**
	 * Obtiene la SessionFactory asociada al DAO
	 * 
	 * @param sessionFactory asociada al DAO
	 */
	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory)
	{
		this.sessionFactory = sessionFactory;
	}

	/**
	 * Obtiene una session de hibernate
	 * 
	 * @return session de hibernate
	 */
	protected Session getSession()
	{
		return sessionFactory.getCurrentSession();
	}

	/**
	 * {@inheritDoc}
	 */
	public E find(PK id) throws InstanceNotFoundException
	{
		E entity = getSession().get(entityClass, id);
		if (entity == null)
		{
			throw new InstanceNotFoundException(id, entityClass.getName());
		}

		return entity;
	}
	
	/**
	 * {@inheritDoc}
	 */
	public void save(E entity)
	{
		getSession().saveOrUpdate(entity);
		getSession().flush();
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public void delete(E entity)
	{
		getSession().delete(entity);
		getSession().flush();
	}
	
	/**
	 * {@inheritDoc}
	 */
	@Override	
	public void refresh(E entity)
	{
		getSession().refresh(entity);
	}
}
