import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';

class EmergencyTaskProvider extends ChangeNotifier {
  List<EmergencyTaskModel> _emergencyModellist = [];

  List<EmergencyTaskModel> get emergencylist {
    return [..._emergencyModellist];
  }

  Future<void> fetchEmergencyTasks(BuildContext context, duedate) async {
    final FirebaseFirestore _firebase = FirebaseFirestore.instance;
    String? imageUrl =
        Provider.of<UserDataProvider>(context, listen: false).imageUrl;
    String? uid = Provider.of<UserDataProvider>(context, listen: false).uid;
    try {
      var response = await _firebase
          .collection("Tasks")
          .where("endDate", isEqualTo: duedate)
          .where("Attachments", arrayContainsAny: [
        {
          "image": imageUrl,
          "uid": uid,
        }
      ]).get();

      List<EmergencyTaskModel> loadedData = [];

      response.docs.forEach((element) {
        loadedData.add(EmergencyTaskModel(
          logo: element["logo"],
          email: element["CompanyDetails"][0]["email"],
          taskname: element["task"],
        ));
        _emergencyModellist = loadedData;
        notifyListeners();
        print(_emergencyModellist.toString());
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}

class EmergencyTaskModel {
  String? taskname;
  String? email;
  String? logo;

  EmergencyTaskModel({this.taskname, this.email, this.logo});
}
