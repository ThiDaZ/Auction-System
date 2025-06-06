package lk.thidas.ee.core.model;

import java.io.Serializable;

public class Bidder implements Serializable {
    private User user;
    private AuctionItem item;
    private int bidderId;
    private double bidAmount;

    public Bidder(){
    }

    public Bidder(User user, AuctionItem item, int bidderId, double bidAmount) {
        this.user = user;
        this.item = item;
        this.bidderId = bidderId;
        this.bidAmount = bidAmount;
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

    public int getBidderId() {
        return bidderId;
    }

    public void setBidderId(int bidderId) {
        this.bidderId = bidderId;
    }

    public double getBidAmount() {
        return bidAmount;
    }

    public void setBidAmount(double bidAmount) {
        this.bidAmount = bidAmount;
    }
}
