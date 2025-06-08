<%--card active state--%>
<template id="active-card">
    <div class="flex flex-col gap-4" id="active-card">
        <div class="flex items-center justify-between" id="highest-bid-info">
            <div>
                <h2 class="text-sm font-medium text-gray-600">
                    Highest Bid
                </h2>
                <p class="mt-1 text-5xl font-extrabold text-primary-color"
                   id="highest-bid"
                >
                    LKR 0
                </p>
            </div>
            <div class="text-right">
                <h2 class="text-sm font-medium text-gray-600">
                    Highest Bidder
                </h2>
                <div class="flex items-center gap-2 mt-1">
                    <img
                            alt="Bidder Avatar"
                            class="h-10 w-10 rounded-full"
                            id="highest-bidder-avatar"
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuBmkIgPNfYZdvPOCiFDvhzUzGJaAOWUuN0EzuEDUFLdp9HuZKeNeAnyEieXtMW7eBP3QYHw0A-soyB7FWokkaSU10Y-oK5MXiTrlmZc3y8_fOFgctVjWrk5XjA6wxiS-3KCQDEInzDZgHPNLRKu-bCZtbDJakEmN0h6iToY6-DoFHNVBpJxwwhHfNbylNNKDBkfy3gZSUzPULrf7InuY6E5_F89E5GvyUW6EHTN96LqJZEUKPFemvMQA2zcKtCC8fUNAKm9VkdtkXI"
                    />
                    <p class="text-xl font-bold text-gray-800" id="highest-bidder-name">John D.</p>
                </div>
            </div>
        </div>
        <div class="border-t border-gray-200 pt-4">
            <h2 class="text-sm font-medium text-gray-600">
                Your Bid
            </h2>
            <p class="mt-1 text-3xl font-bold text-green-600" id="user-bid">LKR 420</p>
            <p class="mt-1 text-xs text-gray-500" id="user-bidder-status">
                <strong>Status:</strong> You are the highest bidder.
            </p>
        </div>
        <p class="mt-2 text-sm text-gray-500">
            Minimum bid increment: LKR 500
        </p>
    </div>
</template>

<%--card end state--%>
<template id="end-card">
    <div class="flex flex-col gap-4">
        <div>
            <h2 class="text-sm font-medium text-gray-600">
                Winning Bid
            </h2>
            <p class="mt-1 text-5xl font-extrabold text-green-600" id="winning-bid">
                LKR 550
            </p>
        </div>
        <div class="text-sm text-gray-700">
            <p id="winner-info">
                <strong>Winner:</strong> John D. (j***n@example.com)
            </p>
            <p id="auction-end-info">
                <strong>Auction Ended:</strong> July 28, 2024, 10:00 AM
                PST
            </p>
        </div>
    </div>
</template>

<%--card before active state--%>
<template id="upcoming-card">
    <div class="flex flex-col gap-4">
        <div>
            <h2 class="text-sm font-medium text-gray-600">
                Starting Bid
            </h2>
            <p class="mt-1 text-5xl font-extrabold text-primary-color" id="starting-bid"
            >
                LKR 400
            </p>
        </div>
    </div>
</template>
