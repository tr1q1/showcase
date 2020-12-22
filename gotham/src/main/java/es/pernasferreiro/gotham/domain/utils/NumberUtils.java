package es.pernasferreiro.gotham.domain.utils;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.util.Locale;

import org.apache.commons.lang3.StringUtils;


/**
 * Utilidades numericas
 */
public class NumberUtils
{
	private static final Locale _locale_es_ES = new Locale("es","ES");
	
	private static DecimalFormat _df;
	private static NumberFormat _nf;
	
	static
	{
		_df = new DecimalFormat();
		_df.setMaximumIntegerDigits(15);
		_df.setMinimumIntegerDigits(1);
		_df.setMaximumFractionDigits(2);
		_df.setMinimumFractionDigits(2);
		_df.setPositiveSuffix("");
		_df.setNegativeSuffix("");
		_df.setNegativePrefix("-");
		_df.setPositivePrefix(" ");
		_df.setGroupingSize(0);
		_df.setGroupingUsed(false);
        //_df.setDecimalSeparatorAlwaysShown(true);
		
		_nf = NumberFormat.getNumberInstance(_locale_es_ES);
	}
	
	/**
	 * Transforma una cadena a bigdecimal
	 * @param cadena cadena que representa un numero
	 * @return bigdecimal
	 * @throws ParseException
	 */
	public static BigDecimal stringToBigDecimal(String cadena) throws ParseException
	{
		BigDecimal bd = null;
		if (!StringUtils.isBlank(cadena))
		{
			cadena = cadena.trim();
			if (cadena.charAt(0) == '+')
			{
				cadena = cadena.substring(1);
			}
			cadena = cadena.replace('.', ',');
			bd = new BigDecimal(_nf.parse(cadena).toString());
		}
		return bd;
	}
	
	/**
	 * Transforma un BigDecimal a String
	 * @param numero BigDecimal a transforma
	 * @return Cadena
	 */
	public static String bigDecimalToString(BigDecimal numero)
	{
		String cadena = _df.format(numero);
		return cadena;
	}
}
