package lk.thidas.ee.web.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.thidas.ee.core.dto.Response_DTO;
import lk.thidas.ee.core.dto.User_DTO;
import lk.thidas.ee.core.model.User;

import java.io.IOException;


@WebServlet("/checkSession")
public class CheckSession extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        JsonObject jsonObject = new JsonObject();


        if (req.getSession().getAttribute("user") != null) {
            User user = (User) req.getSession().getAttribute("user");
            User_DTO userDto = new User_DTO(user.getUsername(), user.getEmail());

            jsonObject.add("user", gson.toJsonTree(userDto));
            jsonObject.addProperty("success", true);

        } else {
            jsonObject.addProperty("success", false);
            jsonObject.addProperty("message", "You are not logged in");
        }


        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(jsonObject));

    }
}
