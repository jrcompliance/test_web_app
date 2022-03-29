import 'package:cloud_firestore/cloud_firestore.dart';

class GetInvoiceModel {
  String? name;
  String? url;
  Timestamp? timestamp;
  bool? status;

  GetInvoiceModel({this.name, this.url, this.timestamp, this.status});
}
