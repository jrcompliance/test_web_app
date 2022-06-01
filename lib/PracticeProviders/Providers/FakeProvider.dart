// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:test_web_app/PracticeProviders/Models/FakeModels.dart';
//
// class FakeProvider extends ChangeNotifier {
//   List<FakeModels> _fakemodellist = [];
//   List<FakeModels> get fakemodellist {
//     return [..._fakemodellist];
//   }
//
//   Future getData() async {
//     var url = Uri.parse("https://postmylead.herokuapp.com/get");
//     var response = await http.get(url);
//     var convertedData = json.decode(response.body);
//     print(convertedData);
//     List<FakeModels> _list = [];
//     convertedData.forEach((data) {
//       _list.add(FakeModels(
//         id: data["id"],
//         title: data["task"],
//         body: data["message"],
//       ));
//       _fakemodellist = _list;
//       notifyListeners();
//     });
//   }
// }
