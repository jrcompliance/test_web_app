import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Models/InvoiceDescriptionModel.dart';


class PdfPage extends StatefulWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  State<PdfPage> createState() => _PdfPageState();
}
class _PdfPageState extends State<PdfPage> {
  final _list = ["Quotation", "Performer Invoice", "Invoice"];
  var activeid = "Quotation";
  double gst = 15300;
  bool qto = false;
  String bnature = "Active";
  bool visible = false;
  final TextEditingController _invoiceController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _invoiceusername = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _ucostController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  bool isExpand = false;

  bool isadded = false;
  double? tbal;
  final pdf = pw.Document();
  // pdf.addPage(pw.Page(
  // pageFormat: PdfPageFormat.a4,
  // build: (pw.Context context) {
  // return pw.Center(
  // child: pw.Text("Hello World"),
  // ); // Center
  // }));
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Material(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
                child: Container(
                  color: Colors.blue,
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // ButtonWidget(
                          //   text: 'Invoice PDF',
                          //   onClicked: () async {
                          //     final date = DateTime.now();
                          //     final dueDate = date.add(Duration(days: 7));
                          //
                          //     final invoice = Invoice(
                          //       supplier: Supplier(
                          //         name: 'Sarah Field',
                          //         address: 'Sarah Street 9, Beijing, China',
                          //         paymentInfo: 'https://paypal.me/sarahfieldzz',
                          //       ),
                          //       customer: Customer(
                          //         name: 'Apple Inc.',
                          //         address: 'Apple Street, Cupertino, CA 95014',
                          //       ),
                          //       info: InvoiceInfo(
                          //         date: date,
                          //         dueDate: dueDate,
                          //         description: 'My description...',
                          //         number: '${DateTime.now().year}-9999',
                          //       ),
                          //       items: [
                          //         InvoiceItem(
                          //           description: 'Coffee',
                          //           date: DateTime.now(),
                          //           quantity: 3,
                          //           vat: 0.19,
                          //           unitPrice: 5.99,
                          //         ),
                          //         InvoiceItem(
                          //           description: 'Water',
                          //           date: DateTime.now(),
                          //           quantity: 8,
                          //           vat: 0.19,
                          //           unitPrice: 0.99,
                          //         ),
                          //         InvoiceItem(
                          //           description: 'Orange',
                          //           date: DateTime.now(),
                          //           quantity: 3,
                          //           vat: 0.19,
                          //           unitPrice: 2.99,
                          //         ),
                          //         InvoiceItem(
                          //           description: 'Apple',
                          //           date: DateTime.now(),
                          //           quantity: 8,
                          //           vat: 0.19,
                          //           unitPrice: 3.99,
                          //         ),
                          //         InvoiceItem(
                          //           description: 'Mango',
                          //           date: DateTime.now(),
                          //           quantity: 1,
                          //           vat: 0.19,
                          //           unitPrice: 1.59,
                          //         ),
                          //         InvoiceItem(
                          //           description: 'Blue Berries',
                          //           date: DateTime.now(),
                          //           quantity: 5,
                          //           vat: 0.19,
                          //           unitPrice: 0.99,
                          //         ),
                          //         InvoiceItem(
                          //           description: 'Lemon',
                          //           date: DateTime.now(),
                          //           quantity: 4,
                          //           vat: 0.19,
                          //           unitPrice: 1.29,
                          //         ),
                          //       ],
                          //     );
                          //
                          //     final pdfFile = await PdfInvoiceApi.generate(invoice);
                          //
                          //     PdfApi.openFile(pdfFile);
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),

            Expanded(
              flex: 5,
              child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage("assets/Images/invoicebg.jpeg"),
                  //     fit: BoxFit.cover,
                  //     filterQuality: FilterQuality.high),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: bgColor,
                ),
                // height: size.height * 0.845,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.015,
                    vertical: size.width * 0.015),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Divider(),
                    Row(
                      children: [
                        SizedBox(
                          height: size.height * 0.15,
                          width: size.width * 0.175,
                          child: Image.asset(
                            "assets/Logos/jrlogo.png",
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("JR Compliance and Testing Labs",
                                style: TxtStls.fieldstyle),
                            Text(
                                "Regd. Office: 705, 7th Floor,Krishna Apra Tower",
                                style: TxtStls.fieldstyle),
                            Text(
                                "Netaji Subhash Place, Pitampura,New Delhi 110034,India",
                                style: TxtStls.fieldstyle),
                            Text("JR Compliance and Testing Labs",
                                style: TxtStls.fieldstyle),
                            Text("PAN: AALFJ0070E",
                                style: TxtStls.fieldstyle),
                            Text("TAN: DELJ10631F",
                                style: TxtStls.fieldstyle),
                            Text("GST REGN NO: 07AALFJ0070E1ZO",
                                style: TxtStls.fieldstyle),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To,", style: TxtStls.fieldtitlestyle),
                            Text(
                              _nameController.text.toString(),
                              style: TxtStls.fieldstyle,
                            ),
                            Text(_addressControoler.text.toString(),
                                style: TxtStls.fieldstyle),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Invoice No. " + _invoiceController.text,
                              style: TxtStls.fieldtitlestyle,
                            ),
                            Text(
                              "Issued On: " +
                                  DateFormat("dd MMM,yyyy")
                                      .format(DateTime.now()),
                              style: TxtStls.fieldstyle,
                            ),
                            Text("Payment Due: Paid",
                                style: TxtStls.fieldstyle),
                          ],
                        )
                      ],
                    ),
                    Text("GST NO- " + _searchController.text,
                        style: TxtStls.fieldtitlestyle),
                    Text("Kind Atten: Mr." + _invoiceusername.text,
                        style: TxtStls.fieldtitlestyle),

                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text("# Description",
                                style: TxtStls.fieldstyle)),
                        Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: invoicelist
                                  .map((e) => Expanded(
                                child: Align(
                                  alignment:
                                  Alignment.centerRight,
                                  child: Text(e,
                                      style:
                                      TxtStls.fieldstyle),
                                ),
                              ))
                                  .toList()),
                        ),
                      ],
                    ),

                    Divider(),
                    Expanded(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Text(
                                        "${index + 1}" +
                                            ". " +
                                            list[index]["desc"],
                                        style: TxtStls.fieldstyle),
                                  ),
                                  Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment:
                                              Alignment.centerRight,
                                              child: Text("9983",
                                                  style:
                                                  TxtStls.fieldstyle),
                                            ),
                                          ),
                                          Expanded(
                                              child: Align(
                                                alignment:
                                                Alignment.centerRight,
                                                child: Text(
                                                    list[index]["qty"]
                                                        .toString(),
                                                    style: TxtStls.fieldstyle),
                                              )),
                                          Expanded(
                                              child: Align(
                                                alignment:
                                                Alignment.centerRight,
                                                child: Text(
                                                    list[index]["ucost"]
                                                        .toString(),
                                                    style: TxtStls.fieldstyle),
                                              )),
                                          Expanded(
                                              child: Align(
                                                alignment:
                                                Alignment.centerRight,
                                                child: Text("".toString(),
                                                    style: TxtStls.fieldstyle),
                                              )),
                                          Expanded(
                                            child: Align(
                                              alignment:
                                              Alignment.centerRight,
                                              child: Text(
                                                  list[index]["amount"]
                                                      .toString(),
                                                  style:
                                                  TxtStls.fieldstyle),
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              );
                            },
                          ),
                          list.length > 0
                              ? Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "IGST 18%",
                                style: TxtStls.fieldstyle,
                              ),
                              Text(
                                gst.toString(),
                                style: TxtStls.fieldstyle,
                              )
                            ],
                          )
                              : SizedBox(),
                          list.length > 0
                              ? Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total :",
                                  style: TxtStls.fieldstyle),
                              Text(
                                  "${tbal == null ? 0 : tbal! + gst}",
                                  style: TxtStls.fieldstyle),
                            ],
                          )
                              : SizedBox(),
                          list.length > 0
                              ? Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Amount Paid :",
                                  style: TxtStls.fieldstyle),
                              Text("85,300",
                                  style: TxtStls.fieldstyle),
                            ],
                          )
                              : SizedBox(),
                          isadded
                              ? Form(
                            key: _formkey,
                            child: Row(
                              children: [
                                Expanded(
                                  child: InvoiceFields(
                                      _descController,
                                      "Enter Service Description"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: InvoiceFields(
                                        _qtyController,
                                        "Enter Quantity")),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: InvoiceFields(
                                        _ucostController,
                                        "Enter UnitCost")),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(
                                                7)),
                                        color: goodClr),
                                    child: Icon(
                                      Icons.done,
                                      color: bgColor,
                                      size: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    if (_formkey.currentState!
                                        .validate()) {
                                      isadded = !isadded;
                                      addingInvoiceData();
                                      _descController.clear();
                                      _qtyController.clear();
                                      _ucostController.clear();
                                      setState(() {});
                                    } else {
                                      null;
                                    }
                                  },
                                )
                              ],
                            ),
                          )
                              : SizedBox(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(7)),
                                    color: btnColor),
                                child: isadded
                                    ? Icon(
                                  Icons.clear,
                                  color: bgColor,
                                  size: 20,
                                )
                                    : Icon(
                                  Icons.add,
                                  color: bgColor,
                                  size: 20,
                                ),
                              ),
                              onTap: () {
                                isadded = !isadded;
                                setState(() {});
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Text("Bank Details:",
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                fontSize: 13,
                                color: txtColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            fontSize: 13,
                            color: txtColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                    Text("Company Name: JR Compliance And Testing Labs",
                        style: TxtStls.fieldtitlestyle),
                    Text("Bank Name: IDFC FIRST BANK",
                        style: TxtStls.fieldtitlestyle),
                    Text("Account Number: 10041186185",
                        style: TxtStls.fieldtitlestyle),
                    Text("IFSC Code: IDFB0040101",
                        style: TxtStls.fieldtitlestyle),
                    Text("SWIFT Code: IDFBINBBMUM",
                        style: TxtStls.fieldtitlestyle),
                    Text("Bank Address: Rohini, New Delhi-110085",
                        style: TxtStls.fieldtitlestyle),
                    Divider(),
                    Text("Terms And Conditions:",
                        style: TxtStls.fieldtitlestyle),
                    InkWell(
                      child: Text(
                        "https://www.jrcompliance.com/terms-and-conditions",
                        style: TxtStls.fieldstyle,
                      ),
                      onTap: () {
                      //  launches.termsofuse();
                      },
                    ),
                    // InkWell(
                    //   child: Text(
                    //     "https://www.jrcompliance.com/privacy-policy",
                    //     style: ClrStls.tnClr,
                    //   ),
                    //   onTap: () {
                    //     launches.privacy();
                    //   },
                    // ),
                    // InkWell(
                    //   child: Text(
                    //     "https://www.jrcompliance.com/purchase-and-billing",
                    //     style: ClrStls.tnClr,
                    //   ),
                    //   onTap: () {
                    //     launches.privacy();
                    //   },
                    // )
                  ],
                ),
              ),
            ),
            ),
        ]),
      ),
    );
  }
  List invoicelist = ["SAC No.", "Qty.", "UnitCost.", "Disc(%)", "Amount"];
  List list = [];
  void addingInvoiceData() async {
    double qty = double.parse(_qtyController.text.toString());
    double ucost = double.parse(_ucostController.text.toString());
    list.add(InvoiceDescriptionModel(
      desc: _descController.text,
      qty: qty,
      ucost: ucost,
      amount: qty * ucost,
    ).toJson());
    print(list);
    tbal = list.map((m) => (m["amount"])).reduce((a, b) => a + b);
    print("Data is set");
  }
  Widget InvoiceFields(
      _controller,
      title,
      ) {
    return Container(
      decoration: deco,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 2),
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: _controller,
          style: TxtStls.fieldstyle,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TxtStls.fieldstyle,
            border: InputBorder.none,
          ),
          validator: (input) {
            if (input!.isEmpty) {
              return "field can not be empty";
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}

