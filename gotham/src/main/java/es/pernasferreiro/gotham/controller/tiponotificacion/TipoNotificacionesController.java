package es.pernasferreiro.gotham.controller.tiponotificacion;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import es.pernasferreiro.gotham.controller.GenericController;
import es.pernasferreiro.gotham.model.persistence.tiponotificacion.TipoNotificacion;
import es.pernasferreiro.gotham.model.services.tiponotificacion.ITipoNotificacionService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/tiponotificacion")
public class TipoNotificacionesController extends GenericController
{
	@Autowired
	private ITipoNotificacionService service;
		
	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Collection<TipoNotificacion> obtenerTiposNotificacion()
	{
		return service.findAll();
	} // obtenerTiposNotificacion
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody TipoNotificacion obtenerTipoNotificacion(@PathVariable long id)
	{
		return service.findById(id);
	} // obtenerTipoNotificacion
	
	@RequestMapping(value = "/app/{app}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Collection<TipoNotificacion> obtenerTiposNotificacionPorApp(@PathVariable String app)
	{
		return service.findByApp(app);
	} // obtenerTiposNotificacionPorApp
}
