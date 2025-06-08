package lk.thidas.ee.ejb.bean;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.json.Json;
import jakarta.json.JsonObject;
import lk.thidas.ee.core.model.AuctionItem;
import lk.thidas.ee.core.model.Bidder;
import lk.thidas.ee.core.model.User;
import lk.thidas.ee.ejb.mdb.AuctionMessageSender;
import lk.thidas.ee.ejb.remote.AuctionService;
import lk.thidas.ee.ejb.remote.BidService;
import lk.thidas.ee.ejb.remote.UserService;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;
import java.util.Comparator;

@Stateless
public class BidManagerBean implements BidService {

    @EJB
    private AuctionService auctionService;

    @EJB
    private UserService userService;

    private Map<String, Bidder> bidders = new ConcurrentHashMap<>();

    @Override
    public Bidder getBid(String bidId) {
        return bidders.get(bidId);
    }

    @Override
    public Bidder placeBid(String email, String auctionId, Double bidAmount, LocalDateTime timestamp) {

        AuctionItem auctionItem = auctionService.getAuctionItem(auctionId);
        User userData = userService.getUser(email);

        String id = UUID.randomUUID().toString();

        if (auctionItem != null && userData != null) {
            Bidder newBid = new Bidder(userData, auctionItem, id, bidAmount, timestamp);
            bidders.put(id, newBid);

            Bidder highBid = getHighestBid(auctionItem);


            if (highBid != null && highBid.getBidAmount() < newBid.getBidAmount()) {
                AuctionMessageSender sender = new AuctionMessageSender();
                JsonObject highBidJson = Json.createObjectBuilder()
                        .add("type", "highest_bid")
                        .add("auctionId", auctionId)
                        .add("user_name", newBid.getUser().getUsername())
                        .add("highest_bid_amount", newBid.getBidAmount())
                        .build();

                sender.sendMessage(highBidJson.toString());
                System.out.println("✅ Sent highest bid update");
            }
            System.out.println("pass 02");

            System.out.println("new added: "
                    + newBid.getUser().getEmail()
                    + "\n"
                    + newBid.getItem().getTitle()
                    + "\n"
                    + newBid.getBidAmount()
                    + "\n"
                    + newBid.getBidDate()
            );

            AuctionMessageSender sender = new AuctionMessageSender();

            JsonObject json = Json.createObjectBuilder()
                    .add("type", "update_bid")
                    .add("auctionId", auctionId)
                    .add("user_name", newBid.getUser().getUsername())
                    .add("bid_amount", newBid.getBidAmount())
                    .add("email", newBid.getUser().getEmail())
                    .add("bid_time", newBid.getBidDate().toString())
                    .build();

            sender.sendMessage(json.toString());


            return newBid;
        }
        return null;
    }

    @Override
    public Bidder getHighestBid(AuctionItem item) {
        if (item == null) {
            return null;
        }

        List<Bidder> itemBids = getAllBids(item);
        if (itemBids.isEmpty()) {
            return null;
        }

        Bidder highestBid = itemBids.stream()
                .max(Comparator.comparingDouble(Bidder::getBidAmount))
                .orElse(null);

        return highestBid;
    }

    @Override
    public List<Bidder> getAllBids(AuctionItem item) {
        if (item == null) {
            return List.of();
        }

        return bidders.values().stream()
                .filter(bidder -> bidder.getItem().equals(item))
                .collect(Collectors.toList());
    }


}
