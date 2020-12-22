package es.pernasferreiro.gotham.domain.exceptions;



/**
 * Se utiliza cuando no se encuentra una instancia en base de datos
 */
@SuppressWarnings("serial")
public class InstanceNotFoundException extends Exception
{
	private Object key;
	private String className;
	
	/**
	 * Inicializa InstanceNotFoundException
	 * 
	 * @param key clave del objeto que genera la excepcion
	 * @param className nombre de clase del objeto que genera la excepcion
	 */
	public InstanceNotFoundException(Object key, String className)
	{
		super("Instance not found (key = [" + key + "] - className = [" + className + "])");
		this.key = key;
		this.className = className;		
	}
	
	/**
	 * Obtiene la clave primaria del objeto para el que se genera la excepcion
	 * 
	 * @return Clave primaria del objeto para el que se genera la excepcion
	 */
	public Object getKey()
	{
		return key;
	}

	/**
	 * Obtiene el nombre de clase del objeto para el que se genera la excepcion
	 * 
	 * @return Nombre de clase del objeto para el que se genera la excepcion
	 */
	public String getClassName()
	{
		return className;
	}
}