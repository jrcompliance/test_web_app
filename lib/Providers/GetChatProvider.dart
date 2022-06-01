import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Models/ChatModel.dart';

class GetMessagesListProvider extends ChangeNotifier {
  List<ChatModel> _chatmodellist = [];
  List<ChatModel> get chatmodellist {
    return [..._chatmodellist];
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> getMessagesList(peerid) async {
    try {
      CollectionReference _collectionref = _firestore.collection("Chats");
      SharedPreferences pref = await SharedPreferences.getInstance();
      var userid = pref.getString("uid");
      var extractedResponse = await _collectionref
          .doc(userid)
          .collection("messages")
          .where("isTo", isEqualTo: peerid)
          .get();
      List<ChatModel> loadedData = [];
      extractedResponse.docs.forEach((element) {
        loadedData.add(ChatModel(
            type: element["type"],
            isFrom: element["isFrom"],
            isTo: element["isTo"],
            time: element["time"],
            content: element["content"]));
      });
      _chatmodellist = loadedData;
      notifyListeners();
      print(_chatmodellist.toString());
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
