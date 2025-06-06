<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link crossorigin="" href="https://fonts.gstatic.com/" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;500;700;900&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
          rel="stylesheet"/>
    <title>Auction - Login</title>
    <link href="data:image/x-icon;base64," rel="icon" type="image/x-icon"/>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
</head>
<body >
<div class="relative flex size-full min-h-screen flex-col bg-slate-50 group/design-root overflow-x-hidden"
     style='font-family: "Plus Jakarta Sans", "Noto Sans", sans-serif;'>
    <div class="layout-container flex h-full grow flex-col">
        <%@ include file="/components/header.jsp" %>

        <main class="flex flex-1 items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
            <div class="w-full max-w-md space-y-8 bg-white p-8 sm:p-10 rounded-xl shadow-xl">
                <div>
                    <h2 class="mt-6 text-center text-3xl font-extrabold text-slate-900">Welcome back!</h2>
                    <p class="mt-2 text-center text-sm text-slate-600">
                        Sign in to continue to BidHub.
                    </p>
                </div>
                <%@ include file="components/alertMessage.jsp" %>
                <div class="mt-8 space-y-6">
                    <input name="remember" type="hidden" value="true"/>
                    <div class="rounded-md shadow-sm -space-y-px">
                        <div>
                            <label class="block text-sm font-medium text-slate-700 mb-1" for="email">Email</label>
                            <input autocomplete="email"
                                   class="form-input relative block w-full appearance-none rounded-md border border-slate-300 px-3 py-3 text-slate-900 placeholder-slate-400 focus:z-10 focus:border-blue-500 focus:outline-none focus:ring-blue-500 sm:text-sm"
                                   id="email" name="email" placeholder="Enter your Email" required=""
                                   type="text"/>
                        </div>
                        <div class="pt-4">
                            <label class="block text-sm font-medium text-slate-700 mb-1" for="password">Password</label>
                            <input autocomplete="current-password"
                                   class="form-input relative block w-full appearance-none rounded-md border border-slate-300 px-3 py-3 text-slate-900 placeholder-slate-400 focus:z-10 focus:border-blue-500 focus:outline-none focus:ring-blue-500 sm:text-sm"
                                   id="password" name="password" placeholder="Enter your password" required=""
                                   type="password"/>
                        </div>
                    </div>
                    <div class="flex items-center justify-between pt-2">
                        <div class="flex items-center">
                            <input class="form-checkbox h-4 w-4 rounded border-slate-300 text-blue-600 focus:ring-blue-500"
                                   id="remember-me" name="remember-me" type="checkbox"/>
                            <label class="ml-2 block text-sm text-slate-900" for="remember-me">Remember me</label>
                        </div>
                        <div class="text-sm">
                            <a class="font-medium text-blue-600 hover:text-blue-500" href="#">Forgot your password?</a>
                        </div>
                    </div>
                    <div>
                        <button class="flex w-full justify-center rounded-md border border-transparent bg-blue-600 py-3 px-4 text-sm font-semibold text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors duration-150"
                                onclick="login()">
                            Log In
                        </button>
                    </div>
                </div>
                <p class="mt-6 text-center text-sm text-slate-600">
                    Don't have an account?
                    <a class="font-medium text-blue-600 hover:text-blue-500" href="signup.jsp">Create an Account</a>
                </p>
            </div>
        </main>

    </div>
</div>
<script src="assets/scripts/session.js"></script>
</body>
</html>