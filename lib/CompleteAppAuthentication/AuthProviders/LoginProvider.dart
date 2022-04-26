import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  String? success;
  String? error;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getLogin(_email, _password) async {
    try {
      isLoading = true;
      notifyListeners();
      SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      var response = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      success = response.user!.email.toString();
      if (success != null) {
        isLoading = false;
        _sharedPreferences.setString("email", _email);
        _sharedPreferences.setString("uid", _auth.currentUser!.uid.toString());
        notifyListeners();
      }
      notifyListeners();
    } on FirebaseException catch (e) {
      error = e.message.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
