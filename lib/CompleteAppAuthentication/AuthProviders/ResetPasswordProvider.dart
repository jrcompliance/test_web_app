import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class PasswordResetProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? error;
  bool isLoading = false;

  Future<void> getPassword(_email) async {
    try {
      isLoading = true;
      notifyListeners();
      await _auth.sendPasswordResetEmail(email: _email);
      isLoading = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      isLoading = false;
      error = e.message.toString();
      notifyListeners();
    }
  }
}
