import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/DashBoard/MainScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  GlobalKey _formKey = GlobalKey();
  bool _isSecured = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
                        "SignUp with",
                        style: TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      )),
                      Image.asset("assets/Logos/jrlogo.jpeg"),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter user name';
                            }
                            return null;
                          },
                          controller: usernameController,
                          style: TextStyle(color: Colors.white),
                          obscureText: false,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintText: "Username",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Material(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter user name';
                            }
                            return null;
                          },
                          controller: phonenumberController,
                          style: TextStyle(color: Colors.white),
                          obscureText: false,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintText: "Phone Number",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                      SizedBox(
                        height: 30,
                      ),
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
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()));
                          },
                          child: Text(
                            "Already have an Account?Login",
                            style: TextStyle(color: Colors.indigo),
                          )),
                      RaisedButton(
                        onPressed: () {
                          getRegister();
                        },
                        child: Text(
                          "SignUp",
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

  Future<void> getRegister() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((cred) async {
      storeUserData();
      if (cred.user == null) {
        print('Not loggedin');
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("email", emailController.text.toString());
        prefs.setString("password", passwordController.text.toString());
        print("loggedin");
      }

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => MainScreen()), (route) => false);
    });
  }

  Future<void> storeUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    fireStore.collection("UsersData").doc(uid).set({
      "email": emailController.text.toString(),
      "username": usernameController.text.toString(),
      "password": passwordController.text.toString(),
      'uid': uid,
    });
  }
}
