import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DuplicatesFinderProvider extends ChangeNotifier {
  bool isLoading = false;
  var existingCutomerid;
  Future<void> findduplicates(entertext) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      isLoading = true;
      notifyListeners();
      await firestore
          .collection("Tasks")
          .where("dupmail", isEqualTo: entertext)
          .get()
          .then((value) {
        print(value.docs);
        value.docs.forEach((element) {
          existingCutomerid = element.get("CxID");
          isLoading = false;

          notifyListeners();
        });
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
