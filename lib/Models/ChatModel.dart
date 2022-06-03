import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? isFrom;
  String? isTo;
  String? time;
  var content;
  String? type;

  ChatModel(
      {
      //   this.peerid,
      // this.currentUid,
      this.type,
      this.content,
      this.time,
      this.isTo,
      this.isFrom});
  Map<String, dynamic> toJson() {
    return {
      "isFrom": isFrom,
      "isTo": isTo,
      "time": time,
      "content": content,
      "type": type,
      // "currentUid": currentUid,
      // "peerid": peerid,
      // "id": id
    };
  }

  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    String isFrom = doc.get("isFrom");
    String isTo = doc.get("isTo");
    String time = doc.get("time");
    String content = doc.get("content");
    int type = doc.get("type");
    return ChatModel(
        isFrom: isFrom,
        isTo: isTo,
        time: time,
        content: content,
        type: "source");
  }

  // static ChatModel fromJson(Map<String, dynamic> json) => ChatModel(
  //     isFrom: json['isFrom'],
  //     isTo: json['isTo'],
  //     time: json['time'],
  //     content: json['content'],
  //     type: json['type']);
}
