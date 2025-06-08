package lk.thidas.ee.ejb.bean;

import jakarta.annotation.PostConstruct;
import jakarta.ejb.Startup;
import jakarta.ejb.Stateless;
import lk.thidas.ee.core.model.AuctionItem;
import lk.thidas.ee.core.model.User;
import lk.thidas.ee.ejb.remote.AuctionService;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Startup
@Stateless
public class AuctionManagerBean implements AuctionService {

    private Map<String, AuctionItem> auctionItems = new ConcurrentHashMap<>();

    @PostConstruct
    void initSampleData() {
        // Add a variety of auction items with different categories, prices, and descriptions
        LocalDateTime now = LocalDateTime.now();

        // Fashion items
        addAuctionItem(new AuctionItem("Vintage Leather Jacket", "Stylish leather jacket perfect for any occasion", 10.00, now, now.plusDays(1)));
        addAuctionItem(new AuctionItem("Designer Handbag", "Luxury designer handbag, barely used", 50.00, now.plusHours(1), now.plusDays(2)));
        addAuctionItem(new AuctionItem("Diamond Necklace", "Beautiful 18k gold necklace with diamond pendant", 200.00, now.plusHours(2), now.plusHours(3)));

        // Electronics
        addAuctionItem(new AuctionItem("Gaming Laptop", "High-performance gaming laptop with RTX graphics", 500.00, now.minusHours(14), now.plusHours(10)));
        addAuctionItem(new AuctionItem("Smartphone", "Latest model smartphone with 256GB storage", 300.00, now.plusDays(1).plusHours(3), now.plusDays(2)));
        addAuctionItem(new AuctionItem("Wireless Headphones", "Noise-cancelling wireless headphones", 75.00, now.plusDays(2), now.plusDays(3)));

        // Home & Garden
        addAuctionItem(new AuctionItem("Antique Desk", "19th century mahogany writing desk", 150.00, now.plusDays(3), now.plusDays(4)));
        addAuctionItem(new AuctionItem("Garden Furniture Set", "Complete patio furniture set with umbrella", 120.00, now.plusDays(3).plusHours(5), now.plusDays(4)));
        addAuctionItem(new AuctionItem("Oil Painting", "Original landscape oil painting by local artist", 90.00, now.plusDays(4), now.plusDays(5)));

        // Collectibles
        addAuctionItem(new AuctionItem("Rare Comic Book", "First edition comic in mint condition", 250.00, now.plusDays(5), now.plusDays(6)));
        addAuctionItem(new AuctionItem("Vintage Vinyl Records", "Collection of classic rock vinyl records", 40.00, now.plusDays(5).plusHours(12), now.plusDays(6)));
        addAuctionItem(new AuctionItem("Sports Memorabilia", "Signed baseball from championship game", 180.00, now.minusHours(4), now.plusDays(1)));

        System.out.println("Sample auction items created.");
    }

    @Override
    public void addAuctionItem(AuctionItem item) {
        String uniqId = UUID.randomUUID().toString();
        auctionItems.put(uniqId, item);
    }

    @Override
    public void removeAuctionItem(AuctionItem item) {
        String keyToRemove = null;
        for (Map.Entry<String, AuctionItem> entry : auctionItems.entrySet()) {
            if (entry.getValue().getTitle().equals(item.getTitle())) {
                keyToRemove = entry.getKey();
                break;
            }
        }

        if (keyToRemove != null) {
            auctionItems.remove(keyToRemove);
            System.out.println("Auction item removed: " + item.getTitle());
        }
    }

    @Override
    public void addNewBid(String auctionID, User user, double amount) {

        AuctionItem existingItem = getAuctionItem(auctionID);

        if (existingItem != null) {
            // In a real implementation, we would create a Bidder object and associate it with the item
            // For now, we'll just log the bid
            System.out.println("New bid added: User " + user.getUsername() + " bid $" + amount + " on " + existingItem.getTitle());

            // Here we could update the current highest bid on the item if needed
            // This would require adding a currentBid field to AuctionItem
        }
    }

    @Override
    public void updateAuctionItem(AuctionItem item) {
        // Find the key for the item with matching title
        String keyToUpdate = null;
        for (Map.Entry<String, AuctionItem> entry : auctionItems.entrySet()) {
            if (entry.getValue().getTitle().equals(item.getTitle())) {
                keyToUpdate = entry.getKey();
                break;
            }
        }

        // Update the item if found
        if (keyToUpdate != null) {
            auctionItems.put(keyToUpdate, item);
            System.out.println("Auction item updated: " + item.getTitle());
        }
    }

    @Override
    public AuctionItem getAuctionItem(String auctionID) {
        System.out.println("Getting auction item: " + auctionID);
        AuctionItem auctionItem = auctionItems.get(auctionID);
        if (auctionItem == null) {
            throw new NullPointerException("Auction Item with id " + auctionID + " not found.");
        }
        return auctionItem;
    }

    @Override
    public Map<String, AuctionItem> getAllAuctionItems() {
        return auctionItems;
    }

    @Override
    public boolean isAuctionActive(String auctionID) {
        AuctionItem item = getAuctionItem(auctionID);
        LocalDateTime now = LocalDateTime.now();

        boolean isActive = (now.isEqual(item.getStartTime()) || now.isAfter(item.getStartTime())) && now.isBefore(item.getEndTime());

        System.out.println("Checking if auction " + auctionID + " is active: " + isActive);
        return isActive;
    }
}
