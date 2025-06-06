package lk.thidas.ee.core.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class AuctionItem implements Serializable {
    private String title;
    private String description;
    private double startBid;
    private LocalDateTime startTime;
    private LocalDateTime endTime;

    public AuctionItem() {}

    public AuctionItem(String title, String description, double startBid, LocalDateTime startTime,  LocalDateTime endTime) {
        this.title = title;
        this.description = description;
        this.startBid = startBid;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getStartBid() {
        return startBid;
    }

    public void setStartBid(double startBid) {
        this.startBid = startBid;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }
}
