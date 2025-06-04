<header
  class="flex items-center justify-between border-b border-slate-200 bg-white px-8 py-4 shadow-sm"
>
  <div class="flex items-center gap-6">
    <div class="flex items-center gap-3 text-slate-900">
      <div class="size-8 text-blue-600">
        <svg fill="none" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
          <path
            clip-rule="evenodd"
            d="M24 4C12.9543 4 4 12.9543 4 24C4 35.0457 12.9543 44 24 44C35.0457 44 44 35.0457 44 24C44 12.9543 35.0457 4 24 4ZM24 6C14.0589 6 6 14.0589 6 24C6 33.9411 14.0589 42 24 42C33.9411 42 42 33.9411 42 24C42 14.0589 33.9411 6 24 6ZM24 12C22.3431 12 21 13.3431 21 15V22H14C12.3431 22 11 23.3431 11 25C11 26.6569 12.3431 28 14 28H21V31C21 32.6569 22.3431 34 24 34C25.6569 34 27 32.6569 27 31V28H34C35.6569 28 37 26.6569 37 25C37 23.3431 35.6569 22 34 22H27V15C27 13.3431 25.6569 12 24 12Z"
            fill="currentColor"
            fill-rule="evenodd"
          ></path>
        </svg>
      </div>
      <h1 class="text-xl font-bold">Auction</h1>
    </div>
    <nav class="flex items-center gap-4">
      <a
        class="text-slate-700 hover:text-blue-600 text-sm font-medium transition-colors"
        href="index.jsp"
        >Home</a
      >
      <a
        class="text-slate-700 hover:text-blue-600 text-sm font-medium transition-colors"
        href="#"
        >Categories</a
      >
      <a
        class="text-slate-700 hover:text-blue-600 text-sm font-medium transition-colors"
        href="#"
        >My Bids</a
      >
      <a
        class="text-slate-700 hover:text-blue-600 text-sm font-medium transition-colors"
        href="login.jsp"
        >Login</a
      >
    </nav>
  </div>
  <div id="loginButtonWrapper" class="">
    <a
      href="login.jsp"
      class="flex min-w-[84px] max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-md h-10 px-5 bg-blue-600 text-white text-sm font-semibold leading-normal tracking-wide shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors"
    >
      <span class="truncate">Login</span>
    </a>
  </div>
  <div id="userNavWrapper" class="flex items-center gap-4 hidden">
    <div class="relative" x-data="{ open: false }">
      <button
        @click="open = !open"
        class="flex items-center gap-2 cursor-pointer"
      >
        <img
          alt="User Avatar"
          class="h-8 w-8 rounded-full object-cover"
          src="https://lh3.googleusercontent.com/aida-public/AB6AXuC556dpIDDWuJEZGlseIhRGeBB4SGIE4neSMfPzU2z7ER1SOqt2vfyLc6hkNRvyF1njsPqv6Bz1xTQQKgMdrC8SuOefQcvViYgtlGbHkLZSjUZPOJ7uGcD8dJDW8sGzSValA5Per4q2H48Zq9WlN757apW58BCG_UVz3rCsQZ_jNT7z5oVBFxm32vClt822yEGmrnNzrA2mKXeCJ2pR98bT6HgfVXtrmCFgDzdSnn6rjALJmaZkD-hdn5bPjZxwCevWE_XaoXP0a4A"
        />
        <span id="usernameDisplay" class="text-sm font-medium text-gray-700">John Doe</span>
        <span
          :class="{'rotate-180': open}"
          class="material-symbols-outlined text-gray-500 transition-transform duration-200"
          >expand_more</span
        >
      </button>
      <div
        @click.away="open = false"
        class="absolute right-0 mt-2 w-48 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none z-10"
        style="display: none"
        x-show="open"
        x-transition:enter="transition ease-out duration-100"
        x-transition:enter-end="transform opacity-100 scale-100"
        x-transition:enter-start="transform opacity-0 scale-95"
        x-transition:leave="transition ease-in duration-75"
        x-transition:leave-end="transform opacity-0 scale-95"
        x-transition:leave-start="transform opacity-100 scale-100"
      >
        <div class="py-1">
          <a
            class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100"
            href="#"
            id="user-menu-item-0"
            role="menuitem"
            tabindex="-1"
            >Account</a
          >
          <a
            class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100"
            href="#"
            id="user-menu-item-1"
            role="menuitem"
            tabindex="-1"
            >Logout</a
          >
        </div>
      </div>
    </div>
  </div>
</header>
