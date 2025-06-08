async function loadUser() {
    try {
        const response = await fetch('checkSession');
        if (response.ok) {
            const json = await response.json();
            if (json.success) {

                const currentPage = window.location.pathname;
                if (currentPage.endsWith('login.jsp') || currentPage.endsWith('signup.jsp')) {
                    window.location.href = 'index.jsp';
                    return;
                }

                // Hide login button
                const loginButtonWrapper = document.getElementById("loginButtonWrapper");
                if (loginButtonWrapper) {
                    loginButtonWrapper.classList.add("hidden");
                }
                // Show user navigation
                const userNavWrapper = document.getElementById("userNavWrapper");
                const username = document.getElementById("usernameDisplay");
                if (userNavWrapper) {
                    userNavWrapper.classList.remove("hidden");
                    username.textContent = json.user.username;
                }
            } else {
                // Show login button
                const loginButtonWrapper = document.getElementById("loginButtonWrapper");
                if (loginButtonWrapper) {
                    loginButtonWrapper.classList.remove("hidden");
                }
                // Hide user navigation
                const userNavWrapper = document.getElementById("userNavWrapper");
                if (userNavWrapper) {
                    userNavWrapper.classList.add("hidden");
                }

                // Redirect to index.jsp if on single-auction.jsp without a session
                const currentPage = window.location.pathname;
                if (currentPage.endsWith("single-auction.jsp")) {
                    window.location.href = 'index.jsp';
                    alert("First, log in to the system to access the auction.")
                }
            }
        }
    } catch (e) {
        console.log(e);
    }
}

document.addEventListener('DOMContentLoaded', function() {
    loadUser();
});

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
