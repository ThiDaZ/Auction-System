package lk.thidas.ee.ejb.mdb;

import jakarta.ejb.Stateless;
import org.apache.activemq.ActiveMQConnectionFactory;
//import org.apache.activemq.ActiveMQConnectionFactory;

import jakarta.jms.*;

@Stateless
public class AuctionMessageSender {

    private static final String BROKER_URL = "tcp://localhost:61616";
    private static final String TOPIC_NAME = "activemqTopic";

    public void sendBidUpdate(String jsonMessage) {
        ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory(BROKER_URL);
        Connection connection = null;
        Session session = null;

        try {
            connection = connectionFactory.createConnection();
            connection.start();

            session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            Topic topic = session.createTopic(TOPIC_NAME);

            try (MessageProducer producer = session.createProducer(topic)) {
                TextMessage message = session.createTextMessage(jsonMessage);
                producer.setDeliveryMode(DeliveryMode.PERSISTENT);
                producer.send(message);

                System.out.println("✅ Message sent successfully to topic: " + TOPIC_NAME);
            }

        } catch (JMSException e) {
            System.err.println("Failed to send message:");
            System.out.println(e.getMessage());
        } finally {
            try {
                if (session != null) session.close();
                if (connection != null) connection.close();
            } catch (JMSException e) {
                System.err.println("Failed to close JMS resources:");
                System.out.println(e.getMessage());
            }
        }
    }

//    public static void main(String[] args) {
//        AuctionMessageSender sender = new AuctionMessageSender();
//        String exampleMessage = "{\"auctionId\":101,\"bid\":5000,\"user\":\"Alice\"}";
//
//        sender.sendBidUpdate(exampleMessage);
//    }


//    @Inject
//    @JMSConnectionFactory("jakarta.jms.Topic")
//    private JMSContext context;
//
//    @Resource(lookup = "activemqTopic")
//    private Topic auctionTopic;
//
//    public void sendAuctionUpdate(String jsonMessage) {
//        context.createProducer().send(auctionTopic, jsonMessage);
//        System.out.println("Sent JMS message: " + jsonMessage);
//    }
//
//    public void sendBidUpdate(String jsonMessage) {
//        context.createProducer().send(auctionTopic, jsonMessage);
//        System.out.println("Sent JMS message: " + jsonMessage);
//    }

}
