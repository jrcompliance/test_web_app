import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:test_web_app/Constants/reusable.dart';

class MoveDrawer extends StatefulWidget {
  const MoveDrawer({Key? key}) : super(key: key);

  @override
  _MoveDrawerState createState() => _MoveDrawerState();
}

class _MoveDrawerState extends State<MoveDrawer> {
  var radioItem;
  var _choosenValue;
  var _choosenValue1;
  final inbounditems = ["CALL", "EMAIL", "SOCIAL MEDIA"];
  final outbounditems = ["CALL", "EMAIL", "SOCIAL MEDIA", "NO RESPONSE"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
        child: ListView(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: neClr.withOpacity(0.1),
              child: IconButton(
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: neClr,
                  )),
            ),
            SizedBox(width: 5),
            Text("Bytridge Lead", style: TxtStls.fieldstyle),
          ],
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Choose Action Type :",
            style: TxtStls.fieldstyle,
          ),
        ),
        SizedBox(height: 10),
        Container(
          color: bgColor,
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: goodClr,
                ),
                child: Row(
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: bgColor),
                      child: Radio(
                        activeColor: btnColor,
                        value: "InBound",
                        groupValue: radioItem,
                        onChanged: (val) {
                          radioItem = val.toString();
                          setState(() {});
                        },
                        toggleable: true,
                      ),
                    ),
                    Text(
                      "INBOUND",
                      style: TxtStls.fieldstyle1,
                    ),
                  ],
                ),
              ),
              Container(
                color: grClr,
                width: 1,
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: avgClr,
                ),
                child: Row(
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: bgColor),
                      child: Radio(
                        activeColor: btnColor,
                        value: "OutBound",
                        groupValue: radioItem,
                        onChanged: (val) {
                          radioItem = val.toString();
                          setState(() {});
                        },
                        toggleable: true,
                      ),
                    ),
                    Text(
                      "OUTBOUND",
                      style: TxtStls.fieldstyle1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        actions(),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Enter a valid Note :",
            style: TxtStls.fieldstyle,
          ),
        ),
        TextFormField(
          maxLines: 4,
        )
      ],
    ));
  }

  Widget actions() {
    if (radioItem == "InBound") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Choose Action Type',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: inbounditems
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TxtStls.fieldstyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: _choosenValue,
            onChanged: (value) {
              setState(() {
                _choosenValue = value as String;
              });
            },
            iconEnabledColor: txtColor,
            buttonPadding: EdgeInsets.symmetric(horizontal: 15),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: goodClr,
            ),
            itemPadding: const EdgeInsets.symmetric(horizontal: 15),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: goodClr,
            ),
          ),
        ),
      );
    } else if (radioItem == "OutBound") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Choose Action Type',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: outbounditems
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TxtStls.fieldstyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: _choosenValue1,
            onChanged: (value) {
              setState(() {
                _choosenValue1 = value as String;
              });
            },
            buttonPadding: EdgeInsets.symmetric(horizontal: 15),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: avgClr,
            ),
            itemPadding: const EdgeInsets.symmetric(horizontal: 15),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: avgClr,
            ),
          ),
        ),
      );
    }
    return Text("Choose Your Action");
  }
}
