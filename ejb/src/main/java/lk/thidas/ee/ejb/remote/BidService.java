package lk.thidas.ee.ejb.remote;

import jakarta.ejb.Remote;
import lk.thidas.ee.core.model.AuctionItem;
import lk.thidas.ee.core.model.Bidder;
import lk.thidas.ee.core.model.User;

import java.time.LocalDateTime;
import java.util.List;

@Remote
public interface BidService{

    Bidder getBid(String bidId);
    Bidder placeBid(String email, String auctionId, Double bidAmount, LocalDateTime timestamp);
    Bidder getHighestBid(AuctionItem item);
    List<Bidder> getAllBids(AuctionItem item);


}
