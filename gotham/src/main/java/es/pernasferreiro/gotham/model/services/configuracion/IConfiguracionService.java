package es.pernasferreiro.gotham.model.services.configuracion;

import java.util.List;

import es.pernasferreiro.gotham.controller.configuracion.ConfiguracionForm;
import es.pernasferreiro.gotham.model.persistence.configuracion.Configuracion;

/**
 * Servicio sobre la entidad Configuracion 
 */
public interface IConfiguracionService
{
	/**
	 * se obtiene la lista de todos los parametros de configuracion con los valores del entorno correspondiente
	 * @param entorno
	 * @return
	 */
	public List<Configuracion> findAll();
	
	/**
	 * se obtiene todos los datos del parametro de configuracion especificado
	 * @param id
	 * @return
	 */
	public Configuracion findById(Long id);
	
	/**
	 * se obtienen todos los parametros de configuracion del grupo especificado para el entorno correspondiente
	 * @param entorno
	 * @param grupo
	 * @return
	 */
	public List<Configuracion> findAllGrupo(String grupo);
	
	/**
	 * se obtiene el parametro de configuracion especificado, del grupo indicado y con valor para el entorno correspondiente
	 * @param entorno
	 * @param grupo
	 * @param parametro
	 * @return
	 */
	public Configuracion findByParametro(String grupo, String parametro);
	
	/**
	 * Se registra un nuevo parametro de configuracion
	 * @return el identificador del parametro creado
	 */
	public Long insert(ConfiguracionForm configuracion);
} // interface
