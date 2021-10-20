import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Auth_Views/GetUserdata.dart';
import 'package:test_web_app/DashBoard/MainScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isSecured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (BuildContext context, constraints) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Lotties/loginbackground.png"),
                fit: BoxFit.fill),
          ),
          child: Card(
            color: Colors.white,
            elevation: 20,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Container(
              constraints: BoxConstraints(maxWidth: 350, maxHeight: 800),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          child: Text(
                        "Login with",
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      )),
                      Image.asset("assets/Logos/jrlogo.jpeg", scale: 1.5),
                      SizedBox(height: 20),
                      Material(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter user email';
                            }
                            return null;
                          },
                          controller: emailController,
                          style: TextStyle(color: Colors.white),
                          obscureText: false,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintText: "Email id",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      SizedBox(height: 30),
                      Material(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter the Password";
                            }
                            return null;
                          },
                          controller: passwordController,
                          style: TextStyle(color: Colors.white),
                          obscureText: _isSecured,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_isSecured
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isSecured = !_isSecured;
                                    });
                                  },
                                  color: Colors.white),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton(
                        onPressed: () {
                          login();
                        },
                        child: Text(
                          "LogIn",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ));
  }

  Future<void> login() async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then((cred) async {
        if (cred.user == null) {
          print('Not loggedin');
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("email", emailController.text.toString());
          prefs.setString("password", passwordController.text.toString());
          print("loggedin");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => MainScreen()),
              (route) => false);
        }
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
