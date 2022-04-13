import 'package:flutter/material.dart';

class MyLogo extends StatelessWidget {
  const MyLogo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        "assets/Logos/Controlifylogo.png",
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
