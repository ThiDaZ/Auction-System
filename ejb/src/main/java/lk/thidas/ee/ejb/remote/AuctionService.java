package lk.thidas.ee.ejb.remote;

import jakarta.ejb.Local;
import lk.thidas.ee.core.model.AuctionItem;
import lk.thidas.ee.core.model.User;

import java.util.Map;

@Local
public interface AuctionService {
    void addAuctionItem(AuctionItem item);
    void removeAuctionItem(AuctionItem item);
    void addNewBid(AuctionItem item, User user, double amount);
    void updateAuctionItem(AuctionItem item);
    AuctionItem getAuctionItem(AuctionItem item);
    Map<String, AuctionItem> getAllAuctionItems();
}
