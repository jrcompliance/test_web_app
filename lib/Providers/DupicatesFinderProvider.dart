import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DuplicatesFinderProvider extends ChangeNotifier {
  List<DupliacetModel> _duplicatelist = [];
  List<DupliacetModel> get duplicatelist {
    return [..._duplicatelist];
  }

  Future<void> dupicates() async {
    try {
      FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
      QuerySnapshot extractedResponse =
          await _firebasefirestore.collection("Tasks").get();
      List<DupliacetModel> lodedData = [];
      extractedResponse.docs.forEach((element) {
        lodedData.add(DupliacetModel(
          email: element["CompanyDetails"][0]["email"],
        ));
        _duplicatelist = lodedData;

        notifyListeners();
        print(_duplicatelist.length);
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}

class DupliacetModel {
  String? email;
  DupliacetModel({this.email});
}
