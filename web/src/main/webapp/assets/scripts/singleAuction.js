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


    document.getElementById("breadcrumbTitle").textContent = item.title;
    document.getElementById("title").textContent = item.title;
    document.getElementById("description").textContent = item.description;

    startCountdownUpdater(startTime, endTime);

}

function startCountdownUpdater(startTime, endTime) {
    setInterval(() => {

        const timeduration = getTimeduration(startTime, endTime);

        document.getElementById("days").textContent = timeduration.duration.days;
        document.getElementById("hours").textContent = timeduration.duration.hours;
        document.getElementById("minutes").textContent = timeduration.duration.minutes;
        document.getElementById("seconds").textContent = timeduration.duration.seconds;


    }, 1000); // ⏱ every 1 second
}


function getTimeduration(startTime, endTime){
    const now = new Date();

    let status = "";
    let duration = {};


    if(now< startTime){
        duration = formatDuration(startTime - now);
        status = "pending"
    }else if(now >= startTime && now < endTime){
        duration = formatDuration(endTime - now);
        status = "active"
    }else{
        status = "ended"
    }

    return{
        status,
        duration
    }
}

function formatDuration(ms) {
    if (ms <= 0) return "0s";

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
