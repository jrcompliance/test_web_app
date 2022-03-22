import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class RemoveServiceProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> removeService(id, e) async {
    try {
      CollectionReference collectionReference = _firestore.collection("Tasks");
      await collectionReference.doc(id).update({
        "Certificates": FieldValue.arrayRemove([e])
      });
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
