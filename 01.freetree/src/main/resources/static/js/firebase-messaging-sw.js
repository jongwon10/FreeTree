importScripts('https://www.gstatic.com/firebasejs/4.8.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/4.8.1/firebase-messaging.js');

// Initialize Firebase
var config = {
    apiKey: "xxxxxx",
    authDomain: "xxxxxx",
    projectId: "xxxxxx",
    storageBucket: "xxxxxx",
    messagingSenderId: "xxxxxx",
};
firebase.initializeApp(config);

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {

    const title = "Hello World";
    const options = {
        body: payload.data.status
    };

    return self.registration.showNotification(title, options);
});