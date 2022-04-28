import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceSaveModel {
  String? invoiceurl;
  String? invoiceID;
  double? amount;
  String? currencyType;
  String? duedate;
  String? status;
  String? invoiceType;
  String? internalNotes;
  String? externalNotes;
  String? referenceID;
  String? id;
  int? cxid;
  int? leadid;

  InvoiceSaveModel(
      {this.invoiceurl,
      this.invoiceID,
      this.amount,
      this.currencyType,
      this.duedate,
      this.status,
      this.invoiceType,
      this.internalNotes,
      this.externalNotes,
      this.referenceID,
      this.id,
      this.cxid,
      this.leadid});

  Map<String, dynamic> toMap() => {
        "invoiceurl": invoiceurl,
        "invoiceID": invoiceID,
        "amount": amount,
        "currencyType": currencyType,
        "duedate": duedate,
        "status": status,
        "invoiceType": invoiceType,
        "internalNotes": internalNotes,
        "externalNotes": externalNotes,
        "referenceID": referenceID,
        "id": id,
        "leadid": leadid,
        "cxid": cxid
      };
}
