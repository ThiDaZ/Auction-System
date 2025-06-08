const socket = new WebSocket("ws://localhost:8080/auction/ws/auction");

const queryString2 = window.location.search;
const urlParams2 = new URLSearchParams(queryString2);
const auctionID_sub = urlParams2.get("id");

socket.onopen = () => {
    socket.send(
        JSON.stringify({
            type: "subscribe",
            auctionID_sub,
        })
    );
};

socket.onmessage = (event) => {
    const data = JSON.parse(event.data);
    console.log("WebSocket message received:", data);

    if (data.type === "highest_bid") {
        if (typeof cardHighestBidUpdate === "function") {
            cardHighestBidUpdate(data);
        }
        console.log("highest_bid");

        if (typeof updateQuickBidButtons === "function") {
            updateQuickBidButtons();
        }
    }

    if (data.type === "update_bid") {
        if (typeof cardUpdate === "function") {
            cardUpdate(data);
        }
        console.log("update_bid");
        if (typeof tableUpdate === "function") {
            tableUpdate(data);
        }
        if (typeof updateQuickBidButtons === "function") {
            updateQuickBidButtons();
        }
    }
};


