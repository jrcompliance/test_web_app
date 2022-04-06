import 'package:flutter/material.dart';

class MyTestScreen extends StatefulWidget {
  const MyTestScreen({Key? key}) : super(key: key);

  @override
  _MyTestScreenState createState() => _MyTestScreenState();
}

class _MyTestScreenState extends State<MyTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Data"),
      ),
      body: Column(
        children: [
          Text("OffLine Data 1"),
          Text("OffLine Data 2"),
          Text("OffLine Data 3")
        ],
      ),
    );
  }
}
