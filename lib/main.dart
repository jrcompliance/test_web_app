import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

//Update the time in 'YYYY-MM-DD HH:MM:SS' format
final eventTime = DateTime.parse('2021-12-16 15:34:00');

class _TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);

  int timeDiff = eventTime.difference(DateTime.now()).inSeconds;
  bool isActive = false;

  Timer? timer;

  void handleTick() {
    if (timeDiff > 0) {
      if (isActive) {
        setState(() {
          if (eventTime != DateTime.now()) {
            timeDiff = timeDiff - 1;
          } else {
            print('Times up!');
            //Do something
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }

    int days = timeDiff ~/ (24 * 60 * 60) % 24;
    int hours = timeDiff ~/ (60 * 60) % 24;
    int minutes = (timeDiff ~/ 60) % 60;
    int seconds = timeDiff % 60;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          title: Center(
            child: Text('Countdown Timer'),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LabelText(
                      label: 'HRS', value: hours.toString().padLeft(2, '0')),
                  LabelText(
                      label: 'MIN', value: minutes.toString().padLeft(2, '0')),
                  LabelText(
                      label: 'SEC', value: seconds.toString().padLeft(2, '0')),
                ],
              ),
              SizedBox(height: 60),
              Container(
                width: 200,
                height: 47,
                margin: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  color: isActive ? Colors.grey : Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(isActive ? 'STOP' : 'START'),
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  LabelText({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: btnColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
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
