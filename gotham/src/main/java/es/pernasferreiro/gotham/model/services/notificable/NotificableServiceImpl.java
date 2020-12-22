package es.pernasferreiro.gotham.model.services.notificable;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import es.pernasferreiro.gotham.model.persistence.notificable.INotificableDAO;
import es.pernasferreiro.gotham.model.persistence.notificable.Notificable;

/**
 * Servicio de la entidad Notificable
 */
@Service("notificableService")
@Transactional
public class NotificableServiceImpl implements INotificableService
{
	@Autowired
	private INotificableDAO notificableDAO;
	
	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public List<Notificable> findAll()
	{
		return notificableDAO.findAll();
	} // findAll

	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public Notificable findById(Long id)
	{
		return notificableDAO.findById(id);
	} // findById
	
	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public List<Notificable> findByApp(String app)
	{
		return notificableDAO.findByApp(app);
	} // findAll
}
