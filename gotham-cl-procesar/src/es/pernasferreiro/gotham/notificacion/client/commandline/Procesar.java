/**
 * 
 */
package es.pernasferreiro.gotham.notificacion.client.commandline;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;

/**
 * @author tR1K1
 *
 */
public final class Procesar
{
	private static final String USER_AGENT = "Mozilla/5.0";
	
	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception
	{
		String url = "http://" + args[0] + ":8080/gotham/notificacion/procesar";
//		System.out.println("\nSending 'POST' request to URL : " + url);
		
		HttpPost post = new HttpPost(url);
		post.addHeader("User-Agent", USER_AGENT);
		
		HttpClient client = HttpClientBuilder.create().build();
		HttpResponse response = client.execute(post);		
		
		// tratamiento de la respuesta del servidor
//		System.out.println("Post parameters : " + post.getEntity());
		System.out.println("Response Code : " + response.getStatusLine().getStatusCode());

//		BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
//		StringBuffer result = new StringBuffer();
//		String line = "";
//		while ((line = rd.readLine()) != null)
//		{
//			result.append(line);
//		} // while
//
//		System.out.println(result.toString());
	} // main
} // class
