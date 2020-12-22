package es.pernasferreiro.gotham.domain.exceptions;

/**
 * Excepciones personalizadas lanzadas desde el controlador
 */
@SuppressWarnings("serial")
public class NotificacionException extends RuntimeException
{
	String message;
	
	/**
	 * Inicializa NotificacionControllerException
	 * @param message Mensaje de error
	 */
	public NotificacionException(String message)
	{
		super(message);
		this.message = message;
	}

	/**
	 * @return the message
	 */
	public String getMessage()
	{
		return message;
	}
}