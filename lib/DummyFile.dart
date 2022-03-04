import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewHome extends StatefulWidget {
  const NewHome({Key? key}) : super(key: key);

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  TextEditingController xcontroller = TextEditingController();
  TextEditingController ycontroller = TextEditingController();
  List? data = [];
  String? value;
  String? x;
  String? date;
  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getarrayLength();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        IconButton(
            onPressed: () {
              // Invoices();
              getData();
              getting();
            },
            icon: Icon(Icons.add)),
        Container(
          width: 100,
          //  MediaQuery.of(context).size.width*.05,
          child: TextFormField(
            controller: xcontroller,
            decoration: InputDecoration(fillColor: Colors.red),
          ),
        ),
        Container(
          width: 100,
          //  MediaQuery.of(context).size.width*.05,
          child: TextFormField(
            controller: ycontroller,
            decoration: InputDecoration(fillColor: Colors.pink),
          ),
        ),
        Text(value == null ? "" : value! + xcontroller.text.toString())
      ]),
    );
  }

  void Invoices() async {
    CollectionReference _references = await _firebase.collection("InvoiceID");
    _references.doc().set({"id": []});
  }

  void getData() async {
    CollectionReference _references = await _firebase.collection("InvoiceID");
    _references.doc('2dtDd787PkHNjpFag0H5').update({
      "id": FieldValue.arrayUnion([000002]),
    });
  }

  void getting() async {
    CollectionReference _references = await _firebase.collection("InvoiceID");
    _references.doc('2dtDd787PkHNjpFag0H5').get().then((value) {
      setState(() {});
    });
  }

  void add() async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    String id = 'TkwQ8Ucg49eJmbgmxTHOoSciN183';
    firebase.collection('EmployeeData').doc(id).set({
      "TCPB": true,
      "add": 'Telangana,India ',
      "bgroup": 'O+',
      "doj": DateTime.now().toString().split(' ')[0],
      "econtact": '9876543210',
      "gender": 'male',
      "password": 'Srinivas@12',
      "udesignation": 'flutter dev',
      "uemail": 'yskyadav03@gmsil.com',
      "uimage":
          'data:image/jpeg;base64,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',
      "uname": 'Srinivas',
      "uphonenumber": '1234567890',
      "urole": 'Employee',
      "uid": id,
    });
  }

  void update() {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    CollectionReference ref = firebase.collection('EmployeeData');
    String id = 'TkwQ8Ucg49eJmbgmxTHOoSciN183';
    ref.doc(id).update({
      "uname": 'Devanand',
    });
  }

  void delete() {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    String id = 'TkwQ8Ucg49eJmbgmxTHOoSciN183';
    CollectionReference ref = firebase.collection('EmployeeData');
    ref.doc(id).delete();
  }

  void newset() async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    CollectionReference ref = firebase.collection('testing');
    String id = ref.doc().id;
    await firebase.collection('testing').doc(id).set({
      "id": id,
      "studentname": 'chandra',
      "age": 21,
      "address": 'telangana,India',
      "gender": 'male',
      "pincode": '521122',
    });
  }

  void getarrayLength() async {
    await _firebase
        .collection("InvoiceID")
        .doc("2dtDd787PkHNjpFag0H5")
        .get()
        .then((value) {
      setState(() {
        var list = List.from(value.data()!["id"]);
        String lastvalue = list.elementAt(list.length - 1);
        //   print("lastvalue is : " + lastvalue);
        updatearray(lastvalue);
      });
    });
  }

  updatearray(String lastvalue) async {
    var month = DateFormat("MM").format(DateTime.now());
    var year = DateFormat("yy").format(DateTime.now());

    int mymonth = int.parse(month);
    int myyear = int.parse(year);
    int acyear = myyear;
    int acyear1 = myyear;
    if (mymonth <= 3) {
      setState(() {
        acyear = myyear - 1;
      });
    } else {
      setState(() {
        acyear1 = myyear + 1;
      });
    }
    show() {
      if (mymonth <= 9) {
        return 0;
      } else {
        return null;
      }
    }

    String val = lastvalue.substring(6);
    //  print("pad value is : "+val);
    int addval = int.parse(val) + 1;
    // print("Added value is : " + addval.toString());
    String storeval = show().toString() +
        mymonth.toString() +
        acyear.toString() +
        acyear1.toString() +
        addval.toString();
    // print(storeval);
    await _firebase.collection("InvoiceID").doc("2dtDd787PkHNjpFag0H5").update({
      "id": FieldValue.arrayUnion([storeval]),
    });
  }
}
