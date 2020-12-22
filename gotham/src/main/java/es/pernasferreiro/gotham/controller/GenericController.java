package es.pernasferreiro.gotham.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import es.pernasferreiro.gotham.domain.exceptions.NotificacionException;

/**
 * Encapsula la funcionalidad comun a todos los controladores 
 */
public abstract class GenericController
{
	/**
	 * Captura las excepciones de tipo NotificacionControllerException
	 * (las de aplicacion) para enviarlas controladamente a la vista
	 * @param ex Excepcion que se produce
	 * @param request Request actual
	 * @param response Response actual
	 * @return Datos enviados en la response
	 * @throws IOException Excepcion de entrada salida
	 */
	 @ExceptionHandler(NotificacionException.class)
	 public @ResponseBody String handleUncaughtException(Exception ex,
			 WebRequest request, HttpServletResponse response) throws IOException
	{
       response.setHeader("Content-Type", "application/json");
   	   response.setStatus(600);
       return ex.getMessage();
	} // handleUncaughtException
}
