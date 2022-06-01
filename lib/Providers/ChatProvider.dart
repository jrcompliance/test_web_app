import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Models/ChatModel.dart';
import 'package:test_web_app/Widgets/Utils.dart';

class ChatProvider extends ChangeNotifier {
  var userid;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UploadTask uploadImageFile(File image, String filename) {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future isCurrentUser(bool isCurrentUser) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userUid = pref.getString("uid");
    firestore.collection("Chats").where("isTo", isNotEqualTo: userUid).get();
  }

  // Future<void> updateFirestoreData(
  //     String chat, String docPath, Map<String, dynamic> dataUpdate) {
  //   return firestore.collection("Chats").doc(docPath).update(dataUpdate);
  // }

  Future<void> saveChatMessage(String content, String isFrom, String isTo,
      String time, String type) async {
    var refMessages = FirebaseFirestore.instance
        .collection("Chats")
        .doc(isFrom)
        .collection("messages");
    var newMessage = ChatModel(
        time: time, isFrom: isFrom, isTo: isTo, content: content, type: type);

    refMessages.add(newMessage.toJson());
    //     .doc()
    //     .set({
    //   "time": time,
    //   "isFrom": isFrom,
    //   "isTo": isTo,
    //   "content": content,
    //   "type": type
    // });
  }

  // static Stream<QuerySnapshot> getChatMessage(String peerid) {
  //   return FirebaseFirestore.instance
  //       .collection("Chats")
  //       .doc()
  //       .collection("messages")
  //       .where("isTo", isEqualTo: peerid)
  //       .orderBy("time", descending: false)
  //       .snapshots()
  //       .transform(Utils.transformer((ChatModel.fromJson)));
  // }

  Future getuserid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return userid = pref.getString("uid");
  }
}
