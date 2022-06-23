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

class PdfISIService {
  static generatePdf(BuildContext context, int isiserviceid) async {
    Size size = MediaQuery.of(context).size;
    // DateTime? invoicedate1 = DateTime.parse(invoicedate);
    // DateTime? duedate1 = DateTime.parse(duedate);

    final image =
        (await rootBundle.load("assets/Logos/jrlogo.png")).buffer.asUint8List();
    final bislogo = (await rootBundle.load("assets/Logos/BIS_logo.png"))
        .buffer
        .asUint8List();
    final isilogo = (await rootBundle.load("assets/Logos/ISI_logo1.png"))
        .buffer
        .asUint8List();
    final signImage =
        (await rootBundle.load("assets/Images/Authorized_Sign.png"))
            .buffer
            .asUint8List();
    final fontBold = await PdfGoogleFonts.alataRegular();

    final nunitolight = await PdfGoogleFonts.nunitoLight();
    final nunitobold = await PdfGoogleFonts.nunitoBold();

    final textStl12 = pw.TextStyle(
        // height: 1.5,
        fontSize: 12,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: nunitolight);
    final textStl12Italic = pw.TextStyle(
        // height: 1.5,
        fontSize: 12,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: nunitolight,
        fontStyle: pw.FontStyle.italic);
    final textStl12bold = pw.TextStyle(
        // height: 1.5,
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: nunitobold);
    final textStl15 = pw.TextStyle(
        // height: 1.5,
        fontSize: 15,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: nunitolight);
    final textStl15bold = pw.TextStyle(
        // height: 1.5,
        fontSize: 15,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: nunitobold);
    final textStl15boldblu = pw.TextStyle(
        // height: 1.5,
        fontSize: 15,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.blue,
        font: nunitobold);
    final textStl25 = pw.TextStyle(
      // height: 1.5,
      fontSize: 25,
      fontWeight: pw.FontWeight.bold,
      letterSpacing: 1.0,
      lineSpacing: 2.0,
      color: PdfColors.black,
      // font: fontBold
    );
    final textStl25blu = pw.TextStyle(
      // height: 1.5,
      fontSize: 25,
      fontWeight: pw.FontWeight.bold,
      letterSpacing: 1.0,
      lineSpacing: 2.0,
      color: PdfColors.blue,
      // font: fontBold
    );
    final textStl18bold = pw.TextStyle(
        // height: 1.5,
        fontSize: 18,
        fontWeight: pw.FontWeight.bold,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: nunitobold);
    final textStl12Line = pw.TextStyle(
        // height: 1.5,
        fontSize: 12,
        decoration: pw.TextDecoration.underline,
        letterSpacing: 1.0,
        lineSpacing: 2.0,
        color: PdfColors.black,
        font: nunitolight);
    pw.SizedBox space2() {
      return pw.SizedBox(height: size.height * 0.02);
    }

    pw.VerticalDivider verticalDivider() {
      return pw.VerticalDivider(
          width: 1.0, thickness: 1.0, color: PdfColors.grey300);
    }

    pw.Flexible steps(step, text) {
      return pw.Flexible(
          flex: 1,
          child: pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(text: step, style: textStl12bold),
                pw.TextSpan(text: " - ", style: textStl12bold),
                pw.TextSpan(text: text, style: textStl12),
              ],
            ),
          ));
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
              pw.TextSpan(text: text1, style: textStl12bold),
              pw.TextSpan(text: ",", style: textStl12),
              pw.TextSpan(text: text2, style: textStl12),
            ],
          ),
        )
      ]);
    }

    pw.Row rowWidget2(
      text1,
    ) {
      return pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Container(
          decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(2.0),
              color: PdfColors.black),
          height: 5,
          width: 5,
        ),
        pw.SizedBox(width: 10),
        pw.Expanded(
          flex: 2,
          child: pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(text: text1, style: textStl12),
              ],
            ),
          ),
        ),
      ]);
    }

    pw.Row rowWidget2link(text1, text2, [text3]) {
      return pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Container(
          decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(2.0),
              color: PdfColors.black),
          height: 5,
          width: 5,
        ),
        pw.SizedBox(width: 10),
        pw.Expanded(
            flex: 3,
            child: pw.RichText(
              text: pw.TextSpan(
                children: [
                  pw.TextSpan(text: text1, style: textStl12),
                  pw.TextSpan(text: text2, style: textStl12Line),
                  pw.TextSpan(text: text3, style: textStl12),
                ],
              ),
            ))
      ]);
    }

    pw.SizedBox space() {
      return pw.SizedBox(height: size.height * 0.01);
    }

    pw.Expanded servicerow(servicetext1, servicetext2, servicedesc, image1) {
      return pw.Expanded(
        flex: 3,
        child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.only(bottom: 20),
                child: pw.Expanded(
                    flex: 3,
                    child: pw.SizedBox(
                        height: size.height * 0.35,
                        width: 150,
                        child: pw.Image(pw.MemoryImage(image1),
                            fit: pw.BoxFit.cover))),
              ),
              pw.Expanded(
                flex: 7,
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        flex: 1,
                        child: pw.RichText(
                            softWrap: true,
                            text: pw.TextSpan(children: [
                              pw.TextSpan(
                                  text: servicetext1, style: textStl15boldblu),
                              pw.TextSpan(text: " ", style: textStl15bold),
                              pw.TextSpan(
                                  text: servicetext2, style: textStl15bold),
                            ])),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Expanded(
                        flex: 6,
                        child: pw.Text(
                          servicedesc,
                          style: textStl12,
                        ),
                      )
                    ]),
              ),
            ]),
      );
    }

    String? myUrl;
    final bgImage = (await rootBundle.load("assets/Images/servicebg2.png"))
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
                            style: textStl12,
                          ),
                        ),

                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            cusname.toString(),
                            style: textStl12,
                          ),
                        ),

                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Place",
                            style: textStl12,
                          ),
                        ),

                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "District",
                            style: textStl12,
                          ),
                        ),

                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "State",
                            style: textStl12,
                          ),
                        ),

                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Country",
                            style: textStl12,
                          ),
                        ),

                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Pincode",
                            style: textStl12,
                          ),
                        ),

                        for (int i = 0; i <= 1; i++) space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            cusemail.toString(),
                            style: textStl12,
                          ),
                        ),

                        for (int i = 1; i <= 2; i++) space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Date : ${DateFormat('dd MMMM ,yyyy').format(DateTime.now())}"
                                .toUpperCase(),
                            style: textStl18bold,
                          ),
                        ),

                        for (int i = 1; i <= 3; i++) space2(),
                        //   pw.Flexible(flex: 1,child: ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Quotation No:",
                            style: textStl12bold,
                          ),
                        ),

                        space(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "487256484",
                            style: textStl12,
                          ),
                        ),
                        for (int i = 1; i <= 3; i++) space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Subject: IS 14286 Quotation under Mandatory BIS-CRS certification controlled by Ministry of New and Renewable Energy",
                            style: textStl12,
                          ),
                        ),
                        for (int i = 1; i <= 3; i++) space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Prepared By : Mr.Tarun Sadana",
                            style: textStl12,
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
                        space2(),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            cusname.toString(),
                            style: textStl12bold,
                          ),
                        ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Place",
                            style: textStl12bold,
                          ),
                        ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "District",
                            style: textStl12bold,
                          ),
                        ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "State",
                            style: textStl12bold,
                          ),
                        ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Country",
                            style: textStl12bold,
                          ),
                        ),
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
                            "Hello,",
                            style: textStl12,
                          ),
                        ),
                        space(),
                        pw.RichText(
                            text: pw.TextSpan(children: [
                          pw.TextSpan(
                              text:
                                  "Thank you for choosing JR Compliance as your compliance partner, we admire the opportunity to provide you with the ",
                              style: textStl12),
                          pw.TextSpan(
                              text: "best compliance services ",
                              style: textStl12Italic),
                          pw.TextSpan(
                              text: "and are sincerely ", style: textStl12),
                          pw.TextSpan(
                              text: "welcoming you to our family.",
                              style: textStl12Italic),
                        ])),
                        space(),
                        pw.RichText(
                            text: pw.TextSpan(children: [
                          pw.TextSpan(
                              text:
                                  "JR Compliance - Indian’s #1 compliance service provider was established in 2013 with the fundamental motive to make compliance seamless worldwide. We are proud to admit that we stand proudly among a few compliance service providers, who provide Indian and Global certification services under one roof. Till date, we have served more than ",
                              style: textStl12),
                          pw.TextSpan(
                              text: "10,000 + Indian and Global brands ",
                              style: textStl12bold),
                          pw.TextSpan(
                              text:
                                  "such as Softbank, Troy, and Bombay Dyeing. With that, we pride ourselves that we have been awarded by Future Business Awards 2020 AS ",
                              style: textStl12),
                          pw.TextSpan(
                              text:
                                  r'''"Best Diversified Compliance & Legal Service provider in India"''',
                              style: textStl12bold),
                        ])),
                        space(),
                        pw.RichText(
                            text: pw.TextSpan(children: [
                          pw.TextSpan(
                              text:
                                  "Moreover, we are pleased to inform you that we are the first Technical Compliance Company in India to receive this prestigious award and are also ",
                              style: textStl12),
                          pw.TextSpan(
                              text: "ISO 9001:2015 ", style: textStl12bold),
                          pw.TextSpan(
                              text:
                                  "Certified company and featured in many National and International news platforms such as Deccan Chronicle, Hindustan Times, Zee News, and more.",
                              style: textStl12),
                        ])),
                        space(),
                        pw.Paragraph(
                          text:
                              r"We are constantly working to provide superior regulatory and certification services to our clients to strive for excellence within defined time constraints, that too without compromising the accuracy of test methods and results. Additionally, at JR Compliance we are committed to provide responsive and competitive services to our clients by maintaining flexibility, adaptability, and a positive attitude while handling your project.",
                          style: textStl12,
                        ),
                        pw.Paragraph(
                          text:
                              r"Looking forward to working with you & be associated with your organization so that we can start this valuable project.",
                          style: textStl12,
                        ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Thank you!",
                            style: textStl12,
                          ),
                        ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Regards",
                            style: textStl12,
                          ),
                        ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Mr.Tarun Sadana",
                            style: textStl12,
                          ),
                        ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Sales & Marketing - BDE",
                            style: textStl12,
                          ),
                        ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "tarun@jrcompliance.com",
                            style: textStl12,
                          ),
                        ),
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "www.jrompliance.com",
                            style: textStl12,
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
                          space(),
                          pw.Align(
                              alignment: pw.Alignment.topCenter,
                              child: pw.Text("INTRODUCTION", style: textStl25)),
                          space2(),
                          servicerow(
                              "BIS",
                              "OVERVIEW",
                              "BIS is an acronym for Bureau of Indian Standard, it is a certification body that impart the product's quality, safety, and credibility of the brands, manufacturers, and producers to the customers. It came into existence through an act of parliament dated 26 November 1986, on 1 April 1987.",
                              bislogo),
                          space2(),
                          pw.Flexible(
                              flex: 2,
                              child: pw.Text(
                                  "The mentioned act has been revised as BIS Act, 2016 and establishes BIS as the National Standards Body authorizes to undertake conformity assessment of products, services, systems and processes.",
                                  style: textStl12)),
                          space2(),
                          pw.Flexible(
                              flex: 2,
                              child: pw.Text(
                                  "The product certification of BIS aims at providing Third Party assurance of quality, safety and reliability of products to the customer. Presence of BIS certification mark, known as Standard Mark, on a product is an assurance of conformity to the specifications.",
                                  style: textStl12)),
                          space2(),
                          pw.Flexible(
                              flex: 2,
                              child: pw.Text(
                                  "Moreover, to maintain a close vigil on quality of the products, BIS conducts surveillance operations or regular surveillance of the licensee's performance by surprise inspections and testing of samples, drawn both from the market/factory.",
                                  style: textStl12)),
                          space2(),
                          pw.Padding(
                              padding: pw.EdgeInsets.only(left: 20),
                              child: pw.Flexible(
                                flex: 1,
                                child: pw.Text(
                                    "BIS certification includes three certification schemes -",
                                    style: textStl12),
                              )),
                          space2(),
                          pw.Padding(
                              padding: pw.EdgeInsets.only(left: 30),
                              child: rowWidget('ISI certification scheme',
                                  'applicabe on Indian manufacturers')),
                          space(),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(left: 30),
                            child: rowWidget('FMCS certification scheme',
                                'applicabe on foreign manufacturers'),
                          ),
                          space(),
                          pw.Padding(
                              padding: pw.EdgeInsets.only(left: 30),
                              child: rowWidget('CRS registration scheme',
                                  'applicabe on electric and electronic appliances')),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text(
                                  "Since your products fall under purview of the ISI certification scheme, we will emphasize on that, in the next section.",
                                  style: textStl12)),
                        ])

                    // child: pw.Text(
                    //     "COMPLIANCE AUTHORITY INTRODUCTION",style: textStl25),
                    ),
                pw.Container(
                    height: size.height - 70,
                    width: size.width - 100,
                    // height: size.height,
                    // width: size.width,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          servicerow(
                              "ISI",
                              "CERTIFICATION",
                              "ISI is an acronym of Indian Standard Institute (ISI), it comes under Scheme - I of Schedule - II of BIS (Conformity Assessment) Regulations, 2016. ISI mark is granted to Indian manufacturers on the successful assessment of manufacturing infrastructure, production process, quality control, and testing capabilities through conducting a factory inspection and product testing.",
                              isilogo),
                          space2(),
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
                                        text: "ISI ", style: textStl25blu),
                                    pw.TextSpan(
                                        text: "CERTIFICATION",
                                        style: textStl25),
                                  ]),
                                )),
                          ),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: rowWidget2(
                                "Prevent from imposition of penalty",
                              )),
                          pw.SizedBox(height: 10),
                          pw.Flexible(
                              flex: 1,
                              child: rowWidget2(
                                "Edge over competitors.",
                              )),
                          pw.SizedBox(height: 10),
                          pw.Flexible(
                              flex: 1,
                              child: rowWidget2(
                                "Easy market access.",
                              )),
                          pw.SizedBox(height: 10),
                          pw.Flexible(
                              flex: 1,
                              child: rowWidget2(
                                "Builds brand’s credibility.",
                              )),
                          pw.SizedBox(height: 10),
                          pw.Flexible(
                              flex: 1,
                              child: rowWidget2(
                                "Confirms impeccable quality standards.",
                              )),
                          space2(),
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
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child:
                                  steps("Step 1", "Filing application form.")),
                          pw.SizedBox(height: 10),
                          pw.Flexible(
                              flex: 1,
                              child: steps("Step 2",
                                  "Factory inspection will be conducted.")),
                          pw.SizedBox(height: 10),
                          pw.Flexible(
                              flex: 1,
                              child: steps("Step 3",
                                  "Product samples will be withdrawn for testing.")),
                          pw.SizedBox(height: 10),
                          pw.Flexible(
                              flex: 1,
                              child: steps("Step 4",
                                  "Product test report will be reviewed.")),
                          pw.SizedBox(height: 10),
                          pw.Flexible(
                              flex: 1,
                              child:
                                  steps("Step 5", " Issuance of certificate.")),
                          space2(),
                          pw.Flexible(
                            flex: 2,
                            child: pw.RichText(
                                text: pw.TextSpan(children: [
                              pw.TextSpan(
                                  text:
                                      "We assure you that you have chosen the right consultant. We have provided ",
                                  style: textStl12),
                              pw.TextSpan(
                                  text:
                                      "error-free services to over 10,000+ clients ",
                                  style: textStl12bold),
                              pw.TextSpan(
                                  text:
                                      "and to brands like Bombay dyeing, Troy, Softbank and more.",
                                  style: textStl12),
                            ])),
                          ),
                        ])),
                pw.Container(
                  height: size.height - 70,
                  width: size.width - 100,
                  // height: size.height,
                  // width: size.width,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Flexible(
                            flex: 1,
                            child: pw.Text(
                                "Following standards will be applicable on your Solar Modules :",
                                style: textStl12)),
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
                        space2(),
                        pw.Flexible(
                            flex: 1,
                            child: pw.Text("3771PRO-003771",
                                style: textStl18bold)),
                        space(),
                        pw.Flexible(
                            flex: 1,
                            child: pw.Text("Details:", style: textStl15bold)),
                        pw.Container(
                            height: size.height * 0.2,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(5.0),
                              border: pw.Border.all(color: PdfColors.grey300),
                            ),
                            child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Text("Prepared For",
                                          style: textStl12bold)),
                                  verticalDivider(),
                                  pw.Expanded(
                                      flex: 4,
                                      child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text(
                                                    cusname.toString(),
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text(
                                                    "customer address",
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text("district",
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text("state",
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text("country",
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text(
                                                    cusemail.toString(),
                                                    style: textStl12)),
                                          ])),
                                  verticalDivider(),
                                  pw.Expanded(
                                      flex: 1,
                                      child: pw.Text("Issued By",
                                          style: textStl12bold)),
                                  verticalDivider(),
                                  pw.Expanded(
                                      flex: 4,
                                      child: pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Flexible(
                                                flex: 2,
                                                child: pw.Text(
                                                    "JR Compliance & Testing Labs",
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 2,
                                                child: pw.Text(
                                                    "705,7th Floor,Krisha Apra Tower",
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text(
                                                    "Netaji Subhash Place",
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text("Pitampura",
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text(
                                                    "New Delhi-110034",
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text("India",
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text(
                                                    "tarun@jrcompliance.com",
                                                    style: textStl12)),
                                            pw.Flexible(
                                                flex: 1,
                                                child: pw.Text(
                                                    "+91 9599550680".toString(),
                                                    style: textStl12)),
                                          ])),
                                ])),
                        space2(),
                        pw.Flexible(
                            flex: 1,
                            child: pw.Text("Project Escalation Levels",
                                style: textStl12)),
                        space2(),
                        pw.Container(
                          height: size.height * 0.2,
                          child: pw.Table(
                              border: pw.TableBorder(
                                  left: pw.BorderSide(color: PdfColors.grey300),
                                  right:
                                      pw.BorderSide(color: PdfColors.grey300),
                                  top: pw.BorderSide(color: PdfColors.grey300),
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey300),
                                  horizontalInside:
                                      pw.BorderSide(color: PdfColors.grey300),
                                  verticalInside:
                                      pw.BorderSide(color: PdfColors.grey300)),
                              children: [
                                pw.TableRow(
                                    // This is the third row for the table
                                    children: [
                                      pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            "BDE - Mr.Tarun Sadana",
                                            style: textStl12,
                                          ),
                                          pw.Text(""),
                                        ],
                                      ),
                                      pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  "Primary Level",
                                                  style: textStl12,
                                                ),
                                                pw.Text(
                                                    "tarun@jrcompliance.com",
                                                    style: textStl12),
                                              ]),
                                        ],
                                      ),
                                      pw.Padding(
                                        padding: pw.EdgeInsets.all(4),
                                        child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Column(
                                                crossAxisAlignment:
                                                    pw.CrossAxisAlignment.start,
                                                children: [
                                                  pw.Text(
                                                    "",
                                                    style: textStl12,
                                                  ),
                                                  pw.Text("+91 9599550680",
                                                      style: textStl12),
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ]),
                                pw.TableRow(children: [
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          "VP - Mr.Lalit Gupta",
                                          style: textStl12,
                                        ),
                                        pw.Text("", style: textStl12),
                                      ]),
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          "Priority",
                                          style: textStl12,
                                        ),
                                        pw.Text("lalit@jrcompliance.com",
                                            style: textStl12),
                                      ]),
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          "",
                                          style: textStl12,
                                        ),
                                        pw.Text("+91 9873060689",
                                            style: textStl12),
                                      ]),
                                ]),
                                pw.TableRow(children: [
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          "CEO - Mr.Rishikesh Mishra",
                                          style: textStl12,
                                        ),
                                        pw.Text("", style: textStl12),
                                      ]),
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          "Urgent",
                                          style: textStl12,
                                        ),
                                        pw.Text("rishi@jrcompliance.com",
                                            style: textStl12),
                                      ]),
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          "",
                                          style: textStl12,
                                        ),
                                        pw.Text("+91 9266450125",
                                            style: textStl12),
                                      ]),
                                ]),
                              ]),
                        ),
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
                        pw.Flexible(
                            flex: 1,
                            child:
                                pw.Text("Scope of Work", style: textStl15bold)),
                        space2(),
                        rowWidget2(
                          "We assist you to know whether a product falls under the purview of concerned authority.",
                        ),
                        space2(),
                        rowWidget2(
                            "For comprehensible guidance, we will first scrutinize the certification requirements of a product."),
                        space2(),
                        rowWidget2(
                            "We will provide you information regarding a number of samples required for product testing because product sample requirements differ depending on product type."),
                        space2(),
                        rowWidget2(
                            "We will educate you about the registration process, benefits, documents required, including any query you may have regarding the same."),
                        space2(),
                        rowWidget2(
                            "Being a reputed compliance consultant, we will provide you technical and non- technical support."),
                        space2(),
                        rowWidget2(
                            "JR Compliance offers competitive and excellent services to our clients by meeting the startled queries/demands."),
                        space2(),
                        rowWidget2(
                            "To ensure the utmost convenience of our client, we will also assist you in the custom clearance of the sample product."),
                        space2(),
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
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Align(
                            alignment: pw.Alignment.topCenter,
                            child: pw.Flexible(
                                flex: 1,
                                child: pw.Text("Commercials",
                                    style: textStl15bold))),
                        space2(),
                        pw.Flexible(
                            flex: 2,
                            child: pw.Text(
                                "Project Fees: The fees below are based on the information provided on your request, assumptions as noted previously and are valid for 90 days from date of issuance.",
                                style: textStl12)),
                        space2(),
                        pw.Container(
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.grey300)),
                          child: pw.Row(children: [
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                  child: pw.Text("#", style: textStl12bold),
                                  alignment: pw.Alignment.centerLeft,
                                )),
                            pw.Expanded(
                                flex: 4,
                                child: pw.Container(
                                  child: pw.Text("Item", style: textStl12bold),
                                  alignment: pw.Alignment.centerLeft,
                                )),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Container(
                                    child: pw.Text("Qty", style: textStl12bold),
                                    alignment: pw.Alignment.center)),
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                    alignment: pw.Alignment.center,
                                    child:
                                        pw.Text("Rate", style: textStl12bold))),
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  alignment: pw.Alignment.centerRight,
                                  child: pw.Text("Amount(USD)",
                                      style: textStl12bold),
                                )),
                          ]),
                        ),
                        pw.ConstrainedBox(
                          constraints: pw.BoxConstraints(
                              minHeight: size.height * 0.5,
                              maxHeight: size.height * 0.70),
                          child: pw.ListView.builder(
                            itemCount: 10,
                            itemBuilder: (_, i) {
                              return pw.Row(children: [
                                pw.Expanded(
                                    flex: 1,
                                    child: pw.Container(
                                      child:
                                          pw.Text("${i + 1}", style: textStl12),
                                      alignment: pw.Alignment.centerLeft,
                                    )),
                                pw.Expanded(
                                    flex: 4,
                                    child: pw.Container(
                                      child: pw.Text("Items${i}",
                                          style: textStl12),
                                      alignment: pw.Alignment.centerLeft,
                                    )),
                                pw.Expanded(
                                    flex: 1,
                                    child: pw.Container(
                                        child:
                                            pw.Text("5*${i}", style: textStl12),
                                        alignment: pw.Alignment.center)),
                                pw.Expanded(
                                    flex: 2,
                                    child: pw.Container(
                                      alignment: pw.Alignment.center,
                                      child:
                                          pw.Text("100*${i}", style: textStl12),
                                    )),
                                pw.Expanded(
                                    flex: 2,
                                    child: pw.Container(
                                      alignment: pw.Alignment.centerRight,
                                      child: pw.Text(5000.toStringAsFixed(2),
                                          style: textStl12),
                                    )),
                              ]);
                            },
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Row(children: [
                            pw.Expanded(flex: 8, child: pw.Text("")),
                            pw.Expanded(
                                flex: 2,
                                child: pw.Column(children: [
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          alignment: pw.Alignment.centerRight,
                                          child: pw.Text("TOTAL",
                                              style: textStl12bold))),
                                  pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          alignment: pw.Alignment.centerRight,
                                          child: pw.Text(
                                              5000.toStringAsFixed(2),
                                              style: textStl12bold))),
                                ]))
                          ]),
                        )

                        ///
                      ]),
                ),
                pw.Container(
                    height: size.height - 70,
                    width: size.width - 100,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text("Payments Terms :",
                                  style: textStl15)),
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
                                          pw.Text(
                                            "50% Advance",
                                            style: textStl12,
                                          ),
                                          pw.Text(
                                            "At the time of starting up the project",
                                            style: textStl12,
                                          ),
                                        ]),
                                    pw.TableRow(children: [
                                      pw.Text(
                                        "30%",
                                        style: textStl12,
                                      ),
                                      pw.Text(
                                        "At the time of sharing Draft report",
                                        style: textStl12,
                                      ),
                                    ]),
                                    pw.TableRow(children: [
                                      pw.Text(
                                        "20%",
                                        style: textStl12,
                                      ),
                                      pw.Text(
                                        "At the time of Project Competition",
                                        style: textStl12,
                                      ),
                                    ]),
                                  ]),
                            ),
                          ),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text(
                                  r'''All Payments will be made to "JR Compliance & Testing Labs"''',
                                  style: textStl12)),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text("Bank Name: IDFC FIRST BANK",
                                  style: textStl12)),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text("Account Number: 10041186185",
                                  style: textStl12)),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text("IFSC Code: IDFB0040101",
                                  style: textStl12)),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text("SWIFT Code: IDFBINBBMUM",
                                  style: textStl12)),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text(
                                  "Bank Address: Rohini New Delhi-110085",
                                  style: textStl12)),
                          space2(),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text("Terms & Condition :",
                                  style: textStl15bold)),
                          space(),
                          rowWidget2link(
                              "The services provided by JR Compliance are governed by our ",
                              "https://www.jrcompliance.com/terms-and-conditions. ",
                              "In case you face difficulty in obtaining our Terms and conditions from our official website, contact your designated representative immediately to receive a copy of the same."),
                          space(),
                          rowWidget2link(
                              "To	know	the	information	regarding	purchase	and	billing,visit - ",
                              "https://www.jrcompliance.com/purchase-and-billing.	"),
                          space(),
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
                                      style: textStl15bold))),
                          space2(),
                          space2(),
                          pw.Paragraph(
                              text:
                                  "To show your acceptance to the proposal, please have an Authorized Representative fill the required information in this document. Once done, please return the proposal and completed Sample Submission Form to the attention of your JR Compliance Representative.",
                              style: textStl12),
                          space2(),
                          pw.Paragraph(
                              text:
                                  "Moreover, a copy of the signed purchase order is required before moving forward with other requirements of projects. With that, if a project will take place at premises of JR Compliance please make sure to provide sample disposition instructions.",
                              style: textStl12),
                          space2(),
                          pw.Text(
                              "By signing this proposal, you confirm that you have read and accepted our terms and conditions",
                              style: textStl12),
                          pw.Text(
                              "to proceed with the work as outlined in this document.",
                              style: textStl12),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child:
                                  pw.Text("Accepted by : ", style: textStl12)),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text("Name of Person: ",
                                  style: textStl12)),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child:
                                  pw.Text("Entity Name :", style: textStl12)),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text("Signature", style: textStl12)),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text(
                                  "Thank you for choosing us as your Compliance Partner!!",
                                  style: textStl12bold)),
                        ])),
                // pw.Container(
                //     height: size.height - 70,
                //     width: size.width - 100,
                //     child: pw.Column(
                //         crossAxisAlignment: pw.CrossAxisAlignment.start,
                //         children: [])),

                //
                //
                //
                //
                //
              ]),
            ];
          },
          footer: (context) {
            final text = 'Page ${context.pageNumber} of ${context.pagesCount}';
            return pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Flexible(
                  flex: 1,
                  child: pw.Text(text.toString()),
                ));
          }),
    );
    Uint8List bytes = await pdf.save();
    print(bytes);
    try {
      print(1);
      FirebaseStorage storage = FirebaseStorage.instance;
      print(2);
      TaskSnapshot upload = await storage
          .ref("Services/ISIServices/${isiserviceid}")
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
