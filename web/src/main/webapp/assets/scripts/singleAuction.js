async function getAuction() {

    const parameter = new URLSearchParams(window.location.search);

    if (parameter.has("id")) {
        const id = parameter.get("id");
        console.log(id);
        try {
            const response = await fetch("getAuction?id=" + id)

            if (response.ok) {
                const json = await response.json();
                if(json.success){
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

function loadAuction(item){

    const now = new Date();




    document.getElementById("breadcrumbTitle").textContent = item.title;
    document.getElementById("title").textContent = item.title;
    document.getElementById("description").textContent = item.description;
}





