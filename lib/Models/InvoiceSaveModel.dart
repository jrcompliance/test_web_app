import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceSaveModel {
  String? invoiceurl;
  String? invoiceID;
  double? amount;
  String? currencyType;
  String? duedate;
  String? status;
  String? invoiceType;

  InvoiceSaveModel(
      {this.invoiceurl,
      this.invoiceID,
      this.amount,
      this.currencyType,
      this.duedate,
      this.status,
      this.invoiceType});

  Map<String, dynamic> toMap() => {
        "invoiceurl": invoiceurl,
        "invoiceID": invoiceID,
        "amount": amount,
        "currencyType": currencyType,
        "duedate": duedate,
        "status": status,
        "invoiceType": invoiceType,
      };
}
