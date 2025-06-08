package lk.thidas.ee.web.servlet;

import com.google.gson.Gson;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.thidas.ee.core.dto.PlaceBid_DTO;
import lk.thidas.ee.core.dto.Response_DTO;
import lk.thidas.ee.core.model.Bidder;
import lk.thidas.ee.core.model.User;
import lk.thidas.ee.ejb.remote.BidService;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/placeBid")
public class PlaceBid extends HttpServlet {

    @EJB
    BidService bidService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        PlaceBid_DTO placeBidDTO = gson.fromJson(req.getReader(), PlaceBid_DTO.class);

        Response_DTO responseDTO = new Response_DTO();

        if (req.getSession().getAttribute("user") != null) {
            User user = (User) req.getSession().getAttribute("user");
            Double bid = Double.parseDouble(placeBidDTO.getBidAmount());
            Bidder newBid = bidService.placeBid(user.getEmail(), placeBidDTO.getAuctionId(), bid, LocalDateTime.now());

            if (newBid != null) {
                responseDTO.setSuccess(true);
                responseDTO.setContent("success");
            } else {
                responseDTO.setSuccess(false);
                responseDTO.setContent("fail");
            }
        }

        System.out.println("Place Bid: " + placeBidDTO.getBidAmount());
        System.out.println("Auction ID  : " + placeBidDTO.getAuctionId());

        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(responseDTO));

    }
}
