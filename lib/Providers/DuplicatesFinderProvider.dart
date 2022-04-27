import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DuplicatesFinderProvider extends ChangeNotifier {
  var existingCutomerid;
  Future<void> findduplicates(entertext) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("Tasks")
        .where("dupmail", isEqualTo: entertext)
        .get()
        .then((value) {
      print(value.docs);
      value.docs.forEach((element) {
        existingCutomerid = element.get("CxID");
        notifyListeners();
      });
    });

    // print(snapshot);
    //
    // snapshot.docs.forEach((element) {
    //   var email = element["CompanyDetails"]["email"];
    //   var cusid = element["CxID"];
    //   print('####' + cusid + email.toString());
    // });
    // snapshot.docs.forEach((element) {
    //   var dd = element["CompanyDetails"][0]["email"];
    //   emaillist = dd.split(",");
    //   print('2222--' + emaillist.toString());
    // });
  }
}
