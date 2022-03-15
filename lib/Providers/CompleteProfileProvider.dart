import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfielProvider with ChangeNotifier {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  String? error;
  bool isLoading = false;
  Future<void> completProfile(
      name, logoBase64, _role, _econtact, _bgroup, _add, _gender, _doj) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      isLoading = true;
      notifyListeners();
      TaskSnapshot upload =
          await storage.ref('profiles/$name').putData(logoBase64);
      String myUrl = await upload.ref.getDownloadURL();
      String uid = _prefs.get("uid").toString();
      await _firebaseFirestore.collection("EmployeeData").doc(uid).update({
        "uimage": myUrl,
        "udesignation": _role,
        "econtact": _econtact,
        "bgroup": _bgroup,
        "add": _add,
        "gender": _gender,
        "doj": _doj
      }).then((value) {
        isLoading = false;
        notifyListeners();
      });
      notifyListeners();
    } on FirebaseException catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
