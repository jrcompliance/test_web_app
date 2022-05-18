import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class CashMemo {
  static var total = 5000;

  static var gstAmount = 900;

  static generatepdf(BuildContext context, cashmemoid) async {
    Size size = MediaQuery.of(context).size;
    String? myUrl;
    int amount = 5900;
    String ruppesinWords = NumberToWord().convert('en-in', amount);
    final image =
        (await rootBundle.load("assets/Logos/jrlogo.png")).buffer.asUint8List();
    final signImage =
        (await rootBundle.load("assets/Images/Authorized_Sign.png"))
            .buffer
            .asUint8List();
    final textStl10 =
        pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold);
    final textStl8 = pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold);
    final textStl15 =
        pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold);
    final textStl12 =
        pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold);
    final textStl12Line = pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        decoration: pw.TextDecoration.underline);
    final bgImage = (await rootBundle.load("assets/Images/invoicebg.png"))
        .buffer
        .asUint8List();
    final pageTheme = pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
        buildBackground: (context) {
          return pw.FullPage(
              ignoreMargins: true, child: pw.Image(pw.MemoryImage(bgImage)));
        });
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageTheme: pageTheme,
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Flexible(
                  flex: 1,
                  child: pw.Align(
                      alignment: pw.Alignment.topCenter,
                      child: pw.Text(
                        "Cash Memo".toUpperCase(),
                        style: textStl15,
                      )),
                ),
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(
                          width: 200,
                          height: 100,
                          child: pw.Image(pw.MemoryImage(image),
                              fit: pw.BoxFit.fill)),
                      pw.Expanded(flex: 2, child: pw.SizedBox()),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text("JR Compliance and Testing Labs",
                                style: textStl10),
                            pw.Text("Office: 705, 7th Floor,Krishna Apra Tower",
                                style: textStl10),
                            pw.Text("Netaji Subhash Place, Pitampura",
                                style: textStl10),
                            pw.Text("New Delhi 110034,India", style: textStl10),
                            pw.Text("GST REGN NO: 07AALFJ0070E1ZO",
                                style: textStl10),
                          ])
                    ]),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("To,", style: textStl12),
                            pw.Text("XYZ Private Limited", style: textStl10),
                            pw.Text("Test Address", style: textStl10),
                            pw.Text("Pincode", style: textStl10),
                            pw.Text("GSTNumber : ", style: textStl10),
                          ]),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text("Cash Memo No :- Cash Memo No",
                              style: textStl10),
                          pw.Text("Date :-  ${DateTime.now()}",
                              style: textStl10),
                        ],
                      )
                    ]),
                pw.SizedBox(height: 10),
                pw.Divider(color: PdfColors.black, thickness: 0.5),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Kind Atten. Mr/Mr's" + " " + "Recievername",
                          style: textStl12),
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                                "Issued On : " +
                                    "" +
                                    DateFormat("dd MMM,yyyy")
                                        .format(DateTime.now()),
                                style: textStl10),
                            pw.Text(
                                "Due Date : " +
                                    "" +
                                    DateFormat("dd MMM,yyyy")
                                        .format(DateTime.now()),
                                style: textStl10)
                          ])
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(children: [
                  pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        child: pw.Text("S.No", style: textStl12),
                        alignment: pw.Alignment.centerLeft,
                      )),
                  pw.Expanded(
                      flex: 7,
                      child: pw.Container(
                        child: pw.Text("Description of Goods/Service",
                            style: textStl12),
                        alignment: pw.Alignment.centerLeft,
                      )),
                  pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text("Amount", style: textStl12),
                      )),
                ]),
                pw.Divider(),
                pw.ConstrainedBox(
                  constraints: pw.BoxConstraints(
                    minHeight: size.height * 0.2,
                  ),
                  child: pw.ListView.builder(
                    itemCount: 1,
                    itemBuilder: (_, i) {
                      return pw.Row(children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Container(
                              child: pw.Text("${i + 1}", style: textStl10),
                              alignment: pw.Alignment.centerLeft,
                            )),
                        pw.Expanded(
                            flex: 7,
                            child: pw.Container(
                              child: pw.Text("Description of Goods/Service",
                                  style: textStl10),
                              alignment: pw.Alignment.centerLeft,
                            )),
                        pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(5000.toStringAsFixed(2),
                                  style: textStl10),
                            )),
                      ]);
                    },
                  ),
                ),
                pw.Expanded(child: pw.SizedBox()),
                pw.Container(
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                      "selectedValue" == "INR"
                          ? pw.Expanded(
                              flex: 5,
                              child: pw.Container(
                                child: pw.Text("IGST/CGST/SGST 18%",
                                    style: textStl10),
                                alignment: pw.Alignment.centerLeft,
                              ))
                          : pw.SizedBox(),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Container(
                            child: pw.Text(
                                "selectedValue" == "INR"
                                    ? gstAmount.toString()
                                    : "",
                                style: textStl10),
                            alignment: pw.Alignment.centerRight,
                          )),
                    ])),
                pw.Container(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Expanded(
                            flex: 6,
                            child: pw.Text(""),
                          ),
                          pw.Expanded(
                              flex: 4,
                              child: pw.Column(children: [
                                pw.Divider(
                                    color: PdfColors.grey, thickness: 0.5),
                                pw.Row(children: [
                                  pw.Expanded(
                                      flex: 1,
                                      child: pw.Container(
                                        alignment: pw.Alignment.centerLeft,
                                        child: pw.Text(
                                            "Total(${"selectedValue"}) :",
                                            style: textStl10),
                                      )),
                                  pw.Expanded(
                                      flex: 1,
                                      child: pw.Container(
                                        alignment: pw.Alignment.centerRight,
                                        child: pw.Text(
                                            total == null
                                                ? "0.00"
                                                : total.toStringAsFixed(2),
                                            style: textStl10),
                                      )),
                                ]),
                              ])),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Divider(color: PdfColors.black, thickness: 0.5),
                pw.SizedBox(height: 5),
                pw.Flexible(
                    flex: 1,
                    child: pw.Text(
                        "Amount in words : Rupees $ruppesinWords Only")),
                pw.Expanded(child: pw.SizedBox()),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Bank Details :-", style: textStl10),
                    pw.Text("For XYZ Private Limited", style: textStl10),
                  ],
                ),
                pw.Expanded(child: pw.SizedBox()),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(""),
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.only(right: 20),
                              child: pw.SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: pw.Image(
                                    pw.MemoryImage(signImage),
                                    fit: pw.BoxFit.fill,
                                  )),
                            ),
                            pw.Padding(
                                padding: pw.EdgeInsets.only(right: 20),
                                child: pw.Align(
                                  alignment: pw.Alignment.bottomRight,
                                  child: pw.Text("Authorized Signatory",
                                      style: textStl10),
                                ))
                          ])
                    ]),
              ]);
        }));
    Uint8List bytes = await pdf.save();
    print(bytes);
    try {
      print(1);
      FirebaseStorage storage = FirebaseStorage.instance;
      print(2);
      TaskSnapshot upload =
          await storage.ref("CashMemo/${cashmemoid}").putData(bytes);
      print(3);
      myUrl = await upload.ref.getDownloadURL();
      print(4);
      print(myUrl);
      print(5);
    } on Exception catch (e, s) {
      print(e.toString());
      print(s.toString());
    }
    print(6);
    return pdf.save();
  }
}
