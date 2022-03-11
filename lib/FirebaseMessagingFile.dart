import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



import 'Config/Config.dart';

class PushNotificationApp extends StatefulWidget {
 // static const routeName = "/firebase-push";

  @override
  _PushNotificationAppState createState() => _PushNotificationAppState();
}

class _PushNotificationAppState extends State<PushNotificationApp> {
  final configurations = Configurations();
  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    getPermission();
    generateMsgToken();
    messageListener(context);
    super.initState();
  }
  generateMsgToken()async{
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    var token = await firebaseMessaging.getToken();
    print(token);
  }

  Future<void> init() async {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: configurations.apiKey,
            appId: configurations.appId,
            messagingSenderId: configurations.messagingSenderId,
            projectId: configurations.projectId));
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: init(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('android firebase initiated');
          return NotificationPage();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> getPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void messageListener(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification?.body}');
        showDialog(
            context: context,
            builder: ((BuildContext context) {
              return DynamicDialog(
                  title: message.notification?.title,
                  body: message.notification?.body);
            }));
      }
    });
  }
}

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<NotificationPage> {
   String? _token;
   Stream<String>? _tokenStream;
  int notificationCount = 0;


  void setToken(String? token) async{
    FirebaseMessaging _messaging = FirebaseMessaging.instance;
    token = await _messaging.getToken(
      vapidKey: "BAltpAl1albpauOu3AypLQLD09dZDbLMl35IJyFB-RKVLR-UnS07FD5fKrSxG3LF57fP0FXBKHdxSbrInhWVdgU");

    print('FCM Token: $token');

      setState(() {

        print('789456');
        _token = token.toString();
        print('aaaa'+_token.toString());
      });





  }

  @override
  void initState() {

    super.initState();
    FirebaseMessaging _messaging = FirebaseMessaging.instance;

    //get token
    _messaging.getToken().then(setToken);
    _tokenStream = _messaging.onTokenRefresh;
    _tokenStream!.listen(setToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase push notification'),
        ),
        body: Container(
          child: Center(
            child: Card(
              margin: EdgeInsets.all(10),
              elevation: 10,
              child: ListTile(
                title: Center(
                  child: OutlinedButton.icon(
                    label: Text('Push Notification',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    onPressed: () {
                      sendPushMessageToWeb();
                    }, icon: Icon(Icons.notifications),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  //send notification
  sendPushMessageToWeb() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return _token;
    }
    try {
      await http
          .post(
        Uri.parse('https://console.firebase.google.com/u/0/project/jrcrm-4f580/notification'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'AAAAcGYfxNM:APA91bF05cRER6uD0IKxfN1SUeNdP1f0Itc97FVsZ5I9tfDInhy7TAPkTujy_1VONbPD9P_Dstju5lxfocCW64gyr2whu79EsTMfuMwT3Gb6QSLi1bpQxefErXdkEDp7AIZ3u2uwFgXt',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
        body: json.encode({
          'to': _token,
          'message': {
            'token': _token,
          },
          "notification": {
            "title": "Push Notification",
            "body": "Firebase  push notification"
          }
        }),
      )
          .then((value) => print(value.body));
      print('FCM request for web sent!');
    } catch (e) {
      print(e);
    }
  }
  generateMsgToken()async{
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    var token = await firebaseMessaging.getToken();
    print(token);
  }
}

//push notification dialog for foreground
class DynamicDialog extends StatefulWidget {
  final title;
  final body;
  DynamicDialog({this.title, this.body});
  @override
  _DynamicDialogState createState() => _DynamicDialogState();
}

class _DynamicDialogState extends State<DynamicDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      actions: <Widget>[
        OutlinedButton.icon(
            label: Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close))
      ],
      content: Text(widget.body),
    );
  }
}



