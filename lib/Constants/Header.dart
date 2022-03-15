import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthProviders/LogOutProvider.dart';

import 'package:test_web_app/CompleteAppAuthentication/Auth_Views/Login_View.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/reusable.dart';

class Header extends StatefulWidget {
  final String title;
  const Header({Key? key, required this.title}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
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
                  _showMyDialog(context);
                },
                icon: Icon(Icons.exit_to_app),
                iconSize: 20,
                color: Colors.grey),
          ],
        ));
  }

  logout(BuildContext context) async {
    Provider.of<LogOutProvider>(context, listen: false)
        .getLogout()
        .then((value) {
      if (Provider.of<LogOutProvider>(context, listen: false).error == null) {
        Future.delayed(Duration(seconds: 4)).then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            dismissDirection: DismissDirection.startToEnd,
            content: Text("LogOut Successfully"),
            backgroundColor: Colors.green,
          ));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          content: Text(Provider.of<LogOutProvider>(context, listen: false)
              .error
              .toString()),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Provider.of<LogOutProvider>(context).isLoading
            ? Center(
                child: SpinKitFadingCube(color: btnColor, size: 30),
              )
            : AlertDialog(
                backgroundColor: bgColor,
                title: Text(
                  "Are you sure to LogOut ?",
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
                      logout(context);
                    },
                  ),
                ],
              );
      },
    );
  }
}
