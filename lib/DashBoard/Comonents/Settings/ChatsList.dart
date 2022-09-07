import 'package:flutter/material.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/NewModels/RoomModel.dart';

class ChatsList extends StatefulWidget {
  RoomModel roomModel;
  EmployeesModel employeesModel;
  bool isTapped;
  ChatsList(
      {Key? key,
      required this.isTapped,
      required this.roomModel,
      required this.employeesModel})
      : super(key: key);

  @override
  _ChatsListState createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
