import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String isFrom;
  String isTo;
  String timestamp;
  var content;
  String type;
  String currentUid;
  String peerid;

  ChatModel({
    required this.timestamp,
    required this.type,
    required this.content,
    required this.isFrom,
    required this.isTo,
    required this.currentUid,
    required this.peerid,
  });

  Map<String, dynamic> toJson() {
    return {
      "isFrom": isFrom,
      "isTo": isTo,
      "timestamp": timestamp,
      "content": content,
      "type": type,
      "currentUid": currentUid,
      "peerid": peerid,
      // "id": id
    };
  }

  factory ChatModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String isFrom = documentSnapshot.get("isFrom");
    String isTo = documentSnapshot.get("isTo");
    String timestamp = documentSnapshot.get("timestamp");
    var content = documentSnapshot.get("content");
    String type = documentSnapshot.get("type");
    String currentUid = documentSnapshot.get("currentUid");
    String peerid = documentSnapshot.get("peerid");
    // String id = documentSnapshot.get("id");

    return ChatModel(
      isFrom: isFrom,
      isTo: isTo,
      timestamp: timestamp,
      content: content,
      type: type,
      currentUid: currentUid,
      peerid: peerid,
    );
  }
}
