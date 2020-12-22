package es.pernasferreiro.ml.mlws.jms.register;

import es.pernasferreiro.ml.mlws.Constants;
import es.pernasferreiro.ml.mlws.jms.model.Click;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Component;

import javax.jms.DeliveryMode;
import javax.jms.ObjectMessage;

@Component
public class NavigationRegister
{
    @Autowired
    private JmsTemplate jmsTemplate;

    // TODO: registrar en la cola correspondiente el mensaje para el NAVREC
    public void registerMessage(Click click) {
        this.jmsTemplate.send((sesion) -> {
            ObjectMessage message = sesion.createObjectMessage();
            message.setJMSDeliveryMode(DeliveryMode.PERSISTENT);
            message.setJMSRedelivered(false);
            message.setStringProperty(Constants.CTE_PROP_JMS_OPERATION, Constants.CTE_MSSG_CLICK_DATA);
            message.setObject(click);

            return message;
        });
    }
}
