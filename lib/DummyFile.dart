import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          api();
        },
        child: Text("Press Here"),
      ),
    );
  }

  void api() async {
    final url = Uri.parse(
        "https://gst-return-status.p.rapidapi.com/gstininfo/07AALFJ0070E1ZO");
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
      'x-rapidapi-host': 'gst-return-status.p.rapidapi.com',
      'x-rapidapi-key': 'f70aa109f5msh8225f751728f8ecp1821c0jsn102526b91ea6'
    });
    //print(response.body);
    var extrcatedData = json.decode(response.body);
    //print(extrcatedData);
    var details = extrcatedData["data"]["details"];
    print(details);
  }
}
