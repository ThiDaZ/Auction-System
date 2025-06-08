async function getAuction() {

    const parameter = new URLSearchParams(window.location.search);

    if (parameter.has("id")) {
        const id = parameter.get("id");
        try {
            const response = await fetch("getAuction?id=" + id)

            if (response.ok) {
                const json = await response.json();
                if (json.success) {
                    loadAuction(json.content);
                    console.log(json.content)
                }
            }

        } catch (e) {
            console.log(e);
        }

    } else {
        window.location = "index.jsp";
    }
}

function loadAuction(data) {
    const item = data.auction;
    const startTime = parseDateTime(item.startTime);
    const endTime = parseDateTime(item.endTime);
    startCountdownUpdater(startTime, endTime);

    document.getElementById("breadcrumbTitle").textContent = item.title;
    document.getElementById("title").textContent = item.title;
    document.getElementById("description").textContent = item.description;

    if(document.getElementById("before-active-card")){
        document.getElementById("starting-bid").textContent = `LKR ${item.startBid}`;
    }    
    if (data.highest_bid) {
        const highestBidElement = document.getElementById("highest-bid");
        const highestBidderName = document.getElementById("highest-bidder-name");
        const bidderInfoDiv = document.querySelector("#highest-bid-info .text-right");
        const bidLabel = document.querySelector("#highest-bid-info h2");
        const userBidElement = document.getElementById("user-bid");
        const currentUserEmail = getCurrentUserEmail();
        
        if (highestBidElement) {
            highestBidElement.textContent = `LKR ${data.highest_bid.amount}`;
            
            // If there's a bidder name, show bidder info, otherwise show as starting bid
            if (data.highest_bid.bidder_name && highestBidderName) {
                bidLabel.textContent = "Highest Bid";
                bidderInfoDiv.style.display = "block";
                highestBidderName.textContent = data.highest_bid.bidder_name;

                // Update user's bid if they are the highest bidder
                if (currentUserEmail && data.highest_bid.email === currentUserEmail && userBidElement) {
                    userBidElement.textContent = `LKR ${data.highest_bid.amount}`;
                }
            } else {
                bidLabel.textContent = "Starting Bid";
                bidderInfoDiv.style.display = "none";
            }
        }
        // Update the bid status to show correct status
        setTimeout(bidStatusUpdate, 100);
    }

    if (data.bid_history && Array.isArray(data.bid_history)) {
        const sortedBids = data.bid_history.sort((a, b) => 
            new Date(b.bidDate) - new Date(a.bidDate)
        );
        
        sortedBids.forEach(bid => {
            const maskedEmail = bid.user.email.replace(/(.{1})(.*)(@.*)/, "$1***$3");
            const bidData = {
                user_name: maskedEmail,
                bid_amount: bid.bidAmount,
                bid_time: new Date(bid.bidDate),
                email: bid.user.email
            };
            tableUpdate(bidData);
        });
    }

    updateQuickBidButtons();
    
    setTimeout(bidStatusUpdate, 100);
}

function startCountdownUpdater(startTime, endTime) {
    let currentState = "";

    function updateCountdown() {
        const cardWrapper = document.getElementById("card-wrapper");
        const timeduration = getTimeduration(startTime, endTime);
        const timeStatusTitle = document.getElementById("time-status-title");
        const timer = document.getElementById('timer-wrapper');
        const bidHistoryWrapper = document.getElementById("bid-history-wrapper");

        if (timer && timeduration.duration) {
            document.getElementById("days").textContent = timeduration.duration.days;
            document.getElementById("hours").textContent = timeduration.duration.hours;
            document.getElementById("minutes").textContent = timeduration.duration.minutes;
            document.getElementById("seconds").textContent = timeduration.duration.seconds;
        }

        if (timeduration.status !== currentState) {
            currentState = timeduration.status;
            cardWrapper.innerHTML = "";

            switch (timeduration.status) {
                case "upcoming": {
                    const template = document.getElementById("upcoming-card");
                    isFormEnable(false);
                    bidHistoryWrapper?.remove();
                    cardWrapper.appendChild(template.content.cloneNode(true));
                    timeStatusTitle.textContent = "Auction Starts In";
                    break;
                }
                case "active": {
                    const template = document.getElementById("active-card");
                    isFormEnable(true);
                    cardWrapper.appendChild(template.content.cloneNode(true));
                    timeStatusTitle.textContent = "Time Remaining ";
                    setTimeout(updateQuickBidButtons, 100);
                    break;
                }
                case "ended": {
                    const template = document.getElementById("end-card");
                    isFormEnable("kill");
                    bidHistoryWrapper?.remove();
                    timer?.remove();
                    cardWrapper.appendChild(template.content.cloneNode(true));
                    clearInterval(countdownInterval);
                    break;
                }
            }
        }
    }

    updateCountdown();

    const countdownInterval = setInterval(updateCountdown, 1000);
}

function isFormEnable(mode) {
    const bidAmount = document.getElementById("bid-amount");
    const bidPlaceButton = document.getElementById("bid-place-button");
    const quickBid1 = document.getElementById("quick-bid-1");
    const quickBid2 = document.getElementById("quick-bid-2");
    const quickBid3 = document.getElementById("quick-bid-3");

    const quickBids = [quickBid1, quickBid2, quickBid3];

    const activeClassQuick = "w-full rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-primary-color focus:ring-offset-1";
    const disableClassQuick = "w-full rounded-md border border-gray-300 bg-gray-100 px-4 py-2 text-sm font-medium text-gray-400 cursor-not-allowed";

    const activeInput = "focus:ring-primary-color focus:border-primary-color block w-full pl-10 pr-12 sm:text-sm border-gray-300 rounded-md";
    const disableInput = "focus:ring-primary-color focus:border-primary-color block w-full pl-10 pr-12 sm:text-sm border-gray-300 rounded-md bg-gray-100 cursor-not-allowed";

    const activePlaceButton = "flex w-full items-center justify-center rounded-md border border-transparent bg-primary-color px-6 py-3 text-base font-medium text-white hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-primary-color focus:ring-offset-2 transition-colors";
    const disablePlaceButton = "flex w-full items-center justify-center rounded-md border border-transparent bg-gray-300 px-6 py-3 text-base font-medium text-gray-500 cursor-not-allowed";

    if (mode === true) {
        bidAmount.disabled = false;
        bidPlaceButton.disabled = false;
        quickBids.forEach(btn => {
            btn.disabled = false;
            btn.className = activeClassQuick;
        });
        bidAmount.className = activeInput;
        bidPlaceButton.className = activePlaceButton;
    } else if (mode === false) {
        bidAmount.disabled = true;
        bidPlaceButton.disabled = true;
        quickBids.forEach(btn => {
            btn.disabled = true;
            btn.className = disableClassQuick;
        });
        bidAmount.className = disableInput;
        bidPlaceButton.className = disablePlaceButton;
    } else if (mode === "kill") {
        quickBids.forEach(btn => {
            btn.remove()
        });
        bidAmount.remove()
        bidPlaceButton.remove()
    }
}

function getTimeduration(startTime, endTime) {
    const now = new Date();

    let status = "";
    let duration = {};


    if (now < startTime) {
        duration = formatDuration(startTime - now);
        status = "upcoming"
    } else if (now >= startTime && now < endTime) {
        duration = formatDuration(endTime - now);
        status = "active"
    } else {
        status = "ended"
    }

    return {
        status,
        duration
    }
}

function formatDuration(ms) {
    if (ms <= 0) {
        return {
            days: 0,
            hours: 0,
            minutes: 0,
            seconds: 0
        };
    }

    const totalSeconds = Math.floor(ms / 1000);
    const days = Math.floor(totalSeconds / (60 * 60 * 24));
    const hours = Math.floor((totalSeconds / (60 * 60)) % 24);
    const minutes = Math.floor((totalSeconds / 60) % 60);
    const seconds = totalSeconds % 60;

    return {
        days,
        hours,
        minutes,
        seconds
    }
}

function parseDateTime(dateTimeStr) {
    if (!dateTimeStr) {
        return new Date();
    }

    return new Date(dateTimeStr);
}

function updateQuickBidButtons() {
    const highestBidElement = document.getElementById("highest-bid");
    const quickBid1 = document.getElementById("quick-bid-1");
    const quickBid2 = document.getElementById("quick-bid-2");
    const quickBid3 = document.getElementById("quick-bid-3");
    const bidAmount = document.getElementById("bid-amount");

    if (highestBidElement && quickBid1 && quickBid2 && quickBid3) {
        const highestBidText = highestBidElement.textContent.trim();
        const highestBid = parseFloat(highestBidText.replace("LKR ", ""));

        if (!isNaN(highestBid)) {
            const quickBid1Amount = highestBid + 500;
            const quickBid2Amount = highestBid + 1000;
            const quickBid3Amount = highestBid + 1500;
            const bidAmountValue = highestBid;

            quickBid1.textContent = `Quick Bid: LKR ${quickBid1Amount}`;
            quickBid2.textContent = `Quick Bid: LKR ${quickBid2Amount}`;
            quickBid3.textContent = `Quick Bid: LKR ${quickBid3Amount}`;
            bidAmount.min = bidAmountValue ? bidAmountValue : 0;
            bidAmount.placeholder = bidAmountValue;

            quickBid1.onclick = () => placeQuickBid(1);
            quickBid2.onclick = () => placeQuickBid(2);
            quickBid3.onclick = () => placeQuickBid(3);
        }
    }
}

function tableUpdate(data) {
    const tableContainer = document.getElementById("bid-table-container");
    if (!tableContainer) return;
    
    const template = document.getElementById("bid-row-template");
    const clone = template.content.cloneNode(true);

    const bidAmount = parseFloat(data.bid_amount);
    if (isNaN(bidAmount)) {
        console.warn("Invalid bid amount");
        return;
    }

    const userNameElement = clone.querySelector("#user_name");
    const bidAmountElement = clone.querySelector("#bid_amount");
    const bidTimeElement = clone.querySelector("#bid_time");

    if (userNameElement && bidAmountElement && bidTimeElement) {
        if (!data.user_name && data.email) {
            data.user_name = data.email.replace(/(.{1})(.*)(@.*)/, "$1***$3");
        }
        
        userNameElement.textContent = data.user_name;
        bidAmountElement.textContent = `LKR ${bidAmount}`;
        bidTimeElement.textContent = formatTimestamp(data.bid_time);

        const currentUserEmail = getCurrentUserEmail();
        if (data.email === currentUserEmail) {
            userNameElement.textContent += ' (You)';
            bidAmountElement.classList.add('text-green-600');
        }
    }

    if (tableContainer.firstChild) {
        tableContainer.insertBefore(clone, tableContainer.firstChild);
    } else {
        tableContainer.appendChild(clone);
    }
}

function cardHighestBidUpdate(data) {
    const highestBidElement = document.getElementById("highest-bid");
    const highestBidderName = document.getElementById("highest-bidder-name");
    const bidderInfoDiv = document.querySelector("#highest-bid-info .text-right");
    const bidLabel = document.querySelector("#highest-bid-info h2");

    if (highestBidElement) {
        highestBidElement.textContent = `LKR ${data.highest_bid_amount}`;
        if (data.user_name && bidderInfoDiv && bidLabel && highestBidderName) {
            bidLabel.textContent = "Highest Bid";
            bidderInfoDiv.style.display = "block";
            highestBidderName.textContent = data.user_name;
        }
        bidStatusUpdate();
    }
}

function cardUpdate(data) {
    const loggedInUserEmail = getCurrentUserEmail();
    
    if (!loggedInUserEmail) {
        return;
    }

    const userBidElement = document.getElementById("user-bid");

    if (data.email === loggedInUserEmail) {
        if (userBidElement) {
            userBidElement.textContent = `LKR ${data.bid_amount}`;
        }
        bidStatusUpdate();
    }
}

function bidStatusUpdate() {

    const highestBidElement = document.getElementById("highest-bid");
    const userStatusElement = document.getElementById("user-bidder-status");
    const userBidElement = document.getElementById("user-bid");

    let currentHighestBid = 0;
    if (highestBidElement) {
        const rawValue = highestBidElement.textContent.replace("LKR", "").replace(",", "").trim();
        currentHighestBid = parseFloat(rawValue) || 0;
    }

    let currentBid = 0;
    if (userStatusElement) {
        const rawValue = userBidElement.textContent.replace("LKR", "").replace(",", "").trim();
        currentBid = parseFloat(rawValue) || 0;
    }

    if (userStatusElement) {
        if (currentBid >= currentHighestBid) {
            userStatusElement.textContent = "Status: You are the highest bidder";
            userStatusElement.classList.add("text-green-600");
            userBidElement.classList.add("text-green-600");
            userBidElement.classList.remove("text-red-600");
            userStatusElement.classList.remove("text-red-600");
        } else {
            userStatusElement.textContent = "Status: Your bid has been outbid";
            userStatusElement.classList.add("text-red-600");
            userBidElement.classList.add("text-red-600");
            userBidElement.classList.remove("text-green-600");
            userStatusElement.classList.remove("text-green-600");
        }
    }
}

function getCurrentUserEmail() {
    return localStorage.getItem("userEmail");
}

function formatTimestamp(date) {
    if (typeof date === 'string') {
        date = new Date(date);
    }
    
    const now = new Date();
    const diffInSeconds = Math.floor((now - date) / 1000);

    if (diffInSeconds < 60) return 'just now';
    if (diffInSeconds < 3600) return `${Math.floor(diffInSeconds / 60)} minutes ago`;
    if (diffInSeconds < 86400) return `${Math.floor(diffInSeconds / 3600)} hours ago`;
    if (diffInSeconds < 604800) return `${Math.floor(diffInSeconds / 86400)} days ago`;
    
    return date.toLocaleDateString();
}
