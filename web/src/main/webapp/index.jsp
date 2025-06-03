<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="preconnect" href="https://fonts.gstatic.com"/>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;500;700;900&family=Plus+Jakarta+Sans:wght@400;500;700;800&display=swap" rel="stylesheet"/>
    <title>BidWise</title>
    <link rel="icon" type="image/x-icon" href="data:image/x-icon;base64,"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms"></script>
</head>
<body class="bg-white" style='font-family: "Plus Jakarta Sans", "Noto Sans", sans-serif;'>
<div class="min-h-screen flex flex-col">
    <%@ include file="/components/header.jsp" %>
    <main class="px-4 sm:px-6 lg:px-10 flex flex-1 justify-center py-8 bg-gray-50">
        <div class="w-full max-w-6xl">
            <div class="px-4 py-6">
                <label class="flex flex-col min-w-40 h-12 w-full max-w-xl mx-auto relative">
                    <div class="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500">
                        <svg fill="currentColor" height="24" width="24" viewBox="0 0 256 256">
                            <path d="M229.66,218.34l-50.07-50.06a88.11,88.11,0,1,0-11.31,11.31l50.06,50.07a8,8,0,0,0,11.32-11.32ZM40,112a72,72,0,1,1,72,72A72.08,72.08,0,0,1,40,112Z"></path>
                        </svg>
                    </div>
                    <input class="form-input w-full rounded-lg text-gray-900 focus:ring-2 focus:ring-blue-500 border border-gray-300 bg-white h-full placeholder:text-gray-500 pl-12 pr-4 py-3 text-base shadow-sm" placeholder="Search for items..."/>
                </label>
            </div>
            <h2 class="text-gray-900 text-2xl font-bold px-4 pb-4 pt-6">Featured Items</h2>

            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 p-4">
                <div class="flex flex-col gap-3 pb-3 bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-xl transition-shadow">
                    <div class="w-full bg-center bg-no-repeat aspect-[4/3] bg-cover" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDG56bDOL29Azp57JQ4j7CGS8OSDtQW5DR7l7qVvrwP1i0IfSz9J9NPWHsAzagOqmoU2OHym5PmNtxK3gNWFeCs-JB-LE7ecXXhbsuh8JeA3UTHW-yXTz406JfQ70vjHn3vSHgY7jHnNpsbaqRiVo3yI3O3ywhPcxCmVRRbwyySb2GgxJm0Ys2Y-dUpeQCpb-kvGdywRHrKnFbchZa-O8TdIkZ1Y_Wq02v_bwuSQkUEFYiylyEhXnVFfe4MQAGMfRPFxGTWTv5c_mM");'></div>
                    <div class="p-4 flex flex-col flex-grow">
                        <h3 class="text-gray-800 text-lg font-semibold">Vintage Leather Jacket</h3>
                        <p class="text-gray-600 text-sm mt-1 mb-4 flex-grow">Stylish leather jacket, perfect for any occasion.</p>
                        <button class="mt-auto w-full rounded-md h-10 px-4 bg-blue-600 text-white text-sm font-semibold shadow-sm hover:bg-blue-700 focus:ring-2 focus:ring-blue-500 transition-colors">
                            View Details
                        </button>
                    </div>
                </div>
                <div class="flex flex-col gap-3 pb-3 bg-white rounded-lg shadow-lg overflow-hidden transition-shadow hover:shadow-xl">
                    <div class="w-full bg-center bg-no-repeat aspect-[4/3] bg-cover" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuACZ9MuaSJv_ZVg37ba0OT16GJlGUqIqHzfIyaMbODxNiAZuaSixeIBu8I0VtnUz8odLLTPPVeDYA0NtkIsWrQ3S0fVxt9PrrV95wcgYiaNH5JmYIt1An8au5Dk61SjUUprpcuI-fvc8tU2nae1FtH_dN9L7KdIEGU4nhqTOBWK-_gEkNSB5-84OkgXGa6XMeZNH4j0Iex2F9L7AksOZ8mKdYYmLvMtdB7MDH3J3O_jjsB4nr93wZ8PVb70Ub9EOJHZinjyF9_sN3g");'></div>
                    <div class="p-4 flex flex-col flex-grow">
                        <h3 class="text-gray-800 text-lg font-semibold">Antique Pocket Watch</h3>
                        <p class="text-gray-600 text-sm mt-1 mb-4 flex-grow">Elegant pocket watch, a timeless piece.</p>
                        <button class="mt-auto w-full rounded-md h-10 px-4 bg-blue-600 text-white text-sm font-semibold shadow-sm hover:bg-blue-700 focus:ring-2 focus:ring-blue-500 transition-colors">
                            View Details
                        </button>
                    </div>
                </div>
                <div class="flex flex-col gap-3 pb-3 bg-white rounded-lg shadow-lg overflow-hidden transition-shadow hover:shadow-xl">
                    <div class="w-full bg-center bg-no-repeat aspect-[4/3] bg-cover" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuAWrFtwkIlmaURAiRSbBlLUEZ5JnQ9PLdR1ILYCFwNb8wcZ9jdNryXJGw7V1LyETOBuCrnD_ebAxl34tJHXzHKbvkOwOPRl_CYdIeWmHHOoPjHMZGvrEIbL1aec4Paj_p2w_wKTtX8vFWMhF05TWSCml5zZyzmyXs66QQ7LLr-DrdqbvfewIZ2tBAVAA4pEq4qyHjmXc7eKWHFGkaf2ldm7RiXMpjUWtCqxZ_RPchL8hlwDcltYn8_L_zMnWrWb8u8pcQ9VfX00gmA");'></div>
                    <div class="p-4 flex flex-col flex-grow">
                        <h3 class="text-gray-800 text-lg font-semibold">Limited Edition Sneakers</h3>
                        <p class="text-gray-600 text-sm mt-1 mb-4 flex-grow">Exclusive sneakers, a collector's dream.</p>
                        <button class="mt-auto w-full rounded-md h-10 px-4 bg-blue-600 text-white text-sm font-semibold shadow-sm hover:bg-blue-700 focus:ring-2 focus:ring-blue-500 transition-colors">
                            View Details
                        </button>
                    </div>
                </div>
                <div class="flex flex-col gap-3 pb-3 bg-white rounded-lg shadow-lg overflow-hidden transition-shadow hover:shadow-xl">
                    <div class="w-full bg-center bg-no-repeat aspect-[4/3] bg-cover" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDmDYJ7LauuAxr2UX6NsibqbJJssK3G0HuKSz5d0QkOvsGNG0-nYEfsgcdIcycbwXXOi_hZ1IUVIoXC5_G-oQQh1EQW6u458bMTv5veoZs4W8YPkXr2pmMlkn3FdzvCOB_MEjfTE_viH9SS221qyeWhG3Tx2ZHf2-F78ogzC8jx5OjQ00HO17u5vuYTY8r_0pOKulaN3ChrRaC3reETojxPCHtx-Y828YrwLHJ5Rc0nyMS779_gYW0tCZdZzvtbRTmXl82LXsRLYt0");'></div>
                    <div class="p-4 flex flex-col flex-grow">
                        <h3 class="text-gray-800 text-lg font-semibold">Designer Handbag</h3>
                        <p class="text-gray-600 text-sm mt-1 mb-4 flex-grow">Chic handbag, a fashion statement.</p>
                        <button class="mt-auto w-full rounded-md h-10 px-4 bg-blue-600 text-white text-sm font-semibold shadow-sm hover:bg-blue-700 focus:ring-2 focus:ring-blue-500 transition-colors">
                            View Details
                        </button>
                    </div>
                </div>
                <div class="flex flex-col gap-3 pb-3 bg-white rounded-lg shadow-lg overflow-hidden transition-shadow hover:shadow-xl">
                    <div class="w-full bg-center bg-no-repeat aspect-[4/3] bg-cover" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuC7WvFvxlhCh2errCD5T8oZ-bivNiwEM8ByyH5ThIL_cprDDnmoW5B4I2XjoTuv1BK9Fus_dOGdZHRcOJpKK1g-FyXQ9mKahehof-LYJiVBgDjBfDm0AFh4HjPCbJev5DNCSdPaGlJqaNBpa1OMBhxBo8S3V-voUGIAPT_F7Jr2gK93PShmKFRSIXu80hDIaj1cO8oZ5v6qurYNuJCKm4yVirZ6IcH6-ZWHD-zLcu7g2WwRGy92DJgIHlO2lposXHKAS24xO_2e56g");'></div>
                    <div class="p-4 flex flex-col flex-grow">
                        <h3 class="text-gray-800 text-lg font-semibold">Classic Car Model</h3>
                        <p class="text-gray-600 text-sm mt-1 mb-4 flex-grow">Detailed car model, a collector's item.</p>
                        <button class="mt-auto w-full rounded-md h-10 px-4 bg-blue-600 text-white text-sm font-semibold shadow-sm hover:bg-blue-700 focus:ring-2 focus:ring-blue-500 transition-colors">
                            View Details
                        </button>
                    </div>
                </div>
                <div class="flex flex-col gap-3 pb-3 bg-white rounded-lg shadow-lg overflow-hidden transition-shadow hover:shadow-xl">
                    <div class="w-full bg-center bg-no-repeat aspect-[4/3] bg-cover" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuA1l7oUGe28VSX_orR5uF06W9nMsbUtQMD_JtUBgbMHPa8z8UlkXX_yNiU6m-yuEChDA3P8vo2aeBJxrz-Q7PtGF401UmXU0nwZ0UfgoMpHZIxLgb4DK4ibxmxtFe8S61QiDEDUxlipk-xxhn7d2eAMZs52My7gHYAaazfDPOOUXB4Hhs6wXlItWp2_Lap8snMxRJG3_7Ux7z5tAGKnXY21tP-R1Ms6wICd4_DV3rzSTKLoGfEqpeXdlFCeHDtBKT5IsR-R8pE32YU");'></div>
                    <div class="p-4 flex flex-col flex-grow">
                        <h3 class="text-gray-800 text-lg font-semibold">Rare Coin Collection</h3>
                        <p class="text-gray-600 text-sm mt-1 mb-4 flex-grow">Valuable coin collection, a rare find.</p>
                        <button class="mt-auto w-full rounded-md h-10 px-4 bg-blue-600 text-white text-sm font-semibold shadow-sm hover:bg-blue-700 focus:ring-2 focus:ring-blue-500 transition-colors">
                            View Details
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <footer class="py-8 px-10 text-center border-t border-gray-200 bg-white">
        <p class="text-sm text-gray-600">© 2025 Auction. All rights reserved.</p>
    </footer>
</div>
</body>
</html>