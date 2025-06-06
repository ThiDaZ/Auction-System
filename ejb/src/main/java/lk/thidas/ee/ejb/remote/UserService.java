package lk.thidas.ee.ejb.remote;

import jakarta.ejb.Local;
import lk.thidas.ee.core.model.User;

@Local
public interface UserService {
    boolean registerUser(String username, String email, String password);
    User login(String email, String password);
}
