import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_web_app/Models/GetInvoiceModel.dart';

class GetInvoiceListProvider extends ChangeNotifier {
  List<GetInvoiceModel> _invoicemodellist = [];
  List<GetInvoiceModel> get invoicemodellist {
    return [..._invoicemodellist];
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> getInvoiceList(id) async {
    CollectionReference _collectionref = _firestore.collection("Tasks");
    QuerySnapshot extractedResponse =
        await _collectionref.doc(id).collection("Invoices").get();
    List<GetInvoiceModel> loadedData = [];
    extractedResponse.docs.forEach((element) {
      print(element.data());
      loadedData.add(GetInvoiceModel(
          amount: element["amount"],
          currencyType: element["currencyType"],
          duedate: element["duedate"],
          invoiceID: element["invoiceID"],
          invoiceType: element["invoiceType"],
          invoiceurl: element["invoiceurl"],
          status: element["status"],
          internalNotes: element["internalNotes"],
          externalNotes: element["externalNotes"],
          referenceID: element["referenceID"],
          docid: element["id"]));
    });
    _invoicemodellist = loadedData;
    notifyListeners();
  }
}
