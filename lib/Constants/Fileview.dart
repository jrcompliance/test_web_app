import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:test_web_app/Constants/reusable.dart';

fileview1(BuildContext context, name, url) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  var alertDialog = AlertDialog(
    contentPadding: EdgeInsets.all(0.0),
    actionsPadding: EdgeInsets.all(0),
    titlePadding: EdgeInsets.all(0),
    insetPadding: EdgeInsets.all(0),
    buttonPadding: EdgeInsets.all(0),
    backgroundColor: txtColor,
    title: Container(
      width: width * 0.4,
      color: Colors.grey[350],
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TxtStls.stl122,
          ),
          IconButton(
            tooltip: "Close Window",
            icon: Icon(Icons.cancel_presentation),
            color: Colors.pink[400],
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    ),
    content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: width * 0.4,
          height: height * 0.6,
          color: txtColor,
          child: SfPdfViewer.network(
            url,
            enableDoubleTapZooming: true,
          ),
        );
      },
    ),
  );
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return alertDialog;
      });
}
