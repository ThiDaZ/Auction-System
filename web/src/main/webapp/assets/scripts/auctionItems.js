async function getAllAuction() {
    try {
        const response = await fetch("getAllAuction");
        if (response.ok) {
            const json = await response.json();

            if (json.success) {
                const auctions = json.content;
                generateCard(auctions);

            } else {
                const data = [];
                console.log("Empty Data!")
            }
        } else {
            console.log("somthing went wrong!")
        }

    } catch (e) {
        console.log(e)
    }
}

function generateCard(auctions) {
    const auctionList = document.getElementById("auction-list");
    const countdownTargets = [];
    for (const id in auctions) {
        const item = auctions[id];

        const startTime = parseDateTime(item.startTime);
        const endTime = parseDateTime(item.endTime);
        const card = document.createElement("div");
        card.className = "flex flex-col bg-white rounded-lg shadow-lg overflow-hidden transition-shadow hover:shadow-xl";

        card.innerHTML = `
            <div class="w-full bg-center bg-no-repeat aspect-[4/3] bg-cover"
                 style="
                 background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDG56bDOL29Azp57JQ4j7CGS8OSDtQW5DR7l7qVvrwP1i0IfSz9J9NPWHsAzagOqmoU2OHym5PmNtxK3gNWFeCs-JB-LE7ecXXhbsuh8JeA3UTHW-yXTz406JfQ70vjHn3vSHgY7jHnNpsbaqRiVo3yI3O3ywhPcxCmVRRbwyySb2GgxJm0Ys2Y-dUpeQCpb-kvGdywRHrKnFbchZa-O8TdIkZ1Y_Wq02v_bwuSQkUEFYiylyEhXnVFfe4MQAGMfRPFxGTWTv5c_mM');">
            </div>
            <div class="p-4 flex flex-col flex-grow">
                <h3 class="text-gray-800 text-lg font-semibold leading-tight">
                    ${item.title}
                </h3>
                <p class="text-gray-600 text-sm font-normal leading-normal mt-1 flex-grow">
                    ${item.description}
                </p>
                <div class="mt-4 space-y-2">
                    <div class="flex items-center text-sm text-gray-500">
                        <span class="material-symbols-outlined text-base mr-2">attach_money</span>
                        <span>
                    Min. Bid:
                    <strong class="text-gray-700">LKR.${item.startBid}</strong>
                </span>
                    </div>
                    <div class="flex items-center text-sm text-gray-500" id="time-tag-container-${id}">
                        <span class="material-symbols-outlined text-base mr-2">timer</span>
                        <span id="time-tag-content-${id}"></span>
                    </div>
                    <div class="flex items-center text-sm text-gray-500">
                        <span class="material-symbols-outlined text-base mr-2">gavel</span>
                        <span>Bids: <strong class="text-gray-700">12</strong></span>
                    </div>
                </div>

                <button
                    onclick="window.location.href='single-auction.jsp?id=${id}'"
                    class="mt-6 w-full flex min-w-[84px] max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-md h-10 px-4 bg-blue-600 text-white text-sm font-semibold leading-normal tracking-wide shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors">
                    <span class="truncate">View Details</span>
                </button>
            </div>
        `;
        auctionList.appendChild(card);

        const timeContentSpan = card.querySelector(`#time-tag-content-${id}`);
        if (timeContentSpan) {
            countdownTargets.push({timeContentSpan, startTime, endTime});
        }

        startCountdownUpdater(countdownTargets);

    }

}

function startCountdownUpdater(targets) {
    setInterval(() => {
        targets.forEach(({timeContentSpan, startTime, endTime}) => {
            timeContentSpan.innerHTML = getTimeTagInfo(startTime, endTime).html;
        });
    }, 1000); // ⏱ every 1 second
}


function getTimeTagInfo(startTime, endTime) {
    const now = new Date();

    let label = "";
    let duration = "";

    if (now < startTime) {
        label = "Starts in:";
        duration = formatDuration(startTime - now);
    } else if (now >= startTime && now < endTime) {
        label = "Ends in:";
        duration = formatDuration(endTime - now);

    } else {
        label = "Ended";
    }

    let html;

    if(label === "Starts in:"){
        html = `${label} <strong class="text-gary-700">${duration}</strong>`;
    }else if (label === "Ends in:"){
        html = `${label} <strong class="text-red-700">${duration}</strong>`;
    }else{
        html = `<strong class="text-gray-700">${label}</strong>`;
    }

    return {
        label,
        duration,
        html
    };
}

function parseDateTime(dateTimeObj) {
    if (!dateTimeObj || !dateTimeObj.date || !dateTimeObj.time) {
        return new Date();
    }

    const {date, time} = dateTimeObj;
    return new Date(
        date.year,
        date.month - 1,
        date.day,
        time.hour,
        time.minute,
        time.second
    );
}

function formatDuration(ms) {
    if (ms <= 0) return "0s";

    const totalSeconds = Math.floor(ms / 1000);
    const days = Math.floor(totalSeconds / (60 * 60 * 24));
    const hours = Math.floor((totalSeconds / (60 * 60)) % 24);
    const minutes = Math.floor((totalSeconds / 60) % 60);
    const seconds = totalSeconds % 60;

    const parts = [];
    if (days) parts.push(`${days}d`);
    if (hours) parts.push(`${hours}h`);
    if (minutes) parts.push(`${minutes}m`);
    if (seconds) parts.push(`${seconds}s`);

    return parts.join(" ");
}
