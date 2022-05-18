import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Models/ChatModel.dart';

class ChatProvider extends ChangeNotifier {
  var chatDocID;
  var isFrom;
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

  Future<void> updateFirestoreData(
      String chat, String docPath, Map<String, dynamic> dataUpdate) {
    return firestore.collection("Chats").doc(docPath).update(dataUpdate);
  }

  Future<void> saveChatMessage(
      String message, String currentUser, String peerUser) {
    return FirebaseFirestore.instance.collection("Chats").doc().set({
      "message": message,
      "time": DateFormat('kk:mm a').format(DateTime.now()).toString(),
      "isFrom": currentUser,
      "isTo": peerUser,
    });
  }

  // Future<void> SaveChatMessage(
  //   String currentUid,
  //   String peerId,
  //   String message,
  // ) {
  //   var chats = firestore.collection("Chats");
  //   return chats
  //       .where(chatDocID,
  //           isEqualTo: {"currentUid": currentUid, "peerId": peerId})
  //       .limit(1)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //         notifyListeners();
  //         if (querySnapshot.docs.isNotEmpty) {
  //           chatDocID = querySnapshot.docs.single.id;
  //         } else {
  //           chats
  //               .add({
  //                 'users': {
  //                   "currentUid": currentUid,
  //                   "peerId": peerId,
  //                   "message": message,
  //                   // "sendBy":documentid,
  //                   "timestamp": DateTime.now()
  //                 }
  //               })
  //               .then((value) => {chatDocID = value})
  //               .whenComplete(() {
  //                 notifyListeners();
  //                 print("completed");
  //               });
  //         }
  //       })
  //       .catchError((error) {
  //         print(error);
  //       });
  // }

  Stream<QuerySnapshot> getChatMessage(String peerUSer) {
    return FirebaseFirestore.instance
        .collection("Chats")
        .where("isTo", isEqualTo: peerUSer)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  // void saveChatMessage(String isFrom, String isTo, String content, String type,
  //     String time, String currentUser, String peerUser) async {
  //   DocumentReference documentReference = await firestore
  //       .collection("Chats")
  //       .doc(isFrom)
  //       .collection(isTo)
  //       .doc(DateTime.now().toString());
  //   ChatModel chatMessages = ChatModel(
  //     isFrom: isFrom,
  //     isTo: isTo,
  //     timestamp: DateTime.now().toString(),
  //     content: content,
  //     type: type,
  //     currentUid: currentUser,
  //     peerid: peerUser,
  //   );
  //
  //   FirebaseFirestore.instance.runTransaction((transaction) async {
  //     transaction.set(documentReference, chatMessages.toJson());
  //   });
  // }
}
