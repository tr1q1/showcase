package es.pernasferreiro.ml.navrec.boot.config;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.TransportAddress;
import org.elasticsearch.transport.client.PreBuiltTransportClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.*;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.repository.config.EnableElasticsearchRepositories;
import org.springframework.jms.annotation.EnableJms;
import org.springframework.jms.config.DefaultJmsListenerContainerFactory;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.support.converter.MappingJackson2MessageConverter;
import org.springframework.jms.support.converter.MessageConverter;
import org.springframework.jms.support.converter.MessageType;

import java.net.InetAddress;
import java.util.List;

@Configuration
@EnableAutoConfiguration
@EnableJms
@ComponentScan(basePackages = "es.pernasferreiro.ml.navrec")
@EnableElasticsearchRepositories(basePackages = "es.pernasferreiro.ml.navrec.es")
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

    // *****************************************************************************************************************
    // *****************************************************************************************************************
    // *****************************************************************************************************************
    // ES configuration
    @Value("${elasticsearch.host}")
    private String esHost;

    @Value("${elasticsearch.port}")
    private Integer esPort;

    @Value("${elasticsearch.clustername}")
    private String esClusterName;

    @Bean(name = "esConnectClient")
    public Client esConnectClient() throws Exception {
        Settings esSettings = Settings.builder()
                .put("cluster.name", this.esClusterName)
                .put("client.transport.sniff", false)
                // .put("client.transport.ignore_cluster_name", true)
                // .put("client.transport.ping_timeout", 2)
                // .put("client.transport.nodes_sampler_interval",
                .build();

        return (new PreBuiltTransportClient(esSettings)).addTransportAddress(new TransportAddress(InetAddress.getByName(this.esHost), this.esPort));
    }

    @Bean(name = "esTemplate")
    @Primary
    public ElasticsearchOperations esTemplate() throws Exception {
        return new ElasticsearchTemplate(this.esConnectClient());
    }
}