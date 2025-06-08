package lk.thidas.ee.web.servlet;

import com.google.gson.Gson;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.thidas.ee.core.dto.Response_DTO;
import lk.thidas.ee.core.dto.User_DTO;
import lk.thidas.ee.ejb.remote.UserService;

import java.io.IOException;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    @EJB
    private UserService userManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        Response_DTO response = new Response_DTO();

        User_DTO user_dto = gson.fromJson(req.getReader(), User_DTO.class);

        if (user_dto.getPassword().equals(user_dto.getConfirmPassword())) {
            if (userManager.registerUser(user_dto.getUsername(), user_dto.getEmail(), user_dto.getPassword())) {
                response.setSuccess(true);
                response.setContent("You have been registered successfully, login again.");
            } else {
                response.setSuccess(false);
                response.setContent("User already exists");
            }
        } else {
            response.setSuccess(false);
            response.setContent("Passwords do not match");
        }

        resp.getWriter().write(gson.toJson(response));
        resp.setContentType("application/json");

    }
}
