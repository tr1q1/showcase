/**
 * 
 */
package es.pernasferreiro.gotham.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import es.pernasferreiro.gotham.domain.utils.ConfiguracionUtils;

/**
 * @author tino
 *
 */
public final class Mail
{
	public static void postMail(
			String[] destinatarios,
			String asunto,
		    String mensaje,
		    String de)
	{
		//Set the host smtp address
		Properties props = new Properties();
		props.put("mail.smtp.host", (ConfiguracionUtils.getParametro("EMAIL", "SERVER")).getValor());
		props.put("mail.smtp.port", (ConfiguracionUtils.getParametro("EMAIL", "PORT")).getValor());
	
		try
		{
			// create some properties and get the default Session
			Session session = Session.getDefaultInstance(props, null);
			session.setDebug(false);
			
			// create a message
			Message msg = new MimeMessage(session);
			
			// set the from and to address
			InternetAddress addressFrom = new InternetAddress(de);
			msg.setFrom(addressFrom);
			
			InternetAddress[] addressTo = new InternetAddress[destinatarios.length]; 
			for (int i = 0; i < destinatarios.length; i++)
			{
			    addressTo[i] = new InternetAddress(destinatarios[i]);
			} // for
			msg.setRecipients(Message.RecipientType.TO, addressTo);
			
			// Optional : You can also set your custom headers in the Email if you Want
			// msg.addHeader("MyHeaderName", "myHeaderValue");
			
			// Setting the Subject and Content Type
			msg.setSubject(asunto);
			msg.setContent(mensaje, (ConfiguracionUtils.getParametro("EMAIL", "CONTENT_TYPE")).getValor());
			
			Transport.send(msg);
		} // try
		catch (MessagingException e)
		{
			e.printStackTrace();
		} // catch
	} // postMail 

	public static void postMail(String[] destinatarios, String asunto, String mensaje)
	{
		Mail.postMail(destinatarios, asunto, mensaje, (ConfiguracionUtils.getParametro("EMAIL", "REMITENTE")).getValor());
	} // post Mail
	
	public static void postMail(String destinatario, String asunto, String mensaje)
	{
		Mail.postMail(new String[] {destinatario}, asunto, mensaje);
	} // post Mail
} // class
