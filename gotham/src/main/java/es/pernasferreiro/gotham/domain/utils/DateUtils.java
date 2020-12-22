package es.pernasferreiro.gotham.domain.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Utilidades de fechas
 */
public class DateUtils
{
	public static String FORMATO_ESPANHOL = "dd-MM-yyyy";
	public static String FORMATO_INGLES = "yyyy-MM-dd";
	
	/**
	 * Obtiene el ano actual
	 * @return
	 */
	public static int getCurrentYear()
	{
		Calendar cal = Calendar.getInstance();
		return cal.get(Calendar.YEAR);
	}
	
	/**
	 * Obtiene el mes actual
	 * @return
	 */
	public static int getCurrentMonth()
	{
		Calendar cal = Calendar.getInstance();
		return cal.get(Calendar.MONTH);
	}

	/**
	 * Obtiene la fecha del primer dia del ano
	 * @param year Ano
	 * @return Fecha del primer dia del ano especificado
	 */
	public static Date getFirstDay(int year)
	{
		return getFirstDay(year, Calendar.JANUARY);
	}
	
	/**
	 * Obtiene la fecha del ultimo dia del ano
	 * @param year Ano
	 * @return Fecha del ultimo dia del ano especificado
	 */
	public static Date getLastDay(int year)
	{
		return getLastDay(year, Calendar.DECEMBER);
	}
	
	/**
	 * Obtiene la fecha correspondiente al primer dia del mes y ano
	 * @param year Ano
	 * @param month Mes
	 * @return Fecha correspondiente al primer dia del mes y ano
	 */
	public static Date getFirstDay(int year, int month)
	{
		Calendar cal = getCalendarFirstDay(year, month);
		return new Date(cal.getTimeInMillis());
	}

	/**
	 * Obtiene la fecha correspondiente al ultimo dia del mes y ano
	 * @param year Ano
	 * @param month Mes
	 * @return Fecha correspondiente al ultimo dia del mes y ano
	 */
	public static Date getLastDay(int year, int month)
	{
		Calendar cal = getCalendarFirstDay(year, month);
		
		int maxDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		cal.set(Calendar.DAY_OF_MONTH, maxDay);
		
		return new Date(cal.getTimeInMillis());
	}
	
	/**
	 * Obtiene la fecha resultante de restar una cantidad de anos a la
	 * fecha actual y obtener el primer dia de ese mes
	 * @param yearsDiff Anos a resta
	 * @return Fecha pasada
	 */
	public static Date getPastDate(int yearsDiff)
	{
		Calendar cal = getCalendarFirstDay(null, null);
		cal.add(Calendar.YEAR, -yearsDiff);
		return new Date(cal.getTimeInMillis());
	}

	/**
	 * Transforma a fecha la cadena especificada
	 * @param strDate cadena que representa la fecha
	 * @return Fecha
	 * @throws ParseException 
	 */
	public static Date stringToDate(String strDate) throws ParseException
	{
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		return formatter.parse(strDate);
	}
	
	/**
	 * Transforma a cadena la fecha
	 * @param date fecha a transformar
	 * @return Cadena que representa la fecha
	 */
	public static String dateToString(Date date, String formato)
	{
		SimpleDateFormat formatter = new SimpleDateFormat(formato);
		return formatter.format(date);
	}
	
	private static Calendar getCalendarFirstDay(Integer year, Integer month)
	{
		Calendar cal = Calendar.getInstance();
		if (null != year)
		{
			cal.set(Calendar.YEAR, year);
		}
		if (null != month)
		{
			cal.set(Calendar.MONTH, month);
		}
		cal.set(Calendar.DAY_OF_MONTH, 1);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.clear(Calendar.MINUTE);
		cal.clear(Calendar.SECOND);
		cal.clear(Calendar.MILLISECOND);
		return cal;
	}
}
