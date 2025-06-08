const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString)
const auctionId = urlParams.get("id");

async function placeBid(){

    const bidAmount = document.getElementById("bid-amount").value;

    const response = await fetch("placeBid",{
        method: "POST",
        body: JSON.stringify({auctionId, bidAmount}),
        headers: {"Content-Type": "application/json"}
    });

    if(response.ok){
        document.getElementById("bid-amount").value = "";
    }else{
        alert("Something went wrong, Try again!")
    }
}

async function placeQuickBid(quickBidType){

    const highestBidElement = document.getElementById("highest-bid");
    if (!highestBidElement) {
        alert("Cannot determine current highest bid");
        return;
    }

    const highestBidText = highestBidElement.textContent.trim();
    const highestBid = parseFloat(highestBidText.replace("LKR ", ""));

    if (isNaN(highestBid)) {
        alert("Invalid highest bid value");
        return;
    }

    let bidIncrement = 0;
    if (quickBidType === 1) {
        bidIncrement = 500;
    } else if (quickBidType === 2) {
        bidIncrement = 1000;
    } else if (quickBidType === 3) {
        bidIncrement = 1500;
    } else {
        alert("Invalid quick bid type");
        return;
    }

    const bidAmount = highestBid + bidIncrement;

    // Send the bid request to the server
    const response = await fetch("placeBid", {
        method: "POST",
        body: JSON.stringify({auctionId, bidAmount}),
        headers: {"Content-Type": "application/json"}
    });

    if(response.ok){
        console.log(`Quick bid placed: LKR ${bidAmount} (+${bidIncrement})`);
    } else {
        alert("Something went wrong, Try again!");
    }
}
