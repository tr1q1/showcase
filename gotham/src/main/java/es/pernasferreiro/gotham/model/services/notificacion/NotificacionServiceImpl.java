package es.pernasferreiro.gotham.model.services.notificacion;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import es.pernasferreiro.gotham.controller.notificacion.NotificacionForm;
import es.pernasferreiro.gotham.domain.beans.StatBean;
import es.pernasferreiro.gotham.domain.exceptions.NotificacionException;
import es.pernasferreiro.gotham.domain.utils.ConfiguracionUtils;
import es.pernasferreiro.gotham.domain.utils.EstadoNotificacion;
import es.pernasferreiro.gotham.model.persistence.notificable.INotificableDAO;
import es.pernasferreiro.gotham.model.persistence.notificable.Notificable;
import es.pernasferreiro.gotham.model.persistence.notificacion.INotificacionDAO;
import es.pernasferreiro.gotham.model.persistence.notificacion.Notificacion;
import es.pernasferreiro.gotham.model.persistence.tiponotificacion.ITipoNotificacionDAO;
import es.pernasferreiro.gotham.model.persistence.tiponotificacion.TipoNotificacion;
import es.pernasferreiro.gotham.util.Mail;
import es.pernasferreiro.gotham.util.SMS;

/**
 * Servicio de la entidad Notificacion
 */
@Service("notificacionService")
@Transactional
public class NotificacionServiceImpl implements INotificacionService
{
	@Autowired
	private INotificacionDAO dao;
	
	@Autowired
	private ITipoNotificacionDAO daoTipos;
	
	@Autowired
	private INotificableDAO daoNotificables;
	
	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public List<Notificacion> findAll()
	{
		return dao.findAll();
	} // findAll

	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public Notificacion findById(Long id)
	{
		return dao.findById(id);
	} // findAll

	@Override
	@Transactional(readOnly = false)
	public Long insert(NotificacionForm input)
	{
		Notificacion notificacion = new Notificacion();
		notificacion.setMaquina(input.getMaquina());
		notificacion.setApp(input.getApp());
		
		if (300 < input.getMensaje().length())
		{
			notificacion.setMensaje(input.getMensaje().substring(0, 299));
		} // then
		else
		{
			notificacion.setMensaje(input.getMensaje());
		} // else
		
		if (1000 < input.getStackTrace().length())
		{
			notificacion.setStackTrace(input.getStackTrace().substring(0, 999));
		} // then
		else
		{
			notificacion.setStackTrace(input.getStackTrace());
		} // else
		
		// obtener el Tipo de Notificacion a partir de su ID
		TipoNotificacion tipo = daoTipos.findById(input.getIdTipo());
		
		if (null != tipo)
		{
			notificacion.setTipo(tipo);
		} // then
		else
		{
			throw new NotificacionException("El tipo de notificacion '" + input.getIdTipo() + "' no existe o no es valido.");
		} // else

		notificacion.setFecha(new java.sql.Timestamp((new java.util.Date()).getTime()));
		notificacion.setEstado(EstadoNotificacion.PENDIENTE.getEstado());
		
		this.dao.save(notificacion);
		
		return notificacion.getId();
	} // insert
	
	@Override
	@Transactional(readOnly = false)
	public Long update(NotificacionForm input)
	{
		Notificacion notificacion = dao.findById(input.getId());

		Long resultado = null; 
		if (null != notificacion)
		{
			notificacion.setEstado(input.getEstado());
			
			this.dao.save(notificacion);
			
			resultado = notificacion.getId();
		} // then
		
		return resultado;
	} // update
	
	@Override
	@Transactional(readOnly = false)
	public Long procesar()
	{
		List<Notificacion> notificaciones = dao.findAll();
		
		Long resultado = new Long(0);
		if (
			(null != notificaciones) &&
			(0 < notificaciones.size())
		)
		{
			for (Notificacion notificacion: notificaciones)
			{
				if (null != notificacion.getTipo())
				{
					List<Notificable> notificables = daoNotificables.findByApp(notificacion.getApp());
					if (
						(null != notificables) &&
						(0 < notificables.size())
					)
					{
						for (Notificable notificable: notificables)
						{
							try
							{
								if ("SMS".equalsIgnoreCase(notificacion.getTipo().getSistema()))
								{
									SMS.postSMS(notificable.getTelefono(), notificacion.getMensaje());
								} // then
								else if ("EMAIL".equalsIgnoreCase(notificacion.getTipo().getSistema()))
								{
									Mail.postMail(notificable.getEmail(), notificacion.getMensaje(), notificacion.getStackTrace());
								} // else if
								else if ("TELEGRAM".equalsIgnoreCase(notificacion.getTipo().getSistema()))
								{
									// TODO: pendiente
								} // else if
								else if ("TWITTER".equalsIgnoreCase(notificacion.getTipo().getSistema()))
								{
									// TODO: pendiente
								} // else if
							} // try
							catch (Exception e)
							{
								// este error se produce cuando el móvil encargado de remitir los SMSs falla
								Mail.postMail(
									(ConfiguracionUtils.getParametro("EMAIL", "INCIDENCIAS")).getValor(),
									"[ERROR][NOTIFICACIONES] Imposible enviar la notificación con id = '" + notificacion.getId() + "'",
									"Ha sido imposible enviar la notificación con id = '" + notificacion.getId() + "': " + ExceptionUtils.getStackTrace(e)
								);
								
								e.printStackTrace();
							} // catch
							
							if (
								(! "EMAIL".equalsIgnoreCase(notificacion.getTipo().getSistema())) &&
								(StringUtils.isNotBlank(notificacion.getStackTrace()))
							)
							{
								Mail.postMail(notificable.getEmail(), notificacion.getMensaje(), notificacion.getStackTrace());
							} // then
						} // for notificables
					} // then
					else
					{
						Mail.postMail(
							(ConfiguracionUtils.getParametro("EMAIL", "INCIDENCIAS")).getValor(),
							"[WARNING][NOTIFICACIONES] No hay personas a las que notificar asociadas a la aplicación '" + notificacion.getApp() + "'",
							"No se han obtenido personas/contactos a los que remitir la notificación/alerta asociadas a la aplicación '" + notificacion.getApp() + "'"
						);
					} // else
				} // then
				else
				{
					Mail.postMail(
						(ConfiguracionUtils.getParametro("EMAIL", "INCIDENCIAS")).getValor(),
						"[ERROR][NOTIFICACIONES] Imposible obtener el tipo de notificación",
						"Ha sido imposible obtener el tipo de la notificación con id = '" + notificacion.getId() + "'"
					);
				} // else

				
				try
				{
					NotificacionForm notificacionForm = new NotificacionForm(notificacion);
					notificacionForm.setEstado(EstadoNotificacion.COMPLETADA.getEstado());
					
					this.update(notificacionForm);
				} // try
				catch (Exception e)
				{
					Mail.postMail(
						(ConfiguracionUtils.getParametro("EMAIL", "INCIDENCIAS")).getValor(),
						"[ERROR][NOTIFICACIONES] Imposible marcar como completada una notificación",
						"Ha sido imposible marcar como completada la notificación con id = '" +
								notificacion.getId() +
								"' - " + 
								ExceptionUtils.getStackTrace(e)
					);
					
					throw e;
				} // catch
			} // for
		} // then
		
		return resultado;
	} // procesar
	
	@Override
	@Transactional(isolation = Isolation.READ_UNCOMMITTED, readOnly = true)
	public List<StatBean> getStats(boolean porDia)
	{
		return dao.getStats(porDia);
	} // getStats
} // class
