package es.pernasferreiro.gotham.model.services.tiponotificacion;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import es.pernasferreiro.gotham.model.persistence.tiponotificacion.ITipoNotificacionDAO;
import es.pernasferreiro.gotham.model.persistence.tiponotificacion.TipoNotificacion;

/**
 * Servicio de la entidad TipoNotificacion
 */
@Service("tipoNotificacionService")
@Transactional
public class TipoNotificacionServiceImpl implements ITipoNotificacionService
{
	@Autowired
	private ITipoNotificacionDAO tipoNotificacionDAO;
	
	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public List<TipoNotificacion> findAll()
	{
		return tipoNotificacionDAO.findAll();
	} // findAll

	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public TipoNotificacion findById(Long id)
	{
		return tipoNotificacionDAO.findById(id);
	} // findById
	
	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public List<TipoNotificacion> findByApp(String app)
	{
		return tipoNotificacionDAO.findByApp(app);
	} // findAll
}
