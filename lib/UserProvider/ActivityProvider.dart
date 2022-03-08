import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:test_web_app/Models/ActivityModels.dart';

class ActivityProvider extends ChangeNotifier {
  List<ActivityModel> _activitymodellist = [];

  List<ActivityModel> get activitymodellist {
    return [..._activitymodellist];
  }

  Future<void> getAllActivitys(did) async {
    FirebaseFirestore _firebase = FirebaseFirestore.instance;
    QuerySnapshot extractedResponse = await _firebase
        .collection("Tasks")
        .doc(did)
        .collection("Activitys")
        .orderBy("When", descending: true)
        .get();
    List<ActivityModel> loadedData = [];
    return extractedResponse.docs.forEach((element) {
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
      _activitymodellist = loadedData;
      notifyListeners();
    });
  }
}

class ActivityProvider1 extends ChangeNotifier {
  List<ActivityModel> _activitymodellist1 = [];

  List<ActivityModel> get activitymodellist1 {
    return [..._activitymodellist1];
  }

  Future<void> getAllActivitys1(did, date1, date2) async {
    FirebaseFirestore _firebase = FirebaseFirestore.instance;
    QuerySnapshot extractedResponse = await _firebase
        .collection("Tasks")
        .doc(did)
        .collection("Activitys")
        .where("queryDate", isGreaterThanOrEqualTo: date1)
        .where("queryDate", isLessThanOrEqualTo: date2)
        .get();

    List<ActivityModel> loadedData = [];
    return extractedResponse.docs.forEach((element) {
      //print(element.data());
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
      _activitymodellist1 = loadedData;
      notifyListeners();
    });
  }
}
