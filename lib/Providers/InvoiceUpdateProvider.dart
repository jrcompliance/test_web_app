import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class InvoiceUpdateProvder extends ChangeNotifier {
  Future invoiceUpdate(firstID, secondID, choosenValue) async {
    print(1);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference reference = await firestore.collection("Tasks");
    reference.doc(firstID).collection("Invoices").doc(secondID).update({
      "status": choosenValue,
    });
    notifyListeners();
  }
}
