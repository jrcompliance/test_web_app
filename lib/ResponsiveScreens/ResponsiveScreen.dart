import 'package:flutter/material.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/reusable.dart';

class TestHomeScreen extends StatefulWidget {
  const TestHomeScreen({Key? key}) : super(key: key);

  @override
  _TestHomeScreenState createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<TestHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: grClr)),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                    child: Row(
                      children: [
                        Text("S.No"),
                        VerticalDivider(color: grClr),
                        Text("Service Description"),
                        VerticalDivider(color: grClr),
                        Text("SAC/HSN"),
                        VerticalDivider(color: grClr),
                        Text("Qty"),
                        VerticalDivider(color: grClr),
                        Text("Rate"),
                        VerticalDivider(color: grClr),
                        Text("Amount")
                      ],
                    ),
                  ),
                  Divider(
                    color: grClr,
                  ),
                  Row(
                    children: [
                      Text("S.No"),
                      VerticalDivider(color: grClr),
                      Text("Service Description"),
                      VerticalDivider(color: grClr),
                      Text("SAC/HSN"),
                      VerticalDivider(color: grClr),
                      Text("Qty"),
                      VerticalDivider(color: grClr),
                      Text("Rate"),
                      VerticalDivider(color: grClr),
                      Text("Amount")
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text("jgjjk"),
          ),
          Expanded(
            flex: 1,
            child: Text("jgjjk"),
          ),
        ],
      ),
    );
  }
}
