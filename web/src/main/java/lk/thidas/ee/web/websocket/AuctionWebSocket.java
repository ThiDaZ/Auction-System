package lk.thidas.ee.web.websocket;

import jakarta.inject.Inject;
import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

import java.io.StringReader;

@ServerEndpoint("/ws/auction")
public class AuctionWebSocket {

    @Inject
    private SessionHandler sessionHandler;

    @OnOpen
    public void onOpen(Session session) {
        sessionHandler.sendToSession(session, "Welcome to the Auction System");
        System.out.println("New connection: " + session.getId());
    }

    @OnClose
    public void onClose(Session session) {
        sessionHandler.removeSession(session);
        System.out.println("Session closed: " + session.getId());
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("Message received: " + message);
        try {
            JsonObject msg = Json.createReader(new StringReader(message)).readObject();

            if (msg.containsKey("type") && "subscribe".equals(msg.getString("type"))) {
                if (msg.containsKey("auctionId")) {
                    String auctionID = msg.getString("auctionId");
                    sessionHandler.addSession(session, auctionID);
                    System.out.println("Session " + session.getId() + " subscribed to auction " + auctionID);
                }
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
