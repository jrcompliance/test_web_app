import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_web_app/Models/GetInvoiceModel.dart';

class GetInvoiceListProvider extends ChangeNotifier {
  List<GetInvoiceModel> _invoicemodellist = [];
  List<GetInvoiceModel> get invoicemodellist {
    return [..._invoicemodellist];
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> getInvoiceList(custometid) async {
    try {
      CollectionReference _collectionref = _firestore.collection("Invoices");
      var extractedResponse =
          await _collectionref.where("cxid", isEqualTo: custometid).get();
      List<GetInvoiceModel> loadedData = [];
      extractedResponse.docs.forEach((element) {
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
            docid: element["id"],
            LeadId: element["leadid"]));
      });
      _invoicemodellist = loadedData;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
