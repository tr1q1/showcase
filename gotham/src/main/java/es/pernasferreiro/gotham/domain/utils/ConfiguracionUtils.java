/**
 * 
 */
package es.pernasferreiro.gotham.domain.utils;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.naming.InitialContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import es.pernasferreiro.gotham.model.persistence.configuracion.Configuracion;
import es.pernasferreiro.gotham.model.persistence.configuracion.IConfiguracionDAO;

/**
 * @author tino
 *
 */
@Component
public final class ConfiguracionUtils
{
	private static IConfiguracionDAO sDao; // se utilizará para poder usarlo de forma static
	
	@Autowired
	private IConfiguracionDAO dao;
	
	@PostConstruct
	private void initStaticDao()
	{
		sDao = this.dao; // a partir de aquí ya se puede usar de forma static
	} // initStaticDao
	
	public static List<Configuracion> getAll()
	{
		return sDao.findAll(ConfiguracionUtils.getEntornoEjecucion());
	} // getAll
	
	public static List<Configuracion> getAllGrupo(String grupo)
	{
		return sDao.findAllGrupo(ConfiguracionUtils.getEntornoEjecucion(), grupo);
	} // getAllGrupo
	
	public static Configuracion getParametro(String grupo, String parametro)
	{
		return sDao.findByParametro(ConfiguracionUtils.getEntornoEjecucion(), grupo, parametro);
	} // getParametro
	
	public static String getEntornoEjecucion()
	{
		String resultado = null;
		try
		{
			Object jndiConstant = new InitialContext().lookup("java:global/ENTORNO");
			String entornoServer = (String) jndiConstant;
			  
			resultado = entornoServer;
		} // try
		catch (Exception e)
		{
			e.printStackTrace();
		} // catch
		
		return resultado;
	} // getEntornoEjecucion
} // class
