import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Providers/InvoiceSaveProvider.dart';

class PdfProvider {
  static generatePdf(
      BuildContext context,
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
      cxID,
      externalNotes,
      internalNotes,
      referenceID,
      LeadId) async {
    DateTime? invoicedate1 = DateTime.parse(invoicedate);
    DateTime? duedate1 = DateTime.parse(duedate);
    final image =
        (await rootBundle.load("assets/Logos/jrlogo.png")).buffer.asUint8List();
    final signImage =
        (await rootBundle.load("assets/Images/Authorized_Sign.png"))
            .buffer
            .asUint8List();
    // final fontBold = await PdfGoogleFonts.openSansBold();
    final textStl10 =
        pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold);
    final textStl15 =
        pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold);
    final textStl12 =
        pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold);
    final textStl12Line = pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        decoration: pw.TextDecoration.underline);

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
          return pw
              .Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.Flexible(
              flex: 1,
              child: pw.Align(
                  alignment: pw.Alignment.topCenter,
                  child: pw.Text(
                    "Tax Invoice",
                    style: textStl15,
                  )),
            ),
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.SizedBox(
                  width: 200,
                  height: 100,
                  child: pw.Image(pw.MemoryImage(image), fit: pw.BoxFit.fill)),
              pw.Expanded(flex: 2, child: pw.SizedBox()),
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("JR Compliance and Testing Labs", style: textStl10
                        // style: pw.TextStyle(fontWeight: pw.FontWeight.bold)
                        ),
                    pw.Text("Office: 705, 7th Floor,Krishna Apra Tower",
                        style: textStl10),
                    pw.Text("Netaji Subhash Place, Pitampura",
                        style: textStl10),
                    pw.Text("New Delhi 110034,India", style: textStl10),
                    pw.Text("PAN: AALFJ0070E", style: textStl10),
                    pw.Text("TAN: DELJ10631F", style: textStl10),
                    pw.Text("GST REGN NO: 07AALFJ0070E1ZO", style: textStl10),
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
                        pw.Text("To,", style: textStl12),
                        pw.Text("$address\n$pincode", style: textStl10),
                        pw.Text("GSTNumber : " + _gst.toString(),
                            style: textStl10),
                        pw.Text(""),
                      ]),
                  pw.Text("Invoice No. JR" + actualinid, style: textStl12)
                ]),
            pw.SizedBox(height: 10),
            pw.Text(
                "Thank You for your consideration!!.\n\r\n\r\nWe admire the opportunity to provide you with the best compliance services, hope we have earned your trust to take this opportunity forward. For more information contact your designated representative or email us at support@jrcompliance.com\n\r\n\r\nTo enhance your convenience, you can make payment either throw Post or electronic remitances",
                style: textStl10),
            pw.Divider(color: PdfColors.black, thickness: 0.5),
            pw.SizedBox(height: 10),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Kind Atten. Mr/Mr's" + " " + Recievername.toString(),
                      style: textStl12),
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                            "Issued On : " +
                                "" +
                                DateFormat("dd MMM,yyyy").format(invoicedate1),
                            style: textStl10),
                        pw.Text(
                            "Due Date : " +
                                "" +
                                DateFormat("dd MMM,yyyy").format(duedate1),
                            style: textStl10)
                      ])
                ]),
            pw.SizedBox(height: 10),
            //   click(),
            pw.Row(children: [
              pw.Expanded(
                  flex: 5,
                  child: pw.Container(
                    child: pw.Text("#Description", style: textStl12),
                    alignment: pw.Alignment.centerLeft,
                  )),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    child: pw.Text("SAC Code", style: textStl12),
                    alignment: pw.Alignment.center,
                  )),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                      child: pw.Text("Unit Cost", style: textStl12),
                      alignment: pw.Alignment.centerRight)),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.Text("Qty", style: textStl12),
                  )),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Text("Disc(%)", style: textStl12))),
              pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text("Amount", style: textStl12),
                  )),
            ]),
            pw.Divider(),
            pw.ConstrainedBox(
              constraints: pw.BoxConstraints(),
              child: pw.ListView.builder(
                itemCount: Servicelist.length,
                itemBuilder: (_, i) {
                  return pw.Row(children: [
                    pw.Expanded(
                        flex: 5,
                        child: pw.Container(
                          child: pw.Text(Servicelist[i]["item"].toString(),
                              style: textStl10),
                          alignment: pw.Alignment.centerLeft,
                        )),
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          child: pw.Text("9983", style: textStl10),
                          alignment: pw.Alignment.center,
                        )),
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                            child: pw.Text(
                                Servicelist[i]["rate"].toStringAsFixed(2),
                                style: textStl10),
                            alignment: pw.Alignment.centerRight)),
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text(Servicelist[i]["qty"].toString(),
                              style: textStl10),
                        )),
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                                Servicelist[i]["disc"].toStringAsFixed(2),
                                style: textStl10))),
                    pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                              Servicelist[i]["price"].toStringAsFixed(2),
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
                  selectedValue == "INR"
                      ? pw.Expanded(
                          flex: 5,
                          child: pw.Container(
                            child:
                                pw.Text("IGST/CGST/SGST 18%", style: textStl10),
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
                            style: textStl10),
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
                        flex: 6,
                        child: pw.Text(""),
                      ),
                      pw.Expanded(
                          flex: 4,
                          child: pw.Column(children: [
                            pw.Divider(color: PdfColors.grey, thickness: 0.5),
                            pw.Row(children: [
                              pw.Expanded(
                                  flex: 1,
                                  child: pw.Container(
                                    alignment: pw.Alignment.centerLeft,
                                    child: pw.Text("Total(${selectedValue}) :",
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
                            // pw.Row(children: [
                            //   pw.Expanded(
                            //       flex: 1,
                            //       child: pw.Container(
                            //         alignment: pw.Alignment.centerLeft,
                            //         child: pw.Text(
                            //             "Amount Paid(${selectedValue}) :",
                            //             style: textStl10),
                            //       )),
                            //   pw.Expanded(
                            //       flex: 1,
                            //       child: pw.Container(
                            //         alignment: pw.Alignment.centerRight,
                            //         child: pw.Text(
                            //             tbal == null
                            //                 ? "0.00"
                            //                 : tbal.toStringAsFixed(2),
                            //             style: textStl10),
                            //       )),
                            // ]),
                            // pw.Row(children: [
                            //   pw.Expanded(
                            //     flex: 1,
                            //     child: pw.Container(
                            //         alignment: pw.Alignment.centerLeft,
                            //         child: pw.Text(
                            //             "Balance(${selectedValue}) :",
                            //             style: textStl10)),
                            //   ),
                            //   pw.Expanded(
                            //       flex: 1,
                            //       child: pw.Container(
                            //         alignment: pw.Alignment.centerRight,
                            //         child: pw.Text("0.00", style: textStl10),
                            //       )),
                            // ]),
                          ])),
                    ],
                  ),
                ],
              ),
            ),
            pw.Divider(color: PdfColors.black, thickness: 0.5),
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              child: pw.Flexible(
                  flex: 1,
                  child: pw.Text(r"Note : " + externalNotes.toString(),
                      style: textStl10)),
            ),
            pw.SizedBox(height: 7.5),
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
                                    style: textStl12Line),
                                padding: pw.EdgeInsets.only(left: 5, bottom: 7),
                              ),
                              pw.SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: pw.Image(
                                    pw.MemoryImage(signImage),
                                    fit: pw.BoxFit.fill,
                                  )),
                              pw.Container(
                                  child: pw.Text("  Authorized Signatory",
                                      style: textStl10),
                                  padding:
                                      pw.EdgeInsets.only(left: 5, bottom: 2))
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
                                    child: pw.Text("Project Reference Code",
                                        style: textStl12Line),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.SizedBox(height: 47),
                                pw.Container(
                                    child: pw.Text(
                                        "Currency : ${selectedValue}",
                                        style: textStl10),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text("Customer ID : $cxID",
                                        style: textStl10),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text("Project ID : 00000",
                                        style: textStl10),
                                    padding:
                                        pw.EdgeInsets.only(left: 5, bottom: 2))
                              ]))),
                  pw.Expanded(
                      //kmikjmnkimki
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
                                        style: textStl12Line),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.SizedBox(height: 11),
                                pw.Container(
                                    child: pw.Text("Bank Name: IDFC FIRST BANK",
                                        style: textStl10),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text(
                                        "Account Number: 10041186185",
                                        style: textStl10),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text("IFSC Code: IDFB0040101",
                                        style: textStl10),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text("SWIFT Code: IDFBINBBMUM",
                                        style: textStl10),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text(
                                        "Bank Address: Rohini, New Delhi-110085",
                                        style: textStl10),
                                    padding:
                                        pw.EdgeInsets.only(left: 5, bottom: 2)),
                              ]))),
                ])),
            pw.SizedBox(height: 5),
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
                                "In case you face difficulty in obtaining our Terms and conditions from our\n   official website, contact your designated representative immediately to receive a copy of the same.",
                            style: pw.TextStyle(
                              fontSize: 7,
                            ),
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
                  pw.SizedBox(height: 20)
                ]),
            pw.Footer(
              trailing: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(),
                    pw.Padding(
                      padding:
                          pw.EdgeInsets.only(left: 400, top: 20, right: 20),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                                'JR' + actualinid.toString() + " | Page 1 of 1",
                                style: textStl10),
                            pw.Text("www.jrcompliance.com", style: textStl10),
                          ]),
                    )
                  ]),
            ),
          ]);
        }));
    Uint8List bytes = await pdf.save();
    print(bytes);
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
    Provider.of<InvoiceSaveProvider>(context, listen: false).invoiceData(
        myUrl,
        activeid,
        "Pending",
        actualinid,
        total,
        selectedValue,
        duedate,
        internalNotes,
        externalNotes,
        referenceID,
        cxID,
        LeadId);
    print(6);
    return pdf.save();
  }
}
