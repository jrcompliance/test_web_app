import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing%202.dart';
import 'package:test_web_app/Models/UserModels.dart';

class PdfFMCSService {
  static generatePdf({
    required BuildContext context,
    required int fmcsserviceid,
    required List Servicelist,
    required String cusname,
    required double tbal,
    required String actualinid,
    required String gstNo,
    required String docid,
    required String activeid,
    required double gstAmount,
    required double total,
    required String invoicedate,
    required String duedate,
    required String selectedValue,
    required String cxID,
    required String externalNotes,
    required String internalNotes,
    required String referenceID,
    required String LeadId,
  }) async {
    Size size = MediaQuery.of(context).size;
    DateTime? invoicedate1 = DateTime.parse(invoicedate);
    DateTime? duedate1 = DateTime.parse(duedate);

    final image =
        (await rootBundle.load("assets/Logos/jrlogo.png")).buffer.asUint8List();
    final bislogo = (await rootBundle.load("assets/Logos/BIS_logo.png"))
        .buffer
        .asUint8List();
    final bdeimage = (await rootBundle.load("assets/Images/bdeimage.jpg"))
        .buffer
        .asUint8List();
    final vpimage = (await rootBundle.load("assets/Images/vpimage.jpg"))
        .buffer
        .asUint8List();
    final ceoimage = (await rootBundle.load("assets/Images/ceoimage.png"))
        .buffer
        .asUint8List();
    final bde2image = (await rootBundle.load("assets/Images/bde2image.jpg"))
        .buffer
        .asUint8List();
    final fmcslogo = (await rootBundle.load("assets/Logos/FMCS_logo3.png"))
        .buffer
        .asUint8List();
    final signImage =
        (await rootBundle.load("assets/Images/Authorized_Sign.png"))
            .buffer
            .asUint8List();
    final latobold = await PdfGoogleFonts.latoRegular();
    final latobold2 = await PdfGoogleFonts.latoBlack();
    final latoitalic = await PdfGoogleFonts.latoLightItalic();

    //  final fonts = await PdfStandardFont(PdfFontFamily.helvetica, 50);
    final textStl12 = pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: latobold);
    final textStl12Line = pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        decoration: pw.TextDecoration.underline);
    final textStl8bold = pw.TextStyle(
        // height: 1.5,
        fontSize: 8,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        fontWeight: pw.FontWeight.bold,
        font: latobold);
    final textStl12Italic = pw.TextStyle(
        // height: 1.5,
        fontSize: 12,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: latoitalic,
        fontStyle: pw.FontStyle.italic);
    final textStl12bold = pw.TextStyle(
        // height: 1.5,
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: latobold);
    final textStl12bold2 = pw.TextStyle(
        // height: 1.5,
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: latobold2);
    final textStl10 = pw.TextStyle(
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: latobold);

    final textStl15bold = pw.TextStyle(
        // height: 1.5,
        fontSize: 15,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: latobold2);
    final textStl15boldblu = pw.TextStyle(
        // height: 1.5,
        fontSize: 15,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.blue,
        font: latobold2);
    final textStl25 = pw.TextStyle(
        // height: 1.5,
        fontSize: 25,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: latobold2);
    final textStl25blu = pw.TextStyle(
        // height: 1.5,
        fontSize: 25,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.blue,
        font: latobold2);
    final textStl18bold = pw.TextStyle(
        // height: 1.5,
        fontSize: 18,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: latobold2);
    final textStl12boldLine = pw.TextStyle(
        // height: 1.5,
        fontSize: 12,
        decoration: pw.TextDecoration.underline,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: latobold);
    pw.SizedBox space2() {
      return pw.SizedBox(height: size.height * 0.02);
    }

    pw.SizedBox space3() {
      return pw.SizedBox(height: size.height * 0.03);
    }

    pw.SizedBox space4() {
      return pw.SizedBox(height: size.height * 0.04);
    }

    pw.VerticalDivider verticalDivider() {
      return pw.VerticalDivider(
          width: 1.0, thickness: 1.0, color: PdfColors.grey300);
    }

    pw.Container listTile(image, name, email, phone) {
      return pw.Container(
          height: size.height * 0.07,
          decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(20.0),
              border: pw.Border.all(color: PdfColors.grey300)),
          child: pw.Row(children: [
            pw.Container(
                height: 80,
                width: 80,
                decoration: const pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.only(
                      topLeft: pw.Radius.circular(20.0),
                      bottomLeft: pw.Radius.circular(20.0),
                      topRight: pw.Radius.zero,
                      bottomRight: pw.Radius.zero),
                ),
                child: pw.Image(pw.MemoryImage(image), fit: pw.BoxFit.fill)),
            pw.SizedBox(width: 10),
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Flexible(
                      flex: 1, child: pw.Text(name, style: textStl12bold)),
                  pw.SizedBox(height: 10),
                  pw.Flexible(
                      flex: 1, child: pw.Text(email, style: textStl12bold)),
                  pw.SizedBox(height: 10),
                  pw.Flexible(
                      flex: 1, child: pw.Text(phone, style: textStl12bold)),
                  pw.SizedBox(height: 10),
                ])
          ]));
    }

    pw.Divider divider() {
      return pw.Divider(color: PdfColors.grey300, height: 2.5, thickness: 1.0);
    }

    pw.Row steps(step, text) {
      return pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(step, style: textStl12Italic),
        pw.Text(" - ", style: textStl12bold),
        pw.Flexible(
          flex: 1,
          child: pw.Text(text, style: textStl12bold),
        )
      ]);
    }

    pw.Row rowWidget(text1, text2) {
      return pw.Row(children: [
        pw.Container(
          decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(2.0),
              color: PdfColors.black),
          height: 5,
          width: 5,
        ),
        pw.SizedBox(width: 10),
        pw.RichText(
          text: pw.TextSpan(
            children: [
              pw.TextSpan(text: text1, style: textStl12Italic),
              pw.TextSpan(text: ",", style: textStl12bold),
              pw.TextSpan(text: text2, style: textStl12bold),
            ],
          ),
        )
      ]);
    }

    pw.Row rowWidget2(
      text1,
    ) {
      return pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Padding(
          padding: pw.EdgeInsets.only(top: 5.0),
          child: pw.Container(
            decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(2.0),
                color: PdfColors.black),
            height: 5,
            width: 5,
          ),
        ),
        pw.SizedBox(width: 10),
        pw.Expanded(
          flex: 2,
          child: pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(text: text1, style: textStl12bold),
              ],
            ),
          ),
        )
      ]);
    }

    pw.Row rowWidget2link(text1, text2, [text3]) {
      return pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Padding(
          padding: pw.EdgeInsets.only(top: 5.0),
          child: pw.Container(
            decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(2.0),
                color: PdfColors.black),
            height: 5,
            width: 5,
          ),
        ),
        pw.SizedBox(width: 10),
        pw.Expanded(
          flex: 3,
          child: pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(text: text1, style: textStl12bold),
                pw.TextSpan(text: text2, style: textStl12boldLine),
                pw.TextSpan(text: text3, style: textStl12bold),
              ],
            ),
          ),
        )
      ]);
    }

    pw.SizedBox space() {
      return pw.SizedBox(height: size.height * 0.01);
    }

    pw.Flexible bisservicerow(servicetext1, servicetext2, image1, desc1,
        [desc2, desc3, desc4, desc5]) {
      return pw.Flexible(
          flex: 5,
          child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Flexible(
                  flex: 1,
                  child: pw.Padding(
                    padding: pw.EdgeInsets.only(top: 20.0),
                    child: pw.Container(
                        // color: PdfColors.pink,
                        height: 80,
                        width: 150,
                        child: pw.Image(pw.MemoryImage(image1),
                            fit: pw.BoxFit.cover)),
                  ),
                ),
                pw.Flexible(
                  flex: 4,
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Flexible(
                          flex: 1,
                          child: pw.RichText(
                              softWrap: true,
                              text: pw.TextSpan(children: [
                                pw.TextSpan(
                                    text: servicetext1,
                                    style: textStl15boldblu),
                                pw.TextSpan(text: " ", style: textStl15bold),
                                pw.TextSpan(
                                    text: servicetext2, style: textStl15bold),
                              ])),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Flexible(
                          flex: 3,
                          child: pw.RichText(
                              softWrap: true,
                              text: pw.TextSpan(children: [
                                pw.TextSpan(text: desc1, style: textStl12bold),
                                pw.TextSpan(
                                    text: desc2, style: textStl12Italic),
                                pw.TextSpan(text: desc3, style: textStl12bold),
                                pw.TextSpan(
                                    text: desc4, style: textStl12Italic),
                                pw.TextSpan(text: desc5, style: textStl12bold),
                              ])),
                        )
                      ]),
                )
              ]));
    }

    pw.Flexible servicerow(servicetext1, servicetext2, image1, desc1,
        [desc2, desc3, desc4, desc5]) {
      return pw.Flexible(
          flex: 6,
          child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Flexible(
                  flex: 1,
                  child: pw.Padding(
                    padding: pw.EdgeInsets.only(top: 20.0),
                    child: pw.Container(
                        // color: PdfColors.pink,
                        height: 80,
                        width: 150,
                        child: pw.Image(pw.MemoryImage(image1),
                            fit: pw.BoxFit.cover)),
                  ),
                ),
                pw.Flexible(
                  flex: 5,
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Flexible(
                          flex: 1,
                          child: pw.RichText(
                              softWrap: true,
                              text: pw.TextSpan(children: [
                                pw.TextSpan(
                                    text: servicetext1,
                                    style: textStl15boldblu),
                                pw.TextSpan(text: " ", style: textStl15bold),
                                pw.TextSpan(
                                    text: servicetext2, style: textStl15bold),
                              ])),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Flexible(
                          flex: 4,
                          child: pw.RichText(
                              softWrap: true,
                              text: pw.TextSpan(children: [
                                pw.TextSpan(text: desc1, style: textStl12bold),
                                pw.TextSpan(
                                    text: desc2, style: textStl12Italic),
                                pw.TextSpan(text: desc3, style: textStl12bold),
                                pw.TextSpan(
                                    text: desc4, style: textStl12Italic),
                                pw.TextSpan(text: desc5, style: textStl12bold),
                              ])),
                        )
                      ]),
                )
              ]));
    }

    String? myUrl;
    final bgImage = (await rootBundle.load("assets/Images/servicebg4.png"))
        .buffer
        .asUint8List();
    final pageTheme = pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 20),
        buildBackground: (context) {
          return pw.FullPage(
              ignoreMargins: true, child: pw.Image(pw.MemoryImage(bgImage)));
        });
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
          maxPages: 10,
          pageTheme: pageTheme,
          build: (pw.Context context) {
            return <pw.Widget>[
              pw.Column(children: [
                pw.Container(
                  height: size.height - 70,
                  width: size.width - 100,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Align(
                          alignment: pw.Alignment.topCenter,
                          child: pw.SizedBox(
                              width: 200,
                              height: 100,
                              child: pw.Image(pw.MemoryImage(image),
                                  fit: pw.BoxFit.fill)),
                        ),
                        space2(),
                        pw.Align(
                          alignment: pw.Alignment.topCenter,
                          child: pw.Flexible(
                            flex: 1,
                            fit: pw.FlexFit.tight,
                            child: pw.Text(
                              "COMPLIANCE PROPOSAL",
                              style: textStl25,
                            ),
                          ),
                        ),
                        space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "To,",
                            style: textStl12bold,
                          ),
                        ),
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            cusname.toString(),
                            style: textStl12bold,
                          ),
                        ),
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Place",
                            style: textStl12bold,
                          ),
                        ),
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "District",
                            style: textStl12bold,
                          ),
                        ),
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "State",
                            style: textStl12bold,
                          ),
                        ),
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Country",
                            style: textStl12bold,
                          ),
                        ),
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Pincode",
                            style: textStl12bold,
                          ),
                        ),
                        for (int i = 1; i <= 2; i++) space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            cusemail.toString(),
                            style: textStl12bold,
                          ),
                        ),

                        for (int i = 1; i <= 2; i++) space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Date: ${DateFormat('dd MMMM ,yyyy').format(DateTime.now())}"
                                .toUpperCase(),
                            style: textStl18bold,
                          ),
                        ),

                        for (int i = 1; i <= 3; i++) space2(),
                        //   pw.Flexible(flex: 1,child: ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Quotation No: 487256484",
                            style: textStl12bold,
                          ),
                        ),
                        for (int i = 1; i <= 2; i++) space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Subject: IS 14286 Quotation under Mandatory BIS-CRS certification controlled by Ministry of New and Renewable Energy",
                            style: textStl12bold,
                          ),
                        ),
                        for (int i = 1; i <= 2; i++) space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Prepared By: Mr.Tarun Sadana",
                            style: textStl12bold,
                          ),
                        ),
                      ]),
                ),
                pw.Container(
                    height: size.height - 70,
                    width: size.width - 100,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            cusname.toString(),
                            style: textStl12bold,
                          ),
                        ),
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Place",
                            style: textStl12bold,
                          ),
                        ),
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "District",
                            style: textStl12bold,
                          ),
                        ),
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "State",
                            style: textStl12bold,
                          ),
                        ),
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Country",
                            style: textStl12bold,
                          ),
                        ),
                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Pincode",
                            style: textStl12bold,
                          ),
                        ),
                        space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Hello ${cusname.toString()}",
                            style: textStl12bold,
                          ),
                        ),
                        // space(),
                        // pw.Flexible(
                        //   flex: 1,
                        //   child: pw.Text(
                        //     ,
                        //     style: textStl12bold,
                        //   ),
                        // ),
                        space2(),
                        pw.RichText(
                            text: pw.TextSpan(children: [
                          pw.TextSpan(
                              text:
                                  "Thank you for choosing JR Compliance as your compliance partner, we admire the opportunity to provide you with the ",
                              style: textStl12bold),
                          pw.TextSpan(
                              text: "best compliance services ",
                              style: textStl12Italic),
                          pw.TextSpan(
                              text: "and are sincerely ", style: textStl12bold),
                          pw.TextSpan(
                              text: "welcoming you to our family.",
                              style: textStl12Italic),
                        ])),
                        space3(),
                        pw.RichText(
                            text: pw.TextSpan(children: [
                          pw.TextSpan(
                              text:
                                  r'''JR Compliance - Indian's #1 compliance service provider was established in 2013 with the fundamental motive to make compliance seamless worldwide. We are proud to admit that we stand proudly among a few compliance service providers, who provide Indian and Global certification services under one roof. Till date, we have served more than ''',
                              style: textStl12bold),
                          pw.TextSpan(
                              text: "10,000 + Indian and Global brands ",
                              style: textStl12Italic),
                          pw.TextSpan(
                              text:
                                  "such as Softbank, Troy, and Bombay Dyeing. With that, we pride ourselves that we have been awarded by Future Business Awards 2020 as ",
                              style: textStl12bold),
                          pw.TextSpan(
                              text:
                                  r'''"Best Diversified Compliance & Legal Service provider in India"''',
                              style: textStl12Italic),
                        ])),
                        space3(),
                        pw.RichText(
                            text: pw.TextSpan(children: [
                          pw.TextSpan(
                              text:
                                  "Moreover, we are pleased to inform you that we are the first Technical Compliance Company in India to receive this prestigious award and are also ",
                              style: textStl12bold),
                          pw.TextSpan(
                              text: "ISO 9001:2015 ", style: textStl12Italic),
                          pw.TextSpan(
                              text:
                                  "Certified company and featured in many National and International news platforms such as Deccan Chronicle, Hindustan Times, Zee News, and more.",
                              style: textStl12bold),
                        ])),
                        space3(),
                        pw.Text(
                          r"We are constantly working to provide superior regulatory and certification services to our clients to strive for excellence within defined time constraints, that too without compromising the accuracy of test methods and results. Additionally, at JR Compliance we are committed to provide responsive and competitive services to our clients by maintaining flexibility, adaptability, and a positive attitude while handling your project.",
                          style: textStl12bold,
                        ),
                        space3(),
                        pw.Text(
                          r"Looking forward to working with you & be associated with your organization so that we can start this valuable project.",
                          style: textStl12bold,
                        ),
                        space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Thank you!",
                            style: textStl12bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Regards",
                            style: textStl12bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Mr.Tarun Sadana",
                            style: textStl12bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Sales & Marketing - BDE",
                            style: textStl12bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "tarun@jrcompliance.com",
                            style: textStl12bold,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "www.jrcompliance.com",
                            style: textStl12bold,
                          ),
                        ),
                      ],
                    )),
                pw.Container(
                    height: size.height - 70,
                    width: size.width - 100,
                    // height: size.height,
                    // width: size.width,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          space3(),
                          pw.Align(
                            alignment: pw.Alignment.topCenter,
                            child: pw.Flexible(
                              flex: 1,
                              child: pw.RichText(
                                text: pw.TextSpan(
                                    text: "COMPLIANCE",
                                    style: textStl25blu,
                                    children: [
                                      pw.TextSpan(text: " "),
                                      pw.TextSpan(
                                          text: "AUTHORITY", style: textStl25)
                                    ]),
                              ),
                            ),
                          ),
                          space3(),
                          pw.Align(
                              alignment: pw.Alignment.topCenter,
                              child: pw.Text("INTRODUCTION", style: textStl25)),
                          space3(),
                          bisservicerow(
                            "BIS",
                            "OVERVIEW",
                            bislogo,
                            "BIS is an acronym for Bureau of Indian Standard, it is a certification body that impart the product's quality, safety, and credibility of the brands, manufacturers, and producers to the customers. It came into existence through an act of parliament dated 26 November 1986, on 1 April 1987.",
                          ),
                          space(),
                          pw.Flexible(
                              flex: 2,
                              child: pw.Text(
                                  "The mentioned act has been revised as BIS Act, 2016 and establishes BIS as the National Standards Body authorizes to undertake conformity assessment of products, services, systems and processes.",
                                  style: textStl12bold)),
                          space4(),
                          pw.Flexible(
                              flex: 2,
                              child: pw.Text(
                                  "The product certification of BIS aims at providing Third Party assurance of quality, safety and reliability of products to the customer. Presence of BIS certification mark, known as Standard Mark, on a product is an assurance of conformity to the specifications.",
                                  style: textStl12bold)),
                          space4(),
                          pw.Flexible(
                              flex: 2,
                              child: pw.Text(
                                  "Moreover, to maintain a close vigil on quality of the products, BIS conducts surveillance operations or regular surveillance of the licensee's performance by surprise inspections and testing of samples, drawn both from the market/factory.",
                                  style: textStl12bold)),
                          space4(),
                          pw.Padding(
                              padding: pw.EdgeInsets.only(left: 0),
                              child: pw.Flexible(
                                flex: 1,
                                child: pw.Text(
                                    "BIS certification includes three certification schemes -",
                                    style: textStl12bold),
                              )),
                          space4(),
                          pw.Padding(
                              padding: pw.EdgeInsets.only(left: 30),
                              child: rowWidget('ISI certification scheme',
                                  'applicabe on Indian manufacturers')),
                          space3(),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(left: 30),
                            child: rowWidget('FMCS certification scheme',
                                'applicabe on foreign manufacturers'),
                          ),
                          space3(),
                          pw.Padding(
                              padding: pw.EdgeInsets.only(left: 30),
                              child: rowWidget('CRS registration scheme',
                                  'applicabe on electric and electronic appliances')),
                          space4(),
                          //Since your products fall under purview of the FMCS certification scheme, we will emphasize on that, in the next section.
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text(
                                  "Since your products fall under purview of the FMCS certification scheme, we will emphasize on that, in the next section.",
                                  style: textStl12bold)),
                        ])),
                pw.Container(
                    height: size.height - 70,
                    width: size.width - 100,
                    // height: size.height,
                    // width: size.width,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          space3(),
                          servicerow(
                              "FMCS",
                              "OVERVIEW",
                              fmcslogo,
                              "Foreign Manufacturers Certification Scheme (FMCS) is acertification scheme under BIS, which is applicable to foreign manufacturers as per ",
                              "BIS Act, 2016 ",
                              "and ",
                              "BIS(Conformity Assessment), 2018. ",
                              "To obtain an FMCS certificate, it is necessary to comply with all the requirements of the applicable Indian standards."),
                          space3(),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Flexible(
                                flex: 1,
                                child: pw.RichText(
                                  text: pw.TextSpan(children: [
                                    pw.TextSpan(
                                        text: "BENEFITS ", style: textStl25blu),
                                    pw.TextSpan(text: "OF ", style: textStl25),
                                    pw.TextSpan(
                                        text: "FMCS ", style: textStl25blu),
                                    pw.TextSpan(
                                        text: "CERTIFICATION",
                                        style: textStl25),
                                  ]),
                                )),
                          ),
                          space3(),
                          pw.Flexible(
                              flex: 1,
                              child: rowWidget2(
                                "Prevent from imposition of penalty",
                              )),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: rowWidget2(
                                "Edge over competitors.",
                              )),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: rowWidget2(
                                "Easy market access.",
                              )),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: rowWidget2(
                                "Builds Brand’s credibility.",
                              )),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: rowWidget2(
                                "Confirms impeccable quality standards.",
                              )),
                          space4(),
                          pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Flexible(
                                flex: 1,
                                child: pw.RichText(
                                  text: pw.TextSpan(children: [
                                    pw.TextSpan(
                                        text: "CERTIFICATION ",
                                        style: textStl25),
                                    pw.TextSpan(
                                        text: "PROCESS", style: textStl25blu),
                                  ]),
                                )),
                          ),
                          space3(),
                          pw.Flexible(
                              flex: 1,
                              child: steps("Step 1",
                                  "An Applicaton form will be duly filed.")),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: steps("Step 2",
                                  "Factory inspection will be conducted.")),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: steps("Step 3",
                                  "Product samples will be withdrawn.")),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: steps("Step 4",
                                  "Payment of \$10,000 Performance Bank Guarantee and signing of Indemnity Bond.")),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: steps(
                                  "Step 5", "Issuance of FMCS certificate.")),
                          space4(),
                          pw.Flexible(
                            flex: 2,
                            child: pw.RichText(
                                text: pw.TextSpan(children: [
                              pw.TextSpan(
                                  text:
                                      "We assure you that you have chosen the right consultant. We have provided ",
                                  style: textStl12bold),
                              pw.TextSpan(
                                  text:
                                      "error-free services to over 10,000+ clients ",
                                  style: textStl12Italic),
                              pw.TextSpan(
                                  text:
                                      "and to brands like Bombay dyeing, Troy, Softbank and more.",
                                  style: textStl12bold),
                            ])),
                          ),
                        ])),
                pw.Container(
                  height: size.height - 70,
                  width: size.width - 100,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        space3(),
                        pw.Flexible(
                            flex: 1,
                            child: pw.Text(
                                "Following standards will be applicable on your Solar Modules :",
                                style: textStl12bold)),
                        space2(),
                        pw.Container(
                            height: size.height * 0.1,
                            decoration: pw.BoxDecoration(
                                color: PdfColors.grey50,
                                borderRadius: pw.BorderRadius.circular(5.0)),
                            child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Expanded(
                                      flex: 1,
                                      child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Expanded(
                                                flex: 1,
                                                child: pw.Text(
                                                    "Indian Standard Applicable",
                                                    style: textStl15bold)),
                                            pw.Expanded(
                                                flex: 1,
                                                child: pw.Text("(IS) No :${""}",
                                                    style: textStl15bold)),
                                          ])),
                                  verticalDivider(),
                                  pw.SizedBox(width: 10),
                                  pw.Expanded(
                                      flex: 1,
                                      child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Expanded(
                                                flex: 1,
                                                child: pw.Text("IS 14286",
                                                    style: textStl15bold)),
                                            pw.Expanded(
                                                flex: 1,
                                                child: pw.Text(
                                                    "IS/IEC 61730 Part1:2004",
                                                    style: textStl15bold)),
                                            pw.Expanded(
                                                flex: 1,
                                                child: pw.Text(
                                                    "IS/IEC 61730 Part 2",
                                                    style: textStl15bold)),
                                          ])),
                                ])),
                        space3(),
                        pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Flexible(
                                  flex: 1,
                                  child: pw.Text("Quotation",
                                      style: textStl12bold)),
                              pw.SizedBox(width: 10),
                              pw.Flexible(
                                  flex: 1,
                                  child: pw.Text("487256484",
                                      style: textStl18bold)),
                            ]),
                        space3(),
                        pw.Flexible(
                            flex: 1,
                            child: pw.Text("Details:", style: textStl18bold)),
                        space2(),
                        pw.Container(
                            height: size.height * 0.26,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(0.0),
                              border: pw.Border.all(color: PdfColors.grey300),
                            ),
                            child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Padding(
                                    padding:
                                        pw.EdgeInsets.only(left: 5.0, top: 20),
                                    child: pw.Expanded(
                                        flex: 2,
                                        child: pw.Text("Prepared For",
                                            style: textStl12bold)),
                                  ),
                                  verticalDivider(),
                                  pw.Expanded(
                                      flex: 4,
                                      child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Padding(
                                              padding: pw.EdgeInsets.only(
                                                  left: 5.0, top: 20),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text(
                                                      cusname.toString(),
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5.0),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text(
                                                      "customer address",
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5.0),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text("district",
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5.0),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text("state",
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5.0),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text("country",
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5.0),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text(
                                                      cusemail.toString(),
                                                      style: textStl12bold)),
                                            ),
                                          ])),
                                  verticalDivider(),
                                  pw.Padding(
                                    padding:
                                        pw.EdgeInsets.only(left: 5.0, top: 20),
                                    child: pw.Expanded(
                                        flex: 1,
                                        child: pw.Text("Issued By",
                                            style: textStl12bold)),
                                  ),
                                  verticalDivider(),
                                  pw.Expanded(
                                      flex: 4,
                                      child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Padding(
                                              padding: pw.EdgeInsets.only(
                                                  left: 5.0, top: 20),
                                              child: pw.Flexible(
                                                  flex: 2,
                                                  child: pw.Text(
                                                      "JR Compliance & Testing Labs",
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5),
                                              child: pw.Flexible(
                                                  flex: 2,
                                                  child: pw.Text(
                                                      "705,7th Floor,Krisha Apra Tower",
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text(
                                                      "Netaji Subhash Place",
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text("Pitampura",
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text(
                                                      "New Delhi-110034",
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text("India",
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text(
                                                      "tarun@jrcompliance.com",
                                                      style: textStl12bold)),
                                            ),
                                            pw.SizedBox(height: 5),
                                            pw.Padding(
                                              padding:
                                                  pw.EdgeInsets.only(left: 5),
                                              child: pw.Flexible(
                                                  flex: 1,
                                                  child: pw.Text(
                                                      "+91 9599550680"
                                                          .toString(),
                                                      style: textStl12bold)),
                                            ),
                                          ])),
                                ])),
                        space3(),
                        pw.Flexible(
                            flex: 1,
                            child: pw.Text("Project Escalation Levels",
                                style: textStl15bold)),
                        space3(),
                        listTile(bdeimage, "Mr.Tarun Sadana - BDE",
                            "tarun@jrcompliance.com", "+91 9599550680"),
                        space(),
                        listTile(vpimage, "Mr.Lalit Gupta - VP",
                            "lalit@jrcompliance.com", "+91 9873060689"),
                        space(),
                        listTile(ceoimage, "Mr.Rishikesh Mishra - CEO",
                            "rishi@jrcompliance.com", "+91 9266450125"),
                        space(),
                        // pw.Container(
                        //   height: size.height * 0.2,
                        //   child: pw.Table(
                        //       border: pw.TableBorder(
                        //           left: pw.BorderSide(color: PdfColors.grey300),
                        //           right:
                        //               pw.BorderSide(color: PdfColors.grey300),
                        //           top: pw.BorderSide(color: PdfColors.grey300),
                        //           bottom:
                        //               pw.BorderSide(color: PdfColors.grey300),
                        //           horizontalInside:
                        //               pw.BorderSide(color: PdfColors.grey300),
                        //           verticalInside:
                        //               pw.BorderSide(color: PdfColors.grey300)),
                        //       children: [
                        //         pw.TableRow(
                        //             // This is the third row for the table
                        //             children: [
                        //               pw.Column(
                        //                 crossAxisAlignment:
                        //                     pw.CrossAxisAlignment.start,
                        //                 children: [
                        //                   pw.Padding(
                        //                     padding: pw.EdgeInsets.only(
                        //                         left: 5.0, top: 5.0),
                        //                     child: pw.Text(
                        //                       "BDE - Mr.Tarun Sadana",
                        //                       style: textStl12bold,
                        //                     ),
                        //                   ),
                        //                   pw.Text(""),
                        //                 ],
                        //               ),
                        //               pw.Column(
                        //                 crossAxisAlignment:
                        //                     pw.CrossAxisAlignment.start,
                        //                 children: [
                        //                   pw.Padding(
                        //                     padding: pw.EdgeInsets.only(
                        //                         left: 5.0,
                        //                         top: 5.0,
                        //                         bottom: 5.0),
                        //                     child: pw.Column(
                        //                         crossAxisAlignment:
                        //                             pw.CrossAxisAlignment.start,
                        //                         children: [
                        //                           pw.Text(
                        //                             "Primary Level",
                        //                             style: textStl12bold,
                        //                           ),
                        //                           pw.Text(
                        //                               "tarun@jrcompliance.com",
                        //                               style: textStl12bold),
                        //                         ]),
                        //                   ),
                        //                 ],
                        //               ),
                        //               pw.Padding(
                        //                 padding: pw.EdgeInsets.all(4),
                        //                 child: pw.Column(
                        //                   crossAxisAlignment:
                        //                       pw.CrossAxisAlignment.start,
                        //                   children: [
                        //                     pw.Column(
                        //                         crossAxisAlignment:
                        //                             pw.CrossAxisAlignment.start,
                        //                         children: [
                        //                           pw.Text(
                        //                             "",
                        //                             style: textStl12bold,
                        //                           ),
                        //                           pw.Padding(
                        //                             padding: pw.EdgeInsets.only(
                        //                                 left: 5.0, top: 5.0),
                        //                             child: pw.Text(
                        //                                 "+91 9599550680",
                        //                                 style: textStl12bold),
                        //                           ),
                        //                         ]),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ]),
                        //         pw.TableRow(children: [
                        //           pw.Column(
                        //               crossAxisAlignment:
                        //                   pw.CrossAxisAlignment.start,
                        //               children: [
                        //                 pw.Padding(
                        //                   padding: pw.EdgeInsets.only(
                        //                       left: 5.0, top: 5.0),
                        //                   child: pw.Text(
                        //                     "VP - Mr.Lalit Gupta",
                        //                     style: textStl12bold,
                        //                   ),
                        //                 ),
                        //                 pw.Text("", style: textStl12bold),
                        //               ]),
                        //           pw.Padding(
                        //             padding: pw.EdgeInsets.only(
                        //                 left: 5.0, top: 5.0, bottom: 5.0),
                        //             child: pw.Column(
                        //                 crossAxisAlignment:
                        //                     pw.CrossAxisAlignment.start,
                        //                 children: [
                        //                   pw.Text(
                        //                     "Priority",
                        //                     style: textStl12bold,
                        //                   ),
                        //                   pw.Text("lalit@jrcompliance.com",
                        //                       style: textStl12bold),
                        //                 ]),
                        //           ),
                        //           pw.Column(
                        //               crossAxisAlignment:
                        //                   pw.CrossAxisAlignment.start,
                        //               children: [
                        //                 pw.Text(
                        //                   "",
                        //                   style: textStl12bold,
                        //                 ),
                        //                 pw.Padding(
                        //                   padding: pw.EdgeInsets.only(
                        //                       left: 5.0, top: 5.0),
                        //                   child: pw.Text("+91 9873060689",
                        //                       style: textStl12bold),
                        //                 ),
                        //               ]),
                        //         ]),
                        //         pw.TableRow(children: [
                        //           pw.Column(
                        //               crossAxisAlignment:
                        //                   pw.CrossAxisAlignment.start,
                        //               children: [
                        //                 pw.Padding(
                        //                   padding: pw.EdgeInsets.only(
                        //                       left: 5.0, top: 5.0, bottom: 5.0),
                        //                   child: pw.Text(
                        //                     "CEO - Mr.Rishikesh Mishra",
                        //                     style: textStl12bold,
                        //                   ),
                        //                 ),
                        //                 pw.Text("", style: textStl12bold),
                        //               ]),
                        //           pw.Padding(
                        //             padding: pw.EdgeInsets.only(
                        //               left: 5.0,
                        //               top: 5.0,
                        //               bottom: 5.0,
                        //             ),
                        //             child: pw.Column(
                        //                 crossAxisAlignment:
                        //                     pw.CrossAxisAlignment.start,
                        //                 children: [
                        //                   pw.Text(
                        //                     "Urgent",
                        //                     style: textStl12bold,
                        //                   ),
                        //                   pw.Text("rishi@jrcompliance.com",
                        //                       style: textStl12bold),
                        //                 ]),
                        //           ),
                        //           pw.Column(
                        //               crossAxisAlignment:
                        //                   pw.CrossAxisAlignment.start,
                        //               children: [
                        //                 pw.Text(
                        //                   "",
                        //                   style: textStl12bold,
                        //                 ),
                        //                 pw.Padding(
                        //                   padding: pw.EdgeInsets.only(
                        //                       left: 5.0, top: 5.0, bottom: 5.0),
                        //                   child: pw.Text("+91 9266450125",
                        //                       style: textStl12bold),
                        //                 ),
                        //               ]),
                        //         ]),
                        //       ]),
                        // ),
                      ]),
                ),
                pw.Container(
                  height: size.height - 70,
                  width: size.width - 100,
                  // height: size.height,
                  // width: size.width,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        space2(),
                        pw.Align(
                          alignment: pw.Alignment.topCenter,
                          child: pw.Flexible(
                              flex: 1,
                              child:
                                  pw.Text("Scope of Work", style: textStl25)),
                        ),
                        space3(),
                        rowWidget2(
                          "We assist you to know whether a product falls under the purview of concerned authority.",
                        ),
                        space4(),
                        rowWidget2(
                            "For comprehensible guidance, we will first scrutinize the certification requirements of a product."),
                        space4(),
                        rowWidget2(
                            "We will provide you information regarding a number of samples required for product testing because product sample requirements differ depending on product type."),
                        space4(),
                        rowWidget2(
                            "We will educate you about the registration process, benefits, documents required, including any query you may have regarding the same."),
                        space4(),
                        rowWidget2(
                            "Being a reputed compliance consultant, we will provide you technical and non- technical support."),
                        space4(),
                        rowWidget2(
                            "JR Compliance offers competitive and excellent services to our clients by meeting the startled queries/demands."),
                        space4(),
                        rowWidget2(
                            "To ensure the utmost convenience of our client, we will also assist you in the custom clearance of the sample product."),
                        space4(),
                        rowWidget2(
                            "Our consultants will invest their sustained efforts to meet the startled queries or demands of concerned authorities."),
                        space4(),
                        rowWidget2(
                            "Obtaining a certificate is no easy task, however, there is no better place to obtain it than JR Compliance because we will analyze the product requirements to give clear guidelines."),
                        space4(),
                        rowWidget2(
                            "We are available 24*7 to make sure our clients get what they expect from us, thus, we will provide you with the finest solution to your queries."),
                      ]),
                ),
                pw.Container(
                    height: size.height - 70,
                    width: size.width - 100,
                    // height: size.height,
                    // width: size.width,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Flexible(
                            flex: 1,
                            child: pw.Align(
                                alignment: pw.Alignment.topCenter,
                                child: pw.Text(
                                  "Tax Invoice",
                                  style: textStl25,
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
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.end,
                                    children: [
                                      pw.Text("JR Compliance and Testing Labs",
                                          style: textStl10
                                          // style: pw.TextStyle(fontWeight: pw.FontWeight.bold)
                                          ),
                                      pw.Text(
                                          "Office: 705, 7th Floor,Krishna Apra Tower",
                                          style: textStl10),
                                      pw.Text("Netaji Subhash Place, Pitampura",
                                          style: textStl10),
                                      pw.Text("New Delhi 110034,India",
                                          style: textStl10),
                                      pw.Text("PAN: AALFJ0070E",
                                          style: textStl10),
                                      pw.Text("TAN: DELJ10631F",
                                          style: textStl10),
                                      pw.Text("GST REGN NO: 07AALFJ0070E1ZO",
                                          style: textStl10),
                                    ])
                              ]),
                          pw.Divider(),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text("To,", style: textStl12),
                                      pw.Text("$address\n$pincode",
                                          style: textStl10),
                                      pw.Text("GSTNumber : " + gstNo.toString(),
                                          style: textStl10),
                                      pw.Text(""),
                                    ]),
                                pw.Text("Invoice No. JR" + actualinid,
                                    style: textStl12)
                              ]),
                          pw.SizedBox(height: 10),
                          pw.Text(
                              "Thank You for your consideration!!.\n\r\n\r\nWe admire the opportunity to provide you with the best compliance services, hope we have earned your trust to take this opportunity forward. For more information contact your designated representative or email us at support@jrcompliance.com\n\r\n\r\nTo enhance your convenience, you can make payment either throw Post or electronic remitances",
                              style: textStl10),
                          pw.Divider(color: PdfColors.black, thickness: 0.5),
                          pw.SizedBox(height: 10),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                    "Kind Atten. Mr/Mr's" +
                                        " " +
                                        cusname.toString(),
                                    style: textStl12),
                                pw.Column(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          "Issued On : " +
                                              "" +
                                              DateFormat("dd MMM,yyyy")
                                                  .format(invoicedate1),
                                          style: textStl10),
                                      pw.Text(
                                          "Due Date : " +
                                              "" +
                                              DateFormat("dd MMM,yyyy")
                                                  .format(duedate1),
                                          style: textStl10)
                                    ])
                              ]),
                          pw.SizedBox(height: 10),
                          //   click(),
                          pw.Row(children: [
                            pw.Expanded(
                                flex: 5,
                                child: pw.Container(
                                  child:
                                      pw.Text("#Description", style: textStl12),
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
                                    child:
                                        pw.Text("Unit Cost", style: textStl12),
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
                                    child:
                                        pw.Text("Disc(%)", style: textStl12))),
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
                                        child: pw.Text(
                                            Servicelist[i]["item"].toString(),
                                            style: textStl10),
                                        alignment: pw.Alignment.centerLeft,
                                      )),
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        child:
                                            pw.Text("9983", style: textStl10),
                                        alignment: pw.Alignment.center,
                                      )),
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          child: pw.Text(
                                              Servicelist[i]["rate"]
                                                  .toStringAsFixed(2),
                                              style: textStl10),
                                          alignment: pw.Alignment.centerRight)),
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                            Servicelist[i]["qty"].toString(),
                                            style: textStl10),
                                      )),
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                              Servicelist[i]["disc"]
                                                  .toStringAsFixed(2),
                                              style: textStl10))),
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        alignment: pw.Alignment.centerRight,
                                        child: pw.Text(
                                            Servicelist[i]["price"]
                                                .toStringAsFixed(2),
                                            style: textStl10),
                                      )),
                                ]);
                              },
                            ),
                          ),

                          pw.Expanded(child: pw.SizedBox()),
                          pw.Container(
                              child: pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                selectedValue == "INR"
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
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
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
                                              color: PdfColors.grey,
                                              thickness: 0.5),
                                          pw.Row(children: [
                                            pw.Expanded(
                                                flex: 1,
                                                child: pw.Container(
                                                  alignment:
                                                      pw.Alignment.centerLeft,
                                                  child: pw.Text(
                                                      "Total(${selectedValue}) :",
                                                      style: textStl10),
                                                )),
                                            pw.Expanded(
                                                flex: 1,
                                                child: pw.Container(
                                                  alignment:
                                                      pw.Alignment.centerRight,
                                                  child: pw.Text(
                                                      total == null
                                                          ? "0.00"
                                                          : total
                                                              .toStringAsFixed(
                                                                  2),
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
                                child: pw.Text(
                                    r"Note : " + externalNotes.toString(),
                                    style: textStl10)),
                          ),
                          pw.SizedBox(height: 7.5),
                          pw.Container(
                              child: pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceEvenly,
                                  children: [
                                pw.Expanded(
                                  flex: 4,
                                  child: pw.Container(
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all()),
                                      child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Container(
                                              child: pw.Text(
                                                  "For JR Compliance and Testing Labs",
                                                  style: textStl12Line),
                                              padding: pw.EdgeInsets.only(
                                                  left: 5, bottom: 22),
                                            ),
                                            pw.SizedBox(
                                                height: 50,
                                                width: 100,
                                                child: pw.Image(
                                                  pw.MemoryImage(signImage),
                                                  fit: pw.BoxFit.fill,
                                                )),
                                            pw.Container(
                                                child: pw.Text(
                                                    "  Authorized Signatory",
                                                    style: textStl10),
                                                padding: pw.EdgeInsets.only(
                                                    left: 5, bottom: 2))
                                          ])),
                                ),
                                pw.Expanded(
                                    flex: 4,
                                    child: pw.Container(
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all()),
                                        child: pw.Column(
                                            mainAxisAlignment: pw
                                                .MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Container(
                                                  child: pw.Text(
                                                      "Project Reference Code",
                                                      style: textStl12Line),
                                                  padding: pw.EdgeInsets.only(
                                                      left: 5)),
                                              pw.SizedBox(height: 62),
                                              pw.Container(
                                                  child: pw.Text(
                                                      "Currency : ${selectedValue}",
                                                      style: textStl10),
                                                  padding: pw.EdgeInsets.only(
                                                      left: 5)),
                                              pw.Container(
                                                  child: pw.Text(
                                                      "Customer ID : $cxID",
                                                      style: textStl10),
                                                  padding: pw.EdgeInsets.only(
                                                      left: 5)),
                                              pw.Container(
                                                  child: pw.Text(
                                                      "Project ID : 00000",
                                                      style: textStl10),
                                                  padding: pw.EdgeInsets.only(
                                                      left: 5, bottom: 2))
                                            ]))),
                                pw.Expanded(
                                    //kmikjmnkimki
                                    flex: 4,
                                    child: pw.Container(
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all()),
                                        child: pw.Column(
                                            mainAxisAlignment: pw
                                                .MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Container(
                                                  child: pw.Text(
                                                      " Electronic Remittance",
                                                      style: textStl12Line),
                                                  padding: pw.EdgeInsets.only(
                                                      left: 5)),
                                              pw.SizedBox(height: 9),
                                              pw.Container(
                                                  child: pw.Text(
                                                      "Bank Name: IDFC FIRST BANK",
                                                      style: textStl10),
                                                  padding: pw.EdgeInsets.only(
                                                      left: 5)),
                                              pw.Container(
                                                  child: pw.Text(
                                                      "Account Number: 10041186185",
                                                      style: textStl10),
                                                  padding: pw.EdgeInsets.only(
                                                      left: 5)),
                                              pw.Container(
                                                  child: pw.Text(
                                                      "IFSC Code: IDFB0040101",
                                                      style: textStl10),
                                                  padding: pw.EdgeInsets.only(
                                                      left: 5)),
                                              pw.Container(
                                                  child: pw.Text(
                                                      "SWIFT Code: IDFBINBBMUM",
                                                      style: textStl10),
                                                  padding: pw.EdgeInsets.only(
                                                      left: 5)),
                                              pw.Container(
                                                  child: pw.Text(
                                                      "Bank Address: Rohini, New Delhi-110085",
                                                      style: textStl10),
                                                  padding: pw.EdgeInsets.only(
                                                      left: 5, bottom: 2)),
                                            ]))),
                              ])),
                          pw.SizedBox(height: 5),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(top: 5.0),
                                        child: pw.Container(
                                          decoration: pw.BoxDecoration(
                                              borderRadius:
                                                  pw.BorderRadius.circular(2.0),
                                              color: PdfColors.black),
                                          height: 3,
                                          width: 3,
                                        ),
                                      ),
                                      pw.SizedBox(width: 10),
                                      pw.Flexible(
                                        flex: 2,
                                        child: pw.Container(
                                          child: pw.RichText(
                                            text: pw.TextSpan(
                                              text: "",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                              children: [
                                                pw.TextSpan(
                                                    text:
                                                        "The services provided by JR Compliance are governed by our",
                                                    style: pw.TextStyle(
                                                      fontSize: 7,
                                                    )),
                                                pw.TextSpan(
                                                    text:
                                                        "Terms and conditions.",
                                                    style: pw.TextStyle(
                                                      decoration: pw
                                                          .TextDecoration
                                                          .underline,
                                                      color: PdfColors.blue,
                                                      fontSize:
                                                          7, /*color:PdfColor.fromHex(Colors.blue)*/
                                                    )),
                                                pw.TextSpan(
                                                  text:
                                                      "In case you face difficulty in obtaining our Terms and conditions from our official website, contact your designated representative immediately to receive a copy of the same.",
                                                  style: pw.TextStyle(
                                                    fontSize: 7,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(top: 5.0),
                                        child: pw.Container(
                                          decoration: pw.BoxDecoration(
                                              borderRadius:
                                                  pw.BorderRadius.circular(2.0),
                                              color: PdfColors.black),
                                          height: 3,
                                          width: 3,
                                        ),
                                      ),
                                      pw.SizedBox(width: 10),
                                      pw.Flexible(
                                        flex: 2,
                                        child: pw.Container(
                                          child: pw.RichText(
                                            text: pw.TextSpan(
                                              text: "",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
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
                                                      decoration: pw
                                                          .TextDecoration
                                                          .underline,
                                                      color: PdfColors.blue,
                                                      fontSize: 7,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(top: 5.0),
                                        child: pw.Container(
                                          decoration: pw.BoxDecoration(
                                              borderRadius:
                                                  pw.BorderRadius.circular(2.0),
                                              color: PdfColors.black),
                                          height: 3,
                                          width: 3,
                                        ),
                                      ),
                                      pw.SizedBox(width: 10),
                                      pw.Flexible(
                                        flex: 2,
                                        child: pw.Container(
                                          child: pw.RichText(
                                            text: pw.TextSpan(
                                              text: "",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
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
                                      )
                                    ]),
                              ]),
                        ])),
                pw.Container(
                    height: size.height - 70,
                    width: size.width - 100,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          space2(),
                          pw.Align(
                              alignment: pw.Alignment.topLeft,
                              child: pw.Text("Payment Terms:",
                                  style: textStl18bold)),
                          space2(),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(right: 50),
                            child: pw.Container(
                              height: size.height * 0.2,
                              child: pw.Table(
                                  border: pw.TableBorder(
                                      left: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      right: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      top: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      horizontalInside: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      verticalInside: pw.BorderSide(
                                          color: PdfColors.grey300)),
                                  children: [
                                    pw.TableRow(
                                        // This is the third row for the table
                                        children: [
                                          pw.Padding(
                                            padding: pw.EdgeInsets.all(8.0),
                                            child: pw.Flexible(
                                              flex: 1,
                                              child: pw.Text(
                                                "50% Advance",
                                                style: textStl12bold,
                                              ),
                                            ),
                                          ),
                                          pw.Padding(
                                            padding: pw.EdgeInsets.all(8.0),
                                            child: pw.Flexible(
                                              flex: 1,
                                              child: pw.Text(
                                                "At the time of starting up the project",
                                                style: textStl12bold,
                                              ),
                                            ),
                                          ),
                                        ]),
                                    pw.TableRow(children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "30%",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "At the time of sharing Draft report",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "20%",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "At the time of Project Competition",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ]),
                            ),
                          ),
                          space3(),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text(
                                  r'''All Payments will be made to "JR Compliance & Testing Labs"''',
                                  style: textStl12bold)),
                          space(),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(right: 50),
                            child: pw.Container(
                              height: size.height * 0.3,
                              child: pw.Table(
                                  border: pw.TableBorder(
                                      left: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      right: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      top: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      horizontalInside: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      verticalInside: pw.BorderSide(
                                          color: PdfColors.grey300)),
                                  children: [
                                    pw.TableRow(
                                        // This is the third row for the table
                                        children: [
                                          pw.Padding(
                                            padding: pw.EdgeInsets.all(8.0),
                                            child: pw.Flexible(
                                              flex: 1,
                                              child: pw.Text(
                                                "Bank Name",
                                                style: textStl12bold,
                                              ),
                                            ),
                                          ),
                                          pw.Padding(
                                            padding: pw.EdgeInsets.all(8.0),
                                            child: pw.Flexible(
                                              flex: 1,
                                              child: pw.Text(
                                                "IDFC FIRST BANK",
                                                style: textStl12bold,
                                              ),
                                            ),
                                          ),
                                        ]),
                                    pw.TableRow(children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "Account Number",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "10041186185",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "IFSC Code",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "IDFB0040101",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "SWIFT Code",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "IDFBINBBMUM",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "Bank Address",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "Rohini New Delhi-110085",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ]),
                            ),
                          ),
                          space3(),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text("Terms & Condition :",
                                  style: textStl18bold)),
                          space2(),
                          rowWidget2link(
                              "The services provided by JR Compliance are governed by our ",
                              "https://www.jrcompliance.com/terms-and-conditions. ",
                              "In case you face difficulty in obtaining our Terms and conditions from our official website, contact your designated representative immediately to receive a copy of the same."),
                          space2(),
                          rowWidget2link(
                              "To	know	the	information	regarding	purchase	and	billing,visit - ",
                              "https://www.jrcompliance.com/purchase-and-billing.	"),
                          space2(),
                          rowWidget2link(
                              "To know more about our privacy policies, visit - ",
                              "https://www.jrcompliance.com/privacy-policy"),
                        ])),
                pw.Container(
                    height: size.height - 70,
                    width: size.width - 100,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Align(
                              alignment: pw.Alignment.topCenter,
                              child: pw.Flexible(
                                  flex: 1,
                                  child: pw.Text("Proposal Authorization",
                                      style: textStl25))),
                          space4(),
                          pw.Paragraph(
                              text:
                                  "To show your acceptance to the proposal, please have an Authorized Representative fill the required information in this document. Once done, please return the proposal and completed Sample Submission Form to the attention of your JR Compliance Representative.",
                              style: textStl12bold),
                          space2(),
                          pw.Paragraph(
                              text:
                                  "Moreover, a copy of the signed purchase order is required before moving forward with other requirements of projects. With that, if a project will take place at premises of JR Compliance please make sure to provide sample disposition instructions.",
                              style: textStl12bold),
                          space2(),
                          pw.Paragraph(
                              text:
                                  "By signing this proposal, you confirm that you have read and accepted our terms and conditions to proceed with the work as outlined in this document.",
                              style: textStl12bold),
                          space2(),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(right: 50),
                            child: pw.Container(
                              height: size.height * 0.25,
                              child: pw.Table(
                                  border: pw.TableBorder(
                                      left: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      right: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      top: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      bottom: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      horizontalInside: pw.BorderSide(
                                          color: PdfColors.grey300),
                                      verticalInside: pw.BorderSide(
                                          color: PdfColors.grey300)),
                                  children: [
                                    pw.TableRow(
                                        // This is the third row for the table
                                        children: [
                                          pw.Padding(
                                            padding: pw.EdgeInsets.all(8.0),
                                            child: pw.Flexible(
                                              flex: 1,
                                              child: pw.Text(
                                                "Accepted by",
                                                style: textStl12bold,
                                              ),
                                            ),
                                          ),
                                          pw.Padding(
                                            padding: pw.EdgeInsets.all(8.0),
                                            child: pw.Flexible(
                                              flex: 1,
                                              child: pw.Text(
                                                "dynamic Accepted by",
                                                style: textStl12bold,
                                              ),
                                            ),
                                          ),
                                        ]),
                                    pw.TableRow(children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "Name of Person",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "dynamic Name of Person",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "Entity Name",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "dynamic Entity Name",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "Signature",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Flexible(
                                          flex: 1,
                                          child: pw.Text(
                                            "dynamic Signature",
                                            style: textStl12bold,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ]),
                            ),
                          ),
                          space3(),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text(
                                  "Thank you for choosing us as your Compliance Partner!!",
                                  style: textStl12Italic)),
                        ])),
              ]),
            ];
          },
          footer: (context) {
            final text = 'Page ${context.pageNumber} of ${context.pagesCount}';
            return pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Flexible(
                  flex: 1,
                  child: pw.Text(text.toString(), style: textStl8bold),
                ));
            //   pw.Row(children: [
            //   pw.Column(children: [
            //     pw.Row(children: [pw.Icon(pw.IconData(0xe126))])
            //   ]),
            //
            // ]);
          }),
    );
    Uint8List bytes = await pdf.save();
    print(bytes);
    try {
      print(1);
      FirebaseStorage storage = FirebaseStorage.instance;
      print(2);
      TaskSnapshot upload = await storage
          .ref("Services/FMCSServices/${fmcsserviceid}")
          .putData(bytes);
      print(3);
      myUrl = await upload.ref.getDownloadURL();
      print(4);
      print(myUrl);
      print(5);
    } on Exception catch (e, s) {
      print(e.toString());
      print(s.toString());
    }
    // Provider.of<InvoiceSaveProvider>(context, listen: false).invoiceData(
    //     myUrl,
    //     activeid,
    //     "Pending",
    //     actualinid,
    //     total,
    //     selectedValue,
    //     duedate,
    //     internalNotes,
    //     externalNotes,
    //     referenceID,
    //     cxID,
    //     LeadId);
    print(6);
    return pdf.save();
  }
}
