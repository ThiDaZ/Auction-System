package lk.thidas.ee.web.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.thidas.ee.core.dto.Response_DTO;
import lk.thidas.ee.core.dto.User_DTO;
import lk.thidas.ee.core.model.User;
import lk.thidas.ee.ejb.remote.UserService;

import java.io.IOException;

@WebServlet("/signIn")
public class LoginServlet extends HttpServlet {
    @EJB
    private UserService userManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Response_DTO response = new Response_DTO();

        Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
        User_DTO user_dto = gson.fromJson(req.getReader(), User_DTO.class);

        User user = userManager.login(user_dto.getEmail(), user_dto.getPassword());

        if(user != null){
            req.getSession().setAttribute("user", user);
            response.setSuccess(true);
            response.setContent("Login Successful");
            System.out.println("User logged in successfully :" + user.getEmail());
        }else{
            response.setSuccess(false);
            response.setContent("Invalid credentials");
        }

        resp.getWriter().write(gson.toJson(response));
        resp.setContentType("application/json");

    }
}
