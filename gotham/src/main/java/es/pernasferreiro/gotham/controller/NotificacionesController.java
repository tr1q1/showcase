package es.pernasferreiro.gotham.controller;

import java.util.Collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import es.pernasferreiro.gotham.model.persistence.notificacion.Notificacion;
import es.pernasferreiro.gotham.model.services.notificacion.INotificacionService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/notificacion")
public class NotificacionesController extends GenericController
{
	private static final Logger logger = LoggerFactory.getLogger(NotificacionesController.class);
	
	@Autowired
	private INotificacionService notificacionService;
		
	@RequestMapping(value = "/all", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Collection<Notificacion> obtenerNotificaciones()
	{
		logger.debug("Petición de consulta de todas las notificaciones ACTIVAS.");
		
		return notificacionService.findAll();
	} // obtenerNotificacion
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Notificacion obtenerNotificacion(@PathVariable long id)
	{
		logger.debug("Petición de consulta de notificacion con id '" + id + "' desde '" + id + "'.");
		
		return notificacionService.findById(id);
	} // obtenerNotificacion
}
