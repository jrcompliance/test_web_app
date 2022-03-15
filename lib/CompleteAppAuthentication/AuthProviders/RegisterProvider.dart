import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? success;
  String? error;
  bool isLoading = false;

  Future<void> getRegister(_email, _password) async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      success = response.user!.email.toString();
      isLoading = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }
}
