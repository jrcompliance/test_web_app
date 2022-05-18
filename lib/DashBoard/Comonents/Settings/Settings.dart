import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/PdfFiles/CashMemo.dart';
import 'package:test_web_app/PdfFiles/CreditNote.dart';
import 'package:test_web_app/PdfFiles/DeliveryNote.dart';
import 'package:test_web_app/Providers/GenerateCxIDProvider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    print("2222");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Column(children: [
      TextButton(
        child: Text("Generatedelivery"),
        onPressed: () {
          Provider.of<RecentFetchCXIDProvider>(context, listen: false)
              .fetchDeliveryID()
              .whenComplete(() {
            Future.delayed(Duration(seconds: 3)).then((value) {
              var deliveryid =
                  Provider.of<RecentFetchCXIDProvider>(context, listen: false)
                      .deliveryid;
              print("Here is the id $deliveryid");
              DeliveryNote.generatepdf(context, deliveryid);
            });
          });
        },
      ),
      TextButton(
        child: Text("Generatecredit"),
        onPressed: () {
          Provider.of<RecentFetchCXIDProvider>(context, listen: false)
              .fetchcreditID()
              .whenComplete(() {
            Future.delayed(Duration(seconds: 3)).then((value) {
              var creditid =
                  Provider.of<RecentFetchCXIDProvider>(context, listen: false)
                      .creditid;
              print("Here is the id $creditid");
              CreditNote.generatepdf(context, creditid);
            });
          });
        },
      ),
      TextButton(
        child: Text("Generate CashMemo"),
        onPressed: () {
          Provider.of<RecentFetchCXIDProvider>(context, listen: false)
              .fetchCashMemoID()
              .whenComplete(() {
            Future.delayed(Duration(seconds: 3)).then((value) {
              var cashmemoid =
                  Provider.of<RecentFetchCXIDProvider>(context, listen: false)
                      .cashmemoid;
              print("Here is the id $cashmemoid");
              CashMemo.generatepdf(context, cashmemoid);
            });
          });
        },
      ),
      // TextButton(
      //   child: Text("create ids"),
      //   onPressed: () {
      //     fetchDeliveryID();
      //     fetchDebitID();
      //   },
      // ),
    ]));
  }

  String toCapitalize(String input) {
    final List<String> splitStr = input.split(' ');
    for (int i = 0; i < splitStr.length; i++) {
      splitStr[i] =
          '${splitStr[i][0].toUpperCase()}${splitStr[i].substring(1)}';
    }
    final output = splitStr.join(' ');
    return output;
  }

  Future<void> fetchcreditID() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore.collection("GenerateId's").doc("creditID").set({
      "creditid": 0,
    });
  }

  Future<void> fetchDebitID() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore.collection("GenerateId's").doc("DebitID").set({
      "debitid": 0,
    });
  }

  Future<void> fetchDeliveryID() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore.collection("GenerateId's").doc("DeliveryID").set({
      "deliveryid": 0,
    });
  }

  Future<void> fetchCashMemoID() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore.collection("GenerateId's").doc("CashMemoID").set({
      "cashmemoid": 0,
    });
  }
}
