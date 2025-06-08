package lk.thidas.ee.core.dto;

import java.io.Serializable;

public class PlaceBid_DTO implements Serializable {
    String auctionId;
    String bidAmount;

    public PlaceBid_DTO() {
    }

    public PlaceBid_DTO(String auctionId, String bidAmount) {
        this.auctionId = auctionId;
        this.bidAmount = bidAmount;
    }

    public String getAuctionId() {
        return auctionId;
    }

    public void setAuctionID(String auctionId) {
        this.auctionId = auctionId;
    }

    public String getBidAmount() {
        return bidAmount;
    }

    public void setBidAmount(String bidAmount) {
        this.bidAmount = bidAmount;
    }
}
