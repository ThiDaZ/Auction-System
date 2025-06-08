package lk.thidas.ee.web.websocket;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.websocket.Session;

import java.io.IOException;
import java.util.Collections;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@ApplicationScoped
public class SessionHandler {

    private static SessionHandler instance;

    public SessionHandler() {
        instance = this;
    }

    public static SessionHandler getInstance() {
        return instance;
    }

    private final Map<Session, String> sessionAuctionMap = new ConcurrentHashMap<>();
    private final Map<String, Set<Session>> auctionSessionMap = new ConcurrentHashMap<>(); // update ui

    public void addSession(Session session, String auctionId) {
        sessionAuctionMap.put(session, auctionId);
        auctionSessionMap.computeIfAbsent(auctionId, k -> ConcurrentHashMap.newKeySet())
                .add(session);
    }

    public void removeSession(Session session) {
        String auctionID = sessionAuctionMap.get(session);
        if (auctionID != null) {
            Set<Session> auctionSessions = auctionSessionMap.get(auctionID);
            if (auctionSessions != null) {
                auctionSessions.remove(session);
                if (auctionSessions.isEmpty()) {
                    auctionSessionMap.remove(auctionID);
                }
            }
        }
    }


    public void sendToSession(Session session, String message) {
        try {
            if (session.isOpen()) {
                session.getBasicRemote().sendText(message);
            }
        } catch (IOException ex) {
            removeSession(session); // Clean up
            System.out.println("Error sending to session: " + ex.getMessage());
        }
    }

    public void broadcastToAuction(String auctionId, String message) {
        Set<Session> sessions = auctionSessionMap.getOrDefault(auctionId, Collections.emptySet());

        for (Session session : sessions) {
            if (session.isOpen()) {
                try {
                    session.getBasicRemote().sendText(String.valueOf(message));
                } catch (IOException e) {
                    System.out.println("Failed to send to session: " + e.getMessage());
                }
            }
        }
    }

    public void broadcastAll(String message) {
        for (Session session : sessionAuctionMap.keySet()) {
            if (session.isOpen()) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    System.out.println("Error broadcasting to all: " + e.getMessage());
                }
            }
        }
    }
}
