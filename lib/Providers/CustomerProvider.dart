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
      List<CustomerModel> loadedData = [];

      extractedResponse.docs.forEach((element) {
        loadedData.add(CustomerModel(
            Customername: element["CompanyDetails"][0]["contactperson"],
            Customeremail: element["CompanyDetails"][0]["email"],
            Customerphone: element["CompanyDetails"][0]["phone"],
            Idocid: element["id"],
            CxID: element["CxID"],
            taskname: element["task"],
            endDate: element["endDate"],
            s: element["success"],
            message: element["message"],
            //startDate: element["startDate"],
            status: element["status"],
            f: element["fail"],
            cat: element["cat"],
            leadId: element["LeadId"],
            //lastseen: element["lastseen"],
            priority: element["priority"],
            dupmail: element["dupmail"],
            assign: element["Attachments"]));
        var set = <String>{};
        List<CustomerModel> duplicateName =
            loadedData.where((e) => set.add(e.dupmail)).toList();
        _customerlist = duplicateName;
        notifyListeners();
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}

//  List<CustomerModel> removeDuplicates(List<CustomerModel> loadedData) {
//     List<CustomerModel> distinct;
//     List<CustomerModel> dummy = loadedData;
//
//     for (int i = 0; i < loadedData.length; i++) {
//       for (int j = 1; j < dummy.length; j++) {
//         if (dummy[i].CxID == loadedData[j].CxID) {
//           dummy.removeAt(j);
//         }
//       }
//     }
//     distinct = dummy;
//     return distinct;
//   }
