import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String? Customername;
  final String? Customeremail;
  final String? Customerphone;
  final String? Idocid;
  final int? CxID;
  String? taskname;
  //Timestamp startDate;
  String? endDate;
  String? priority;
  //Timestamp lastseen;
  String? cat;
  String? message;
  String? status;
  int? s;
  int? f;
  List? assign;
  int? leadId;
  String dupmail;

  CustomerModel(
      {this.Customername,
      this.Customeremail,
      this.Customerphone,
      this.Idocid,
      this.CxID,
      this.taskname,
      this.status,
      this.cat,
      this.endDate,
      this.message,
      //required this.startDate,
      this.priority,
      //required this.lastseen,
      this.f,
      this.s,
      this.assign,
      this.leadId,
      required this.dupmail});
}
