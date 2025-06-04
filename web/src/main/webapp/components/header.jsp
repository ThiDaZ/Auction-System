<header class="flex items-center justify-between border-b border-slate-200 bg-white px-8 py-4 shadow-sm">
    <div class="flex items-center gap-6">
        <div class="flex items-center gap-3 text-slate-900">
            <div class="size-8 text-blue-600">
                <svg fill="none" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
                    <path clip-rule="evenodd"
                          d="M24 4C12.9543 4 4 12.9543 4 24C4 35.0457 12.9543 44 24 44C35.0457 44 44 35.0457 44 24C44 12.9543 35.0457 4 24 4ZM24 6C14.0589 6 6 14.0589 6 24C6 33.9411 14.0589 42 24 42C33.9411 42 42 33.9411 42 24C42 14.0589 33.9411 6 24 6ZM24 12C22.3431 12 21 13.3431 21 15V22H14C12.3431 22 11 23.3431 11 25C11 26.6569 12.3431 28 14 28H21V31C21 32.6569 22.3431 34 24 34C25.6569 34 27 32.6569 27 31V28H34C35.6569 28 37 26.6569 37 25C37 23.3431 35.6569 22 34 22H27V15C27 13.3431 25.6569 12 24 12Z"
                          fill="currentColor" fill-rule="evenodd"></path>
                </svg>
            </div>
            <h1 class="text-xl font-bold">Auction</h1>
        </div>
        <nav class="flex items-center gap-4">
            <a class="text-slate-700 hover:text-blue-600 text-sm font-medium transition-colors"
               href="index.jsp">Home</a>
            <a class="text-slate-700 hover:text-blue-600 text-sm font-medium transition-colors" href="#">Categories</a>
            <a class="text-slate-700 hover:text-blue-600 text-sm font-medium transition-colors" href="#">My Bids</a>
            <a class="text-slate-700 hover:text-blue-600 text-sm font-medium transition-colors"
               href="login.jsp">Login</a>
        </nav>
    </div>
    <div id="login-btn" class="">
        <a href="login.jsp" class="flex min-w-[84px] max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-md h-10 px-5 bg-blue-600 text-white text-sm font-semibold leading-normal tracking-wide shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors">
            <span class="truncate">Login</span>
        </a>
    </div>
    <div id="userNavDetails" class="flex items-center gap-4 hidden">
        <button class="relative p-2 rounded-full text-slate-600 hover:bg-slate-100 hover:text-slate-800 focus:ring-2 focus:ring-blue-500 transition-colors">
            <span class="material-icons text-2xl">notifications_none</span>
            <span class="absolute top-1.5 right-1.5 h-2 w-2 rounded-full bg-red-500"></span>
        </button>
        <div class="bg-center bg-no-repeat bg-cover rounded-full size-10 border-2 border-slate-200 hover:border-blue-500"
             style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuBy-xi6YAx3qJRNDss7PzxiNqZDYhmb_YZPlbQHxFgg3hOWzDI3SniHQlZdVEhMFh8KyPgAaB_ztI-fhnJrMc9ioG02oYz3dR6PgepDCEIuHKoTALH0XciEf7fzqzP08jgbVnfSxvwz-jUIBbYBzz-WICdjs7ovb3n2djwLBs60jBynbOOJXWi8O5AFeEx9pHZIBNuIfkWEMogwBoXe3Faibh7d6xLHpId5CL49GJLYqPCMXfqh3iHZsqjrfD5gF_vbDnLSD_rvJcE");'></div>
    </div>
</header>
