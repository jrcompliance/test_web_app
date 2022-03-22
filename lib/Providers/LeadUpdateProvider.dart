import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:test_web_app/Models/LeadUpdateModel.dart';
import 'package:test_web_app/Models/MoveModel.dart';

class LeadUpdateProvider with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var ntime = DateTime.now().toString().split(" ")[0];
  Future<void> updateLead(cat, who, noteController, lastDate, radioItem, action,
      id, key, activeid, uenddate, timer, status) async {
    try {
      LeadUpdateModel leadUpdateModel = LeadUpdateModel();
      leadUpdateModel.From = cat;
      leadUpdateModel.To = key == "move" ? activeid : cat;
      leadUpdateModel.Who = who;
      leadUpdateModel.When = Timestamp.now();
      leadUpdateModel.Note = noteController;
      leadUpdateModel.LatDate = lastDate;
      leadUpdateModel.Yes = ntime.compareTo(lastDate) <= 0 ? true : false;
      leadUpdateModel.Bound = radioItem;
      leadUpdateModel.Action = action;
      leadUpdateModel.queryDate = DateTime.now().toString().split(" ")[0];
      CollectionReference _collectionReference = _firestore.collection("Tasks");
      await _collectionReference
          .doc(id)
          .collection("Activitys")
          .doc()
          .set(leadUpdateModel.toMap())
          .then((value) {
        _collectionReference.doc(id).update({
          "cat": key == "move" ? activeid : cat,
          "endDate": uenddate,
          "time": timer,
          "status": key == "move" ? valupdate(activeid) : status,
        });
      });
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  valupdate(activeid) {
    switch (activeid) {
      case "PROSPECT":
        {
          return "GOOD";
        }
      case "IN PROGRESS":
        {
          return "FOLLOWUP";
        }
      case "WON":
        {
          return "PAYMENT";
        }
      case "CLOSE":
        {
          return "IRRELEVENT";
        }
      default:
        {
          return "FRESH";
        }
    }
  }
}
