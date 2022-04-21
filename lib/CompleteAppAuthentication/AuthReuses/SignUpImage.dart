import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:flutter/material.dart';

class SigUpImage extends StatelessWidget {
  const SigUpImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 2,
      child: ScaleAnimatedWidget.tween(
        duration: Duration(seconds: 1),
        child: Image.asset(
          "assets/Logos/SignUp.png",
          fit: BoxFit.scaleDown,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
