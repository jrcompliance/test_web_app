import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({Key? key, this.mobile, this.tablet, required this.desktop})
      : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width <= 1100;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1100;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, constraints) {
        if (constraints.maxWidth > 1100) {
          return desktop;
        } else if (constraints.maxWidth <= 1100 &&
            constraints.maxWidth >= 800) {
          return tablet ?? desktop;
        } else {
          return mobile ?? desktop;
        }
      },
    );
  }
}
