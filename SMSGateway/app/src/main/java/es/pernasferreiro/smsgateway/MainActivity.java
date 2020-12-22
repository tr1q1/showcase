package es.pernasferreiro.smsgateway;

import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.koushikdutta.async.AsyncNetworkSocket;
import com.koushikdutta.async.http.server.AsyncHttpServer;
import com.koushikdutta.async.http.server.AsyncHttpServerRequest;
import com.koushikdutta.async.http.server.AsyncHttpServerResponse;
import com.koushikdutta.async.http.server.HttpServerRequestCallback;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import es.pernasferreiro.smsgateway.utils.DateUtils;

public class MainActivity extends AppCompatActivity
{
    private static final int CTE_DEFAULT_PORT = 11513;

    private Boolean isEnabled = false;
    private AsyncHttpServer server = new AsyncHttpServer();

    private TextView tvLog;
    private TextView tvPassphrase;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tvLog = (TextView) findViewById(R.id.tvLog);

        TextView tvServer = (TextView) findViewById(R.id.tvServer);
        final String ip = this.getIPAddress(true);
        tvServer.setText("http://" + ip + ":" + CTE_DEFAULT_PORT + "/");
    } // onCreate

    @Override
    protected void onResume()
    {
        super.onResume();

        tvPassphrase = (TextView) findViewById(R.id.tvPassphrase);
        server.post("/", new HttpServerRequestCallback()
        {
            @Override
            public void onRequest(final AsyncHttpServerRequest request, final AsyncHttpServerResponse response)
            {
                final String log = new ProcessRequest().attendRequest(tvPassphrase.getText().toString().trim(), request);

                runOnUiThread(new Runnable()
                {
                    @Override
                    public void run()
                    {
                        AsyncNetworkSocket sock = (AsyncNetworkSocket) request.getSocket();

                        appendAtBeginningTextView("Petición recibida de '" + sock.getRemoteAddress().toString() + "': '" + log + "'");
                    } // run
                }); // runOnUiThread

                response.send(log);
                response.end();
            } // onRequest
        });
    } // onResume

    /**
     * metodo que arranca o detiene el servidor
     */
    public void changeServerState(View view)
    {
        TextView tvServer = (TextView) findViewById(R.id.tvServer);
        if (isEnabled)
        {
            this.appendAtBeginningTextView("Deshabilitando servidor");

            // parar servidor
            this.stopServer();

            tvServer.setTextColor(Color.parseColor("#cc0000"));
        } // then
        else
        {
            this.appendAtBeginningTextView("Habilitando servidor");

            // arrancar servidor
            this.startServer();

            tvServer.setTextColor(Color.parseColor("#669900"));
        } // else
    } // changeServerState

    private void startServer()
    {
        // TODO: arrancar un servidor en el puerto CTE_DEFAULT_PORT para atender las peticiones
        try
        {
            server.listen(CTE_DEFAULT_PORT);

            this.isEnabled = true;
        } // try
        catch (Exception e)
        {
            this.appendAtBeginningTextView(e.getStackTrace().toString());
        } // catch
    } // startServer

    private void stopServer()
    {
        // TODO: parar el servidor
        try
        {
            server.stop();
            this.isEnabled = false;
        } // try
        catch (Exception e)
        {
            this.appendAtBeginningTextView(e.getStackTrace().toString());
        } // catch
    } // stopServer

    public String getIPAddress(boolean useIPv4)
    {
        try
        {
            List<NetworkInterface> interfaces = Collections.list(NetworkInterface.getNetworkInterfaces());
            for (NetworkInterface intf : interfaces)
            {
                List<InetAddress> addrs = Collections.list(intf.getInetAddresses());
                for (InetAddress addr : addrs)
                {
                    if (!addr.isLoopbackAddress())
                    {
                        String sAddr = addr.getHostAddress();
                        //boolean isIPv4 = InetAddressUtils.isIPv4Address(sAddr);
                        boolean isIPv4 = sAddr.indexOf(':')<0;

                        if (useIPv4)
                        {
                            if (isIPv4)
                            {
                                return sAddr;
                            }
                        }
                        else
                        {
                            if (! isIPv4)
                            {
                                int delim = sAddr.indexOf('%'); // drop ip6 zone suffix
                                return delim<0 ? sAddr.toUpperCase() : sAddr.substring(0, delim).toUpperCase();
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // for now eat exceptions
        }

        return "";
    } // getIPAddress

    private void setTextView(TextView tv, String texto)
    {
        if (null != tv)
        {
            tv.setText(texto);
        } // then
    } // setTextView

    private void appendAtBeginningTextView(String texto)
    {
        TextView tvLog = (TextView) findViewById(R.id.tvLog);
        if (null != tvLog)
        {
            String contenidoAnterior = tvLog.getText().toString();
            tvLog.setText("[" + DateUtils.dateToString(new Date(), DateUtils.FORMATO_TIMESTAMP_ESPANHOL) + "]\n");
            tvLog.append("\t\t" + texto + "\n\n");
            tvLog.append(contenidoAnterior);
        } // then
    } // appendAtBeginningTextView

    private void appendTextView(TextView tv, String texto)
    {
        if (null != tv)
        {
            tv.append(texto);
        } // then
    } // appendAtBeginningTextView
} // class
