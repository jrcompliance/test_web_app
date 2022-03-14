importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
  const firebaseConfig = {
    apiKey: "AIzaSyBHfeiGb-qLY4CgkKtrGV9plcWcPj2VBQQ",
       authDomain: "jrcrm-4f580.firebaseapp.com",
       databaseURL: "https://jrcrm-4f580-default-rtdb.firebaseio.com",
       projectId: "jrcrm-4f580",
       storageBucket: "jrcrm-4f580.appspot.com",
       messagingSenderId: "482749695187",
       appId: "1:482749695187:web:7a15babbc145e16c36c026",
       measurementId: "G-1DG924Y1CR"
 };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });