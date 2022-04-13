import 'package:cloud_firestore/cloud_firestore.dart';

class GetInvoiceModel {
  double? amount;
  String? currencyType;
  String? duedate;
  String? invoiceID;
  String? invoiceType;
  String? invoiceurl;
  String? status;
  GetInvoiceModel(
      {this.amount,
      this.currencyType,
      this.duedate,
      this.invoiceID,
      this.invoiceType,
      this.invoiceurl,
      this.status});
}
