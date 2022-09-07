import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/DashBoard/Comonents/Settings/ChatsList.dart';
import 'package:test_web_app/DashBoard/Comonents/Settings/EmployeesList.dart';
import 'package:test_web_app/GoogleSheets/DataFields.dart';
import 'package:test_web_app/GoogleSheets/GSheetsApi.dart';
import 'package:test_web_app/NewModels/ChattingScreen.dart';
import 'package:test_web_app/PdfFiles/CashMemo.dart';
import 'package:test_web_app/PdfFiles/CreditNote.dart';
import 'package:test_web_app/PdfFiles/DeliveryNote.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';
import 'package:test_web_app/Providers/GenerateCxIDProvider.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:test_web_app/Providers/UserProvider.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var data;
  @override
  void initState() {
    fetchServiceID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.93,
      width: size.width,
      child: Row(
        children: [
          Expanded(flex: 3, child: EmployeesList()),
          // Expanded(flex: 7, child: ChatsList()),
        ],
      ),
    );
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

  Future<void> fetchServiceID() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore.collection("GenerateId's").doc("ISIServiceId").set({
      "isiserviceid": 0,
    });
  }

//   Future<void> createExcel() async {
// // Create a new Excel Document.
//     final Workbook workbook = Workbook();
//
// // Accessing sheet via index.
//     final Worksheet sheet = workbook.worksheets[0];
//
// //Initialize the List\<Object>
//
//     final List<Object> list = [
//       'Toatal Income',
//       20000,
//       'On Date',
//       DateTime(2021, 11, 11)
//     ];
//
//     list.add(data);
//
// // Represent the starting row.
//     final int firstRow = 1;
//
// // Represent the starting column.
//     final int firstColumn = 1;
//
// // Represents that the data should be imported vertically.
//     final bool isVertical = true;
//
// //Import the Object list to Sheet
//     sheet.importList(data, firstRow, firstColumn, isVertical);
//
//     sheet.autoFitColumn(1);
//
//     final List<int> bytes = workbook.saveAsStream();
//     workbook.dispose();
//
//     if (kIsWeb) {
//       AnchorElement(
//           href:
//               'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
//         ..setAttribute('download', 'Output.xlsx')
//         ..click();
//     } else {
//       final String path = (await getApplicationSupportDirectory()).path;
//       final String fileName =
//           Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
//       final File file = File(fileName);
//       await file.writeAsBytes(bytes, flush: true);
//       OpenFile.open(fileName);
//     }
//   }
}
//     child: Column(children: [
//   TextButton(
//     child: Text("Generatedelivery"),
//     onPressed: () {
//       Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//           .fetchDeliveryID()
//           .whenComplete(() {
//         Future.delayed(Duration(seconds: 3)).then((value) {
//           var deliveryid =
//               Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//                   .deliveryid;
//           print("Here is the id $deliveryid");
//           DeliveryNote.generatepdf(context, deliveryid);
//         });
//       });
//     },
//   ),
//   TextButton(
//     child: Text("Generatecredit"),
//     onPressed: () {
//       Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//           .fetchcreditID()
//           .whenComplete(() {
//         Future.delayed(Duration(seconds: 3)).then((value) {
//           var creditid =
//               Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//                   .creditid;
//           print("Here is the id $creditid");
//           CreditNote.generatepdf(context, creditid);
//         });
//       });
//     },
//   ),
//   TextButton(
//     child: Text("Generate CashMemo"),
//     onPressed: () {
//       Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//           .fetchCashMemoID()
//           .whenComplete(() {
//         Future.delayed(Duration(seconds: 3)).then((value) {
//           var cashmemoid =
//               Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//                   .cashmemoid;
//           print("Here is the id $cashmemoid");
//           CashMemo.generatepdf(context, cashmemoid);
//         });
//       });
//     },
//   ),
//   TextButton(
//     child: Text("create Xl sheet"),
//     onPressed: () {},
//   ),
// ])
