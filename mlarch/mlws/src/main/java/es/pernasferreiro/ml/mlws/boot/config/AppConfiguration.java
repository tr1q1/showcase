package es.pernasferreiro.ml.mlws.boot.config;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.*;
import org.springframework.jms.annotation.EnableJms;
import org.springframework.jms.config.DefaultJmsListenerContainerFactory;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.support.converter.MappingJackson2MessageConverter;
import org.springframework.jms.support.converter.MessageConverter;
import org.springframework.jms.support.converter.MessageType;

@Configuration
@EnableAutoConfiguration
@EnableJms
@ComponentScan(basePackages = "es.pernasferreiro.ml.mlws")
public class AppConfiguration
{
    // *****************************************************************************************************************
    // *****************************************************************************************************************
    // *****************************************************************************************************************
    // AMQ configuration
    @Value("${amiga.data.jms.connectionFactory.broker.brokerURL}")
    private String brokerURL;

    @Value("${amiga.data.jms.connectionFactory.broker.userName}")
    private String username;

    @Value("${amiga.data.jms.connectionFactory.broker.password}")
    private String password;

    @Bean(name = "connectionFactory")
    public ActiveMQConnectionFactory connectionFactory() {
        ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory();
        connectionFactory.setBrokerURL(this.brokerURL);
        connectionFactory.setPassword(this.username);
        connectionFactory.setUserName(this.password);
        connectionFactory.setTrustAllPackages(true);

        return connectionFactory;
    }

    @Bean(name = "jmsTemplate")
    public JmsTemplate jmsTemplate() {
        JmsTemplate template = new JmsTemplate();
        template.setConnectionFactory(this.connectionFactory());

        return template;
    }

    @Bean(name = "queuesFactory")
    public DefaultJmsListenerContainerFactory queuesFactory() {
        DefaultJmsListenerContainerFactory factory = new DefaultJmsListenerContainerFactory();
        factory.setConnectionFactory(this.connectionFactory());
        factory.setConcurrency("1-1");

        return factory;
    }

    @Bean(name = "jmsMessageConverter") // Serialize message content to json using TextMessage
    public MessageConverter jacksonJmsMessageConverter() {
        MappingJackson2MessageConverter converter = new MappingJackson2MessageConverter();
        converter.setTargetType(MessageType.TEXT);
        converter.setTypeIdPropertyName("_type");

        return converter;
    }
}