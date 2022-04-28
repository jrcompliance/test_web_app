import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_web_app/Models/InvoiceSaveModel.dart';

class InvoiceSaveProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future invoiceData(
      invoiceurl,
      invoiceType,
      status,
      invoiceID,
      amount,
      currencyType,
      duedate,
      internalNotes,
      externalNotes,
      referenceID,
      customerid,
      leadid) async {
    try {
      CollectionReference reference = await _firestore.collection("Invoices");
      String docID = reference.doc().id;
      InvoiceSaveModel model = InvoiceSaveModel();
      model.invoiceurl = invoiceurl;
      model.invoiceID = invoiceID;
      model.amount = amount;
      model.currencyType = currencyType;
      model.duedate = duedate;
      model.status = status;
      model.invoiceType = invoiceType;
      model.internalNotes = internalNotes;
      model.externalNotes = externalNotes;
      model.referenceID = referenceID;
      model.id = docID;
      model.cxid = customerid;
      model.leadid = leadid;
      reference.doc(docID).set(model.toMap());
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
