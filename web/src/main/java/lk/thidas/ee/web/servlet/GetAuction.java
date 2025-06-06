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

@WebServlet("/getAuction")
public class GetAuction extends HttpServlet {

    @EJB
    private AuctionService auctionService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        Response_DTO response_DTO = new Response_DTO();

        String auctionID = req.getParameter("id");
        System.out.println("auctionID: " + auctionID);

        if (auctionID != null && !auctionID.isEmpty()) {
            AuctionItem auctionItem = auctionService.getAuctionItem(auctionID);
            response_DTO.setSuccess(true);
            response_DTO.setContent(auctionItem);
        } else {
            response_DTO.setSuccess(false);
            response_DTO.setContent("Invalid Auction ID");
        }

        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(response_DTO));

    }
}
