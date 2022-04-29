import 'package:cloud_firestore/cloud_firestore.dart';

class GetInvoiceModel {
  double? amount;
  String? currencyType;
  String? duedate;
  String? invoiceID;
  String? invoiceType;
  String? invoiceurl;
  String? status;
  String internalNotes;
  String externalNotes;
  String referenceID;
  String docid;
  int LeadId;

  GetInvoiceModel(
      {this.amount,
      this.currencyType,
      this.duedate,
      this.invoiceID,
      this.invoiceType,
      this.invoiceurl,
      this.status,
      required this.internalNotes,
      required this.externalNotes,
      required this.referenceID,
      required this.docid,
      required this.LeadId});
}
