import 'package:flutter/material.dart';

class MyLogo extends StatelessWidget {
  const MyLogo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Logos/Controlifylogo.png"),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high)),
    );
  }
}
