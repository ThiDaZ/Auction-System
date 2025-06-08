package lk.thidas.ee.web.mdb;

import jakarta.annotation.PostConstruct;
import jakarta.ejb.ActivationConfigProperty;
import jakarta.ejb.MessageDriven;

import jakarta.inject.Inject;
import jakarta.jms.Message;
import jakarta.jms.MessageListener;
import jakarta.jms.TextMessage;
import jakarta.json.Json;
import jakarta.json.JsonObject;
import lk.thidas.ee.web.websocket.SessionHandler;

import java.io.StringReader;


@MessageDriven(
        activationConfig = {
                @ActivationConfigProperty(propertyName = "destinationLookup", propertyValue = "activemqTopic"),
                @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "jakarta.jms.Topic"),
                @ActivationConfigProperty(propertyName = "destination", propertyValue = "activemqTopic"),
                @ActivationConfigProperty(propertyName = "resourceAdapter", propertyValue = "activemq-rar-6.1.6")
        }
)
public class AuctionUpdateMessageListener implements MessageListener {

    @Inject
    private SessionHandler sessionHandler;

    @PostConstruct
    public void init() {
        System.out.println("MDB AuctionUpdateMessageListener is active");
    }

    @Override
    public void onMessage(Message message) {
        try {
            if (message instanceof TextMessage) {
                TextMessage textMsg = (TextMessage) message;
                String jsonPayload = textMsg.getText();
                System.out.println("jsonPayload: " + jsonPayload);

                JsonObject json = Json.createReader(new StringReader(jsonPayload)).readObject();
                String auctionId = json.getString("auctionId");

                SessionHandler.getInstance().broadcastToAuction(auctionId, json.toString());
                System.out.println(json.toString());

                System.out.println("JMS update forwarded to WebSocket for auction: " + auctionId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}