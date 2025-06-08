package lk.thidas.ee.ejb.bean;

import jakarta.ejb.EJB;
import jakarta.ejb.Schedule;
import jakarta.ejb.Stateless;
import jakarta.json.Json;
import jakarta.json.JsonObject;

import lk.thidas.ee.core.model.AuctionItem;
import lk.thidas.ee.core.model.Bidder;
import lk.thidas.ee.ejb.mdb.AuctionMessageSender;
import lk.thidas.ee.ejb.remote.AuctionService;
import lk.thidas.ee.ejb.remote.BidService;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.logging.Logger;

@Stateless
public class AuctionScheduler {

    @EJB
    private AuctionService auctionManager;

    @EJB
    private BidService bidService;
    
    private static final Logger logger = Logger.getLogger(AuctionScheduler.class.getName());

    @Schedule(minute = "*/1", hour = "*", persistent = false)
    public void checkAuctionEndings(){
        Map<String, AuctionItem> auctionItems = auctionManager.getAllAuctionItems();
        LocalDateTime now = LocalDateTime.now();

        for (Map.Entry<String, AuctionItem> entry : auctionItems.entrySet()) {
            String auctionId = entry.getKey();
            AuctionItem item = entry.getValue();

            if (now.isAfter(item.getEndTime())) {
                logger.info("Auction " + item.getTitle() + " has ended.");
                  // Get the winning bid and persist it
                Bidder winner = bidService.getHighestBid(auctionId);
                if (winner != null) {
                    bidService.setWinningBid(auctionId, winner);
                }
                
                // Create winner announcement message
                JsonObject winnerJson = Json.createObjectBuilder()
                    .add("type", "auction_ended")
                    .add("auctionId", auctionId)
                    .add("winningBid", winner != null ? winner.getBidAmount() : item.getStartBid())
                    .add("winnerName", winner != null ? winner.getUser().getUsername() : "No winner")
                    .add("winnerEmail", winner != null ? winner.getUser().getEmail() : "")
                    .add("endTime", now.toString())
                    .build();

                // Send winner announcement via WebSocket
                AuctionMessageSender sender = new AuctionMessageSender();
                sender.sendMessage(winnerJson.toString());

                // Remove the auction from active auctions
                // auctionManager.removeAuctionItem(item);
            }
        }
    }
}
