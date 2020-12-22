package es.pernasferreiro.gotham.model.services.configuracion;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import es.pernasferreiro.gotham.controller.configuracion.ConfiguracionForm;
import es.pernasferreiro.gotham.domain.utils.ConfiguracionUtils;
import es.pernasferreiro.gotham.model.persistence.configuracion.Configuracion;
import es.pernasferreiro.gotham.model.persistence.configuracion.IConfiguracionDAO;

/**
 * Servicio de la entidad Configuracion
 */
@Service("configuracionService")
@Transactional
public class ConfiguracionServiceImpl implements IConfiguracionService
{
	@Autowired
	private IConfiguracionDAO dao;
	
	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public List<Configuracion> findAll()
	{
		return dao.findAll(ConfiguracionUtils.getEntornoEjecucion());
	} // findAll

	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public Configuracion findById(Long id)
	{
		return dao.findById(id);
	} // findById

	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public List<Configuracion> findAllGrupo(String grupo)
	{
		return dao.findAllGrupo(ConfiguracionUtils.getEntornoEjecucion(), grupo);
	} // findAllGrupo

	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public Configuracion findByParametro(String grupo, String parametro)
	{
		return dao.findByParametro(ConfiguracionUtils.getEntornoEjecucion(), grupo, parametro);
	} // findByParametro
	
	@Override
	@Transactional(readOnly = false)
	public Long insert(ConfiguracionForm input)
	{
		Configuracion parametro = new Configuracion();
		parametro.setGrupo(input.getGrupo());
		parametro.setParametro(input.getParametro());
		parametro.setValor(input.getValor());
		parametro.setFecha(new java.sql.Timestamp((new java.util.Date()).getTime()));
		parametro.setEntorno(input.getEntorno());
		
		this.dao.save(parametro);
		
		return parametro.getId();
	} // insert
} // class
