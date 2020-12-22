package es.pernasferreiro.gotham.controller.configuracion;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import es.pernasferreiro.gotham.controller.GenericController;
import es.pernasferreiro.gotham.model.persistence.configuracion.Configuracion;
import es.pernasferreiro.gotham.model.services.configuracion.IConfiguracionService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/configuracion")
public class ConfiguracionController extends GenericController
{
	@Autowired
	private IConfiguracionService service;
			
	@RequestMapping(value = "/", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Long insert(@RequestBody ConfiguracionForm form)
	{
		form.validar();
		
		return service.insert(form);
	} // insert
	
	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Collection<Configuracion> findAll()
	{
		return service.findAll();
	} // findAll

	@RequestMapping(value = "/{grupo}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Collection<Configuracion> findAllGrupo(@PathVariable String grupo)
	{
		return service.findAllGrupo(grupo);
	} // findAllGrupo
	
	@RequestMapping(value = "/{grupo}/{parametro}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Configuracion findByParametro(@PathVariable String grupo, @PathVariable String parametro)
	{
		return service.findByParametro(grupo, parametro);
	} // findAll
	
	@RequestMapping(value = "/id/{id:[\\d]+}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Configuracion findById(@PathVariable long id)
	{
		return service.findById(id);
	} // findById	
} // class
