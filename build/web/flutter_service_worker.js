'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "5647f238abe2adc43ccb25400753e9fa",
"/": "5647f238abe2adc43ccb25400753e9fa",
"main.dart.js": "fda199e0faa35807e32b1cebdb785825",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "b8599f2cbcf212aaa6fd837d0766d328",
"assets/AssetManifest.json": "1450a1751cee0e92bb39291a65fed10b",
"assets/NOTICES": "182915418e8b2bf6b03a39074a764a7d",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/lib/imgs/Salfit.jpg": "7e2c202cb7d6d87db96427facdcb84d8",
"assets/lib/imgs/info.png": "90895a57aeaf4400714998474d9a3df3",
"assets/lib/imgs/avoid_travel.png": "dfaed14f78e281c4836df70cb1bcd521",
"assets/lib/imgs/safe_distance.png": "104853573b0f94b4123a8204529ce807",
"assets/lib/imgs/plus.png": "0669889b9f204ee7624f179fb4b76778",
"assets/lib/imgs/Hebron.jpg": "f5bff7e4a88703f07550fed0b501164c",
"assets/lib/imgs/icon.png": "6958a9d9672b11dc4c0a16fae316c828",
"assets/lib/imgs/fever.png": "6ac65d5227bbbc65e75f566706fee4c5",
"assets/lib/imgs/GazaStrip.jpg": "41e76ddbfe7f39e9d2d6cca41d7a5916",
"assets/lib/imgs/app.png": "0ab9378d64194f5402dc94aebfd19933",
"assets/lib/imgs/details.png": "5c8c6feb33e6546d375a69d0d09ae955",
"assets/lib/imgs/globe.gif": "83f4be21622ce36f8aa5f5d5dcc63155",
"assets/lib/imgs/Qalqilya.jpg": "ff5521f070f01ca80c312c08c5dec15e",
"assets/lib/imgs/Ramallah.jpg": "284372c7f5b14be8d046e3c4d8522de2",
"assets/lib/imgs/male.png": "9c1041e6e98706bb73661a6e62cec001",
"assets/lib/imgs/map.png": "f71d229c2df90f3000b1fb63dca82e82",
"assets/lib/imgs/app_photo.png": "70facc3feaf63d99191058eb425c3e77",
"assets/lib/imgs/github.png": "154f401b1ec86a275185f3c6b8d0aba3",
"assets/lib/imgs/unknown.png": "895b9273f1d67aae680b42438b0a79c6",
"assets/lib/imgs/cities.png": "28879e2fb8fc2b6971c112c8e789c1d9",
"assets/lib/imgs/gmail.png": "923567b6d8dbafe6b1d9acddc713cfb9",
"assets/lib/imgs/shake_hands.png": "280856c1b0b392e495a3a4d8b34dfeff",
"assets/lib/imgs/house.png": "3f502936400a4d3df8cc1d4cbc725ca1",
"assets/lib/imgs/bathroom.png": "8c41ba16cea59126b126c759bb1be844",
"assets/lib/imgs/sneeze.png": "5032f71eee3073071411d167e8503a86",
"assets/lib/imgs/Jenin.jpg": "8b0ef024beff16037686ee752d088c2a",
"assets/lib/imgs/handwash.png": "a0dd32f563a9655002451a8979493444",
"assets/lib/imgs/developer.png": "694cc095b8be5f9eca11c1f36b263330",
"assets/lib/imgs/prevention.png": "b8e10d0f4cc1a1859c2bac0c2dd3697f",
"assets/lib/imgs/breath.png": "36be761652b3d78383d535a717abb610",
"assets/lib/imgs/female.png": "dc302583af606e409afc6d28d98ff8ac",
"assets/lib/imgs/statistics.png": "d17518ccea8ab16d006f0ffba1d0e3e6",
"assets/lib/imgs/cook_home.png": "7c101879ef04fab5831c0a2278dd936f",
"assets/lib/imgs/Jericho.jpg": "a8f606077a68d2852754f8d8e751851f",
"assets/lib/imgs/data.png": "d9a30b61d75fafcb9cac00d630fb71b3",
"assets/lib/imgs/sample.png": "1a0463dab36c5569752bbfcb8c5b7cbc",
"assets/lib/imgs/phone.png": "48eed64e06af423453745f82c109551f",
"assets/lib/imgs/tired.png": "b2d0b7e6461ae9df65014dd81d0eb3ce",
"assets/lib/imgs/Tulkarm.jpg": "783ed46988f0fa0b87eac1808a9f2a1f",
"assets/lib/imgs/cough.png": "3bffc0e54711bd0b59bee23b08d91681",
"assets/lib/imgs/Tubas.jpg": "02f7173051086e89ac692bc3c73e5370",
"assets/lib/imgs/thanks.png": "be1dde69623242ca351a05d458963751",
"assets/lib/imgs/avoid_social.png": "e3f5ea9a537031f402059c76650cbbc3",
"assets/lib/imgs/medical_stuff.png": "3c7dad57e90e8009d931afc8413b153f",
"assets/lib/imgs/home_swipe_up.json": "c3d398ae4e4d0f6c01c97b4b4d3c4721",
"assets/lib/imgs/death.png": "1cdcf14e5df8accd0f619bd81dc77667",
"assets/lib/imgs/facebook.png": "f0e9e8b2677997b419726066e308e358",
"assets/lib/imgs/mask.png": "b321462663405e385f7f0e2d24b3bc8f",
"assets/lib/imgs/symptoms.png": "23bb623ca60487d372a21a30656a5f31",
"assets/lib/imgs/Bethlehem.jpg": "3f5a0e3784d8beb319ce187fbb7370f9",
"assets/lib/imgs/demo.gif": "0b4576b31fb73a75a92ffe2896c7d96e",
"assets/lib/imgs/Nablus.jpg": "c1ba2ee412973f2a3749cd6790e6e447",
"assets/lib/imgs/Jerusalem.jpg": "0372f24ea4cb2decf374dfef485a507a",
"assets/lib/imgs/website_icon.png": "77e9211fff0490b68abf039afb892400",
"assets/lib/imgs/people.png": "dc5126dde01a023434996d61d4d7d873",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16"
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
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
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
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
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
    return self.skipWaiting();
  }

  if (event.message === 'downloadOffline') {
    downloadOffline();
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
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
