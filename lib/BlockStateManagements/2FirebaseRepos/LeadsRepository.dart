import 'package:cloud_firestore/cloud_firestore.dart';

class ShowLeadsRepo {
  Future<QuerySnapshot<Map<String, dynamic>>> showLeads() async {
    FirebaseFirestore _firebase = FirebaseFirestore.instance;
    var extractedResponse = await _firebase.collection("Tasks").get();
    return extractedResponse;
  }
}
