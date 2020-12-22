package es.pernasferreiro.gotham.model.persistence.ifrt;

import java.io.Serializable;

import es.pernasferreiro.gotham.domain.exceptions.InstanceNotFoundException;

/**
 * Define el comportamiento de las operaciones a base de datos
 * 
 * @param <E> Tipo de la entidad que representa
 * @param <PK> Tipo de la clave primaria de la entidad
 */
public interface IGenericDAO<E, PK extends Serializable>
{
	/**
	 * Primer resultado de una busqueda cuando hay paginacion
	 */
	public static final int FIRST_RESULT = 0;
	
	/**
	 * Todos los resultados de una busqueda cuando hay paginacion
	 */
	public static final int ALL_RESULTS = 0;
	
	/**
	 * Almacena una entidad en la base de datos
	 * 
	 * @param entity
	 */
	void save(E entity);

	/**
	 * Obtiene un entidad por su clave primari
	 * 
	 * @param id Clave primaria
	 * @return Entidad
	 * @throws InstanceNotFoundException
	 */
	E find(PK id) throws InstanceNotFoundException;

	/**
	 * Elimina una entidad de la base de datos
	 * @param entity Entidad a eliminar
	 */
	void delete(E entity);
	
	/**
	 * Refresca un objeto con la informacion de base de datos
	 * @param entity Entidad
	 */
	void refresh(E entity);
}