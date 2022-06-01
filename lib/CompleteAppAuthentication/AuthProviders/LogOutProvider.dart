import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Models/UserModel2.dart';

class LogOutProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? error;
  bool isLoading = false;
  Future<void> getLogout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      isLoading = true;
      notifyListeners();
      await _auth.signOut().then((value) {
        isloggedOut = true;
        sharedPreferences.clear();
        Future.delayed(Duration(seconds: 4)).then((value) {
          isLoading = false;
          notifyListeners();
        });
      });

      notifyListeners();
    } on Exception catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }
}
