import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UpdateStatusProvider with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> updatestatus(id, value) async {
    try {
      CollectionReference collectionReference = _firestore.collection("Tasks");
      collectionReference.doc(id).update({"status": value});
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
