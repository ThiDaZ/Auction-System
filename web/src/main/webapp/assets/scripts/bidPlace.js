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

async function placeQuickBid(id){
    
    const response = await fetch("placeBid",{
        method: "POST",
        body: "",
        headers: {"Content-Type": "application/json"}
    });
}
