package lk.thidas.ee.ejb.mdb;

import jakarta.annotation.Resource;
import jakarta.inject.Inject;
import jakarta.jms.JMSConnectionFactory;
import jakarta.jms.JMSContext;
import jakarta.jms.Topic;

public class AuctionMessageSender {

    @Inject
    @JMSConnectionFactory("activemq-connection-pool")
    private JMSContext context;

    @Resource(lookup = "activemqTopic")
    private Topic auctionTopic;

    public void sendAuctionUpdate(String jsonMessage) {
        context.createProducer().send(auctionTopic, jsonMessage);
        System.out.println("✅ Sent JMS message: " + jsonMessage);
    }

}
