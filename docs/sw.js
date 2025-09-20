const CACHE_NAME = 'qrpay-v1';
const urlsToCache = [
  '/qrpay/',
  '/qrpay/index.html',
  '/qrpay/main.dart.js',
  '/qrpay/flutter.js',
  '/qrpay/favicon.png',
  '/qrpay/icons/Icon-192.png',
  '/qrpay/icons/Icon-512.png'
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        return cache.addAll(urlsToCache);
      })
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request)
      .then((response) => {
        if (response) {
          return response;
        }
        return fetch(event.request);
      }
    )
  );
});
