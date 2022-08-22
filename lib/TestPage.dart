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
                flex: isExpanded ? 6 : 2,
                child: Container(
                    color: Colors.pink,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ExpandablePanel(
                          collapsed: ExpandableButton(
                            child: Text("eiughiur"),
                          ),
                          expanded: Column(
                            children: [
                              Row(
                                children: [
                                  Text("gsuyfhewiuf"),
                                  Text("gsuyfhewiuf"),
                                  Text("gsuyfhewiuf"),
                                  Text("gsuyfhewiuf"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("gsuyfhewiuf"),
                                  Text("gsuyfhewiuf"),
                                  Text("gsuyfhewiuf"),
                                  Text("gsuyfhewiuf"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("gsuyfhewiuf"),
                                  Text("gsuyfhewiuf"),
                                  Text("gsuyfhewiuf"),
                                  Text("gsuyfhewiuf"),
                                ],
                              ),
                              ExpandableButton(
                                child: Text('back'),
                              )
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () {}, child: Text("uifhawiufhweu")),
                      ],
                    ))),
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
