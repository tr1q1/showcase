package es.pernasferreiro.gotham.controller.notificable;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import es.pernasferreiro.gotham.controller.GenericController;
import es.pernasferreiro.gotham.model.persistence.notificable.Notificable;
import es.pernasferreiro.gotham.model.services.notificable.INotificableService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/notificables")
public class NotificablesController extends GenericController
{
	@Autowired
	private INotificableService service;
		
	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Collection<Notificable> obtenerNotificables()
	{
		return service.findAll();
	} // obtenerNotificables
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Notificable obtenerNotificable(@PathVariable long id)
	{
		return service.findById(id);
	} // obtenerNotificable
	
	@RequestMapping(value = "/app/{app}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Collection<Notificable> obtenerNotificablesPorApp(@PathVariable String app)
	{
		return service.findByApp(app);
	} // obtenerNotificablesPorApp
}
