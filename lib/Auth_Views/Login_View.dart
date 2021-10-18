import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_web_app/Constants/reusable.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Lotties/loginbackground.png"),
              fit: BoxFit.fill),
        ),
        duration: Duration(milliseconds: 50),
        child: Card(
          color: Colors.white,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(1))),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Scan QR Code to Login :",
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("1 .  Open your application",
                            style: TextStyle(fontSize: 17.5)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("2.  Select Scanner to scan Qr Code",
                            style: TextStyle(fontSize: 17.5))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 66.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(border: Border.all(color: grClr)),
                    child: QrImage(
                      version: QrVersions.auto,
                      data: "20",
                      embeddedImage: AssetImage("assets/Logos/circlelogo.png"),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(40, 40),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
