import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
var ntime = DateTime.now().toString().split(" ")[0];

class ProgressUpdsate {
  static movetoanotherCategory(id, cat, activeid, noteController, lastDate,
      radioItem, action, context) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).collection("Activitys").doc().set({
      "From": cat,
      "To": activeid,
      "Who": Provider.of<UserDataProvider>(context, listen: false).username,
      "When": Timestamp.now(),
      "Note": noteController.text.toString(),
      "LatDate": lastDate,
      "Yes": ntime.compareTo(lastDate) <= 0 ? true : false,
      "Bound": radioItem,
      "Action": action,
      "queryDate": DateTime.now().toString().split(" ")[0],
    }, SetOptions(merge: true)).then((value) {
      collectionReference.doc(id).update({
        "cat": activeid,
      });
    });
  }

  static updatesame(
      id, cat, noteController, lastDate, radioItem, action, context) async {
    CollectionReference _collectionReference = _firestore.collection("Tasks");
    _collectionReference.doc(id).collection("Activitys").doc().set({
      "From": cat,
      "To": cat,
      "Who": Provider.of<UserDataProvider>(context, listen: false).username,
      "When": Timestamp.now(),
      "Note": noteController.text.toString(),
      "LatDate": lastDate,
      "Yes": ntime.compareTo(lastDate) <= 0 ? true : false,
      "Bound": radioItem,
      "Action": action,
      "queryDate": DateTime.now().toString().split(" ")[0],
    }, SetOptions(merge: true));
  }
}

class UpdateServices {
  static lastseenUpdate(id) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "lastseen": Timestamp.now(),
    });
  }
}

class StatusUpdateServices {
  Color clr(action) {
    if (action == "CALL") {
      return wonClr;
    } else if (action == "EMAIL") {
      return avgClr;
    } else if (action == "SOCIAL MEDIA") {
      return btnColor;
    } else {
      return clsClr;
    }
  }

  static Color CatColor(cat) {
    if (cat == "PROSPECT") {
      return prosClr;
    } else if (cat == "IN PROGRESS") {
      return ipClr;
    } else if (cat == "WON") {
      return wonClr;
    } else if (cat == "CLOSE") {
      return clsClr;
    } else {
      return neClr;
    }
  }

  // new status update here...
  static updateStatus(id, stat1) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "status": stat1.toString(),
    });
  }

  static statusget(String newsta) {
    if (newsta == "CONTACTED") {
      return "CONTACTED";
    }
    if (newsta == "ASSIGNED") {
      return "ASSIGNED";
    } else {
      return "FRESH";
    }
  }

  static Color statcolorget(String newres) {
    if (newres == "CONTACTED") {
      return conClr;
    } else if (newres == "ASSIGNED") {
      return flwClr;
    } else {
      return wonClr;
    }
  }

  //Status updated here... 2
  static updateStatus1(id, stat2) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "status1": stat2.toString(),
    });
  }

  static statusget1(String prosta) {
    if (prosta == "AVERAGE") {
      return "AVERAGE";
    } else {
      return "GOOD";
    }
  }

  static Color statcolorget1(String prores) {
    if (prores == "AVERAGE") {
      return avgClr;
    } else {
      return goodClr;
    }
  }

  //Status updated here... 3
  static updateStatus2(id, stat3) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "status2": stat3.toString(),
    });
  }

  static statusget2(String insta) {
    if (insta == "QUOTATION") {
      return "QUOTATION";
    }
    if (insta == "SPECIFICATION") {
      return "SPECIFICATION";
    } else {
      return "FOLLOWUP";
    }
  }

  static Color statcolorget2(String inres) {
    if (inres == "QUOTATION") {
      return qtoClr;
    } else if (inres == "SPECIFICATION") {
      return spClr;
    } else {
      return flwClr;
    }
  }

  //Status updated here...5
  static updateStatus4(id, stat4) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "status4": stat4.toString(),
    });
  }

  static statusget4(String wonsta) {
    if (wonsta == "SAMPLES") {
      return "SAMPLES";
    }
    if (wonsta == "DOCUMENTS") {
      return "DOCUMENTS";
    } else {
      return "PAYMENT";
    }
  }

  static Color statcolorget4(String wonres) {
    if (wonres == "SAMPLES") {
      return goodClr;
    } else if (wonres == "DOCUMENTS") {
      return flwClr;
    } else {
      return wonClr;
    }
  }

  //Status updated here...6
  static updateStatus5(id, stat5) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "status": stat5.toString(),
    });
  }

  static statusget5(String clsta) {
    if (clsta == "NO ANSWER") {
      return "NO ANSWER";
    }
    if (clsta == "INFORMATIVE") {
      return "INFORMATIVE";
    }
    if (clsta == "BUDGET ISSUE") {
      return "BUDGET ISSUE";
    } else {
      return "IRRELEVANT";
    }
  }

  static Color statcolorget5(String clres) {
    if (clres == "NO ANSWER") {
      return conClr;
    } else if (clres == "INFORMATIVE") {
      return flwClr;
    } else if (clres == "BUDGET ISSUE") {
      return clsClr;
    } else {
      return irrClr;
    }
  }
}

class FlagService {
  static Color pricolorget(String flagres) {
    if (flagres == "U") {
      return Clrs.urgent;
    } else {
      return Colors.grey;
    }
  }

  static updateFlag(id, prcl) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "priority": prcl.toString(),
    });
  }

  static Color stateClr(String statecolor) {
    if (statecolor == "NEW") {
      return neClr;
    }
    if (statecolor == "PROSPECT") {
      return prosClr;
    }
    if (statecolor == "IN PROGRESS") {
      return ipClr;
    }
    if (statecolor == "WON") {
      return wonClr;
    } else {
      return clsClr;
    }
  }

  static Color stateClr1(String statecolor1) {
    if (statecolor1 == "NEW") {
      return neClr;
    }
    if (statecolor1 == "PROSPECT") {
      return prosClr;
    }
    if (statecolor1 == "IN PROGRESS") {
      return ipClr;
    }
    if (statecolor1 == "WON") {
      return wonClr;
    } else {
      return clsClr;
    }
  }
}

class EndDateOperations {
  static updateEdateTask(id, TextEditingController _endDateController) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "endDate": _endDateController.text.toString() == null
          ? DateTime.now().toString().split(" ")[0]
          : _endDateController.text.toString(),
    });
  }

  static updateEdateTask1(id) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "endDate": '',
    });
  }
}

class CrudOperations {
  // static Future<void> fetchmostrecent() async {
  //   _firestore
  //       .collection("Tasks")
  //       .orderBy("startDate", descending: true)
  //       .snapshots()
  //       .listen((event) {
  //     var obj = event.docs.first.get("CxID");
  //     var storevalue = obj + 1;
  //     return storevalue;
  //   });
  // }

  static uploadTask(
    _taskController,
    _endDateController,
    _nameController,
    _emailController,
    _phoneController,
    _messageController,
    uid,
    image,
  ) async {
    try {
      print("Hey Yalagala your request is under process please wait");
      CollectionReference collectionReference =
          await _firestore.collection("Tasks");
      String did = collectionReference.doc().id;
      collectionReference.doc(did).set({
        "time": Timestamp.now(),
        "flag": false,
        // "CxID": RecentFetchCXIDProvider.CxID == null
        //     ? 100
        //     : RecentFetchCXIDProvider.CxID,
        "id": did,
        "task": _taskController.text.toString(),
        "startDate": Timestamp.fromDate(DateTime.now()),
        "qDate": DateTime.now().toString().split(" ")[0],
        "endDate": _endDateController.text.toString(),
        "message": _messageController.text.toString(),
        "priority": "E",
        "cat": "NEW",
        "status": "FRESH",
        "status1": "AVERAGE",
        "status2": "FOLLOWUP",
        "status4": "PAYMENT",
        "status5": "IRRELEVANT",
        "Attachments": [
          {"uid": uid, "image": image}
        ],
        "Attachments1": [],
        "companyname": "",
        "logo": "",
        "website": "",
        "fail": 0,
        "success": 0,
        "CompanyDetails": [
          {
            "contactperson": _nameController.text.toString(),
            "email": _emailController.text.toString(),
            "phone": _phoneController.text.toString(),
          }
        ],
        "lastseen": Timestamp.now(),
        "Certificates": [],
      }).then((value) {
        _taskController.clear();
        _endDateController.clear();
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static deleteTask(id) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).delete();
  }

  static stoptimer(id) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "time": DateTime.now(),
    });
  }

  static certificateUpdate(id, certifi) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "Certificates": FieldValue.arrayUnion([certifi.toString()])
    }).then((value) {
      certifi.clear();
    });
  }

  static deleteCertifcate(id, String element) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "Certificates": FieldValue.arrayRemove([element])
    });
  }
}

// class StateUpdateServices {
//   static prosUpdate(
//       id, String category, note, lastDate, radioItem, action, context) async {
//     CollectionReference collectionReference = _firestore.collection("Tasks");
//     collectionReference.doc(id).update({
//       "Activity": FieldValue.arrayUnion([
//         {
//           "From": category,
//           "To": "PROSPECT",
//           "Who": Provider.of<UserDataProvider>(context, listen: false).username,
//           "When": Timestamp.now(),
//           "Note": note.text.toString(),
//           "LatDate": lastDate,
//           "Yes": ntime.compareTo(lastDate) <= 0 ? true : false,
//           "Bound": radioItem,
//           "Action": action,
//         }
//       ])
//     }).then((value) {
//       note.clear();
//     });
//   }
//
//   static InprosUpdate(
//       id, String category, note, lastDate, radioItem, action, context) async {
//     CollectionReference collectionReference = _firestore.collection("Tasks");
//     collectionReference.doc(id).update({
//       "Activity": FieldValue.arrayUnion([
//         {
//           "From": category,
//           "To": "IN PROGRESS",
//           "Who": Provider.of<UserDataProvider>(context, listen: false).username,
//           "When": Timestamp.now(),
//           "Note": note.text.toString(),
//           "LatDate": lastDate,
//           "Yes": ntime.compareTo(lastDate) <= 0 ? true : false,
//           "Bound": radioItem,
//           "Action": action,
//         }
//       ])
//     }).then((value) {
//       note.clear();
//     });
//   }
//
//   static wonUpdate(
//       id, String category, note, lastDate, radioItem, action, context) async {
//     CollectionReference collectionReference = _firestore.collection("Tasks");
//     collectionReference.doc(id).update({
//       "Activity": FieldValue.arrayUnion([
//         {
//           "From": category,
//           "To": "WON",
//           "Who": Provider.of<UserDataProvider>(context, listen: false).username,
//           "When": Timestamp.now(),
//           "Note": note.text.toString(),
//           "LatDate": lastDate,
//           "Yes": ntime.compareTo(lastDate) <= 0 ? true : false,
//           "Bound": radioItem,
//           "Action": action,
//         }
//       ])
//     }).then((value) {
//       note.clear();
//     });
//   }
//
//   static closeUpdate(
//       id, String category, note, lastDate, radioItem, action, context) async {
//     CollectionReference collectionReference = _firestore.collection("Tasks");
//
//     collectionReference.doc(id).update({
//       "Activity": FieldValue.arrayUnion([
//         {
//           "From": category,
//           "To": "CLOSE",
//           "Who": Provider.of<UserDataProvider>(context, listen: false).username,
//           "When": Timestamp.now(),
//           "Note": note.text.toString(),
//           "LatDate": lastDate,
//           "Yes": ntime.compareTo(lastDate) <= 0 ? true : false,
//           "Bound": radioItem,
//           "Action": action,
//         }
//       ])
//     }).then((value) {
//       note.clear();
//     });
//   }
// }

class ComapnyUpdateServices {
  static updateCompany(id, cl1, cl5) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "companyname": cl1.text.toString(),
      "website": cl5.text.toString(),
      "logo": "https://www.google.com/s2/favicons?sz=64&domain_url=" +
          cl5.text.toString(),
    }).then((value) {
      cl1.clear();
      cl5.clear();
    });
  }

  static addMoreContacts(id, cl2, cl3, cl4) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "CompanyDetails": FieldValue.arrayUnion([
        {
          "contactperson": cl2.text.toString(),
          "email": cl3.text.toString(),
          "phone": cl4.text.toString(),
        }
      ])
    }).then((value) {
      cl2.clear();
      cl3.clear();
      cl4.clear();
    });
  }

  static removeContact(id, element) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "CompanyDetails": FieldValue.arrayRemove([element])
    });
  }
}

class GraphValueServices {
  static update(id, value) async {
    CollectionReference collectioReference = _firestore.collection("Tasks");
    await collectioReference.doc(id).update({
      "flag": value,
    });
  }

  static success(id) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    await collectionReference.doc(id).update({
      "success": FieldValue.increment(1),
    });
  }

  static fail(id) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "fail": FieldValue.increment(1),
    });
  }

  static noAnswer(id) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "noAnswer": FieldValue.increment(1),
    });
  }

  static clientDemand(id) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "ocd": FieldValue.increment(1),
    });
  }

  static graph(endDate, id) {
    var ntime = DateTime.now().toString().split(" ")[0];
    if (ntime.compareTo(endDate) <= 0) {
      success(id);
    } else {
      fail(id);
    }
  }
}

class AssignServices {
  static assign(id, uid, image) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "Attachments": FieldValue.arrayUnion([
        {"uid": uid, "image": image}
      ]),
    });
  }

  static remove(id, e) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({
      "Attachments": FieldValue.arrayRemove([e]),
    });
  }
}

class disable {
  static off(id, addtime) async {
    CollectionReference collectionReference = _firestore.collection("Tasks");
    collectionReference.doc(id).update({"time": addtime});
  }
}
