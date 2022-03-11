import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyDummy extends StatefulWidget {
  const MyDummy({Key? key}) : super(key: key);

  @override
  _MyDummyState createState() => _MyDummyState();
}

class _MyDummyState extends State<MyDummy> {
  @override
  void initState() {
    generateMsgToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Hey there!"),
      ),
    );
  }
  generateMsgToken()async{
    print("Hey yalagala Plaese wait function is under process");
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    print("Messaging intialized successfully");
    await firebaseMessaging.requestPermission().then((value) => print(value));
    await firebaseMessaging.getToken().then((value) => print(value));
    print("success");
  }
}
