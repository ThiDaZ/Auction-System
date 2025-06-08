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

    switch (data.type) {
        case "new_bid":
            handleNewBid(data);
            break;
        case "auction_ended":
            console.log("auction_ended");
            console.log(data);
            handleAuctionEnd(data);
            break;
    }
};

function handleAuctionEnd(message) {
    const cardWrapper = document.getElementById('card-wrapper');
    if (!cardWrapper) return;

    // Clear existing content
    cardWrapper.innerHTML = '';

    // Clone the end card template
    const endCard = document.getElementById("end-card").content.cloneNode(true);

    // Update winning bid amount
    const winningBidElement = endCard.querySelector("#winning-bid");
    if (winningBidElement) {
        winningBidElement.textContent = `LKR ${message.winningBid.toLocaleString()}`;
    }

    // Update winner info
    const winnerName = message.winnerName;
    const winnerEmail = message.winnerEmail;
    const maskedEmail = winnerEmail ? maskEmail(winnerEmail) : "";
    const winnerInfoElement = endCard.querySelector("#winner-info");
    if (winnerInfoElement) {
        winnerInfoElement.innerHTML = `<strong>Winner:</strong> ${winnerName} ${
            maskedEmail ? `(${maskedEmail})` : ""
        }`;
    }

    // Update end time
    const endTime = new Date(message.endTime);
    const endTimeElement = endCard.querySelector("#auction-end-info");
    if (endTimeElement) {
        endTimeElement.innerHTML = `<strong>Auction Ended:</strong> ${endTime.toLocaleString()}`;
    }

    // Add the end card to the wrapper
    cardWrapper.appendChild(endCard);
    
    // Update visual state
    showEndState();
    
    // Remove timer if it exists
    const timerWrapper = document.getElementById('timer-wrapper');
    if (timerWrapper) {
        timerWrapper.remove();
    }

    // Remove bid history if it exists
    const bidHistory = document.getElementById('bid-history-wrapper');
    if (bidHistory) {
        bidHistory.remove();
    }
}

function maskEmail(email) {
    const [username, domain] = email.split("@");
    const maskedUsername =
        username.charAt(0) +
        "*".repeat(username.length - 2) +
        username.charAt(username.length - 1);
    return `${maskedUsername}@${domain}`;
}


