<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Auction</title>
    <link href="data:image/x-icon;base64," rel="icon" type="image/x-icon"/>
    <link crossorigin="" href="https://fonts.gstatic.com/" rel="preconnect"/>
    <link
            as="style"
            href="https://fonts.googleapis.com/css2?display=swap&amp;family=Plus+Jakarta+Sans:wght@400;500;700;800&amp;family=Noto+Sans:wght@400;500;700;900"
            onload="this.rel='stylesheet'"
            rel="stylesheet"
    />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <style>
        .font-plus-jakarta-sans {
            font-family: "Plus Jakarta Sans", "Noto Sans", sans-serif;
        }

        .primary-color {
            color: #0c7ff2;
        }

        .bg-primary-color {
            background-color: #0c7ff2;
        }

        .border-primary-color {
            border-color: #0c7ff2;
        }

        .ring-primary-color:focus {
            --tw-ring-color: #0c7ff2;
        }
    </style>
</head>
<body onload="getAuction()" class="font-plus-jakarta-sans bg-gray-50 text-gray-900">
<div class="relative flex min-h-screen flex-col">
    <%@ include file="/components/header.jsp" %>
    <main class="container mx-auto flex-1 px-4 py-8 sm:px-6 lg:px-8">
        <div class="max-w-4xl mx-auto">
            <div class="mb-4">
                <nav aria-label="Breadcrumb">
                    <ol class="flex items-center space-x-2 text-sm" role="list">
                        <li>
                            <a
                                    class="font-medium text-gray-500 hover:text-gray-700"
                                    href="index.jsp"
                            >Home</a
                            >
                        </li>
                        <li>
                            <svg
                                    aria-hidden="true"
                                    class="h-5 w-5 flex-shrink-0 text-gray-300"
                                    fill="currentColor"
                                    viewBox="0 0 20 20"
                            >
                                <path
                                        clip-rule="evenodd"
                                        d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z"
                                        fill-rule="evenodd"
                                ></path>
                            </svg>
                        </li>
                        <li>
                            <span id="breadcrumbTitle" class="font-medium text-gray-800">Auction</span>
                        </li>
                    </ol>
                </nav>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <div>
                    <div
                            class="aspect-w-1 aspect-h-1 w-full overflow-hidden rounded-lg shadow-lg"
                    >
                        <img
                                alt="Smartphone X Pro"
                                class="h-full w-full object-cover object-center"
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuAWAdFxBj-mf2lS2n9F66iWPZeEi8m0cvnVZ8Jyj4Fj8Z5Smgt34L2N8uYsMnD1wq1BD0ZCzwwuuK_k6mAew8UwW8ExBwF3mjfIah3tOHnyEpY_cZLOfHgSnaJSHwMjXkNT1CU_BXHeA_ARyq6B0ev1oB90tKF2U7yotQnIdygGeO3IakZM1AoysVR707iAX9WjyQ3_o9DSMRC40Jy33T2GrvaopkAXUj-JDIuOKijMQE9BDdxuKX7ong3AlIuhMAOXAaqiOCkk-yM"
                        />
                    </div>
                </div>
                <div class="flex flex-col justify-between">
                    <div>
                        <h1
                                class="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl"
                                id="title"
                        >
                            Title
                        </h1>
                        <p id="description" class="mt-4 text-gray-700">
                            Description
                        </p>

                        <%--            state card--%>
                        <div class="mt-8 p-6 bg-white rounded-lg shadow-md" id="card-wrapper">
                        </div>
                        <%@ include file="components/auctionStateCards.jsp" %>

                        <%--            time--%>
                        <div class="mt-8" id="timer-wrapper">
                            <h2 id="time-status-title" class="text-sm font-medium text-gray-600">
                                Time Remaining
                            </h2>
                            <div class="mt-2 grid grid-cols-4 gap-2 text-center">
                                <div>
                                    <div
                                            class="rounded-md bg-gray-100 py-3 px-2 text-2xl font-bold text-gray-900"
                                            id="days"
                                    >
                                        0
                                    </div>
                                    <div class="mt-1 text-xs text-gray-500">Days</div>
                                </div>
                                <div>
                                    <div
                                            class="rounded-md bg-gray-100 py-3 px-2 text-2xl font-bold text-gray-900"
                                            id="hours"
                                    >
                                        0
                                    </div>
                                    <div class="mt-1 text-xs text-gray-500">Hours</div>
                                </div>
                                <div>
                                    <div
                                            class="rounded-md bg-gray-100 py-3 px-2 text-2xl font-bold text-gray-900"
                                            id="minutes"
                                    >
                                        0
                                    </div>
                                    <div class="mt-1 text-xs text-gray-500">Minutes</div>
                                </div>
                                <div>
                                    <div
                                            class="rounded-md bg-gray-100 py-3 px-2 text-2xl font-bold text-gray-900"
                                            id="seconds"
                                    >
                                        0
                                    </div>
                                    <div class="mt-1 text-xs text-gray-500">Seconds</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--                form--%>
                    <div class="mt-10">
                        <div>
                            <div class="grid grid-cols-3 gap-4 items-end">
                                <div class="col-span-2">
                                    <label
                                            class="block text-sm font-medium text-gray-700"
                                            for="bid-amount"
                                    >Your Bid Amount</label
                                    >
                                    <div class="mt-1 relative rounded-md shadow-sm">
                                        <div
                                                class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none"
                                        >
                                            <span class="text-gray-500 sm:text-sm">LKR</span>
                                        </div>
                                        <input
                                                class="focus:ring-primary-color focus:border-primary-color block w-full pl-10 pr-12 sm:text-sm border-gray-300 rounded-md bg-gray-100 cursor-not-allowed"
                                                disabled=""
                                                id="bid-amount"
                                                min="0"
                                                name="bid-amount"
                                                placeholder="0"
                                                step="100"
                                                type="number"
                                        />
                                    </div>
                                </div>
                                <button
                                        class="flex w-full items-center justify-center rounded-md border border-transparent bg-gray-300 px-6 py-3 text-base font-medium text-gray-500 cursor-not-allowed"
                                        disabled=""
                                        id="bid-place-button"
                                        onclick="placeBid()"
                                >
                                    Place Bid
                                </button>
                            </div>
                            <div class="mt-4 grid grid-cols-3 gap-2">
                                <button
                                        class="w-full rounded-md border border-gray-300 bg-gray-100 px-4 py-2 text-sm font-medium text-gray-400 cursor-not-allowed"
                                        disabled=""
                                        type="button"
                                        id="quick-bid-1"
                                >
                                    Quick Bid: LKR 0
                                </button>
                                <button
                                        class="w-full rounded-md border border-gray-300 bg-gray-100 px-4 py-2 text-sm font-medium text-gray-400 cursor-not-allowed"
                                        disabled=""
                                        type="button"
                                        id="quick-bid-2"
                                >
                                    Quick Bid: LKR 0
                                </button>
                                <button
                                        class="w-full rounded-md border border-gray-300 bg-gray-100 px-4 py-2 text-sm font-medium text-gray-400 cursor-not-allowed"
                                        disabled=""
                                        type="button"
                                        id="quick-bid-3"
                                >
                                    Quick Bid: LKR 0
                                </button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <%--            bidding history--%>
            <div class="mt-12 bg-white shadow-lg rounded-lg p-6" id="bid-history-wrapper">
                <h2 class="text-2xl font-bold text-gray-900 mb-6">
                    Bidding History
                </h2>
                <div id="bid-table-container" class="max-h-80 overflow-y-auto custom-scrollbar space-y-4 pr-2">
                    <template id="bid-row-template">
                        <div class="flex items-center justify-between border-b border-gray-200 pb-4 last:border-b-0 last:pb-0">
                            <div class="flex items-center">
                                <img
                                        alt="Bidder Avatar"
                                        class="h-10 w-10 rounded-full mr-4"
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuBmkIgPNfYZdvPOCiFDvhzUzGJaAOWUuN0EzuEDUFLdp9HuZKeNeAnyEieXtMW7eBP3QYHw0A-soyB7FWokkaSU10Y-oK5MXiTrlmZc3y8_fOFgctVjWrk5XjA6wxiS-3KCQDEInzDZgHPNLRKu-bCZtbDJakEmN0h6iToY6-DoFHNVBpJxwwhHfNbylNNKDBkfy3gZSUzPULrf7InuY6E5_F89E5GvyUW6EHTN96LqJZEUKPFemvMQA2zcKtCC8fUNAKm9VkdtkXI"
                                />
                                <div>
                                    <p class="text-sm font-semibold text-gray-800">John D.</p>
                                    <p class="text-xs text-gray-500">2 hours ago</p>
                                </div>
                            </div>
                            <p class="text-lg font-bold text-primary-color">LKR 450</p>
                        </div>
                    </template>

<%--                    <div--%>
<%--                            class="flex items-center justify-between border-b border-gray-200 pb-4 last:border-b-0 last:pb-0"--%>
<%--                    >--%>
<%--                        <div class="flex items-center">--%>
<%--                            <img--%>
<%--                                    alt="Bidder Avatar"--%>
<%--                                    class="h-10 w-10 rounded-full mr-4"--%>
<%--                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuD0aQ7ywJwNOwimvhqnmOEKZEZ9TXH2GHdZh0FmkP70H2wkqODEIy3oOhqrGvupNuQJeBxicnu6LZXf2l0xDQYLplQMvP3hNlcPC1JDA8lSI1rla3WIosh9Q7QQC1iiSiSzA7Gom06uSoz9ZknoFV8GARPFB6FvlmHVM3fR5IVLjVMnOyCP3c-a4xootETXqwjoPJ71roYkWGuut6OD_jJk2gGeDRHXBmd7IcZQXxFhF-ZBwtbprmZy9VESaq2CGqN6NWQlbaiFQVw"--%>
<%--                            />--%>
<%--                            <div>--%>
<%--                                <p class="text-sm font-semibold text-gray-800">--%>
<%--                                    Jane S. (You)--%>
<%--                                </p>--%>
<%--                                <p class="text-xs text-gray-500">5 hours ago</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <p class="text-lg font-semibold text-green-600">$420</p>--%>
<%--                    </div>--%>
<%--                    <div--%>
<%--                            class="flex items-center justify-between border-b border-gray-200 pb-4 last:border-b-0 last:pb-0"--%>
<%--                    >--%>
<%--                        <div class="flex items-center">--%>
<%--                            <img--%>
<%--                                    alt="Bidder Avatar"--%>
<%--                                    class="h-10 w-10 rounded-full mr-4"--%>
<%--                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAe1eK4zNa6MpJdOSj_zQCGUDn1A0S9QFWVXSstwZ90JuyXKBT1wsYM_hJrXmmodGlJtPFL6zpPMQTlcRE1xdzA8o22eC3O6wphcLY5VphAsBO7YrGvOhQTscLkQWXY011ofW5OtbY_m1jh5FaFrHwZ2QipwLr6_P3MuCK9xSG_l-aHZctPpkBb0qdYB8ot8ZG_NdXDNaollUvrZC1x9eSeBfNqtZz40aboirvz3qMfel4v3khQ0BlGkq2YahdebL8zFuxnyVsIxY8"--%>
<%--                            />--%>
<%--                            <div>--%>
<%--                                <p class="text-sm font-semibold text-gray-800">Mike B.</p>--%>
<%--                                <p class="text-xs text-gray-500">1 day ago</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <p class="text-lg font-semibold text-gray-700">$400</p>--%>
<%--                    </div>--%>
<%--                    <div--%>
<%--                            class="flex items-center justify-between border-b border-gray-200 pb-4 last:border-b-0 last:pb-0"--%>
<%--                    >--%>
<%--                        <div class="flex items-center">--%>
<%--                            <img--%>
<%--                                    alt="Bidder Avatar"--%>
<%--                                    class="h-10 w-10 rounded-full mr-4"--%>
<%--                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAe1eK4zNa6MpJdOSj_zQCGUDn1A0S9QFWVXSstwZ90JuyXKBT1wsYM_hJrXmmodGlJtPFL6zpPMQTlcRE1xdzA8o22eC3O6wphcLY5VphAsBO7YrGvOhQTscLkQWXY011ofW5OtbY_m1jh5FaFrHwZ2QipwLr6_P3MuCK9xSG_l-aHZctPpkBb0qdYB8ot8ZG_NdXDNaollUvrZC1x9eSeBfNqtZz40aboirvz3qMfel4v3khQ0BlGkq2YahdebL8zFuxnyVsIxY8"--%>
<%--                            />--%>
<%--                            <div>--%>
<%--                                <p class="text-sm font-semibold text-gray-800">Mike B.</p>--%>
<%--                                <p class="text-xs text-gray-500">1 day ago</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <p class="text-lg font-semibold text-gray-700">$400</p>--%>
<%--                    </div>--%>
<%--                    <div--%>
<%--                            class="flex items-center justify-between border-b border-gray-200 pb-4 last:border-b-0 last:pb-0"--%>
<%--                    >--%>
<%--                        <div class="flex items-center">--%>
<%--                            <img--%>
<%--                                    alt="Bidder Avatar"--%>
<%--                                    class="h-10 w-10 rounded-full mr-4"--%>
<%--                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAe1eK4zNa6MpJdOSj_zQCGUDn1A0S9QFWVXSstwZ90JuyXKBT1wsYM_hJrXmmodGlJtPFL6zpPMQTlcRE1xdzA8o22eC3O6wphcLY5VphAsBO7YrGvOhQTscLkQWXY011ofW5OtbY_m1jh5FaFrHwZ2QipwLr6_P3MuCK9xSG_l-aHZctPpkBb0qdYB8ot8ZG_NdXDNaollUvrZC1x9eSeBfNqtZz40aboirvz3qMfel4v3khQ0BlGkq2YahdebL8zFuxnyVsIxY8"--%>
<%--                            />--%>
<%--                            <div>--%>
<%--                                <p class="text-sm font-semibold text-gray-800">Mike B.</p>--%>
<%--                                <p class="text-xs text-gray-500">1 day ago</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <p class="text-lg font-semibold text-gray-700">$400</p>--%>
<%--                    </div>--%>
<%--                    <div--%>
<%--                            class="flex items-center justify-between border-b border-gray-200 pb-4 last:border-b-0 last:pb-0"--%>
<%--                    >--%>
<%--                        <div class="flex items-center">--%>
<%--                            <img--%>
<%--                                    alt="Bidder Avatar"--%>
<%--                                    class="h-10 w-10 rounded-full mr-4"--%>
<%--                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAe1eK4zNa6MpJdOSj_zQCGUDn1A0S9QFWVXSstwZ90JuyXKBT1wsYM_hJrXmmodGlJtPFL6zpPMQTlcRE1xdzA8o22eC3O6wphcLY5VphAsBO7YrGvOhQTscLkQWXY011ofW5OtbY_m1jh5FaFrHwZ2QipwLr6_P3MuCK9xSG_l-aHZctPpkBb0qdYB8ot8ZG_NdXDNaollUvrZC1x9eSeBfNqtZz40aboirvz3qMfel4v3khQ0BlGkq2YahdebL8zFuxnyVsIxY8"--%>
<%--                            />--%>
<%--                            <div>--%>
<%--                                <p class="text-sm font-semibold text-gray-800">Mike B.</p>--%>
<%--                                <p class="text-xs text-gray-500">1 day ago</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <p class="text-lg font-semibold text-gray-700">$400</p>--%>
<%--                    </div>--%>
<%--                    <div--%>
<%--                            class="flex items-center justify-between border-b border-gray-200 pb-4 last:border-b-0 last:pb-0"--%>
<%--                    >--%>
<%--                        <div class="flex items-center">--%>
<%--                            <img--%>
<%--                                    alt="Bidder Avatar"--%>
<%--                                    class="h-10 w-10 rounded-full mr-4"--%>
<%--                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAe1eK4zNa6MpJdOSj_zQCGUDn1A0S9QFWVXSstwZ90JuyXKBT1wsYM_hJrXmmodGlJtPFL6zpPMQTlcRE1xdzA8o22eC3O6wphcLY5VphAsBO7YrGvOhQTscLkQWXY011ofW5OtbY_m1jh5FaFrHwZ2QipwLr6_P3MuCK9xSG_l-aHZctPpkBb0qdYB8ot8ZG_NdXDNaollUvrZC1x9eSeBfNqtZz40aboirvz3qMfel4v3khQ0BlGkq2YahdebL8zFuxnyVsIxY8"--%>
<%--                            />--%>
<%--                            <div>--%>
<%--                                <p class="text-sm font-semibold text-gray-800">Mike B.</p>--%>
<%--                                <p class="text-xs text-gray-500">1 day ago</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <p class="text-lg font-semibold text-gray-700">$400</p>--%>
<%--                    </div>--%>
<%--                    <div--%>
<%--                            class="flex items-center justify-between border-b border-gray-200 pb-4 last:border-b-0 last:pb-0"--%>
<%--                    >--%>
<%--                        <div class="flex items-center">--%>
<%--                            <img--%>
<%--                                    alt="Bidder Avatar"--%>
<%--                                    class="h-10 w-10 rounded-full mr-4"--%>
<%--                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAe1eK4zNa6MpJdOSj_zQCGUDn1A0S9QFWVXSstwZ90JuyXKBT1wsYM_hJrXmmodGlJtPFL6zpPMQTlcRE1xdzA8o22eC3O6wphcLY5VphAsBO7YrGvOhQTscLkQWXY011ofW5OtbY_m1jh5FaFrHwZ2QipwLr6_P3MuCK9xSG_l-aHZctPpkBb0qdYB8ot8ZG_NdXDNaollUvrZC1x9eSeBfNqtZz40aboirvz3qMfel4v3khQ0BlGkq2YahdebL8zFuxnyVsIxY8"--%>
<%--                            />--%>
<%--                            <div>--%>
<%--                                <p class="text-sm font-semibold text-gray-800">Mike B.</p>--%>
<%--                                <p class="text-xs text-gray-500">1 day ago</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <p class="text-lg font-semibold text-gray-700">$400</p>--%>
<%--                    </div>--%>
<%--                    <div--%>
<%--                            class="flex items-center justify-between pb-4 last:border-b-0 last:pb-0"--%>
<%--                    >--%>
<%--                        <div class="flex items-center">--%>
<%--                            <img--%>
<%--                                    alt="Bidder Avatar"--%>
<%--                                    class="h-10 w-10 rounded-full mr-4"--%>
<%--                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuA0W5BQJxnyBXrb3aLLXx4W7Qm0PXnoB3RiuyeISHMVVi_187sE3IpE0IiJg4Pvq6Pt4XUbqjhTWgynt5WgNltCqLWP8gbqRX6m1Hxp_jKVzpqFawEyS_zHGkUngf-JtCDL01VV3Fw-L5mjdsofQYXHH5CTFne6bgfVBY18IZDsC2M3ipWJqSFYyIFVqud9O1L6Nk3r3kliCGz63FXnoMRxyYIOLnJ3YhwVkiUSWAUPvSRuUT-VXrtBU9oARNBGgcgXTvPlhuRfsqY"--%>
<%--                            />--%>
<%--                            <div>--%>
<%--                                <p class="text-sm font-semibold text-gray-800">Sarah L.</p>--%>
<%--                                <p class="text-xs text-gray-500">2 days ago</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <p class="text-lg font-semibold text-gray-700">$380</p>--%>
<%--                    </div>--%>

                </div>
            </div>

        </div>
    </main>

    <footer class="bg-gray-100 border-t border-gray-200">
        <div
                class="container mx-auto px-4 sm:px-6 lg:px-8 py-8 text-center text-sm text-gray-500"
        >
            <p>© 2025 Auction. All rights reserved.</p>
        </div>
    </footer>
</div>
<script src="assets/scripts/bidPlace.js"></script>
<script src="assets/scripts/singleAuction.js"></script>
<script src="assets/scripts/auctionWebSocket.js"></script>
<script src="assets/scripts/session.js"></script>
</body>
</html>
