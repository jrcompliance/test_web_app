import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Models/UserModels.dart';

class UserDataProvider extends ChangeNotifier {
  String? username;
  String? email;
  String? phone;
  String? imageUrl;
  String? role;
  String? uid;
  Future<void> getUserData() async {
    try {
      FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
      FirebaseAuth _auth = FirebaseAuth.instance;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var uid = prefs.getString("uid");
      await _firebasefirestore
          .collection("EmployeeData")
          .doc(uid)
          .get()
          .then((value) {
        username = value.get("uname");
        email = value.get("uemail");
        phone = value.get("uphoneNumber");
        imageUrl = value.get("uimage");
        role = value.get("urole");
        notifyListeners();
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
