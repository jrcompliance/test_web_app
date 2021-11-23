import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';

import 'package:test_web_app/Auth_Views/MyLogo.dart';
import 'package:test_web_app/Constants/reusable.dart';

class Recoverpassword extends StatefulWidget {
  const Recoverpassword({Key? key}) : super(key: key);

  @override
  _RecoverpasswordState createState() => _RecoverpasswordState();
}

class _RecoverpasswordState extends State<Recoverpassword> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 10),
        alignment: Alignment.center,
        child: Card(
          elevation: 10.0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 10),
            constraints: BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyLogo(),
                  SizedBox(height: 10.0),
                  Text("Recover", style: TxtStls.titlestyle),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email Address", style: TxtStls.fieldtitlestyle),
                        Container(
                          decoration: deco,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 2),
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
                                } else if (!regExp.hasMatch(email)) {
                                  return "Enter a valid email";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: btnColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text("Reset Your Password"),
                          ),
                          onTap: () {
                            forgotPassword(_emailController);
                          },
                        ),
                        SizedBox(height: 40.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> forgotPassword(_emailController) async {
    try {
      if (_formkey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });

        await _auth
            .sendPasswordResetEmail(email: _emailController.text.toString())
            .then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            dismissDirection: DismissDirection.startToEnd,
            content: Text(
                "Password Reset Link sent to your registered email Successfully"),
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 600, vertical: 15),
          ));
          setState(() {
            _isLoading = false;
          });
        });
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.startToEnd,
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 600, vertical: 15),
      ));
    }
  }
}
