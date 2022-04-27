import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DuplicatesFinderProvider extends ChangeNotifier {
  List<DuplicateModel> _duplicatelist = [];
  List<DuplicateModel> get duplicatelist {
    return [..._duplicatelist];
  }

  Future<void> dupicates() async {
    try {
      FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
      QuerySnapshot extractedResponse =
          await _firebasefirestore.collection("Tasks").get();
      List<DuplicateModel> lodedData = [];
      extractedResponse.docs.forEach((element) {
        lodedData
            .add(DuplicateModel(email: element["CompanyDetails"][0]["email"]));
        print(lodedData.toSet().toList());
        _duplicatelist = lodedData;
        notifyListeners();
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}

class DuplicateModel {
  String? email;
  DuplicateModel({this.email});
}
