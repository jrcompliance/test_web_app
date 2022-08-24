import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                    color: Colors.pink,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(children: [
                          TextButton(
                              onHover: (bool value) {
                                setState(() {
                                  value
                                      ? isExpanded == true
                                      : isExpanded == false;
                                });
                              },
                              onPressed: () {},
                              child: Text("hover")),
                          // Expanded(child: SizedBox()),
                          // Expanded(child: SizedBox()),
                          // Expanded(child: SizedBox()),
                          // Expanded(child: Text('huyghguiwehgiu'))
                        ]),
                        Stack(children: [
                          TextButton(
                              onPressed: () {}, child: Text("uifhawiufhweu")),
                        ]),
                      ],
                    ))),
            isExpanded
                ? const Positioned(
                    bottom: 50.0,
                    left: 50.0,
                    child: Expanded(child: const Text('huyghguiwehgiu')))
                : const SizedBox(),
            Expanded(
                flex: 8,
                child: Container(
                    color: Colors.purple,
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {}, child: Text("uifhawiufhweu")),
                        TextButton(
                            onPressed: () {}, child: Text("uifhawiufhweu")),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
