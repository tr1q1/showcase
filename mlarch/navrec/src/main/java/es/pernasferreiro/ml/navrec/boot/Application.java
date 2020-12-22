package es.pernasferreiro.ml.navrec.boot;

import es.pernasferreiro.ml.navrec.jms.model.Click;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.jms.core.JmsTemplate;

import java.util.Date;

@SpringBootApplication
public class Application
{
    public static void main(String[] args)
    {
        ConfigurableApplicationContext context = SpringApplication.run(Application.class, args);

        // TODO: eliminar
        // UNIT TEST
        JmsTemplate jmsTemplate = context.getBean(JmsTemplate.class);
        // Send a message with a POJO - the template reuse the message converter
        Click click = new Click();
        click.setTimeStamp((new Date()).getTime());
        click.setApplication("NAVREC");
        click.setSeccion(1);
        click.setIp("127.0.0.1");
        click.setUser("tR1K1");

        jmsTemplate.convertAndSend("MLA.IN.data.private.LOCAL", click);
        System.out.println("Register a click");
    }
}
