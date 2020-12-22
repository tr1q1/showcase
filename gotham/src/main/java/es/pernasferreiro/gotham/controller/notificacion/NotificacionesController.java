package es.pernasferreiro.gotham.controller.notificacion;

import java.util.Collection;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import es.pernasferreiro.gotham.controller.GenericController;
import es.pernasferreiro.gotham.domain.beans.StatBean;
import es.pernasferreiro.gotham.domain.utils.ConfiguracionUtils;
import es.pernasferreiro.gotham.model.persistence.notificacion.Notificacion;
import es.pernasferreiro.gotham.model.services.notificacion.INotificacionService;
import es.pernasferreiro.gotham.util.Mail;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/notificacion")
public class NotificacionesController extends GenericController
{
	@Autowired
	private INotificacionService service;
		
	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Collection<Notificacion> obtenerNotificaciones()
	{
		return service.findAll();
	} // obtenerNotificacion
	
	@RequestMapping(value = "/", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Long insert(@RequestBody NotificacionForm form)
	{
		form.validar();
		
		return service.insert(form);
	} // insert
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Notificacion obtenerNotificacion(@PathVariable long id)
	{
		return service.findById(id);
	} // obtenerNotificacion
	
	@RequestMapping(value = "/procesar", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Long procesarNotificaciones()
	{
		try
		{
			return service.procesar();
		} // try
		catch (Exception e)
		{
			Mail.postMail((ConfiguracionUtils.getParametro("EMAIL", "INCIDENCIAS")).getValor(), "[ERROR]" + e.getMessage(), ExceptionUtils.getStackTrace(e));
			
			throw e;
		} // catch
	} // procesarNotificaciones
	
	@RequestMapping(value = "/stats", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Collection<StatBean> obtenerEstadisticas()
	{
		return service.getStats(false);
	} // obtenerEstadisticas
	
	@RequestMapping(value = "/stats/day", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Collection<StatBean> obtenerEstadisticasDelDia()
	{
		return service.getStats(true);
	} // obtenerEstadisticasDelDia
} // class
