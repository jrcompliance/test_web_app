import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthProviders/LoginProvider.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthReuses/MyLogo.dart';
import 'package:test_web_app/CompleteAppAuthentication/Auth_Views/RecoverPassword_View.dart';
import 'package:test_web_app/CompleteAppAuthentication/Auth_Views/Register_View.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/MainScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSecured = true;
  bool _isAgree = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Provider.of<LoginProvider>(context).isLoading
                  ? Center(
                      child: SpinKitFadingCube(
                        size: size.height * 0.05,
                        color: btnColor,
                      ),
                    )
                  : SizedBox(
                      width: size.width,
                      height: size.height,
                      child: ScaleAnimatedWidget.tween(
                        duration: Duration(seconds: 1),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              MyLogo(),
                              Text(
                                'Log in',
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
                                      onPressed: () {}),
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
                                      onPressed: () {}),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Email Address",
                                        style: TxtStls.fieldtitlestyle),
                                    Container(
                                      decoration: deco,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.01),
                                        child: TextFormField(
                                          cursorColor: btnColor,
                                          controller: _emailController,
                                          style: TxtStls.fieldstyle,
                                          decoration: InputDecoration(
                                            errorStyle: ClrStls.errorstyle,
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
                                    SizedBox(height: size.height * 0.01),
                                    Text("Password",
                                        style: TxtStls.fieldtitlestyle),
                                    Container(
                                      decoration: deco,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.01),
                                        child: TextFormField(
                                          cursorColor: btnColor,
                                          controller: _passwordController,
                                          style: TxtStls.fieldstyle,
                                          obscureText: _isSecured,
                                          decoration: InputDecoration(
                                            errorStyle: ClrStls.errorstyle,
                                            hintText: "Password",
                                            hintStyle: TxtStls.fieldstyle,
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isSecured
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: btnColor,
                                                ),
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
                                    SizedBox(height: size.height * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
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
                                          ],
                                        ),
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
                                    SizedBox(height: size.height * 0.01),
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
                                        //generateMsgToken();
                                        getLogin(context);
                                      },
                                    ),
                                    SizedBox(height: size.height * 0.01),
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
            ),
            Expanded(
              flex: 2,
              child: ScaleAnimatedWidget.tween(
                duration: Duration(seconds: 1),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Image.asset(
                      "assets/Logos/login.png",
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // generateMsgToken() async {
  //   print("Hey yalagala Plaese wait function is under process");
  //   FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //   print("Messaging intialized successfully");
  //   await firebaseMessaging.requestPermission().then((value) => print(value));
  //   await firebaseMessaging.getToken().then((value) => print(value));
  //   print("success");
  // }

  getLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Provider.of<LoginProvider>(context, listen: false)
          .getLogin(_emailController.text.toString(),
              _passwordController.text.toString())
          .then((value) {
        if (Provider.of<LoginProvider>(context, listen: false).success !=
            null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            dismissDirection: DismissDirection.startToEnd,
            content: Text("Login successfully"),
            backgroundColor: Colors.green,
          ));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => MainScreen()),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            dismissDirection: DismissDirection.startToEnd,
            content: Text(Provider.of<LoginProvider>(context, listen: false)
                .error
                .toString()),
            backgroundColor: Colors.red,
          ));
        }
      });
    }
  }
}