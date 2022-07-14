import 'package:flutter/material.dart';

class MyEditableText extends StatefulWidget {
  final int index;

  MyEditableText({Key? key, required this.index}) : super(key: key);

  @override
  _MyEditableTextState createState() => _MyEditableTextState();
}

// A custom list tile
class _MyEditableTextState extends State<MyEditableText> {
  // Initalliy make the TextField uneditable.
  bool editable = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: TextField(
              enabled: editable,
              decoration: InputDecoration(
                  //  hintText: "Index ${widget.index}",
                  hintStyle: TextStyle(color: Colors.black)),
              onEditingComplete: () {
                // After editing is complete, make the editable false
                setState(() {
                  editable = !editable;
                });
              },
            ),
          ),
          InkWell(
            child: Icon(Icons.edit),
            onTap: () {
              setState(() {
                editable = !editable;
              });
            },
          )
        ],
      ),
    );
  }
}
