import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/StreamModels/StreamProviderModel.dart';
import 'package:test_web_app/StreamProviders/StreamProvider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    var _list = Provider.of<List<DummyLeadModels>>(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (_, i) {
          return Text(_list[i].task.toString());
        },
      ),
    );
  }
}
