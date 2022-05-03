'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "80b8084792063c2ae8c4220a3dd782dc",
"favicon.ico": "9097e320eeb2bfc18ab119e08d4fa4bc",
"index.html": "ff7eac04d33aefda3249dfb98f47ffa9",
"/": "ff7eac04d33aefda3249dfb98f47ffa9",
"firebase-messaging-sw.js": "10e0203d087fb9b2c5c6c4cf8eb0300f",
"main.dart.js": "6b6abe06b1ffef6955e9dc8fea3ebcfb",
"icons/Icon-192.png": "64eabfc5de64da9c46c29935932142a6",
"icons/Icon-maskable-192.png": "59cfa769ac45b55ac27212afc44f3879",
"icons/Icon-maskable-512.png": "4c15436634779af5b3efadf52a4c69a5",
"icons/Icon-512.png": "f3dccb794b645942535b733039a9dfa8",
"manifest.json": "9ff5af7aeb30da31f06fd643ca324344",
".git/config": "38881ccff4dc4e249623736f3cd97a15",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
"assets/AssetManifest.json": "daab87d045d66818e47e3056870b1a42",
"assets/NOTICES": "dd2ae4645578e9b49523d8657f11d042",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/sign_button/images/mail.png": "c9172bdda51109489593c86da58f10e8",
"assets/packages/sign_button/images/instagram.png": "6c356b0bd4b0f7f80046fc2557e85757",
"assets/packages/sign_button/images/github.png": "c67686f615f334806a07d41d594c34c1",
"assets/packages/sign_button/images/microsoft.png": "dfb60902957a3204c63d4d3de2ae76ff",
"assets/packages/sign_button/images/tumblr.png": "695506da08f97651af960af9f268dcc4",
"assets/packages/sign_button/images/apple.png": "c82fbe8cbcecaa462da7bd30015b3565",
"assets/packages/sign_button/images/twitter.png": "08ed456da7c064a42ed528098c78dfc0",
"assets/packages/sign_button/images/facebookDark.png": "deface349f4fd6bece4039901e8c6c44",
"assets/packages/sign_button/images/linkedin.png": "e4ae6d8c444c75a24d02cd9995072297",
"assets/packages/sign_button/images/reddit.png": "1b200a970d87b9ab578ac556b24cf16b",
"assets/packages/sign_button/images/yahoo.png": "8d028327c009ae90e08ebfd965176f8b",
"assets/packages/sign_button/images/googleDark.png": "3a7df7781108618c2b3d05a5121abdfc",
"assets/packages/sign_button/images/youtube.png": "615f39ecf21272fec7eceb7984ed8959",
"assets/packages/sign_button/images/appleDark.png": "11238aa9e757b14b5e3460b467e6a2b4",
"assets/packages/sign_button/images/pinterest.png": "4e9b78531f5968aad62a1ec26eb75b18",
"assets/packages/sign_button/images/google.png": "46039fa62c3167028c4fdb86816c3363",
"assets/packages/sign_button/images/facebook.png": "f4dfe9871ac8cce8278c2aba8c897e1d",
"assets/packages/sign_button/images/amazon.png": "af00fbd77763d45afd0131b85e5f78a5",
"assets/packages/sign_button/images/githubDark.png": "561b115749533c422a8c02e4843c73d2",
"assets/packages/sign_button/images/quora.png": "b10aaad4707aad91cbab341ef33ea56c",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/assets/Notations/Document.png": "3167cbfc83e647308f3ca85e9eed8c24",
"assets/assets/Notations/Category.png": "25d2eb0ec2b13d62d36fa0e0ca05b5d0",
"assets/assets/Notations/Ticket.png": "acc5b6ba4b06caeedd718b845e76db60",
"assets/assets/Notations/Chart.png": "26508383a846204d5f5e601fa5819bac",
"assets/assets/Notations/Activity.png": "fc51ef4ea1184791132cd312450c9b21",
"assets/assets/Notations/Calendar.png": "ea8ea0450e7c3a351930f2aa951292f7",
"assets/assets/Notations/Notification.png": "cfea2326924087305177fc1884345515",
"assets/assets/Notations/Setting.png": "108284f62135b397b2abc50fb3e0c539",
"assets/assets/Images/Authorized_Sign.png": "0f3859fae74b9102f403507fde16ada5",
"assets/assets/Images/cancelled.png": "f1e4dee5e4c2e73c8ad6ec616682bbc8",
"assets/assets/Images/received.png": "e6fd7db8044105e6add12ec1a3433950",
"assets/assets/Images/invoicebg.jpeg": "5405b50b3bcd8202c10c15570c7185e1",
"assets/assets/Images/disputed.png": "10a85406d7ab17c0b3e3a7a2741c9cc0",
"assets/assets/Images/invoicebg.png": "e53675b3730fc196b94bbfea1d044535",
"assets/assets/Images/success.png": "48302fb10bcad74a4dfc5d012ba44152",
"assets/assets/Images/pdf.png": "ebad6904fef15229e1face471e77092c",
"assets/assets/Images/fail.png": "c8b2502ea2cf57cc00a8869f29122167",
"assets/assets/Images/pending.png": "b3918d86c8e6ea9d455bf7fc65628a4b",
"assets/assets/Images/live.png": "b191046cd0226a447d91bdb49de2c25f",
"assets/assets/Lotties/filter.json": "6bf7c74f00652e3a1751a1134dd5a06f",
"assets/assets/Lotties/empty.json": "7f1578e46268212b12f1d29b95c97055",
"assets/assets/Lotties/createdate.json": "c8aa7a6b87587b8d0b6149bbf6e80d3c",
"assets/assets/Lotties/attachments.json": "dfb9683e4f35fa0e310606483a67a999",
"assets/assets/Lotties/success.json": "4150df280f6e91fcacd96562e0d2f313",
"assets/assets/Lotties/lastseen.json": "74e0248dae2a7b002e57757c6868b87e",
"assets/assets/Lotties/live.json": "38bcfb95a4b26baff028cb562334b687",
"assets/assets/Lotties/userdata.json": "eee337c9b62b5d85e73cdd0a41749474",
"assets/assets/Lotties/agent.json": "656f68511b3f67d6148b68c9e459cb99",
"assets/assets/Lotties/chillwork.json": "065607d527d217f12b4e798d71891b2a",
"assets/assets/Lotties/normalwork.json": "6e45990cf9a616a7a79541fb7eef7050",
"assets/assets/Lotties/check.json": "97525e4243dd22d98b8823ee64aa1511",
"assets/assets/Lotties/lastdate.json": "eaccd4488b86ec61362debedc2b31a08",
"assets/assets/Lotties/stats.json": "84a2e9afedbce6545158d8dedbcac1a6",
"assets/assets/Lotties/fail.json": "e7c2304ee24bd84ef9ebfa6a91e03f9e",
"assets/assets/Lotties/registeredsucees.json": "933029e3cbc48f4b08a03b219ce51bb5",
"assets/assets/Logos/login.png": "6d50100773ac154dc323c39282bb7e08",
"assets/assets/Logos/jrlogo.png": "a1da0238793a5c3dfd35b8d86af745af",
"assets/assets/Logos/Controlifylogo.png": "cadb6682c60e0a4bfb7063fb5d115752",
"assets/assets/Logos/upload.png": "ed577da85ccbeeb971e1f7a69d253958",
"assets/assets/Logos/SignUp.png": "af5537980f0f099937095fa8e0b34140",
"assets/assets/Logos/4.png": "98c0ddebccfe86b2d76e4e2742e503d2",
"assets/assets/Logos/2.png": "43b22e48ebb256e81651e9fabed2db78",
"assets/assets/Logos/3.png": "b3410d268d763badb52fdf6bf4a68a12",
"assets/assets/Logos/lamp.png": "8e58d732f862ace4efe080c2de00f84a",
"assets/assets/Logos/1.png": "cc33857c71033fc6bbb5c7d49a1b4f2e",
"assets/assets/Logos/Ologo.png": "53b77fce86716866757bad36e504d61d"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
