package es.pernasferreiro.smsgateway;

import android.telephony.SmsManager;

import com.koushikdutta.async.http.body.JSONObjectBody;
import com.koushikdutta.async.http.server.AsyncHttpServerRequest;

import org.json.JSONObject;

import java.util.Date;

import es.pernasferreiro.smsgateway.utils.DateUtils;

/**
 * Created by tino on 7/09/16.
 */
public class ProcessRequest
{
    public String attendRequest(String passphrase, AsyncHttpServerRequest request)
    {
        StringBuilder log = new StringBuilder(0);
        JSONObject json = new JSONObject();
        if (request.getBody() instanceof JSONObjectBody)
        {
            try
            {
                json = ((JSONObjectBody) request.getBody()).get();

                if ((null != json) && (! json.getString("token").isEmpty()) && (passphrase.equals(json.getString("token"))))
                {
                    if (! json.getString("phone").isEmpty())
                    {
                        if (! json.getString("msg").isEmpty())
                        {
                            String phone = json.getString("phone").trim();
                            String msg = json.getString("msg").trim();

                            SmsManager sms = SmsManager.getDefault();
                            sms.sendTextMessage(phone, null, msg, null, null);

                            log.append("message dispatched");
                        } // then
                        else
                        {
                            log.append("empty message");
                        } // else
                    } // then
                    else
                    {
                        log.append("empty phone");
                    } // else
                } // then
                else
                {
                    log.append("incorrect token: '" + json.getString("token") + "'");
                } // else
            } // try
            catch (Exception e)
            {
                log.append("[ERROR] " + e.getStackTrace());
            } // catch
        } // then
        else
        {
            log.append("empty request");
        } // else

        return "[" + DateUtils.dateToString(new Date(), DateUtils.FORMATO_TIMESTAMP_ESPANHOL) + "] " + log.toString();
    } // attendRequest
} // class
