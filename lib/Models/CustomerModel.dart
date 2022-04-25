import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String Customername;
  final String Customeremail;
  final String Customerphone;
  final String? Idocid;
  final int? CxID;
  String taskname;
  Timestamp startDate;
  String endDate;
  String priority;
  Timestamp lastseen;
  String cat;
  String message;
  String status;
  int s;
  int f;
  List assign;
  int leadId;

  CustomerModel(
      {required this.Customername,
      required this.Customeremail,
      required this.Customerphone,
      this.Idocid,
      this.CxID,
      required this.taskname,
      required this.status,
      required this.cat,
      required this.endDate,
      required this.message,
      required this.startDate,
      required this.priority,
      required this.lastseen,
      required this.f,
      required this.s,
      required this.assign,
      required this.leadId});
}
