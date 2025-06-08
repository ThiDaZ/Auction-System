package lk.thidas.ee.ejb.bean;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
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
            Bidder highBid = getHighestBid(auctionItem);
            if (highBid != null && bidAmount <= highBid.getBidAmount()) {
                return null;
            }

            Bidder newBid = new Bidder(userData, auctionId, auctionItem, id, bidAmount, timestamp);
            bidders.put(id, newBid);

            AuctionMessageSender sender = new AuctionMessageSender();
            JsonObject highBidJson = Json.createObjectBuilder()
                    .add("type", "highest_bid")
                    .add("auctionId", auctionId)
                    .add("user_name", newBid.getUser().getUsername())
                    .add("highest_bid_amount", newBid.getBidAmount())
                    .add("email", newBid.getUser().getEmail())
                    .build();
            sender.sendMessage(highBidJson.toString());


            AuctionMessageSender sender2 = new AuctionMessageSender();
            JsonObject json = Json.createObjectBuilder()
                    .add("type", "update_bid")
                    .add("auctionId", auctionId)
                    .add("user_name", newBid.getUser().getUsername())
                    .add("bid_amount", newBid.getBidAmount())
                    .add("email", newBid.getUser().getEmail())
                    .add("bid_time", newBid.getBidDate().toString())
                    .build();

            sender2.sendMessage(json.toString());

            System.out.println("new added: "
                    + newBid.getUser().getEmail()
                    + "\n"
                    + newBid.getItem().getTitle()
                    + "\n"
                    + newBid.getBidAmount()
                    + "\n"
                    + newBid.getBidDate());

            System.out.println("✅ Sent highest bid update");
            return newBid;
        }
        return null;
    }

    @Override
    public Bidder getHighestBid(AuctionItem item) {
        if (item == null) {
            return null;
        }
        System.out.println("highest bid pass 01");

        List<Bidder> itemBids = getAllBids(item);
        if (itemBids.isEmpty()) {
            System.out.println("highest bid Empty");
            return null;
        }
        System.out.println("highest bid pass 02");

        return itemBids.stream()
                .max(Comparator.comparingDouble(Bidder::getBidAmount))
                .orElse(null);
    }

    @Override
    public Bidder getHighestBid(String auctionId) {
        if (auctionId == null || auctionId.isEmpty()) {
            return null;
        }

        return bidders.values().stream()
                .filter(bidder -> auctionId.equals(bidder.getAuctionId()))
                .max(Comparator.comparingDouble(Bidder::getBidAmount))
                .orElse(null);
    }


    @Override
    public List<Bidder> getAllBids(AuctionItem item) {
        if (item == null) {
            System.out.println("all bid null");
            return List.of();
        }

        String auctionId = auctionService.getAuctionIdByItem(item);
        if (auctionId == null) {
            System.out.println("No auctionId found for given item");
            return List.of();
        }

        return bidders.values().stream()
                .filter(bidder -> auctionId.equals(bidder.getAuctionId()))
                .sorted(Comparator.comparing(Bidder::getBidDate).reversed())
                .collect(Collectors.toList());
    }

    @Override
    public List<Bidder> getAllBids(String auctionId) {
        return bidders.values().stream()
                .filter(bidder -> bidder.getAuctionId().equals(auctionId))
                .sorted(Comparator.comparing(Bidder::getBidDate).reversed()) // Optional: latest bid first
                .collect(Collectors.toList());
    }

}
