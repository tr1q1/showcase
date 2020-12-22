package es.pernasferreiro.gotham.domain.utils;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

import es.pernasferreiro.gotham.domain.exceptions.NotificacionException;

/**
 * Clase de utilidad web 
 */
public class Validation
{
	/**
	 * Valida si se esta suministrando la varible
	 * @param nombre Nombre del campo
	 * @param valor Valor de la variable
	 */
	public static void validar(String nombre, String valor)
	{
		if (StringUtils.isBlank(valor))
		{
			throw new NotificacionException(String.format("El campo '%1$s' es obligatorio", nombre));
		}
	}
	
	/**
	 * Valida si se esta suministrando la varible
	 * @param nombre Nombre del campo
	 * @param valor Valor de la variable
	 */
	public static void validarObj(String nombre, Object valor)
	{
		if (null == valor)
		{
			throw new NotificacionException(String.format("El campo '%1$s' es obligatorio", nombre));
		}
	}

	/**
	 * Valida que la cadena tiene un formato de fecha correcta
	 * @param nombre Nombre del campo
	 * @param fecha valor de la fecha
	 * @return Fecha
	 */
	public static Date validarFormatoFecha(String nombre, String fecha)
	{
		try
		{
			return DateUtils.stringToDate(fecha);
		}
		catch (ParseException e)
		{
			throw new NotificacionException(String.format("El campo '%1$s' tiene un formato incorrecto", nombre));
		}
	}
	
	/**
	 * Valida que la cadena tiene un formato de importe correcto
	 * @param nombre Nombre del campo
	 * @param fecha Valor del importe
	 * @return Bigdecimal
	 */
	public static BigDecimal validarFormatoImporte(String nombre, String importe)
	{
		try
		{
			return NumberUtils.stringToBigDecimal(importe);
		}
		catch (ParseException e)
		{
			throw new NotificacionException(String.format("El campo '%1$s' tiene un formato incorrecto", nombre));
		}
	}
}
