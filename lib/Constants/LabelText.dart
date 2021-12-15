import 'package:flutter/material.dart';
import 'package:test_web_app/Constants/reusable.dart';

class LabelText extends StatelessWidget {
  LabelText({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: btnColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$label',
            style: TxtStls.fieldstyle1,
          ),
          Text(
            '$value',
            style: TxtStls.fieldstyle1,
          ),
        ],
      ),
    );
  }
}
