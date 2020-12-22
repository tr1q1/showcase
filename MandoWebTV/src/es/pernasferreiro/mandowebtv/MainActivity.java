package es.pernasferreiro.mandowebtv;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Toast;

import com.beardedhen.androidbootstrap.BootstrapButton;

public class MainActivity extends Activity implements OnClickListener
{
	private static final String DEFAULT_IP = "192.168.10.12";
    private static final int DEFAULT_PORT = 30000;
    private static final int TIMEOUT = 5000;
    
    private BootstrapButton btBack;
    private BootstrapButton btDown;
    private BootstrapButton btForward;
    private BootstrapButton btLeft;
    private BootstrapButton btMenu;
    private BootstrapButton btOk;
    private BootstrapButton btOptions;
    private BootstrapButton btPlay;
    private BootstrapButton btRewind;
    private BootstrapButton btRight;
    private BootstrapButton btStop;
    private BootstrapButton btUp;
    
    private Socket conn;
    private String ip;
    
	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
        btUp = (BootstrapButton)super.findViewById(R.id.btUp);
        btDown = (BootstrapButton)super.findViewById(R.id.btDown);
        btLeft = (BootstrapButton)super.findViewById(R.id.btLeft);
        btRight = (BootstrapButton)super.findViewById(R.id.btRight);
        btOk = (BootstrapButton)super.findViewById(R.id.btOk);
        btBack = (BootstrapButton)super.findViewById(R.id.btBack);
        btOptions = (BootstrapButton)super.findViewById(R.id.btOptions);
        btRewind = (BootstrapButton)super.findViewById(R.id.btRewind);
        btPlay = (BootstrapButton)super.findViewById(R.id.btPlay);
        btStop = (BootstrapButton)super.findViewById(R.id.btStop);
        btForward = (BootstrapButton)super.findViewById(R.id.btForward);
        btMenu = (BootstrapButton)super.findViewById(R.id.btMenu);

        btUp.setOnClickListener(this);
        btDown.setOnClickListener(this);
        btLeft.setOnClickListener(this);
        btRight.setOnClickListener(this);
        btOk.setOnClickListener(this);
        btBack.setOnClickListener(this);
        btOptions.setOnClickListener(this);
        btRewind.setOnClickListener(this);
        btPlay.setOnClickListener(this);
        btStop.setOnClickListener(this);
        btForward.setOnClickListener(this);
        btMenu.setOnClickListener(this);
	} // onCreate
	
    @Override
	protected void onResume()
	{
		super.onResume();
		
        ip = PreferenceManager.getDefaultSharedPreferences(this).getString("etIP", DEFAULT_IP);
        (new Thread(new ConnectionThread())).start();
	}

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        getMenuInflater().inflate(R.menu.settings, menu);
        
        return true;
    }
    	
    @Override
    protected void onDestroy()
    {
        try
        {
            if (
            	(null != conn) && 
            	(conn.isConnected())
            )
            {
                conn.close();
            } // then
        }
        catch(IOException ioexception)
        {
            Toast.makeText(getApplicationContext(), "Imposible cerrar la conexion", Toast.LENGTH_SHORT).show();
        } // catch
        
        super.onDestroy();
    }

	@Override
	public void onClick(View v)
	{
		switch (v.getId())
		{
			case R.id.btUp:
				this.sendRequest("U");
				break;
			case R.id.btMenu:
				this.sendRequest("m");
				break;
			case R.id.btRewind:
				this.sendRequest("w");
				break;
			case R.id.btPlay:
				this.sendRequest("y");
				break;
			case R.id.btForward:
				this.sendRequest("f");
				break;
			case R.id.btBack:
				this.sendRequest("F");
				break;
			case R.id.btStop:
				this.sendRequest("s");
				break;
			case R.id.btOk:
				this.sendRequest("Q");
				break;
			case R.id.btDown:
				this.sendRequest("D");
				break;
			case R.id.btLeft:
				this.sendRequest("L");
				break;
			case R.id.btRight:
				this.sendRequest("R");
				break;
			case R.id.btOptions:
				this.sendRequest("V");
				break;
		} // switch
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item)
	{
		switch (item.getItemId())
		{
			case R.id.menu_settings:
				Intent opciones = new Intent(MainActivity.this, OptionsActivity.class);
				startActivity(opciones);
				
				break;
		} // switch
		
		return true;
	}
	
// METODOS DE USO INTERNO
	private void sendRequest(String s)
    {
        if (! Common.isConnected((ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE), this.conn))
        {
        	(new Thread(new ConnectionThread())).start();
        } // then
        
    	try 
    	{
    		OutputStream outstream = this.conn.getOutputStream(); 
    		PrintWriter out = new PrintWriter(outstream, true);

    		out.println(s);
    		out.flush();
    	} // try
    	catch (IOException e)
    	{
    		Toast.makeText(getApplicationContext(), "Imposible realizar la accion", Toast.LENGTH_SHORT).show();
    	} // catch
    } // sendRequest
	
    class ConnectionThread implements Runnable
    {
    	public void run()
    	{
    		try
    		{
    			if (Common.isNetAvaliable((ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE)))
    			{
                	conn = new Socket(InetAddress.getByName(ip), DEFAULT_PORT);
                	conn.setSoTimeout(TIMEOUT);
            	} // then
    			else
    			{
        			runOnUiThread(new java.lang.Runnable()
        			{
        				public void run()
        				{
        					Toast.makeText(MainActivity.this, "El dispositivo no tiene conexión de red", Toast.LENGTH_SHORT).show();
        				}
        			});
    			} // else
    		} // try
    		catch (UnknownHostException unknownhostexception)
    		{
    			runOnUiThread(new java.lang.Runnable()
    			{
    				public void run()
    				{
    					Toast.makeText(MainActivity.this, "No existe un WebTV con la IP '"+ ip + "'", Toast.LENGTH_SHORT).show();
    				}
    			});
    		}
    		catch (IOException ioexception)
    		{
	            runOnUiThread(new java.lang.Runnable()
	            {
	                public void run()
	                {
	                    android.widget.Toast.makeText(MainActivity.this, "Imposible conectar con '" + ip + "'", Toast.LENGTH_SHORT).show();
	                }
	            });
	        } // catch
    	} // run
    } // class
} // class
