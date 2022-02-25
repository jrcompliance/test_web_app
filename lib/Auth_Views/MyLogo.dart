import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_web_app/Auth_Views/Url_launchers.dart';
import 'package:test_web_app/Constants/reusable.dart';

class MyLogo extends StatelessWidget {
  const MyLogo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 400,
          height: 130,
          alignment: Alignment.center,
          child: Image.asset(
            "assets/Logos/Controlifylogo.png",
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
        ),
        Container(
          width: 440,
          height: 110,
          alignment: Alignment.bottomCenter,
          child: RichText(
            text: TextSpan(
                text: "Conceptualized By",
                style: TxtStls.fieldtitlestyle1,
                children: <TextSpan>[
                  TextSpan(
                      text: " JR Compliance",
                      style: TxtStls.fieldtitlestyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launches.launchJr();
                        })
                ]),
          ),
        )
      ],
    );
  }
}
