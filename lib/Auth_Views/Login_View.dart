import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:test_web_app/Auth_Views/MyLogo.dart';
import 'package:test_web_app/Auth_Views/RecoverPassword_View.dart';
import 'package:test_web_app/Auth_Views/Register_View.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/MainScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isSecured = true;
  bool _isAgree = false;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: _isLoading
                  ? Center(
                      child: SpinKitFadingCube(
                        size: 50.0,
                        color: btnColor,
                      ),
                    )
                  : AnimatedContainer(
                      duration: const Duration(milliseconds: 1),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            MyLogo(),
                            Text(
                              'Log in',
                              style: TxtStls.titlestyle,
                            ),
                            SizedBox(height: 40.0),
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
                                      print('click');
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
                                      print('click');
                                    }),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 140),
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
                            SizedBox(height: 20.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 140.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                          } else if (!regExp.hasMatch(email)) {
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
                                      Text(
                                        "Remember me",
                                        style: TxtStls.fieldstyle,
                                      ),
                                      SizedBox(width: 120),
                                      InkWell(
                                        child: Text("Reset Password?",
                                            style: TxtStls.btnstyle),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      Recoverpassword()));
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(12.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: btnColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: Text(
                                        "Log In",
                                        style: TextStyle(color: bgColor),
                                      ),
                                    ),
                                    onTap: () {
                                      getLogin(_emailController,
                                          _passwordController);
                                    },
                                  ),
                                  SizedBox(height: 15.0),
                                  Align(
                                    alignment: Alignment.center,
                                    child: RichText(
                                      text: TextSpan(
                                          text: "Don't have an account yet? ",
                                          style: TxtStls.fieldtitlestyle,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "New Account",
                                                style: TxtStls.btnstyle,
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    RegisterScreen()),
                                                            (route) => false);
                                                      })
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ),
            Expanded(
              flex: 2,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 2),
                child: Image.asset(
                  "assets/Logos/login.png",
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

  Future<void> getLogin(
    _emailController,
    _passwordController,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: _emailController.text.toString(),
                password: _passwordController.text.toString())
            .then((cred) {
          if (cred.user != null) {
            prefs.setString("email", _emailController.text.toString());
            prefs.setString("password", _passwordController.text.toString());
          } else {}
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            dismissDirection: DismissDirection.startToEnd,
            content: Expanded(child: Text("Log in Successfully")),
            padding: EdgeInsets.symmetric(horizontal: 800, vertical: 15),
            backgroundColor: Colors.green,
          ));
          setState(() => _isLoading = false);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => MainScreen()));
        });
      } on FirebaseException catch (e) {
        print(e.toString());
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          content: Expanded(child: Text(e.message.toString())),
          padding: EdgeInsets.symmetric(horizontal: 600, vertical: 15),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
