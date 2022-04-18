import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthProviders/ResetPasswordProvider.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthReuses/MyLogo.dart';
import 'package:test_web_app/Constants/reusable.dart';

class Recoverpassword extends StatefulWidget {
  const Recoverpassword({Key? key}) : super(key: key);

  @override
  _RecoverpasswordState createState() => _RecoverpasswordState();
}

class _RecoverpasswordState extends State<Recoverpassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScaleAnimatedWidget.tween(
        duration: Duration(seconds: 1),
        child: AnimatedContainer(
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
                    SizedBox(height: size.height * 0.01),
                    Text("Password Recover", style: TxtStls.titlestyle),
                    SizedBox(height: size.height * 0.01),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email Address", style: TxtStls.fieldtitlestyle),
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
                                  } else if (!regExp.hasMatch(email)) {
                                    return "Enter a valid email";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Provider.of<PasswordResetProvider>(context).isLoading
                              ? Center(
                                  child: SpinKitFadingCube(
                                    color: btnColor,
                                    size: 20,
                                  ),
                                )
                              : InkWell(
                                  child: Container(
                                    padding: EdgeInsets.all(12.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: btnColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Text(
                                      "Reset Your Password",
                                      style: TextStyle(color: bgColor),
                                    ),
                                  ),
                                  onTap: () {
                                    getPassword(context);
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
      ),
    );
  }

  getPassword(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      Provider.of<PasswordResetProvider>(context, listen: false)
          .getPassword(_emailController.text.toString())
          .then((value) {
        print(Provider.of<PasswordResetProvider>(context, listen: false).error);
        if (Provider.of<PasswordResetProvider>(context, listen: false).error ==
            null) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              dismissDirection: DismissDirection.startToEnd,
              content: Text(
                  "Password Reset Link sent to your registered email Successfully"),
              backgroundColor: Colors.green));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              dismissDirection: DismissDirection.startToEnd,
              content: Text(
                Provider.of<PasswordResetProvider>(context, listen: false)
                    .error
                    .toString(),
              ),
              backgroundColor: Colors.red));
        }
      });
    }
  }
}
