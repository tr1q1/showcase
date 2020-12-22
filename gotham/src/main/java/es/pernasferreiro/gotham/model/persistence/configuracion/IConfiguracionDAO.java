package es.pernasferreiro.gotham.model.persistence.configuracion;

import java.util.List;

import es.pernasferreiro.gotham.model.persistence.ifrt.IGenericDAO;

/**
 * DAO para operaciones sobre Parametros de Configuracion
 */
public interface IConfiguracionDAO extends IGenericDAO<Configuracion, Long>
{
	public List<Configuracion> findAll(String entorno);
	
	public Configuracion findById(Long id);
	
	public List<Configuracion> findAllGrupo(String entorno, String grupo);
	
	public Configuracion findByParametro(String entorno, String grupo, String parametro);
} // interface
