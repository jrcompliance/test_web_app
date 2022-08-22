import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_web_app/Models/GetServiceModel.dart';
import 'package:test_web_app/Models/ServiceSaveModel.dart';
import 'package:test_web_app/Models/ServicesModel.dart';
import 'package:test_web_app/Models/UserModels.dart';

class GetServiceProvider extends ChangeNotifier {
  String? serviceurl;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future getServiceData(leadid, docid, customerid) async {
    try {
      CollectionReference reference = _firestore.collection("Services");
      var extractedResponse = await reference
          .where('docid', isEqualTo: docid)
          .where('LeadId', isEqualTo: leadid.toString())
          .where('cxID', isEqualTo: customerid.toString())
          .get();
      extractedResponse.docs.forEach((element) {
        serviceurl = element.get('serviceurl');
        print('kggerge' + serviceurl.toString());
        notifyListeners();
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
