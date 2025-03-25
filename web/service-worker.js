// BitNet optimized service worker
const CACHE_NAME = 'bitnet-static-cache-v1';
const DYNAMIC_CACHE = 'bitnet-dynamic-cache-v1';

// Assets to cache immediately
const STATIC_ASSETS = [
  './',
  './index.html',
  './styles.css',
  './flutter_bootstrap.js',
  './flutter.js',
  './manifest.json',
  './favicon.png',
  './icons/favicon-16x16.png',
  './icons/favicon-32x32.png',
  './icons/apple-touch-icon.png',
  './icons/android-chrome-192x192.png',
  './icons/android-chrome-512x512.png',
];

// Install event - cache essential static assets
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      console.log('Caching static assets');
      return cache.addAll(STATIC_ASSETS);
    })
  );
  // Activate immediately without waiting for tabs to close
  self.skipWaiting();
});

// Activate event - clean up old caches
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.filter(name => {
          return name !== CACHE_NAME && name !== DYNAMIC_CACHE;
        }).map(name => {
          console.log('Deleting old cache:', name);
          return caches.delete(name);
        })
      );
    })
  );
  // Take control of all clients
  self.clients.claim();
});

// Fetch event - handle requests with cache-first strategy
self.addEventListener('fetch', event => {
  // Only cache GET requests
  if (event.request.method !== 'GET') return;
  
  // Skip caching for API and firebase requests
  const url = new URL(event.request.url);
  if (url.pathname.includes('/api/') || 
      url.hostname.includes('firebaseapp') ||
      url.hostname.includes('googleapis')) {
    return;
  }

  event.respondWith(
    // Try cache first
    caches.match(event.request).then(cachedResponse => {
      // Return cached response if found
      if (cachedResponse) {
        return cachedResponse;
      }
      
      // Otherwise fetch from network
      return fetch(event.request)
        .then(response => {
          // Don't cache responses that aren't successful
          if (!response || response.status !== 200 || response.type !== 'basic') {
            return response;
          }
          
          // Clone the response as it's a stream that can only be consumed once
          const responseToCache = response.clone();
          
          // Add the network response to the cache for future visits
          caches.open(DYNAMIC_CACHE).then(cache => {
            cache.put(event.request, responseToCache);
          });
          
          return response;
        })
        .catch(err => {
          // Return a fallback response for image requests when offline
          if (event.request.url.match(/\.(jpg|jpeg|png|gif|svg|webp)$/)) {
            return caches.match('./icons/favicon-32x32.png');
          }
          return new Response('Network error happened', {
            status: 408,
            headers: { 'Content-Type': 'text/plain' }
          });
        });
    })
  );
});

// Handle pushes for notifications
self.addEventListener('push', event => {
  if (!event.data) return;
  
  const pushData = event.data.json();
  const options = {
    body: pushData.body,
    icon: './icons/android-chrome-192x192.png',
    vibrate: [100, 50, 100],
    data: {
      dateOfArrival: Date.now(),
      url: pushData.url || '/'
    }
  };
  
  event.waitUntil(
    self.registration.showNotification('BitNet', options)
  );
});

// Handle notification clicks
self.addEventListener('notificationclick', event => {
  event.notification.close();
  
  event.waitUntil(
    clients.matchAll({
      type: 'window'
    }).then(clientList => {
      const url = event.notification.data.url;
      
      // Try to find existing window and focus it
      for (const client of clientList) {
        if (client.url === url && 'focus' in client) {
          return client.focus();
        }
      }
      
      // Otherwise open a new window
      if (clients.openWindow) {
        return clients.openWindow(url);
      }
    })
  );
});