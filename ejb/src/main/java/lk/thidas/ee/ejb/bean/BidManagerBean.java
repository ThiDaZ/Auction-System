package lk.thidas.ee.ejb.bean;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import lk.thidas.ee.core.model.AuctionItem;
import lk.thidas.ee.core.model.Bidder;
import lk.thidas.ee.core.model.User;
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
            return newBid;
        }
        return null;
    }

    @Override
    public User getHighestBidder(AuctionItem item) {
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

        return highestBid.getUser();
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
