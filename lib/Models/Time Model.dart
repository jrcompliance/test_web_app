import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

myConter(id, DateTime timer) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Tasks");
  collectionReference.doc(id).update({
    "time": timer,
  });
}
