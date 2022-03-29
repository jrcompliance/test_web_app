import 'package:flutter/material.dart';

class MyClass extends StatefulWidget {
  const MyClass({Key? key}) : super(key: key);

  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {


  void myfunction() {
    List<int> _list = [9, 8, 5, 1, 2, 7,1,2,7];

    for (var i = 0; i<_list.length; i++) {
      for (var j = i+1; j <_list.length; j++) {
        if (_list[i]==_list[j]) {
          print("duplicate numers are ${_list[i]}");

          // print("${_list[i]}is even number");
        } else {
          // print("${_list[i]}is odd number");
        }
      }
    }

  }


    @override
    void initState() {
      myfunction();
      super.initState();
    }
    @override
    Widget build(BuildContext context) {
      return Container(


      );
    }



}
