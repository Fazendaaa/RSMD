const websiteVersion="v1";
self.addEventListener('install', installEvent => {
    installEvent.waitUntil(
        caches.open(websiteVersion).then(cache => {
            cache.addAll([ '/*' ]);
        })
    )
})

self.addEventListener('fetch', fetchEvent => {
    fetchEvent.respondWith(
        caches.match(fetchEvent.request).then(res => {
            return res || fetch(fetchEvent.request)
        })
    )
})

