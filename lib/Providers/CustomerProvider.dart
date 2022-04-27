import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Models/CustomerModel.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';

class CustmerProvider extends ChangeNotifier {
  List<CustomerModel> _customerlist = [];
  List<CustomerModel> get customerlist {
    return [..._customerlist];
  }

  Future<void> getCustomers(BuildContext context) async {
    final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
    String? imageUrl =
        Provider.of<UserDataProvider>(context, listen: false).imageUrl;
    String? uid = Provider.of<UserDataProvider>(context, listen: false).uid;
    try {
      var extractedResponse = await _firebasefirestore
          .collection("Tasks")
          .where("Attachments", arrayContainsAny: [
        {
          "image": imageUrl.toString(),
          "uid": uid.toString(),
        }
      ]).get();
      extractedResponse.docs.forEach((element) {
        //print(element.data());
        var mylist = [element.data()];
        final jsonList = mylist.map((item) => jsonEncode(item)).toList();
        final uniqieJsonList = jsonList.toSet().toList();
        final result = uniqieJsonList.map((e) => jsonDecode(e)).toList();
        print(result);
      });
      //final jsonList = extra
      // final mymap = Map();
      // extractedResponse.docs.forEach((element) {
      //   print(element.data());
      //   mymap[element.get("dupmail")] = mymap;
      // });
      // var mymapwithoutDuplicates = mymap.values.toSet().toList();
      // final List<CustomerModel> lodedData = [];
      // extractedResponse.docs.forEach((element) {
      //   print(element["dupmail"]);
      //   lodedData.add(CustomerModel(
      //       Customername: element["CompanyDetails"][0]["contactperson"],
      //       Customeremail: element["CompanyDetails"][0]["email"],
      //       Customerphone: element["CompanyDetails"][0]["phone"],
      //       Idocid: element["id"],
      //       CxID: element["CxID"],
      //       taskname: element["task"],
      //       endDate: element["endDate"],
      //       s: element["success"],
      //       message: element["message"],
      //       startDate: element["startDate"],
      //       status: element["status"],
      //       f: element["fail"],
      //       cat: element["cat"],
      //       leadId: element["LeadId"],
      //       lastseen: element["lastseen"],
      //       priority: element["priority"],
      //       dupmail: element["dupmail"],
      //       assign: element["Attachments"]));
      //
      //   _customerlist = lodedData;
      //   notifyListeners();
      // });

      // List<CustomerModel> lodedData = [];
      //
      // extractedResponse.docs.forEach((element) {
      //   if (element["dupmail"] == element["dupmail"]) {
      //   //  print(element["dupmail"]);
      //   }
      //   lodedData.add(CustomerModel(
      //       Customername: element["CompanyDetails"][0]["contactperson"],
      //       Customeremail: element["CompanyDetails"][0]["email"],
      //       Customerphone: element["CompanyDetails"][0]["phone"],
      //       Idocid: element["id"],
      //       CxID: element["CxID"],
      //       taskname: element["task"],
      //       endDate: element["endDate"],
      //       s: element["success"],
      //       message: element["message"],
      //       startDate: element["startDate"],
      //       status: element["status"],
      //       f: element["fail"],
      //       cat: element["cat"],
      //       leadId: element["LeadId"],
      //       lastseen: element["lastseen"],
      //       priority: element["priority"],
      //       dupmail: element["dupmail"],
      //       assign: element["Attachments"]));
      //   var response = lodedData.remove("CxID");
      //
      //   print(response);
      //   _customerlist = lodedData;

      // });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
