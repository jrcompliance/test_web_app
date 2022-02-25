// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:test_web_app/BlockStateManagements/1Models/CovidModel.dart';
//
// class CovidApiRepo {
//   Future<List<CovidModel>> getLatestCovidData() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     final extractedResponse = await firestore.collection("Tasks").get();
//     print("Hey Yalagala This is BLOC Pattern");
//     return (extractedResponse.docs as List)
//         .map((e) => CovidModel.fromJSON(e))
//         .toList();
//   }
// }
