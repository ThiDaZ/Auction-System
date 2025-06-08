const socket = new WebSocket("ws://localhost:8080/auction/ws/auction")

const queryString2 = window.location.search;
const urlParams2 = new URLSearchParams(queryString2)
const auctionID_sub = urlParams2.get("id");

socket.onopen = () => {
    socket.send(JSON.stringify({
            type: "subscribe",
            auctionID_sub
        }
    ));
}

socket.onmessage = (event) => {
    const update = JSON.parse(event.data);
    console.log(update);

    if (update.type === "auction_update") {
        console.log(update.newBid);
        console.log(update);
    }
}


// if (update.type === "bid" || update.type === "auction_update") {
//     // Allow a small delay for any DOM updates to complete
//     setTimeout(() => {
//         // Check if updateQuickBidButtons function exists (it's defined in singleAuction.js)
//         if (typeof updateQuickBidButtons === "function") {
//             updateQuickBidButtons();
//         }
//     }, 100);
// }