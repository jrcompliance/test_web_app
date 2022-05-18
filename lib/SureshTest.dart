import 'package:flutter/material.dart';

class SureshTestScreen extends StatefulWidget {
  const SureshTestScreen({Key? key}) : super(key: key);

  @override
  _SureshTestScreenState createState() => _SureshTestScreenState();
}

class _SureshTestScreenState extends State<SureshTestScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width * 1,
        height: size.height * 1,
        child: Column(
          children: [
            Table(
              children: [
                TableRow(children: [
                  Text("S.No"),
                  Text("S.No"),
                  Text("S.No"),
                  Text("S.No"),
                ]),
              ],
            ),
            Expanded(
              child: Table(
                children: [
                  for (int i = 0; i <= 10; i++)
                    TableRow(children: [
                      Text("Ram"),
                      Text("Ram S.No"),
                      Text("S.Ram No"),
                      Text("S.No Ram"),
                    ]),
                ],
              ),
            ),
            Text("dahghkgjg")
          ],
        ),
      ),
    );
  }
}
