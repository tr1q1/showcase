/**
 * 
 */
package es.pernasferreiro.gotham.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import es.pernasferreiro.gotham.domain.utils.ConfiguracionUtils;

/**
 * @author tino
 *
 */
public final class SMS
{
//	private static final String USER_AGENT = "Mozilla/5.0";
//	private static final String CONTENT_TYPE  = "application/json";
//	private static final String SMS_SERVER = "http://172.17.50.94:8766";
//	private static final String SMS_TOKEN  = "2GsJKOLK5R!_?";

	private static final Logger logger = LoggerFactory.getLogger(SMS.class);
	
	public static void postSMS(String telefono, String mensaje) throws ClientProtocolException, IOException
	{
		HttpClient client = HttpClientBuilder.create().build();
		String urlServer = "http://" +
							(ConfiguracionUtils.getParametro("SMS", "SERVER")).getValor() +
							":" +
							(ConfiguracionUtils.getParametro("SMS", "PORT")).getValor();
		HttpPost post = new HttpPost(urlServer);

		// add header
		post.setHeader("User-Agent", (ConfiguracionUtils.getParametro("SMS", "USER_AGENT")).getValor());
		String contentType = (ConfiguracionUtils.getParametro("COMMON", "CONTENT_TYPE")).getValor();
		post.setHeader("Content-Type", contentType);
		post.setHeader("Accept", contentType);
		
		JSONObject parametros = new JSONObject();
		parametros.put("number", telefono.trim()); 
		parametros.put("message", mensaje.trim());
		parametros.put("token", (ConfiguracionUtils.getParametro("SMS", "TOKEN")).getValor());
		
		post.setEntity(new StringEntity(parametros.toString()));

		HttpResponse response = client.execute(post);
		
		if (logger.isDebugEnabled())
		{
			logger.debug("\nSending 'POST' request to URL : " + urlServer);
			logger.debug("Post parameters : " + post.getEntity());
			logger.debug("Response Code : " + response.getStatusLine().getStatusCode());
	
			BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
	
			StringBuffer result = new StringBuffer();
			String line = "";
			while ((line = rd.readLine()) != null)
			{
				result.append(line);
			} // while
	
			logger.debug(result.toString());
		} // then
	} // postSMS
} // class
