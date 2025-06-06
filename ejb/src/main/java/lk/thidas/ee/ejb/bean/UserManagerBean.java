package lk.thidas.ee.ejb.bean;

import jakarta.annotation.PostConstruct;
import jakarta.ejb.LocalBean;
import jakarta.ejb.Startup;
import jakarta.ejb.Stateless;
import lk.thidas.ee.core.model.User;
import lk.thidas.ee.ejb.remote.UserService;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Startup
@Stateless
@LocalBean
public class UserManagerBean implements UserService {
    private Map<String, User> users = new ConcurrentHashMap<>();

    @PostConstruct
    void initSampleData() {
        registerUser("Alice", "alice@example.com", "123");
        registerUser("Bob", "bob@example.com", "123");
        registerUser("Charlie", "charlie@example.com", "123");
        System.out.println("Sample users registered.");
    }


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
        }
        return null;
    }

}
