import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_web_app/Models/InvoiceSaveModel.dart';

class InvoiceSaveProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future invoiceData(id, invoiceurl, invoiceType, status, invoiceID, amount,
      currenctType, duedate) async {
    try {
      CollectionReference reference = await _firestore.collection("Tasks");
      InvoiceSaveModel model = InvoiceSaveModel();
      model.invoiceurl = invoiceurl;
      model.invoiceID = invoiceID;
      model.amount = amount;
      model.currencyType = currenctType;
      model.duedate = duedate;
      model.status = status;
      model.invoiceType = invoiceType;
      reference.doc(id).collection("Invoices").doc().set(model.toMap());
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
