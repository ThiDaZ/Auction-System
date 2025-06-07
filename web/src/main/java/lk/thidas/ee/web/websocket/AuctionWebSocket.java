package lk.thidas.ee.web.websocket;

import jakarta.inject.Inject;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/ws/auction")
public class AuctionWebSocket {

    @Inject private SessionHandler sessionHandler;

    @OnOpen
    public void onOpen(Session session) {
        sessionHandler.addSession(session);
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
    }

}
