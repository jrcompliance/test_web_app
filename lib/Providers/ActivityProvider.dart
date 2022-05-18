import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:test_web_app/Models/ActivityModels.dart';

class ActivityProvider extends ChangeNotifier {
  List<ActivityModel> _activitymodellist = [];

  List<ActivityModel> get activitymodellist {
    return [..._activitymodellist];
  }

  Future<void> getAllActivitys(id) async {
    FirebaseFirestore _firebase = FirebaseFirestore.instance;
    try {
      var response = await _firebase
          .collection("Tasks")
          .doc(id)
          .collection("Activitys")
          .get();
      List<ActivityModel> loadedData = [];
      response.docs.forEach((element) {
        loadedData.add(ActivityModel(
            action: element['Action'],
            bound: element['Bound'],
            from: element["From"],
            to: element["To"],
            who: element["Who"],
            lastdate: element["LatDate"],
            yes: element["Yes"],
            qdate: element["queryDate"],
            when: element["When"],
            note: element["Note"]));
      });
      _activitymodellist = loadedData;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}

class ActivityProvider1 extends ChangeNotifier {
  List<ActivityModel> _activitymodellist1 = [];

  List<ActivityModel> get activitymodellist1 {
    return [..._activitymodellist1];
  }

  Future<void> getAllActivitys1(id, date1, date2) async {
    FirebaseFirestore _firebase = FirebaseFirestore.instance;
    try {
      var extractedResponse = await _firebase
          .collection("Tasks")
          .doc(id)
          .collection("Activitys")
          .where("queryDate", isGreaterThanOrEqualTo: date1)
          .where("queryDate", isLessThanOrEqualTo: date2)
          .get();

      List<ActivityModel> loadedData = [];
      extractedResponse.docs.forEach((element) {
        print(element.data());
        loadedData.add(ActivityModel(
            action: element['Action'],
            bound: element['Bound'],
            from: element["From"],
            to: element["To"],
            who: element["Who"],
            lastdate: element["LatDate"],
            yes: element["Yes"],
            qdate: element["queryDate"],
            when: element["When"],
            note: element["Note"]));
      });
      _activitymodellist1 = loadedData;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
