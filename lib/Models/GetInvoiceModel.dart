import 'package:cloud_firestore/cloud_firestore.dart';

class GetInvoiceModel {
  String? url;
  Timestamp? timestamp;
  bool? status;
  String? invoiceid;
  String? type;

  GetInvoiceModel(
      {this.url, this.timestamp, this.status, this.invoiceid, this.type});
}
