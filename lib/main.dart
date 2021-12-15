import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
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
    Timer(Duration(seconds: 4), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString("email") == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MainScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitFadingCube(
        size: 50.0,
        color: btnColor,
      )),
    );
  }
}

class Dummy extends StatefulWidget {
  const Dummy({Key? key}) : super(key: key);

  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CountdownTimer(
          endTime: 9999999999999,
        ),
      ),
    );
  }
}

// class APage extends StatefulWidget {
//   const APage({Key? key}) : super(key: key);
//
//   @override
//   _APageState createState() => _APageState();
// }
//
// class _APageState extends State<APage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ADMIN SIDE"),
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width * 1,
//         height: MediaQuery.of(context).size.height * 1,
//         color: txtColor,
//         child: StreamBuilder(
//           stream:
//               FirebaseFirestore.instance.collection("EmployeeData").snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return Container();
//             }
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (BuildContext context, index) {
//                 return ListTile(
//                   leading: ClipRRect(
//                       borderRadius: BorderRadius.all(Radius.circular(40.0)),
//                       child: Image.network(
//                           snapshot.data!.docs[index]["imageUrl"])),
//                   title: Text(snapshot.data!.docs[index]["username"]),
//                   onTap: () {
//                     login(snapshot.data!.docs[index]["email"],
//                         snapshot.data!.docs[index]["password"]);
//                   },
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<void> login(email, password) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password)
//           .then((cred) async {
//         if (cred.user != null) {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (_) => MainScreen()));
//         } else {
//           print('Not loggedin');
//         }
//       });
//     } on Exception catch (e) {
//       print(e.toString());
//     }
//   }
// }
