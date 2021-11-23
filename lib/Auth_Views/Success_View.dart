import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
import 'package:test_web_app/Auth_Views/MyLogo.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/MainScreen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Card(
          elevation: 10.0,
          child: Container(
            constraints: BoxConstraints(maxWidth: 600, maxHeight: 450),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyLogo(),
                SizedBox(
                    height: 200,
                    child:
                        Lottie.asset("assets/Lotties/registeredsucees.json")),
                SizedBox(height: 30),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    margin: EdgeInsets.symmetric(horizontal: 60.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: btnColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      "Your account created successfully",
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
