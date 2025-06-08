package lk.thidas.ee.ejb.remote;

import jakarta.ejb.Remote;
import lk.thidas.ee.core.model.AuctionItem;
import lk.thidas.ee.core.model.User;

import java.util.Map;

@Remote
public interface AuctionService {
    void addAuctionItem(AuctionItem item);
    void removeAuctionItem(AuctionItem item);
    void addNewBid(String auctionID, User user, double amount);
    void updateAuctionItem(AuctionItem item);
    AuctionItem getAuctionItem(String auctionID);
    Map<String, AuctionItem> getAllAuctionItems();
    boolean isAuctionActive(String auctionID);
}
