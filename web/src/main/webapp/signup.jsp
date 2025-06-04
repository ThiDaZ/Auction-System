<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="preconnect" href="https://fonts.gstatic.com/"/>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;500;700;900&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <title>Auction - SignUp</title>
    <link rel="icon" type="image/x-icon" href="data:image/x-icon;base64,"/>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
</head>
<body >
<div class="min-h-screen flex flex-col bg-slate-50" style='font-family: "Plus Jakarta Sans", "Noto Sans", sans-serif;'>

    <%@ include file="/components/header.jsp" %>

    <main class="flex flex-1 items-center justify-center py-12 px-4">
        <div class="w-full max-w-md space-y-8 bg-white p-8 rounded-xl shadow-xl">
            <div>
                <h2 class="mt-6 text-center text-3xl font-extrabold text-slate-900">Create your new account</h2>
                <p class="mt-2 text-center text-sm text-slate-600">
                    Sign in to continue to BidHub.
                </p>
            </div>
            <%@ include file="components/alertMessage.jsp" %>
            <div class="mt-8 space-y-6">
                <div>
                    <div class="pt-4">
                        <label class="block text-sm font-medium text-slate-700 mb-1" for="username">Username</label>
                        <input autocomplete="username"
                               class="w-full rounded-md border border-slate-300 px-3 py-3 text-slate-900 placeholder-slate-400 focus:border-blue-500 focus:ring-blue-500 sm:text-sm"
                               id="username" name="username" placeholder="Enter your username" required
                               type="text"/>
                    </div>
                    <div class="pt-4">
                        <label class="block text-sm font-medium text-slate-700 mb-1" for="email">Email Address</label>
                        <input autocomplete="email"
                               class="w-full rounded-md border border-slate-300 px-3 py-3 text-slate-900 placeholder-slate-400 focus:border-blue-500 focus:ring-blue-500 sm:text-sm"
                               id="email" name="email" placeholder="Enter your email address" required
                               type="email"/>
                    </div>
                    <div class="pt-4">
                        <label class="block text-sm font-medium text-slate-700 mb-1" for="password">Password</label>
                        <input autocomplete="new-password"
                               class="w-full rounded-md border border-slate-300 px-3 py-3 text-slate-900 placeholder-slate-400 focus:border-blue-500 focus:ring-blue-500 sm:text-sm"
                               id="password" name="password" placeholder="Enter your password" required
                               type="password"/>
                    </div>
                    <div class="pt-4">
                        <label class="block text-sm font-medium text-slate-700 mb-1" for="confirm-password">Confirm
                            Password</label>
                        <input autocomplete="new-password"
                               class="w-full rounded-md border border-slate-300 px-3 py-3 text-slate-900 placeholder-slate-400 focus:border-blue-500 focus:ring-blue-500 sm:text-sm"
                               id="confirm-password" name="confirm-password" placeholder="Re-enter your password"
                               required
                               type="password"/>
                    </div>
                </div>
                <div>
                    <button class="w-full rounded-md bg-blue-600 py-3 px-4 text-sm font-semibold text-white hover:bg-blue-700 focus:ring-2 focus:ring-blue-500 transition-colors duration-150"
                            onclick="signup()"
                    >
                        Create Account
                    </button>
                </div>
            </div>
            <p class="mt-6 text-center text-sm text-slate-600">
                Already have an account?
                <a class="font-medium text-blue-600 hover:text-blue-500" href="signup.jsp">Login</a>
            </p>
        </div>
    </main>

    <script src="assets/scripts/session.js"></script>
</div>
</body>
</html>