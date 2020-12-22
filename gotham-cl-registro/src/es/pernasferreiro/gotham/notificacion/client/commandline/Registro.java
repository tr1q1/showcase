/**
 * 
 */
package es.pernasferreiro.gotham.notificacion.client.commandline;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.InetAddress;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.JSONObject;

/**
 * @author tR1K1
 *
 */
public final class Registro
{
	private static final String USER_AGENT = "Mozilla/5.0";
	private static final String CTE_CONTENT_JSON = "application/json";
	
	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception
	{
		if (4 <= args.length)
		{
			String maquina = InetAddress.getLocalHost().getHostName();
			
			if (
				(null == maquina) ||
				(0 >= maquina.trim().length())
			)
			{
				maquina = InetAddress.getLocalHost().getHostAddress();
			} // then

			JSONObject parametros = new JSONObject();
			parametros.put("maquina", maquina); 
			parametros.put("app", args[1]);
			parametros.put("idTipo", args[2]);
			parametros.put("mensaje", args[3]);
			parametros.put("stackTrace", args[4]);
			
			String url = "http://" + args[0] + ":8080/gotham/notificacion/";
			HttpPost post = new HttpPost(url);
			post.addHeader("User-Agent", USER_AGENT);
			post.addHeader("Content-Type", CTE_CONTENT_JSON);
			
			post.setEntity(new StringEntity(parametros.toString()));
	
			HttpClient client = HttpClientBuilder.create().build();
			HttpResponse response = client.execute(post);
			
			
			// tratamiento de la respuesta del servidor
//			System.out.println("\nSending 'POST' request to URL : " + url);
//			System.out.println("Post parameters : " + post.getEntity());
			System.out.println("Response Code : " + response.getStatusLine().getStatusCode());

			if (200 != response.getStatusLine().getStatusCode())
			{
				BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
				StringBuffer result = new StringBuffer();
				String line = "";
				while ((line = rd.readLine()) != null)
				{
					result.append(line);
				} // while
		
				System.out.println(result.toString());
			} // then
		} // then
		else
		{
			throw new RuntimeException("Faltan parámetros de entrada. Uso: <SERVIDOR_NOTIFICACIONES> <ID_APP> <ID_TIPO_NOTIFICACION> <MENSAJE_A_ENVIAR> <TRAZA_ERROR_A_ENVIAR_POR_EMAIL>");
		} // else
	} // main
} // class
