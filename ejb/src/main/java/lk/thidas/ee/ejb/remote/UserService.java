package lk.thidas.ee.ejb.remote;

import jakarta.ejb.Remote;
import lk.thidas.ee.core.model.User;

@Remote
public interface UserService {
    boolean registerUser(String username, String email, String password);
    User login(String email, String password);
    User getUser(String email);
}
