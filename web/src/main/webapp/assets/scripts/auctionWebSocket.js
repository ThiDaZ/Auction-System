const socket = new WebSocket("wss://localhost:8080/auction")

socket.onmessage = (event) => {
    const update = JSON.parse(event.data);
}

