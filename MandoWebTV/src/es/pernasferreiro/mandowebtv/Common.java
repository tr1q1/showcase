package es.pernasferreiro.mandowebtv;

import java.net.Socket;

import android.net.ConnectivityManager;
import android.net.NetworkInfo;

/**
 * @author tR1K1
 *
 */
public final class Common
{
	public static boolean isConnected(ConnectivityManager cm, Socket s)
	{
		return (isNetAvaliable(cm) && ((null != s) && (s.isConnected())));
	} // isConnected
	
    public static boolean isNetAvaliable(ConnectivityManager cm)
    {
    	boolean result = false;
        if (null != cm)
        {
            NetworkInfo networkinfo = cm.getActiveNetworkInfo();
            
            result = ((null != networkinfo) && (networkinfo.isConnected()));
        } // then
        
        return result;
    } // isConnected
} // class
