async function getAuction() {

    const parameter = new URLSearchParams(window.location.search);

    if (parameter.has("id")) {
        const id = parameter.get("id");
        console.log(id);
        try {
            const response = await fetch("getAuction?id=" + id)

            if (response.ok) {
                const json = await response.json();
                if (json.success) {
                    loadAuction(json.content);
                    console.log(json.content);
                }
                console.log(json);
            }

        } catch (e) {
            console.log(e);
        }

    } else {
        window.location = "index.jsp";
    }

}

function loadAuction(item) {
    const startTime = parseDateTime(item.startTime);
    const endTime = parseDateTime(item.endTime)
    startCountdownUpdater(startTime, endTime);

    document.getElementById("breadcrumbTitle").textContent = item.title;
    document.getElementById("title").textContent = item.title;
    document.getElementById("description").textContent = item.description;

    if(document.getElementById("before-active-card")){
        document.getElementById("starting-bid").textContent = item.startBid;
    }

    // Update quick bid buttons if the auction is active
    updateQuickBidButtons();
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
                    console.log("upcoming");
                    const template = document.getElementById("upcoming-card");
                    isFormEnable(false);
                    bidHistoryWrapper?.remove();
                    cardWrapper.appendChild(template.content.cloneNode(true));
                    timeStatusTitle.textContent = "Auction Starts In";
                    break;
                }
                case "active": {
                    console.log("active");
                    const template = document.getElementById("active-card");
                    isFormEnable(true);
                    cardWrapper.appendChild(template.content.cloneNode(true));
                    timeStatusTitle.textContent = "Time Remaining ";
                    // Update quick bid buttons when auction becomes active
                    setTimeout(updateQuickBidButtons, 100); // Small delay to ensure DOM is updated
                    break;
                }
                case "ended": {
                    console.log("ended");
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

    const activeInput = "focus:ring-primary-color focus:border-primary-color block w-full pl-7 pr-12 sm:text-sm border-gray-300 rounded-md";
    const disableInput = "focus:ring-primary-color focus:border-primary-color block w-full pl-7 pr-12 sm:text-sm border-gray-300 rounded-md bg-gray-100 cursor-not-allowed";

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

// function parseDateTime(dateTimeObj) {
//     if (!dateTimeObj || !dateTimeObj.date || !dateTimeObj.time) {
//         return new Date();
//     }
//
//     const {date, time} = dateTimeObj;
//     return new Date(
//         date.year,
//         date.month - 1,
//         date.day,
//         time.hour,
//         time.minute,
//         time.second
//     );
// }

function parseDateTime(dateTimeStr) {
    if (!dateTimeStr) {
        return new Date(); // fallback
    }

    return new Date(dateTimeStr);
}

function updateQuickBidButtons() {
    const highestBidElement = document.getElementById("highest-bid");
    const quickBid1 = document.getElementById("quick-bid-1");
    const quickBid2 = document.getElementById("quick-bid-2");
    const quickBid3 = document.getElementById("quick-bid-3");

    // Only update if the auction is active and the highest bid element exists
    if (highestBidElement && quickBid1 && quickBid2 && quickBid3) {
        // Extract the numeric value from the highest bid text (remove "LKR " prefix)
        const highestBidText = highestBidElement.textContent.trim();
        const highestBid = parseFloat(highestBidText.replace("LKR ", ""));

        if (!isNaN(highestBid)) {
            // Calculate the three quick bid amounts
            const quickBid1Amount = highestBid + 500;
            const quickBid2Amount = highestBid + 1000;
            const quickBid3Amount = highestBid + 1500;

            // Update the text of the quick bid buttons
            quickBid1.textContent = `Quick Bid: LKR ${quickBid1Amount}`;
            quickBid2.textContent = `Quick Bid: LKR ${quickBid2Amount}`;
            quickBid3.textContent = `Quick Bid: LKR ${quickBid3Amount}`;

            // Set the onclick handlers
            quickBid1.onclick = () => placeQuickBid(1);
            quickBid2.onclick = () => placeQuickBid(2);
            quickBid3.onclick = () => placeQuickBid(3);
        }
    }
}
