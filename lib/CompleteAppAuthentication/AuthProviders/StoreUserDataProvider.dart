import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthModels/RegisterModel.dart';

class StoreUserDataProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? error;

  Future<void> storeUserData(
      _username, _email, _password, _phonenumber, _isAgree) async {
    RegisterModel _registerModel = RegisterModel();
    _registerModel.fcmtoken = null;
    _registerModel.TCPB = _isAgree;
    _registerModel.add = null;
    _registerModel.doj = null;
    _registerModel.econtact = null;
    _registerModel.gender = null;
    _registerModel.password = _password;
    _registerModel.udesignation = null;
    _registerModel.uemail = _email;
    _registerModel.uid = _auth.currentUser!.uid.toString();
    _registerModel.uimage = null;
    _registerModel.uname = _username;
    _registerModel.uphoneNumber = _phonenumber;
    _registerModel.urole = "Employee";
    String uid = _auth.currentUser!.uid.toString();
    try {
      await _firestore
          .collection("EmployeeData")
          .doc(uid)
          .set(_registerModel.toMap());
      notifyListeners();
    } on Exception catch (e) {
      error = e.toString();
    }
  }
}
