const socket = new WebSocket("ws://localhost:8080/auction/ws/auction")

const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString)
const auctionId = urlParams.get("id");

socket.onmessage = (event) => {
    const update = JSON.parse(event.data);
    console.log(update);
}

socket.onopen = () => {
    socket.send(JSON.stringify({
        type: "subscribe",
        auctionId
    }));
}
