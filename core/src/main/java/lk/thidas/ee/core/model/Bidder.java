package lk.thidas.ee.core.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Bidder implements Serializable {
    private User user;
    private AuctionItem item;
    private String auctionId;
    private String bidderId;
    private double bidAmount;
    private LocalDateTime bidDate;

    public Bidder(){
    }

    public Bidder(User user, String auctionId, AuctionItem item, String bidderId, double bidAmount, LocalDateTime bidDate) {
        this.user = user;
        this.auctionId = auctionId;
        this.item = item;
        this.bidderId = bidderId;
        this.bidAmount = bidAmount;
        this.bidDate = bidDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public AuctionItem getItem() {
        return item;
    }

    public void setItem(AuctionItem item) {
        this.item = item;
    }

    public String getBidderId() {
        return bidderId;
    }

    public void setBidderId(String bidderId) {
        this.bidderId = bidderId;
    }

    public double getBidAmount() {
        return bidAmount;
    }

    public void setBidAmount(double bidAmount) {
        this.bidAmount = bidAmount;
    }

    public LocalDateTime getBidDate() {
        return bidDate;
    }

    public void setBidDate(LocalDateTime bidDate) {
        this.bidDate = bidDate;
    }
    public String getAuctionId() {
        return auctionId;
    }
    public void setAuctionId(String auctionId) {
        this.auctionId = auctionId;
    }
}
