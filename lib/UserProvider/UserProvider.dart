import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:test_web_app/UserProvider/AllUserModel.dart';

class AllUSerProvider with ChangeNotifier {
  List<AllUserModel> _alluserModellist = [];
  List<AllUserModel> get alluserModellist {
    return [..._alluserModellist];
  }

  Future<void> fetchAllUser() async {
    // print("Hey Yalagala You function is starts from here............");
    try {
      FirebaseFirestore _firebase = FirebaseFirestore.instance;
      QuerySnapshot extractedResponse =
          await _firebase.collection("EmployeeData").get();
      print("Yalagala this is Provider pattern");
      List<AllUserModel> loadedData = [];
      return extractedResponse.docs.forEach((extractData) {
        loadedData.add(AllUserModel(
            auserimage: extractData["uimage"],
            ausername: extractData["uname"],
            auseremail: extractData["uemail"],
            auserphone: extractData["uphoneNumber"],
            ausergender: extractData["gender"],
            auserdesignation: extractData["udesignation"],
            auserbgroup: extractData["bgroup"],
            auserecontact: extractData["econtact"],
            adoj: extractData["doj"],
            aadd: extractData["add"],
            uid: extractData["uid"]));
        _alluserModellist = loadedData;
        notifyListeners();
      });
    } on Exception catch (e) {
      print(e.toString());
    }
    //print("Hey Yalagala Your function ended thank you!..............");
  }
}
