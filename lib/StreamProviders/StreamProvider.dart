import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_web_app/StreamModels/StreamProviderModel.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DummyLeadModels>> get books {
    return _firestore.collection("Tasks").snapshots().map((event) => event.docs
        .map((DocumentSnapshot documentSnapshot) =>
            DummyLeadModels(task: documentSnapshot.get("task")))
        .toList());
  }
}
