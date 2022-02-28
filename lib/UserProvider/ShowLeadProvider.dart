import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:test_web_app/UserProvider/LeadModel.dart';

class AllLeadsProvider with ChangeNotifier {
  List<ShowLeadModel> _showleadmodellist = [];
  List<ShowLeadModel> get showleadmodellist {
    return [..._showleadmodellist];
  }

  Future<void> fetchAllLead() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot extractedResponse = await firestore.collection("Tasks").get();
    List<ShowLeadModel> lodedData = [];
    extractedResponse.docs.forEach((extractData) {
      //print(extractData.data());
      lodedData.add(ShowLeadModel(
        id: extractData["id"],
        task: extractData["task"],
        CxID: extractData["CxID"],
        startDate: extractData["startDate"],
        endDate: extractData["endDate"],
        companyDetails: extractData["CompanyDetails"],
        meesage: extractData["message"],
      ));
      _showleadmodellist = lodedData;
      notifyListeners();
    });
  }
}
