package lk.thidas.ee.web.websocket;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.websocket.Session;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@ApplicationScoped
public class SessionHandler {

    private final Set<Session> sessions= new HashSet<>();

    public void addSession(Session session){
        sessions.add(session);
    }

    public void removeSession(Session session){
        sessions.remove(session);
    }


    private void sendToSession(Session session, String message) {
        try {
            session.getBasicRemote().sendText(message);
        } catch (IOException ex) {
            sessions.remove(session);
            System.out.println(ex);
//            Logger.getLogger(DeviceSessionHandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void broadcast(String message) {
        for (Session session : sessions) {
            if (session.isOpen()) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    System.out.println("Error while sending auction message: " + e.getMessage());
                }
            } else {
                System.out.println("Session is closed. Skipping...");
            }
        }
    }

}
