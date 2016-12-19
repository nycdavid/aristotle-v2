'use strict';

$(document).ready(function() {
  if ('serviceWorker' in navigator && 'PushManager' in window) {
    navigator.serviceWorker.register('/service_worker.js')
      .then(function(swReg) {
        console.log('Service Worker is registered:', swReg);
        swReg.pushManager.subscribe({
          userVisibleOnly: true,
          applicationServerKey: new Uint8Array([])
        }).then(function(sub) {
          console.log('Subscribed!', sub);
        }, function(err) {
          console.log('ERROR', err);
        });
      })
  }
});
