/**
 * 
 */
package es.pernasferreiro.notificacion;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;

/**
 * @author tR1K1
 *
 */
public final class SendSMS
{
	private static final String USER_AGENT = "Mozilla/5.0";
	
	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception
	{
		SendSMS http = new SendSMS();
		
		System.out.println("\nTesting 2 - Send Http POST request");
		http.sendPost();
	} // main
	
	// HTTP POST request
	private void sendPost() throws Exception
	{
		String url = "http://172.17.50.94:8766";
		
		HttpClient client = HttpClientBuilder.create().build();
		HttpPost post = new HttpPost(url);

		// add header
		post.setHeader("User-Agent", USER_AGENT);

		List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
		urlParameters.add(new BasicNameValuePair("number", "+34656278569"));
		urlParameters.add(new BasicNameValuePair("message", "PRUEBA 1 INDEPENDIENTE desde Java"));
		urlParameters.add(new BasicNameValuePair("token", "2GsJKOLK5R!_?"));

		post.setEntity(new UrlEncodedFormEntity(urlParameters));

		HttpResponse response = client.execute(post);
		System.out.println("\nSending 'POST' request to URL : " + url);
		System.out.println("Post parameters : " + post.getEntity());
		System.out.println("Response Code : " + response.getStatusLine().getStatusCode());

		BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));

		StringBuffer result = new StringBuffer();
		String line = "";
		while ((line = rd.readLine()) != null)
		{
			result.append(line);
		} // while

		System.out.println(result.toString());
	}
}
