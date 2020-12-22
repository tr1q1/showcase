package es.pernasferreiro.ml.navrec.jms.listener;

import es.pernasferreiro.ml.navrec.Constants;
import es.pernasferreiro.ml.navrec.es.service.ClickService;
import es.pernasferreiro.ml.navrec.jms.model.Click;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

@Component
public class NavigationListener
{
    @Autowired
    private ClickService clickService;

    @JmsListener(
            containerFactory = "queuesFactory",
            destination = "${es.pernasferreiro.ml.jms.conf.NAVQ}",
            selector = Constants.CTE_PROP_JMS_OPERATION + " = '" + Constants.CTE_MSSG_CLICK_DATA+ "'"
    )
    public void processMessage(Click click) {
        // TODO: send info to a logger
        // System.out.println("[" + (new Date()) + "] - NavigationListener - '" + click.toString() + "'");

        clickService.save(new es.pernasferreiro.ml.navrec.es.model.Click(click));
    }
}
