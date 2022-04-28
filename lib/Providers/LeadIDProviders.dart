import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LeadIdProviders extends ChangeNotifier {
  List _leadidslist = [];
  List get leadidslist {
    return [..._leadidslist];
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future getLeadIds(selectedCxid) async {
    var response = await _firestore
        .collection("Tasks")
        .where("CxID", isEqualTo: selectedCxid)
        .get();
    List myLeadids = [];
    response.docs.forEach((element) {
      myLeadids.add(element.data()["LeadId"].toString());
    });
    print(myLeadids);
    _leadidslist = myLeadids;
    notifyListeners();
  }
}
