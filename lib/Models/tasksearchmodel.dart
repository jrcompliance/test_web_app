import 'package:cloud_firestore/cloud_firestore.dart';

class TaskSearchModel {
  String? id;
  String taskname;
  int CxID;
  Timestamp startDate;
  String endDate;
  String priority;
  Timestamp lastseen;
  String cat;
  String message;
  String newsta;
  String prosta;
  String insta;
  String wonsta;
  String clsta;
  List assign;
  bool val;
  String logo;

  TaskSearchModel({
    this.id,
    required this.taskname,
    required this.CxID,
    required this.startDate,
    required this.endDate,
    required this.priority,
    required this.lastseen,
    required this.cat,
    required this.message,
    required this.newsta,
    required this.prosta,
    required this.insta,
    required this.wonsta,
    required this.clsta,
    required this.assign,
    required this.val,
    required this.logo,
  });
}
