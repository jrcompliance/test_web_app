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
    final url = Uri.parse("http://myproductsapi.herokuapp.com/products");
    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "Accept"
    });
    print(response.body);
  }
}
