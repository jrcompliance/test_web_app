import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Models/ChatModel.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/NewModels/ChattingScreen.dart';
import 'package:test_web_app/NewModels/RoomModel.dart';

class GetMessagesListProvider extends ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  var roomiDS;

  String createRoomId(EmployeesModel toChatUserModel) {
    // SmallId_LargeId
    String roomID = "";

    print(
        "createRoomId ${user!.uid.hashCode} >> ${toChatUserModel.uid.hashCode} ");
    print("createRoomId ${user!.uid} >> ${toChatUserModel.uid} ");
    if (user!.uid.hashCode > toChatUserModel.uid.hashCode) {
      roomID = toChatUserModel.uid! + "_" + user!.uid;
    } else if (user!.uid.hashCode < toChatUserModel.uid.hashCode) {
      roomID = user!.uid + "_" + toChatUserModel.uid.toString();
    } else {
      roomID = user!.uid + "_" + toChatUserModel.uid.toString();
    }

    print("createRoomId @$roomID");

    return roomID;
  }
}
