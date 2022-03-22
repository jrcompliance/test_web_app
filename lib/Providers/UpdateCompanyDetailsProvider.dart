import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:test_web_app/Models/UpdateCompanyDetailsModel.dart';

class UpdateCompanyDeatailsProvider with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> updateCompanyDetails(id, cl1, cl5) async {
    try {
      CollectionReference collectionReference = _firestore.collection("Tasks");
      UpdateCompanyDeatailsModel model = UpdateCompanyDeatailsModel();
      model.companyname = cl1;
      model.logo = "https://www.google.com/s2/favicons?sz=64&domain_url=" + cl5;
      model.website = cl5;
      collectionReference.doc(id).update(model.toMap());
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
