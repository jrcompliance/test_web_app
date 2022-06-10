import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_web_app/Models/UserModel2.dart';

class MessageModel {
  String? message;
  Timestamp? timeStamp;
  String? senderId;
  String? peerId;

  MessageModel({this.message, this.timeStamp, this.senderId, this.peerId});

  factory MessageModel.fromMap(Map map) {
    return MessageModel(
        message: map['message'],
        timeStamp: map['timeStamp'],
        senderId: map['senderId'],
        peerId: map['peerId']);
  }
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'timeStamp': FieldValue.serverTimestamp(),
      'senderId': FirebaseAuth.instance.currentUser!.uid,
      'peerId': peerid,
    };
  }
}
