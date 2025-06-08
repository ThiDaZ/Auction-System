package lk.thidas.ee.web.message;

import jakarta.annotation.PostConstruct;
import jakarta.ejb.ActivationConfigProperty;
import jakarta.ejb.MessageDriven;

import jakarta.jms.JMSException;
import jakarta.jms.Message;
import jakarta.jms.MessageListener;
import jakarta.jms.TextMessage;


@MessageDriven(
        activationConfig = {
                @ActivationConfigProperty(propertyName = "destinationLookup", propertyValue = "activemqTopic"),
                @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "jakarta.jms.Topic"),
                @ActivationConfigProperty(propertyName = "destination", propertyValue = "activemqTopic"),
                @ActivationConfigProperty(propertyName = "resourceAdapter", propertyValue = "activemq-rar-6.1.6")
        }
)
public class AuctionUpdateMessageListener implements MessageListener {

    @PostConstruct
    public void init() {
        System.out.println("✅ MDB AuctionUpdateMessageListener is active");
    }

    @Override
    public void onMessage(Message message) {
        try {
            TextMessage textMessage = (TextMessage) message;
            String body = textMessage.getText();
            System.out.println("📥 Received auction update: " + body);



        } catch (JMSException e) {
            e.printStackTrace();
        }
    }
}