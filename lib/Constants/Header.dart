import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_web_app/Constants/Responsive.dart';
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
      child: Responsive.isSmallScreen(context)
          ? Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.menu),
                color: btnColor,
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : Expanded(
              flex: 6,
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 20, color: txtColor, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
