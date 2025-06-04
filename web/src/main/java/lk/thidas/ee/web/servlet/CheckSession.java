package lk.thidas.ee.web.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.thidas.ee.core.dto.Response_DTO;
import lk.thidas.ee.core.model.User;

import java.io.IOException;


@WebServlet("/checkSession")
public class CheckSession extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        JsonObject jsonObject = new JsonObject();
        Gson gson = new Gson();

        Response_DTO responseDto = new Response_DTO();

        if(req.getSession().getAttribute("user") != null){
            User user = (User) req.getSession().getAttribute("user");
            responseDto.setContent(user);
            responseDto.isSuccess(true);
        }else{
            responseDto.setContent("not signed in");
        }

        jsonObject.add("response_DTO", gson.toJsonTree(responseDto));

        resp.setContentType("application/json");
        resp.getWriter().write(jsonObject.toString());

    }
}
