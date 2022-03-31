import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:test_web_app/Models/OurCustomerModel.dart';

class CustmerProvider extends ChangeNotifier {
  List<CustomerModel> _customerlist = [];
  List<CustomerModel> get customerlist {
    return [..._customerlist];
  }

  Future<void> getCustomers() async {
    try {
      FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
      QuerySnapshot extractedResponse =
          await _firebasefirestore.collection("Tasks").get();
      List<CustomerModel> lodedData = [];
      extractedResponse.docs.forEach((element) {
        lodedData.add(CustomerModel(
          Customername: element["CompanyDetails"][0]["contactperson"],
          Customeremail: element["CompanyDetails"][0]["email"],
          Customerphone: element["CompanyDetails"][0]["phone"],
          Idocid: element["id"],
        ));
        _customerlist = lodedData;
        notifyListeners();
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
