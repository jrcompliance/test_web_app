import 'dart:ui';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:test_web_app/Auth_Views/Url_launchers.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
import 'package:test_web_app/Auth_Views/MyLogo.dart';
import 'package:test_web_app/Auth_Views/Success_View.dart';
import 'package:test_web_app/Constants/reusable.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isSecured = true;
  bool _isAgree = false;
  bool _isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  var maxLength = 10;
  var textLength = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: _isLoading
                  ? Center(
                      child: SpinKitFadingCube(
                        size: size.height * 0.05,
                        color: btnColor,
                      ),
                    )
                  : ScaleAnimatedWidget.tween(
                      duration: Duration(seconds: 1),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyLogo(),
                            Text(
                              'Sign Up',
                              style: TxtStls.titlestyle,
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SignInButton(
                                    buttonType: ButtonType.googleDark,
                                    imagePosition: ImagePosition.left,
                                    buttonSize: ButtonSize.large,
                                    btnTextColor: txtColor,
                                    btnColor: fieldColor,
                                    elevation: 0.0,
                                    width: 150,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.0))),
                                    btnText: 'Google',
                                    onPressed: () {
                                      print("Google");
                                    }),
                                SizedBox(width: 25),
                                SignInButton(
                                    buttonType: ButtonType.facebookDark,
                                    imagePosition: ImagePosition.left,
                                    buttonSize: ButtonSize.large,
                                    btnTextColor: txtColor,
                                    btnColor: fieldColor,
                                    elevation: 0.0,
                                    width: 150,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.0))),
                                    btnText: 'Facebook',
                                    onPressed: () {
                                      print("facebook");
                                    }),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: 0.2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Or',
                                      style: TxtStls.fieldstyle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.black,
                                      thickness: 0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.075),
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Full Name",
                                        style: TxtStls.fieldtitlestyle),
                                    Container(
                                      decoration: deco,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, top: 2),
                                        child: TextFormField(
                                          controller: _usernameController,
                                          style: TxtStls.fieldstyle,
                                          decoration: InputDecoration(
                                            hintText: "Your name",
                                            hintStyle: TxtStls.fieldstyle,
                                            border: InputBorder.none,
                                          ),
                                          validator: (fullname) {
                                            if (fullname!.isEmpty) {
                                              return "Name can not be empty";
                                            } else if (fullname.length < 3) {
                                              return "Name should be atleast 3 letters";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text("Phone Number",
                                        style: TxtStls.fieldtitlestyle),
                                    Container(
                                      decoration: deco,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, top: 2),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          maxLength: maxLength,
                                          controller: _phonenumberController,
                                          style: TxtStls.fieldstyle,
                                          decoration: InputDecoration(
                                            suffixText:
                                                '${textLength.toString()}/${maxLength.toString()}',
                                            counterText: "",
                                            hintText: "Phone Number",
                                            hintStyle: TxtStls.fieldstyle,
                                            border: InputBorder.none,
                                          ),
                                          validator: (phoneNumber) {
                                            String patttern =
                                                r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                            RegExp regExp = RegExp(patttern);
                                            if (phoneNumber!.isEmpty) {
                                              return "Phone Number can not be empty";
                                            } else if (phoneNumber.length <
                                                    10 ||
                                                phoneNumber.length > 10) {
                                              return "Enter valid Phone Number";
                                            } else if (!regExp
                                                .hasMatch(phoneNumber)) {
                                              return "Only numbers are allowed";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              textLength = value.length;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text("Email Address",
                                        style: TxtStls.fieldtitlestyle),
                                    Container(
                                      decoration: deco,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, top: 2),
                                        child: TextFormField(
                                          controller: _emailController,
                                          style: TxtStls.fieldstyle,
                                          decoration: InputDecoration(
                                            hintText: "Enter email address",
                                            hintStyle: TxtStls.fieldstyle,
                                            border: InputBorder.none,
                                          ),
                                          validator: (email) {
                                            String pattern =
                                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                            RegExp regExp = RegExp(pattern);
                                            if (email!.isEmpty) {
                                              return "Email can not be empty";
                                            } else if (!regExp
                                                .hasMatch(email)) {
                                              return "Enter a valid email";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text("Password",
                                        style: TxtStls.fieldtitlestyle),
                                    Container(
                                      decoration: deco,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, top: 2),
                                        child: TextFormField(
                                          controller: _passwordController,
                                          style: TxtStls.fieldstyle,
                                          obscureText: _isSecured,
                                          decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle: TxtStls.fieldstyle,
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                                icon: Icon(_isSecured
                                                    ? Icons.visibility_off
                                                    : Icons.visibility),
                                                onPressed: () {
                                                  setState(() {
                                                    _isSecured = !_isSecured;
                                                  });
                                                },
                                                color: txtColor),
                                          ),
                                          validator: (password) {
                                            if (password!.isEmpty) {
                                              return "Password can not be empty";
                                            } else if (password.length < 6) {
                                              return "Passowrd should be atleast 6 letters";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Checkbox(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0))),
                                          activeColor: btnColor,
                                          value: _isAgree,
                                          onChanged: (value) {
                                            setState(() {
                                              _isAgree = value ?? false;
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                                text:
                                                    "By creating an account you agree to the \n",
                                                style: TxtStls.fieldstyle,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: "terms of use",
                                                      style: TextStyle(
                                                          color: btnColor,
                                                          fontSize: 12.5,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              launches
                                                                  .termsofuse();
                                                            }),
                                                  TextSpan(
                                                    text: " and our ",
                                                    style: TxtStls.fieldstyle,
                                                  ),
                                                  TextSpan(
                                                      text: "privacy policy",
                                                      style: TextStyle(
                                                          color: btnColor,
                                                          fontSize: 12.5,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              launches
                                                                  .privacy();
                                                            }),
                                                  TextSpan(
                                                    text: " followed by \n",
                                                    style: TxtStls.fieldstyle,
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          "purchase and billing",
                                                      style: TextStyle(
                                                          color: btnColor,
                                                          fontSize: 12.5,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              launches
                                                                  .purchase();
                                                            })
                                                ]),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 12.0),
                                    _isAgree
                                        ? InkWell(
                                            child: Container(
                                              padding: EdgeInsets.all(12.0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: _isAgree
                                                      ? btnColor
                                                      : fieldColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              child: Text(
                                                "Create Account",
                                                style: TextStyle(
                                                    color: _isAgree
                                                        ? Colors.white
                                                        : txtColor),
                                              ),
                                            ),
                                            onTap: () {
                                              getRegister(
                                                  _emailController,
                                                  _passwordController,
                                                  _usernameController,
                                                  _phonenumberController);
                                            },
                                          )
                                        : Container(
                                            padding: EdgeInsets.all(12.0),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: fieldColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            child: Text(
                                              "Create Account",
                                              style: TextStyle(color: txtColor),
                                            ),
                                          ),
                                    SizedBox(height: 12.0),
                                    Align(
                                      alignment: Alignment.center,
                                      child: RichText(
                                        text: TextSpan(
                                            text: "Already have an account? ",
                                            style: TxtStls.fieldtitlestyle,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: "Log in",
                                                  style: TxtStls.btnstyle,
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      LoginScreen()));
                                                        })
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ),
            Expanded(
              flex: 2,
              child: ScaleAnimatedWidget.tween(
                duration: Duration(seconds: 1),
                child: Image.asset(
                  "assets/Logos/SignUp.png",
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getRegister(_emailController, _passwordController,
      _usernameController, _phonenumberController) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_formkey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: _emailController.text.toString(),
                password: _passwordController.text.toString())
            .then((cred) {
          if (cred.user != null) {
            storeUserData();
          } else {}
          setState(() => _isLoading = false);
        });
      } on FirebaseException catch (e) {
        print(e.toString());
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> storeUserData() async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    String uid = _auth.currentUser!.uid.toString();
    await _fireStore.collection("EmployeeData").doc(uid).set({
      "uid": uid,
      "uname": _usernameController.text.toString(),
      "uemail": _emailController.text.toString(),
      "uphoneNumber": _phonenumberController.text.toString(),
      "uimage": "",
      "password": _passwordController.text.toString(),
      "urole": "Employee",
      "TCPB": _isAgree,
      "add": null,
      "bgroup": null,
      "doj":null,
      "econtact":null,
      "udesignation": null,

    }, SetOptions(merge: true)).then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => SuccessScreen())));
  }
}
