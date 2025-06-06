<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;500;700;900&family=Plus+Jakarta+Sans:wght@400;500;700;800&display=swap"
          rel="stylesheet"
    />
    <title>Auction</title>
    <link rel="icon" type="image/x-icon" href="data:image/x-icon;base64," />
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>

  </head>
  <body
    class="bg-white"
    style="font-family: 'Plus Jakarta Sans', 'Noto Sans', sans-serif"
    onload="getAllAuction()"
  >
    <div class="min-h-screen flex flex-col">
      <%@ include file="/components/header.jsp" %>
      <main
        class="px-4 sm:px-6 lg:px-10 flex flex-1 justify-center py-8 bg-gray-50"
      >
        <div class="w-full max-w-6xl">
          <div class="px-4 py-6">
            <label class="flex flex-col min-w-40 h-12 w-full max-w-xl mx-auto relative">
              <div class="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500">
                <svg
                  fill="currentColor"
                  height="24"
                  width="24"
                  viewBox="0 0 256 256"
                >
                  <path
                    d="M229.66,218.34l-50.07-50.06a88.11,88.11,0,1,0-11.31,11.31l50.06,50.07a8,8,0,0,0,11.32-11.32ZM40,112a72,72,0,1,1,72,72A72.08,72.08,0,0,1,40,112Z"
                  ></path>
                </svg>
              </div>
              <input
                class="form-input w-full rounded-lg text-gray-900 focus:ring-2 focus:ring-blue-500 border border-gray-300 bg-white h-full placeholder:text-gray-500 pl-12 pr-4 py-3 text-base shadow-sm"
                placeholder="Search for items..."
              />
            </label>
          </div>
          <h2 class="text-gray-900 text-2xl font-bold leading-tight tracking-tight px-4 pb-4 pt-6">
            Live Auctions
          </h2>

          <div id="auction-list" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 p-4">

          </div>
        </div>
      </main>
      <footer class="py-8 px-10 text-center border-t border-gray-200 bg-white">
        <p class="text-sm text-gray-600">
          © 2025 Auction. All rights reserved.
        </p>
      </footer>
      <script src="assets/scripts/session.js"></script>
      <script src="assets/scripts/auctionItems.js"></script>
    </div>
  </body>
</html>
