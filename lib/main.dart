import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
import 'package:test_web_app/Auth_Views/Register_View.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/MainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "JR CRM",
      theme: ThemeData.dark().copyWith(
        scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(Colors.grey)),
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: bgColor),
        canvasColor: secondaryColor,
      ),
      home: LandingScreen(),
    );
  }
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString("email") == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => RegisterScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MainScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("EmployeeData")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {}
              return PopupMenuButton<String>(
                itemBuilder: (context) => snapshot.data!.docs
                    .map((item) => PopupMenuItem<String>(
                        value: item["uid"],
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(item["imageUrl"]),
                            ),
                            Text(
                              item["username"],
                            ),
                          ],
                        )))
                    .toList(),
                onSelected: (value) {
                  print(value);
                },
              );
            }));
  }
}
