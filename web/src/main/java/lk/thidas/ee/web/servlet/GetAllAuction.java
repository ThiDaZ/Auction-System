package lk.thidas.ee.web.servlet;

import com.google.gson.Gson;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.thidas.ee.core.dto.Response_DTO;
import lk.thidas.ee.core.model.AuctionItem;
import lk.thidas.ee.ejb.remote.AuctionService;

import java.io.IOException;
import java.util.Map;

@WebServlet("/getAllAuction")
public class GetAllAuction extends HttpServlet {

    @EJB
    private AuctionService auctionService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        Response_DTO responseDto = new Response_DTO();
        System.out.println("getAllAuction");


        Map<String, AuctionItem> auctionItems = auctionService.getAllAuctionItems();

        if (auctionItems == null || auctionItems.isEmpty()) {
            responseDto.setSuccess(false);
            responseDto.setContent("No auction items found");
            return;
        } else {
            responseDto.setSuccess(true);
            responseDto.setContent(auctionItems);
        }

        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(responseDto));

    }
}
