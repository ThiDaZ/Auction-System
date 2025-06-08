const socket = new WebSocket("ws://localhost:8080/auction/ws/auction")

const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString)
const auctionId = urlParams.get("id");

socket.onmessage = (event) => {
    const update = JSON.parse(event.data);
    console.log(update);

    // If this is a bid update, update the highest bid display and quick bid buttons
    if (update.type === "bid" || update.type === "auction_update") {
        // Allow a small delay for any DOM updates to complete
        setTimeout(() => {
            // Check if updateQuickBidButtons function exists (it's defined in singleAuction.js)
            if (typeof updateQuickBidButtons === "function") {
                updateQuickBidButtons();
            }
        }, 100);
    }
}

socket.onopen = () => {
    socket.send(JSON.stringify({
        type: "subscribe",
        auctionId
    }));
}
