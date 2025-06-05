package lk.thidas.ee.core.model;

import java.io.Serializable;

public class AuctionItem implements Serializable {
    private int id;
    private String title;
    private String description;
    private double currentBid;
    private double bidPrice;
}
