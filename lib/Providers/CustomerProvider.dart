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
      List<CustomerModel> lodedData = [];
      extractedResponse.docs.forEach((element) {
        lodedData.add(CustomerModel(
            Customername: element["CompanyDetails"][0]["contactperson"],
            Customeremail: element["CompanyDetails"][0]["email"],
            Customerphone: element["CompanyDetails"][0]["phone"],
            Idocid: element["id"],
            CxID: element["CxID"],
            taskname: element["task"],
            endDate: element["endDate"],
            s: element["success"],
            message: element["message"],
            startDate: element["startDate"],
            status: element["status"],
            f: element["fail"],
            cat: element["cat"],
            lastseen: element["lastseen"],
            priority: element["priority"],
            assign: element["Attachments"]));
        _customerlist = lodedData;
        notifyListeners();
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
