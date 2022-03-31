import 'dart:html';
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
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:flutter/gestures.dart';
//import 'package:pdf';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  Color bkcolor = Colors.black;
  List list = [
    "Description",
    "SAC Code",
    "Quantity",
    "Unit Cost",
    "disc",
    "Amount"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Pdf Status"),
      ),
      body: Column(
        children: [
          Center(
            child: FlatButton(
              child: Text("Generate Now"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class PdfProvider {
  static generatePdf(
      List Servicelist, Recievername, tbal, actualinid, _gst, docid,activeid,gstAmount,total) async {
    final image =
        (await rootBundle.load("assets/Logos/jrlogo.png")).buffer.asUint8List();
    final bgImage = (await rootBundle.load("assets/Images/invoicebg.png"))
        .buffer
        .asUint8List();
    final pageTheme = pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 30,right: 30,top: 50,bottom: 20),
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
              pw.Expanded(child: pw.SizedBox()),
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
                        pw.Text("GSTNumber. : " + _gst.toString(),
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(""),
                      ]),
                  pw.Text("Invoice No. JR" + actualinid,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                ]),
            pw.SizedBox(height: 10),
            pw.Text(
                "Thank You for your consideration!!.\n We admire the opportunity to provide you with the best compliance services, hope we have earned your trust to take this opportunity forward. For more information contact your designated representative or email us at support@jrcompliance.com\nTo enhance your convenience, you can make payment either throw Post or electronic remitances",
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal, fontSize: 8)),
            pw.SizedBox(height: 10),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Kind Atten. Mr/Mr's" + " " + Recievername.toString(),
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text(
                            "Issued On." +
                                "" +
                                DateFormat("dd MMM,yyyy")
                                    .format(DateTime.now()),
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text("Payment Due: Paid",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                      ])
                ]),
            pw.SizedBox(height: 10),
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
                          child: pw.Text(Servicelist[i]["rate"].toStringAsFixed(2),
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
                          child: pw.Text(Servicelist[i]["disc"].toStringAsFixed(2),
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold)))),
                  pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(Servicelist[i]["price"].toStringAsFixed(2),
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      )),
                ]);
              },
            ),
            pw.Expanded(child: pw.SizedBox()),
            pw.Container(
             child: pw.Row(
               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                      flex: 5,
                      child: pw.Container(
                        child: pw.Text("IGST/CGST/SGST 18%",
                            style:
                            pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        alignment: pw.Alignment.centerLeft,
                      )),
                  pw.Expanded(
                      flex: 5,
                      child: pw.Container(
                        child: pw.Text(gstAmount.toStringAsFixed(2),
                            style:
                            pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        alignment: pw.Alignment.centerRight,
                      )),
                ]
              )
            ),
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
                        flex:2,
                        child: pw.Text(""),
                      ),
                      pw.Expanded(
                        flex:2,
                        child: pw.Text(""),
                      ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        child:   pw.Text("Total(INR) :",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      )
                    ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(total == null ? "0.00" : total.toStringAsFixed(2),
                              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        )
                      )
                    ],
                  ),
                 pw.Row(
                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: pw.CrossAxisAlignment.end,
                   children: [
                     pw.Expanded(
                       flex:2,
                       child: pw.Text(""),
                     ),
                     pw.Expanded(
                       flex:2,
                       child: pw.Text(""),
                     ),
                     pw.Expanded(
                       flex: 2,
                      child: pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text("Amount Paid(INR) :",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      )
                     ),
                     pw.Expanded(
                       flex: 2,
                       child: pw.Container(
                         alignment: pw.Alignment.centerRight,
                         child: pw.Text(tbal == null ? "0.00" : tbal.toStringAsFixed(2),
                             style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                       )
                     )
                   ]

                 ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Expanded(
                        flex:2,
                        child: pw.Text(""),
                      ),
                      pw.Expanded(
                        flex:2,
                        child: pw.Text(""),
                      ),

                      pw.Expanded(
                        flex: 2,
                        child:
                        pw.Container(
                            alignment: pw.Alignment.centerLeft,
                          child: pw.Text("Balance(INR) :",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold,),
                          )
                        ),
                      ),
                     pw.Expanded(
                       flex: 2,
                      child: pw.Container(
                        alignment: pw.Alignment.centerRight,
                        child:  pw.Text("0.00",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      )
                     )
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(
              height: 10
            ),
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
                                    child: pw.Text("Currency : INR",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold)),
                                    padding: pw.EdgeInsets.only(left: 5)),
                                pw.Container(
                                    child: pw.Text("Customer ID : 00000",
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
           pw.Row(
             children: [
               pw.Bullet(
                   text:"The services provided by JR Compliance are governed by our",style: pw.TextStyle(fontSize: 6,),
               ),


             ]

           ),
           pw.Container(
             child: pw.RichText(
               text: pw.TextSpan(
                 text: ". ",
                 style:pw.TextStyle(fontSize: 6,fontWeight: pw.FontWeight.bold),
                 children:[
                   pw.TextSpan(text:"The services provided by JR Compliance are governed by our",style: pw.TextStyle(fontSize: 6,) ),
                   pw.TextSpan(text: "Terms and conditions.", style: pw.TextStyle(decoration: pw.TextDecoration.underline,fontSize: 6,/*color:PdfColor.fromHex(Colors.blue)*/)),
                   pw.TextSpan(text: "In case you face difficulty in obtaining our Terms and conditions from our official    website, contact your designated representative immediately to receive a copy of the same.", style: pw.TextStyle(fontSize: 6),),
                 ],),),),
           pw.Container(
             child: pw.RichText(
               text: pw.TextSpan(
                 text: ". ",
                 style:pw.TextStyle(fontSize: 6,fontWeight: pw.FontWeight.bold),
                 children:[
                   pw.TextSpan(text:"To know the information regarding purchase and billing.",style: pw.TextStyle(fontSize: 6,) ),
                   pw.TextSpan(text: "visit https://www.jrcompliance.com/purchase-and-billing", style: pw.TextStyle(decoration: pw.TextDecoration.underline,fontSize: 6,/*color:PdfColor.fromHex(Colors.blue)*/)),

                 ],
               ),
             ),
           ),
           pw.Container(
             child: pw.RichText(
               text: pw.TextSpan(
                 text: ". ",
                 style:pw.TextStyle(fontSize: 6,fontWeight: pw.FontWeight.bold),
                 children:[
                   pw.TextSpan(text:"This invoice is due in accordance with the agreed credit terms.",style: pw.TextStyle(fontSize: 6,) ),

                 ],

               ),

             ),
           ),
         ]
       ),
            pw.SizedBox(
              height: 40
            ),
            pw.Footer(
              trailing:
              pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                   children: [
                     // pw.Expanded(
                     //   child: pw.Text(""),
                     // ),
                  //   pw.Container(
                  //     padding: pw.EdgeInsets.only(right: 20),
                  //     child: pw.RichText(
                  //       text: pw.TextSpan(
                  //         text: ". ",
                  //         style:pw.TextStyle(fontSize: 6,fontWeight: pw.FontWeight.bold),
                  //         children:[
                  //           pw.TextSpan(text:"The services provided by JR Compliance are governed by our",style: pw.TextStyle(fontSize: 6,) ),
                  //           pw.TextSpan(text: "Terms and conditions.", style: pw.TextStyle(decoration: pw.TextDecoration.underline,fontSize: 6,/*color:PdfColor.fromHex(Colors.blue)*/)),
                  //           pw.TextSpan(text: "In case you face difficulty in obtaining our Terms and conditions from our official    website, contact your designated representative immediately to receive a copy of the same.", style: pw.TextStyle(fontSize: 6),),
                  //         ],),),),
                    // pw.Container(
                    //   child: pw.RichText(
                    //     text: pw.TextSpan(
                    //       text: ". ",
                    //       style:pw.TextStyle(fontSize: 6,fontWeight: pw.FontWeight.bold),
                    //       children:[
                    //         pw.TextSpan(text:"To know the information regarding purchase and billing.",style: pw.TextStyle(fontSize: 6,) ),
                    //         pw.TextSpan(text: "visit https://www.jrcompliance.com/purchase-and-billing", style: pw.TextStyle(decoration: pw.TextDecoration.underline,fontSize: 6,/*color:PdfColor.fromHex(Colors.blue)*/)),
                    //
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // pw.Container(
                    //   child: pw.RichText(
                    //     text: pw.TextSpan(
                    //       text: ". ",
                    //       style:pw.TextStyle(fontSize: 6,fontWeight: pw.FontWeight.bold),
                    //       children:[
                    //         pw.TextSpan(text:"This invoice is due in accordance with the agreed credit terms.",style: pw.TextStyle(fontSize: 6,) ),
                    //
                    //       ],
                    //
                    //     ),
                    //
                    //   ),
                    // ),
                    pw.SizedBox(
                      height: 80
                    ),
                 pw.Padding(
                   padding: pw.EdgeInsets.only(left: 400,top: 20,right: 20),
                   child:    pw.Column(
                       mainAxisAlignment: pw.MainAxisAlignment.center,
                       children: [
                         pw.Text('JR'+actualinid.toString()+" | Page 1 of 1"),
                         pw.Text("www.jrcompliance.com"),
                       ]

                   ),
                 )

                  ]
              ),


               ),
          ]);
        }));
    Uint8List bytes = await pdf.save();
    print(bytes);

    //  Uint8List fileBytes = Uint8List.fromList(bytes);
    // var file =  File(fileBytes,"output.pdf");
    //
    // print('@@@@@'+file.toString());
    FirebaseStorage storage = FirebaseStorage.instance;
    TaskSnapshot upload =
        await storage.ref('Attachments/invoice.pdf').putData(bytes);
    String myUrl = await upload.ref.getDownloadURL();
    print(myUrl);

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference reference = await firestore.collection("Tasks");
    reference.doc(docid).collection("Invoices").doc().set({
      "InvoiceUrl": myUrl,
      "Timestamp": Timestamp.now(),
      "status": false,
      "InvoiceId":actualinid,
      "type":activeid,
    });
    return pdf.save();

  }

}
