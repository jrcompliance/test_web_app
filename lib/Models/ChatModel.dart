import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? isFrom;
  String? isTo;
  String? time;
  var content;
  String? type;

  // String? currentUid;
  // String? peerid;

  ChatModel(
      {
      //   this.peerid,
      // this.currentUid,
      this.type,
      this.content,
      this.time,
      this.isTo,
      this.isFrom});

  static ChatModel fromJson(Map<String, dynamic> json) => ChatModel(
      isFrom: json['isFrom'],
      isTo: json['isTo'],
      time: json['time'],
      content: json['content'],
      type: json['type']);

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
}
