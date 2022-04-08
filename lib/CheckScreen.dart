import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:test_web_app/Models/UserModels.dart';

class PdfProvider {
  static generatePdf(
      List Servicelist,
      Recievername,
      tbal,
      actualinid,
      _gst,
      docid,
      activeid,
      gstAmount,
      total,
      invoicedate,
      duedate,
      selectedValue,
      cxID) async {
    DateTime? invoicedate1 = DateTime.parse(invoicedate);
    DateTime? duedate1 = DateTime.parse(duedate);
    //  click(){
    //    return pw.FlatButton(
    //
    //      name: "",
    //      child: pw.Text(""),
    //        flags: <PdfAnnotFlags>{PdfAnnotFlags.print,}
    //
    //    );
    //
    // }

    final image =
        (await rootBundle.load("assets/Logos/jrlogo.png")).buffer.asUint8List();
    String? myUrl;
    final bgImage = (await rootBundle.load("assets/Images/invoicebg.png"))
        .buffer
        .asUint8List();
    final pageTheme = pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 20),
        buildBackground: (context) {
          return pw.FullPage(
              ignoreMargins: true, child: pw.Image(pw.MemoryImage(bgImage)));
        });
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageTheme: pageTheme,
        build: (pw.Context context) {
          String? gstNumber;
          String? invoice;
          return pw.Column(children: [
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.SizedBox(
                  width: 200,
                  height: 100,
                  child: pw.Image(pw.MemoryImage(image), fit: pw.BoxFit.fill)),
              pw.Expanded(flex: 2, child: pw.SizedBox()),
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("JR Compliance and Testing Labs",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("Office: 705, 7th Floor,Krishna Apra Tower",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("Netaji Subhash Place, Pitampura",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("New Delhi 110034,India",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("PAN: AALFJ0070E",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("TAN: DELJ10631F",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("GST REGN NO: 07AALFJ0070E1ZO",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ])
            ]),
            pw.Divider(),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("To,",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text("$address\n$pincode",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text("GSTNumber : " + _gst.toString(),
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(""),
                      ]),
                  pw.Text("Invoice No. JR" + actualinid,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                ]),
            pw.SizedBox(height: 10),
            pw.Text(
                "Thank You for your consideration!!.\n\r\n\r\nWe admire the opportunity to provide you with the best compliance services, hope we have earned your trust to take this opportunity forward. For more information contact your designated representative or email us at support@jrcompliance.com\n\r\n\r\nTo enhance your convenience, you can make payment either throw Post or electronic remitances",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
            pw.SizedBox(height: 10),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Kind Atten. Mr/Mr's" + " " + Recievername.toString(),
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                            "Issued On : " +
                                "" +
                                DateFormat("dd MMM,yyyy").format(invoicedate1),
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(
                            "Due Date : " +
                                "" +
                                DateFormat("dd MMM,yyyy").format(duedate1),
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                      ])
                ]),
            pw.SizedBox(height: 10),
            //   click(),
            pw.Row(children: [
              pw.Expanded(
                  flex: 5,
                  child: pw.Container(
                    child: pw.Text("#Description",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    alignment: pw.Alignment.centerLeft,
                  )),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    child: pw.Text("SAC Code",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    alignment: pw.Alignment.center,
                  )),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                      child: pw.Text("Unit Cost",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      alignment: pw.Alignment.centerRight)),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.Text("Qty",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  )),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text("Disc(%)",
                          style:
                              pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text("Amount",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  )),
            ]),
            pw.Divider(),
            // pw.ConstrainedBox(
            // constraints: pw.BoxConstraints.tight(PdfPoint(200,400)),
            // child:
            pw.ListView.builder(
              itemCount: Servicelist.length,
              itemBuilder: (_, i) {
                return pw.Row(children: [
                  pw.Expanded(
                      flex: 5,
                      child: pw.Container(
                        child: pw.Text(Servicelist[i]["item"].toString(),
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        alignment: pw.Alignment.centerLeft,
                      )),
                  pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        child: pw.Text("9983",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        alignment: pw.Alignment.center,
                      )),
                  pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                          child: pw.Text(
                              Servicelist[i]["rate"].toStringAsFixed(2),
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          alignment: pw.Alignment.centerRight)),
                  pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        alignment: pw.Alignment.center,
                        child: pw.Text(Servicelist[i]["qty"].toString(),
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      )),
                  pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                              Servicelist[i]["disc"].toStringAsFixed(2),
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold)))),
                  pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                            Servicelist[i]["price"].toStringAsFixed(2),
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      )),
                ]);
              },
            ),
            pw.Expanded(flex: 5, child: pw.SizedBox()),
            pw.Container(
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                  selectedValue == "INR"
                      ? pw.Expanded(
                          flex: 5,
                          child: pw.Container(
                            child: pw.Text("IGST/CGST/SGST 18%",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                            alignment: pw.Alignment.centerLeft,
                          ))
                      : pw.SizedBox(),
                  pw.Expanded(
                      flex: 5,
                      child: pw.Container(
                        child: pw.Text(
                            selectedValue == "INR"
                                ? gstAmount.toStringAsFixed(2)
                                : "",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        alignment: pw.Alignment.centerRight,
                      )),
                ])),
            pw.SizedBox(height: 10),
            pw.Container(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(""),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(""),
                      ),
                      pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text("Total(${selectedValue}) :",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          )),
                      pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                                total == null
                                    ? "0.00"
                                    : total.toStringAsFixed(2),
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ))
                    ],
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(""),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(""),
                        ),
                        pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text("Amount Paid(${selectedValue}) :",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            )),
                        pw.Expanded(
                            flex: 2,
                            child: pw.Container(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(
                                  tbal == null
                                      ? "0.00"
                                      : tbal.toStringAsFixed(2),
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            ))
                      ]),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(""),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(""),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Balance(${selectedValue}) :",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            )),
                      ),
                      pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text("0.00",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Container(
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                  pw.Expanded(
                    flex: 4,
                    child: pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Column(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                  child: pw.Text(
                                      "For JR Compliance and Testing Labs",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          decoration:
                                              pw.TextDecoration.underline)),
                                  padding: pw.EdgeInsets.only(left: 5),
                                  margin: pw.EdgeInsets.only(bottom: 60)),
                              pw.Container(
                                  child: pw.Text("  Authorized Signatory",
                                      style: pw.TextStyle(fontSize: 8)),
                                  padding:
                                      pw.EdgeInsets.only(left: 5, bottom: 5))
                            ])),
                  ),
                  pw.Expanded(
                      flex: 4,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Column(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Container(
                                    child: pw.Text(
                                      "Project Reference Code",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          decoration:
                                              pw.TextDecoration.underline),
                                    ),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.SizedBox(height: 41),
                                pw.Container(
                                    child: pw.Text(
                                        "Currency : ${selectedValue}",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold)),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text("Customer ID : ${cxID}",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold)),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text("Project ID : 00000",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold)),
                                    padding:
                                        pw.EdgeInsets.only(left: 5, bottom: 5))
                              ]))),
                  pw.Expanded(
                      flex: 4,
                      child: pw.Container(
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Column(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Container(
                                    child: pw.Text(" Electronic Remittance",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            decoration:
                                                pw.TextDecoration.underline)),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.SizedBox(height: 13),
                                pw.Container(
                                    child: pw.Text("Bank Name: IDFC FIRST BANK",
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child:
                                        pw.Text("Account Number: 10041186185",
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                              fontWeight: pw.FontWeight.bold,
                                            )),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text("IFSC Code: IDFB0040101",
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text("SWIFT Code: IDFBINBBMUM",
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text(
                                        "Bank Address: Rohini, New Delhi-110085",
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                    padding:
                                        pw.EdgeInsets.only(left: 5, bottom: 5)),
                              ]))),
                ])),
            pw.SizedBox(height: 10),
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    child: pw.RichText(
                      text: pw.TextSpan(
                        text: ". ",
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold),
                        children: [
                          pw.TextSpan(
                              text:
                                  "The services provided by JR Compliance are governed by our",
                              style: pw.TextStyle(
                                fontSize: 7,
                              )),
                          pw.TextSpan(
                              text: "Terms and conditions.",
                              style: pw.TextStyle(
                                decoration: pw.TextDecoration.underline,
                                color: PdfColors.blue,
                                fontSize:
                                    7, /*color:PdfColor.fromHex(Colors.blue)*/
                              )),
                          pw.TextSpan(
                            text:
                                "In case you face difficulty in obtaining our Terms and conditions from our official    website, contact your designated representative immediately to receive a copy of the same.",
                            style: pw.TextStyle(fontSize: 7),
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Container(
                    child: pw.RichText(
                      text: pw.TextSpan(
                        text: ". ",
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold),
                        children: [
                          pw.TextSpan(
                              text:
                                  "To know the information regarding purchase and billing.",
                              style: pw.TextStyle(
                                fontSize: 7,
                              )),
                          pw.TextSpan(
                              text:
                                  "visit https://www.jrcompliance.com/purchase-and-billing",
                              style: pw.TextStyle(
                                decoration: pw.TextDecoration.underline,
                                color: PdfColors.blue,
                                fontSize: 7,
                              )),
                        ],
                      ),
                    ),
                  ),
                  pw.Container(
                    child: pw.RichText(
                      text: pw.TextSpan(
                        text: ". ",
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold),
                        children: [
                          pw.TextSpan(
                              text:
                                  "This invoice is due in accordance with the agreed credit terms.",
                              style: pw.TextStyle(
                                fontSize: 7,
                              )),
                        ],
                      ),
                    ),
                  ),
                ]),
            pw.Footer(
              trailing: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 80),
                    pw.Padding(
                      padding:
                          pw.EdgeInsets.only(left: 400, top: 20, right: 20),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text('JR' +
                                actualinid.toString() +
                                " | Page 1 of 1"),
                            pw.Text("www.jrcompliance.com"),
                          ]),
                    )
                  ]),
            ),
          ]);
        }));
    Uint8List bytes = await pdf.save();
    print(bytes);

    //  Uint8List fileBytes = Uint8List.fromList(bytes);
    // var file =  File(fileBytes,"output.pdf");
    //
    // print('@@@@@'+file.toString());
    try {
      print(1);
      FirebaseStorage storage = FirebaseStorage.instance;
      print(2);
      TaskSnapshot upload =
          await storage.ref("Invoices/${actualinid}").putData(bytes);
      print(3);
      myUrl = await upload.ref.getDownloadURL();
      print(4);
      print(myUrl);
      print(5);
    } on Exception catch (e, s) {
      print(e.toString());
      print(s.toString());
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference reference = await firestore.collection("Tasks");
    reference.doc(docid).collection("Invoices").doc().set({
      "InvoiceUrl": myUrl,
      "Timestamp": Timestamp.now(),
      "status": false,
      "InvoiceId": actualinid,
      "type": activeid,
    });
    print(6);
    return pdf.save();
  }
}
