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

  if (data.type === "highest_bid" || data.type === "update_bid") {
    setTimeout(() => {
        if (typeof updateQuickBidButtons === "function") {
            updateQuickBidButtons();
        }
    }, 100);
  }

  if (data.type === "highest_bid") {
  }

  if (data.type === "update_bid") {
    setTimeout(() => {

      if (typeof tableUpdate === "function") {
        console.log(data);
        tableUpdate(data);
      }
    }, 100);
    console.log(data);
  }
};


