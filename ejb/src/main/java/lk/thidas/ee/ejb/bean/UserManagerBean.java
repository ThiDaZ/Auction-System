package lk.thidas.ee.ejb.bean;

import jakarta.ejb.Startup;
import jakarta.ejb.Stateless;
import lk.thidas.ee.core.model.User;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Startup
@Stateless
public class UserManagerBean {
    private Map<String, User> users = new ConcurrentHashMap<>();

    public boolean registerUser(String username, String email, String password) {
        if (users.containsKey(email)) {
            return false;
        }
        users.put(email, new User(username, email, password));
        System.out.println("User registered successfully :" + email + " " + password + " " + username);
        return true;
    }

    public User login(String email, String password) {

        if (users.containsKey(email)) {
            User user = users.get(email);
            if (user != null) {
                if (user.getPassword().equals(password)) {
                    System.out.println("User logged in successfully :" + user.getEmail() + " " + user.getPassword());
                    return user;
                } else {
                    System.out.println("Invalid credentials");
                    return null;
                }
            }
        } else {
            System.out.println("User not found");
            return null;
        }
        return null;
    }

}
