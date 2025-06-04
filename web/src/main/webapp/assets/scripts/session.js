async function loadUser() {
    try {
        const response = await fetch('checkSession');
        if (!response.ok) {
            const json = await response.json();
            console.log(json);
        }
    } catch (e) {
        console.log(e);
    }
}

async function login() {
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    try {
        const response = await fetch("signIn", {
            method: 'POST',
            body: JSON.stringify({email: email, password: password}),
            headers: {"Content-Type": "application/json"}
        });

        if (response.ok) {
            const json = await response.json();
            if (json.success) {
                window.location = "index.jsp";
                document.getElementById("errorMessageWrapper").classList.add("hidden");

            } else {
                document.getElementById("errorMessageWrapper").classList.remove("hidden");
                document.getElementById("errorMessage").textContent = json.content
            }
            console.log(json);
        }


    } catch (e) {
        console.log(e);
    }
}

async function signup() {

    const user_DTO = {
        email: document.getElementById("email").value,
        username: document.getElementById("username").value,
        password: document.getElementById("password").value,
        confirmPassword: document.getElementById("confirm-password").value
    }

    try {
        const response = await fetch("signup", {
            method: "POST",
            body: JSON.stringify(user_DTO),
            headers: {"Content-Type": "application/json"}
        });

        if (response.ok) {
            const json = await response.json();
            if (json.success) {
                window.location = "login.jsp"
                document.getElementById("errorMessageWrapper").classList.add("hidden");
                document.getElementById("successMessageWrapper").classList.remove("hidden");
                document.getElementById("successMessage").textContent = json.content

            } else {
                document.getElementById("errorMessageWrapper").classList.remove("hidden");
                document.getElementById("errorMessage").textContent = json.content
            }
            console.log(json);
        }

    } catch (e) {
        console.log(e)
    }
}

async function logout() {
    try {
        const response = await fetch("logout");
        if (response.ok) {
            const json = await response.json();
            console.log(json);
        }
    } catch (e) {
        console.log(e);
    }
}