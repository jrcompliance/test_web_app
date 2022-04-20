import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AddServiceProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addService(id, certifi) async {
    try {
      CollectionReference collectionReference = _firestore.collection("Tasks");
      await collectionReference.doc(id).update({
        "Certificates": FieldValue.arrayUnion([certifi.toString()])
      });
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
