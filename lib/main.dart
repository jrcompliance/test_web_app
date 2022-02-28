import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
import 'package:test_web_app/Auth_Views/Success_View.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/MainScreen.dart';
import 'package:test_web_app/DummyFile.dart';
import 'package:test_web_app/UserProvider/GstProvider.dart';
import 'package:test_web_app/UserProvider/ShowLeadProvider.dart';
import 'package:test_web_app/UserProvider/UserProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => AllUSerProvider()),
      ChangeNotifierProvider(create: (ctx) => AllLeadsProvider()),
      ChangeNotifierProvider(create: (ctx) => GstProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "JR CRM",
      theme: ThemeData.light().copyWith(
        scrollbarTheme:
            ScrollbarThemeData(thumbColor: MaterialStateProperty.all(btnColor)),
        scaffoldBackgroundColor: AbgColor.withOpacity(0.1),
        canvasColor: bgColor.withOpacity(1),
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
    Future.delayed(Duration(seconds: 3))
        .then((value) => _checkAuthentication());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SpinKitFadingCube(
          size: size.height * 0.075,
          color: btnColor,
        ),
      ),
    );
  }

  _checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString("email") == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MainScreen()));
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
