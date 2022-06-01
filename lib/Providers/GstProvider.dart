import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class GstProvider with ChangeNotifier {
  //String? doc;
  String? pincode;
  String? pan;
  //String? gstinstatusfetched;
  String? principalplace;
  String? entitytype;
  String? tradename;
  String? registrationtype;
  String? legalname;
  String? dor;
  List? businessnature;
  String? gstinstatus;
  bool isLoading = false;
  String? error;

  Future<void> fetchGstData(gst) async {
    try {
      isLoading = true;
      notifyListeners();
      Future.delayed(Duration(seconds: 1)).then((value) async {
        final Uri = "https://gst-return-status.p.rapidapi.com/gstininfo/$gst";
        // final url = Uri.parse(
        //     "https://gst-return-status.p.rapidapi.com/gstininfo/$gst");
        final response = await Dio().get(Uri,
            options: Options(headers: {
              'content-type': 'application/json',
              'x-rapidapi-host': 'gst-return-status.p.rapidapi.com',
              'x-rapidapi-key':
                  'f70aa109f5msh8225f751728f8ecp1821c0jsn102526b91ea6'
            }));
        // final response = await http.get(url, headers: {
        //   'content-type': 'application/json',
        //   'x-rapidapi-host': 'gst-return-status.p.rapidapi.com',
        //   'x-rapidapi-key': 'f70aa109f5msh8225f751728f8ecp1821c0jsn102526b91ea6'
        // });

        var extractedResponse = response.data;
        print(extractedResponse);
        var myData = extractedResponse["data"]["details"];

        pincode = myData["pincode"];
        pan = myData["pan"];
        //gstinstatusfetched = myData["gstinstatusfetched"];
        principalplace = myData["principalplace"];
        entitytype = myData["entitytype"];
        tradename = myData["tradename"];
        registrationtype = myData["registrationtype"];
        legalname = myData["legalname"];
        dor = myData["dor"];
        businessnature = myData["businessnature"];
        gstinstatus = myData["gstinstatus"];
        isLoading = false;
        //doc = myData["doc"];
        notifyListeners();
      });
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
