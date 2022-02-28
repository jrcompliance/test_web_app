import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:test_web_app/UserProvider/GstModel.dart';

class GstProvider with ChangeNotifier {
  String? doc;
  String? pincode;
  String? pan;
  String? gstinstatusfetched;
  String? principalplace;
  String? entitytype;
  String? tradename;
  String? registrationtype;
  String? legalname;
  String? dor;
  String? businessnature;
  String? gstinstatus;

  Future<void> fetchGstData(gst) async {
    try {
      final url =
          Uri.parse("https://gst-return-status.p.rapidapi.com/gstininfo/$gst");
      final response = await http.get(url, headers: {
        'content-type': 'application/json',
        'x-rapidapi-host': 'gst-return-status.p.rapidapi.com',
        'x-rapidapi-key': 'f70aa109f5msh8225f751728f8ecp1821c0jsn102526b91ea6'
      });
      var extractedResponse = json.decode(response.body);
      var myData = extractedResponse["data"]["details"];
      doc = myData["doc"];
      pincode = myData["pincode"];
      pan = myData["pan"];
      gstinstatusfetched = myData["gstinstatusfetched"];
      principalplace = myData["principalplace"];
      entitytype = myData["entitytype"];
      tradename = myData["tradename"];
      registrationtype = myData["registrationtype"];
      legalname = myData["legalname"];
      dor = myData["dor"];
      businessnature = myData["businessnature"];
      gstinstatus = myData["gstinstatus"];
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
