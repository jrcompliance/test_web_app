import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';

class UserDataProvider extends ChangeNotifier {
  List<EmployeesModel> _employeelist = [];
  List<EmployeesModel> get employeelist {
    return [..._employeelist];
  }

  String? fcmtoken;
  String? add;
  String? bgroup;
  String? doj;
  String? econtact;
  String? gender;
  String? udesignation;
  String? username;
  String? email;
  String? phone;
  String? imageUrl;
  String? role;
  String? uid;
  int? eid;

  Future<void> getUserData() async {
    try {
      FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString("uid");
      await _firebasefirestore
          .collection("EmployeeData")
          .doc(userid)
          .get()
          .then((value) {
        //print(value.data());
        fcmtoken = value.get("fcmtoken");
        add = value.get("add");
        bgroup = value.get("bgroup");
        doj = value.get("doj");
        econtact = value.get("econtact");
        udesignation = value.get("udesignation");
        gender = value.get("gender");
        username = value.get("uname");
        email = value.get("uemail");
        phone = value.get("uphoneNumber");
        imageUrl = value.get("uimage");
        role = value.get("urole");
        eid = value.get("eid");
        uid = value.get("uid");
        notifyListeners();
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> getEmployeesList(userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString("uid");
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      var extractedResponse = await firestore
          .collection("EmployeeData")
          .where("uid", isNotEqualTo: userid)
          .get();
      List<EmployeesModel> loadedData = [];
      extractedResponse.docs.forEach((element) {
        loadedData.add(EmployeesModel(
          fcmtoken: element["fcmtoken"],
          add: element["add"],
          bgroup: element["bgroup"],
          doj: element["doj"],
          econtact: element["econtact"],
          gender: element["gender"],
          udesignation: element["udesignation"],
          uname: element["uname"],
          uemail: element["uemail"],
          uphoneNumber: element["uphoneNumber"],
          uimage: element["uimage"],
          urole: element["urole"],
          uid: element["uid"],
          eid: element["eid"],
        ));
        var set = <String>{};
        List<EmployeesModel> duplicateName =
            loadedData.where((e) => set.add(e.uemail.toString())).toList();
        _employeelist = duplicateName;
        notifyListeners();
        // print(element.data());
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateOnlinestatus(id, value) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference =
          firestore.collection("EmployeeData");
      collectionReference.doc(id).update({"status": value});
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
