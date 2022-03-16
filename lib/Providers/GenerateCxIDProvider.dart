import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class RecentFetchCXIDProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int? CxID;
  Future<void> fetchRecent() async {
    try {
      await _firestore
          .collection("GenerateId's")
          .doc("CxID")
          .update({"CxID": FieldValue.increment(1)}).then((value) async {
        await _firestore
            .collection("GenerateId's")
            .doc("CxID")
            .get()
            .then((value) {
          CxID = value.get("CxID");
          notifyListeners();
        });
      });
      notifyListeners();
    } on Exception catch (e, s) {
      print("${s}" + "${e.toString()}");
    }
  }
}
