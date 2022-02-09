import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:test_web_app/Constants/reusable.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilla Shehsu Kosam"),
      ),
      body: Column(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Expanded(
                child: Text(
                  'Choose Option',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              items: _dropdownItems
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
              ),
              itemPadding: const EdgeInsets.symmetric(horizontal: 15),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: bgColor,
              ),
            ),
          ),
          showMyWidget(),
        ],
      ),
    );
  }

  List _dropdownItems = [
    "Srinivas",
    "Sheshu",
    "Rajeev",
    "Hemanth",
  ];
  var _choosenValue;
  List _yalalist = ["Developer", "Designer", "Balck & Tall"];
  List _sheshulist = ["Developer", "Designer", "white & mediym"];
  List _rajeevlist = [
    "Pega Developer",
    "Designer",
    "Balck & Tall",
    "Digital Markater"
  ];
  List _hemathlist = ["FullStackDeveloper", "Designer", "Balck & short"];
  Widget drop1() {
    return Wrap(
      children: _yalalist
          .map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(e),
                  color: btnColor,
                ),
              ))
          .toList(),
    );
  }

  Widget drop2() {
    return Wrap(
      children: _sheshulist
          .map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(e),
                  color: grClr,
                ),
              ))
          .toList(),
    );
  }

  Widget drop3() {
    return Wrap(
      children: _rajeevlist
          .map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(e),
                  color: goodClr,
                ),
              ))
          .toList(),
    );
  }

  Widget drop4() {
    return Wrap(
      children: _hemathlist
          .map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(e),
                  color: wonClr,
                ),
              ))
          .toList(),
    );
  }

  showMyWidget() {
    switch (_choosenValue) {
      case "Srinivas":
        return drop1();

        break;
      case "Sheshu":
        return drop2();

        break;
      case "Rajeev":
        return drop3();

        break;
      case "Hemanth":
        return drop4();
        break;
      default:
        return Text("Choose data");
        break;
    }
  }
}
