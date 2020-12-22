/**
 * 
 */
package es.pernasferreiro.gotham.domain.utils;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import es.pernasferreiro.gotham.model.persistence.configuracion.IConfiguracionDAO;

/**
 * @author tino
 *
 */
public final class Configuracion
{
	@Autowired
	private IConfiguracionDAO dao;
	
	public List<es.pernasferreiro.gotham.model.persistence.configuracion.Configuracion> getAll(String entorno)
	{
		return dao.findAll(entorno);
	} // getAll
	
	public List<es.pernasferreiro.gotham.model.persistence.configuracion.Configuracion> getAllGrupo(String entorno, String grupo)
	{
		return dao.findAllGrupo(entorno, grupo);
	} // getAllGrupo
	
	public es.pernasferreiro.gotham.model.persistence.configuracion.Configuracion getParametro(String entorno, String grupo, String parametro)
	{
		return dao.findByParametro(entorno, grupo, parametro);
	} // getAll
} // class
