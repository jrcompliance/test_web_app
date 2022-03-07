import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Constants/reusable.dart';

class Header extends StatefulWidget {
  final String title;
  Header({Key? key, required this.title}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: AbgColor.withOpacity(0.0001),
        height: size.height * 0.07,
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            if (Responsive.isSmallScreen(context))
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.menu),
                  color: btnColor,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 20, color: txtColor, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications),
                iconSize: 20,
                color: Colors.grey),
            IconButton(
                onPressed: () {
                  _showMyDialog();
                },
                icon: Icon(Icons.exit_to_app),
                iconSize: 20,
                color: Colors.grey),
          ],
        ));
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
      prefs.clear();
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text(
            'Are you sure to LogOut / ${username}?',
            style: TxtStls.fieldtitlestyle,
          ),
          actions: <Widget>[
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: grClr,
              child: Text(
                'Cancel',
                style: TxtStls.fieldstyle1,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: clsClr,
              child: Text('Ok', style: TxtStls.fieldstyle1),
              onPressed: () {
                logout();
              },
            ),
          ],
        );
      },
    );
  }
}
