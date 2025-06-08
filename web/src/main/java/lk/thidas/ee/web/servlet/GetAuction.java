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
import lk.thidas.ee.core.model.AuctionItem;
import lk.thidas.ee.core.model.Bidder;
import lk.thidas.ee.ejb.remote.AuctionService;
import lk.thidas.ee.ejb.remote.BidService;
import lk.thidas.ee.web.util.LocalDateTimeAdapter;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/getAuction")
public class GetAuction extends HttpServlet {

    @EJB
    private AuctionService auctionService;

    @EJB
    private BidService bidService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        Response_DTO response_DTO = new Response_DTO();

        String auctionID = req.getParameter("id");

        if (auctionID != null && !auctionID.isEmpty()) {
            try {
                AuctionItem auctionItem = auctionService.getAuctionItem(auctionID);

                Bidder highestBid = bidService.getHighestBid(auctionID);
                System.out.println("Highest bid: " + highestBid + " for auction: " + auctionID);
                List<Bidder> bidHistory = bidService.getAllBids(auctionID);

                Map<String, Object> responseContent = new HashMap<>();
                responseContent.put("auction", auctionItem);

                if (highestBid != null) {
                    Map<String, Object> highestBidInfo = new HashMap<>();
                    highestBidInfo.put("amount", highestBid.getBidAmount());
                    highestBidInfo.put("bidder_name", highestBid.getUser().getUsername());
                    highestBidInfo.put("email", highestBid.getUser().getEmail());
                    responseContent.put("highest_bid", highestBidInfo);
                }

                // Add bid history
                responseContent.put("bid_history", bidHistory);

                response_DTO.setSuccess(true);
                response_DTO.setContent(responseContent);
            } catch (Exception e) {
                response_DTO.setSuccess(false);
                response_DTO.setContent("Error retrieving auction details: " + e.getMessage());
            }
        } else {
            response_DTO.setSuccess(false);
            response_DTO.setContent("Invalid Auction ID");
        }

        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(response_DTO));

    }
}
