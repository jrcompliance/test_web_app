import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing%202.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:test_web_app/Models/UserModels.dart';

class PdfISIService {
  static generatePdf(
    BuildContext context,
  ) async {
    Size size = MediaQuery.of(context).size;
    // DateTime? invoicedate1 = DateTime.parse(invoicedate);
    // DateTime? duedate1 = DateTime.parse(duedate);

    final image =
        (await rootBundle.load("assets/Logos/jrlogo.png")).buffer.asUint8List();
    final bislogo = (await rootBundle.load("assets/Logos/BIS_logo.png"))
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
      // font: fontBold
    );
    final textStl15bold = pw.TextStyle(
      // height: 1.5,
      fontSize: 15,
      fontWeight: pw.FontWeight.bold,
      letterSpacing: 1.0,
      lineSpacing: 2.0,
      color: PdfColors.black,
      // font: fontBold
    );
    final textStl15boldblu = pw.TextStyle(
      // height: 1.5,
      fontSize: 15,
      fontWeight: pw.FontWeight.bold,
      letterSpacing: 1.0,
      lineSpacing: 2.0,
      color: PdfColors.blue,
      // font: fontBold
    );
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
    final textStl18 = pw.TextStyle(
      // height: 1.5,
      fontSize: 18,
      fontWeight: pw.FontWeight.bold,
      letterSpacing: 1.0,
      lineSpacing: 2.0,
      color: PdfColors.black,
      // font: fontBold
    );
    final textStl12Line = pw.TextStyle(
      // height: 1.5,
      fontSize: 12,
      fontWeight: pw.FontWeight.bold,
      decoration: pw.TextDecoration.underline,
      letterSpacing: 1.0,
      lineSpacing: 2.0,
      color: PdfColors.black,
    );
    pw.SizedBox space2() {
      return pw.SizedBox(height: size.height * 0.02);
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
                        height: size.height * 0.3,
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
                          child: pw.SizedBox(
                              height: size.height * 0.4,
                              child: pw.Text(servicedesc, style: textStl12))),
                    ]),
              ),
            ]),
      );
    }

    String? myUrl;
    final bgImage = (await rootBundle.load("assets/Images/invoicebg.png"))
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
                            style: textStl18,
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
                    height: size.height - 80,
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
                        pw.Flexible(
                          flex: 1,
                          child: pw.Text(
                            "Thank you for choosing JR Compliance",
                            style: textStl12,
                          ),
                        ),
                        space2(),
                        pw.Expanded(
                            flex: 3,
                            child: pw.Paragraph(
                                text:
                                    r"""Thank you for Choosing JR Compliance for your compliance requirements & we very excited about our new partnership, and sincerely welcome you for being  a part  of our extended family.I look forward to a long and fruitful relationship between our two businesses.""",
                                style: textStl12)
                            // child: pw.Text(
                            //   r"""Thank you for Choosing JR Compliance for your compliance requirements & we very excited about our new partnership, and sincerely welcome you for being  a part  of our extended family.I look forward to a long and fruitful relationship between our two businesses.""",
                            //   style: textStl12,
                            // ),
                            ),
                        space2(),
                        pw.Expanded(
                            flex: 9,
                            child: pw.Paragraph(
                                text:
                                    r"""JR Compliance established in 2013 is amongst the First Few Compliance Companies in India to provide all kind of Complex Technical Compliance solutions under one Roof. Today we have Customers in 20+ Countries including top brands of the world and we are proud to tellyou that JR Compliance is awarded by Future Business Awards 2020 AS "Best Diversified Compliance  & Legal  Service  provider  in India".We are the first  Technical  Compliance Company in India to receive this prestigious award. We are also ISO 9001:2015 Certified company and featured in many International & National News at several stages & Have highest number of satisfied global clients. Hope our relationship will touch new heights innear future. We will be highly obliged by becoming your Preferred Compliance partner.""",
                                style: textStl12)
                            // child: pw.Text(
                            //   r"""JR Compliance established in 2013 is amongst the First Few Compliance Companies in India to provide all kind of Complex Technical Compliance solutions under one Roof. Today we have Customers in 20+ Countries including top brands of the world and we are proud to tellyou that JR Compliance is awarded by Future Business Awards 2020 AS "Best Diversified Compliance  & Legal  Service  provider  in India".We are the first  Technical  Compliance Company in India to receive this prestigious award. We are also ISO 9001:2015 Certified company and featured in many International & National News at several stages & Have highest number of satisfied global clients. Hope our relationship will touch new heights innear future. We will be highly obliged by becoming your Preferred Compliance partner.""",
                            //   style: textStl12,
                            // ),
                            ),
                        space2(),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Paragraph(
                                text:
                                    r"""We, JR Compliance & Testing Labs, come up with superior regulatory and certification services. We strive to proceed in an expedient and efficient manner in order to meet the client's time constraints without compromising accuracy of test methods and results. We maintain flexible, adaptable and positive attitude while handling client's project.We apprised of all industry changes so as to always be able to provide our client with the most updated regulatory requirements.""",
                                style: textStl12)
                            // child: pw.Text(
                            //   r"""We, JR Compliance & Testing Labs, come up with superior regulatory and certification services. We strive to proceed in an expedient and efficient manner in order to meet the client's time constraints without compromising accuracy of test methods and results. We maintain flexible, adaptable and positive attitude while handling client's project.We apprised of all industry changes so as to always be able to provide our client with the most updated regulatory requirements.""",
                            //   style: textStl12,
                            // ),
                            ),
                        space2(),
                        pw.Flexible(
                          flex: 2,
                          child: pw.Text(
                            r"Looking forward to working with you & be associated with your organization so that we can start this valuable project.",
                            style: textStl12,
                          ),
                        ),
                        space2(),
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
                            "tarun@jrompliance.com",
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
                    height: size.height - 80,
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
                    height: size.height - 80,
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
                              bislogo),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text(
                                  "The mentioned act has been revised as BIS Act, 2016 and establishes BIS as the National Standards Body authorizes to undertake conformity assessment of products, services, systems and processes.",
                                  style: textStl12)),
                          space2(),
                          pw.Flexible(
                              flex: 1,
                              child: pw.Text(
                                  "The product certification of BIS aims at providing Third Party assurance of quality, safety and reliability of products to the customer. Presence of BIS certification mark, known as Standard Mark, on a product is an assurance of conformity to the specifications.",
                                  style: textStl12)),
                          space2(),
                          pw.Flexible(
                              flex: 1,
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
                          pw.Padding(
                            padding: pw.EdgeInsets.only(left: 30),
                            child: rowWidget('FMCS certification scheme',
                                'applicabe on foreign manufacturers'),
                          ),
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
                        ])),
                pw.Container(
                  height: size.height - 100,
                  width: size.width - 100,
                  // height: size.height,
                  // width: size.width,
                  child: pw.Text("dhsiufewhiofewf"),
                ),
                pw.Container(
                  height: size.height - 100,
                  width: size.width - 100,
                  // height: size.height,
                  // width: size.width,
                  child: pw.Text("dhsiufewhiofewf"),
                ),
                pw.Container(
                  height: size.height - 100,
                  width: size.width - 100,
                  // height: size.height,
                  // width: size.width,
                  child: pw.Text("dhsiufewhiofewf"),
                ),

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
      TaskSnapshot upload =
          await storage.ref("Services/BIS-ISI.pdf").putData(bytes);
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
