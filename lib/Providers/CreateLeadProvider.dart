import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CreateLeadProvider with ChangeNotifier {
  String? error;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> createTask(
      _leadnameController,
      _endDateController,
      _clientnameController,
      _clientemailController,
      _clientphoneController,
      _firstmessageController,
      _selectperson,
      _image,
      cxid,
      leadId) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    String did = collectionReference.doc().id;

    try {
      collectionReference.doc(did).set({
        "dupmail": _clientemailController,
        "time": Timestamp.now(),
        "flag": false,
        "CxID": cxid,
        "id": did,
        "task": _leadnameController,
        "startDate": Timestamp.fromDate(DateTime.now()),
        "qDate": DateTime.now().toString().split(" ")[0],
        "endDate": _endDateController,
        "message": _firstmessageController,
        "priority": "E",
        "cat": "NEW",
        "status": "FRESH",
        "Attachments": [
          {"uid": _selectperson, "image": _image}
        ],
        "Attachments1": [],
        "companyname": "",
        "logo": "",
        "website": "",
        "fail": 0,
        "success": 0,
        "CompanyDetails": [
          {
            "contactperson": _clientnameController,
            "email": _clientemailController,
            "phone": _clientphoneController,
          }
        ],
        "lastseen": Timestamp.now(),
        "Certificates": [],
        "LeadId": leadId
      });
      notifyListeners();
    } on FirebaseException catch (e) {
      error = e.message.toString();
      print("error is  $error");
    }
  }
}
