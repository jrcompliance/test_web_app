import 'package:flutter/material.dart';

class MySpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * 0.01);
  }
}
