import 'package:flutter/material.dart';
import 'package:test_web_app/Constants/reusable.dart';

class LabelText extends StatelessWidget {
  LabelText({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      elevation: 20.0,
      child: Container(
        width: 40,
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
      ),
    );
  }
}
