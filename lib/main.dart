import 'dart:async';
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
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

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  int _currentStep = 0;
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildStepper(StepperType.horizontal),
    );
  }

  Widget steps() {
    List<Step> stepslist() => [
          Step(
            title: Text("Pay"),
            content: Container(),
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 0,
          ),
          Step(
            title: Text("Recieve"),
            content: Container(),
            state: _currentStep <= 1 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 1,
          ),
          Step(
            title: Text("Pay"),
            content: Container(),
            state: _currentStep <= 2 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 2,
          ),
          Step(
            title: Text("Recieve"),
            content: Container(),
            state: _currentStep <= 3 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 3,
          ),
        ];
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _currentStep,
      physics: ClampingScrollPhysics(),
      elevation: 10,
      steps: stepslist(),

      onStepContinue: () {
        if (_currentStep < (stepslist().length - 1)) {
          setState(() {
            _currentStep += 1;
          });
        }
      },

      // onStepCancel takes us to the previous step
      onStepCancel: () {
        if (_currentStep == 0) {
          return;
        }

        setState(() {
          _currentStep -= 1;
        });
      },

      // onStepTap allows to directly click on the particular step we want
      onStepTapped: (step) {
        setState(() {
          _currentStep = step;
        });
      },
    );
  }

  CupertinoStepper _buildStepper(StepperType type) {
    final canCancel = currentStep > 0;
    final canContinue = currentStep < 3;
    return CupertinoStepper(
      type: type,
      currentStep: currentStep,
      onStepTapped: (step) => setState(() => currentStep = step),
      onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
      onStepContinue: canContinue ? () => setState(() => ++currentStep) : null,
      steps: [
        for (var i = 0; i < 3; ++i)
          _buildStep(
            title: Text('Step ${i + 1}'),
            isActive: i == currentStep,
            state: i == currentStep
                ? StepState.editing
                : i < currentStep
                    ? StepState.complete
                    : StepState.indexed,
          ),
        _buildStep(
          title: Text('Error'),
          state: StepState.error,
        ),
        _buildStep(
          title: Text('Disabled'),
          state: StepState.disabled,
        )
      ],
    );
  }

  Step _buildStep({
    required Widget title,
    StepState state = StepState.indexed,
    bool isActive = false,
  }) {
    return Step(
      title: title,
      subtitle: Text('Subtitle'),
      state: state,
      isActive: isActive,
      content: LimitedBox(
        maxWidth: 300,
        maxHeight: 300,
        child: Container(color: CupertinoColors.systemGrey),
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
