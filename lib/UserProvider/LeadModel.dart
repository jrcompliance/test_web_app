import 'package:cloud_firestore/cloud_firestore.dart';

class ShowLeadModel {
  final String id;
  final String task;
  final int CxID;
  final Timestamp startDate;
  final String endDate;
  final List companyDetails;
  final String meesage;
  ShowLeadModel({
    required this.id,
    required this.task,
    required this.CxID,
    required this.startDate,
    required this.endDate,
    required this.companyDetails,
    required this.meesage,
  });
}
