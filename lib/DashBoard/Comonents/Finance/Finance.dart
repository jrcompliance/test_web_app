import 'dart:ui';
import 'package:test_web_app/Auth_Views/Url_launchers.dart';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Models/InvoiceDescriptionModel.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/UserProvider/CustomerProvider.dart';
import 'package:test_web_app/UserProvider/GstProvider.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final _list = ["Quotation", "Performer Invoice", "Invoice"];
  var activeid = "Quotation";
  bool qto = false;
  String bnature = "Active";
  bool visible = false;
  final TextEditingController _searchController1 = TextEditingController();
  final TextEditingController _invoiceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _invoiceusername = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
  double gst = 15300;
  double? tbal;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final customerlist = Provider.of<CustmerProvider>(context).customerlist;
    return Container(
      color: AbgColor.withOpacity(0.0001),
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
      child: qto
          ? TranslationAnimatedWidget.tween(
              duration: Duration(milliseconds: 250),
              translationDisabled: Offset(400, 0),
              translationEnabled: Offset(0, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: bgColor,
                      ),
                      height: size.height * 0.92,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.015),
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Create New " + activeid,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: txtColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          qto = false;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color: btnColor,
                                      ))
                                ],
                              ),
                              SizedBox(height: size.height * 0.05),
                              Container(
                                decoration: BoxDecoration(
                                    color: fieldColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 2),
                                  child: TextField(
                                    controller: _searchController,
                                    style: TxtStls.fieldstyle,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.search,
                                            color: btnColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Provider.of<GstProvider>(context,
                                                      listen: false)
                                                  .fetchGstData(
                                                      _searchController.text)
                                                  .then((value) {
                                                getarrayLength();
                                                visible = true;
                                                _invoiceusername.text =
                                                    cusname!;
                                                _emailController.text =
                                                    cusemail!;
                                                _nameController.text =
                                                    Provider.of<GstProvider>(
                                                            context,
                                                            listen: false)
                                                        .tradename
                                                        .toString();
                                                _dateController.text =
                                                    DateFormat("dd-MM-yyyy")
                                                        .format(DateTime.now());
                                                _addressControoler.text =
                                                    Provider.of<GstProvider>(
                                                            context,
                                                            listen: false)
                                                        .principalplace
                                                        .toString();
                                                _pincodeController.text =
                                                    Provider.of<GstProvider>(
                                                            context,
                                                            listen: false)
                                                        .pincode
                                                        .toString();
                                                _panController.text =
                                                    Provider.of<GstProvider>(
                                                            context,
                                                            listen: false)
                                                        .pan
                                                        .toString();
                                                setState(() {
                                                  _statusController.text =
                                                      Provider.of<GstProvider>(
                                                              context,
                                                              listen: false)
                                                          .gstinstatus
                                                          .toString();
                                                  bnature =
                                                      Provider.of<GstProvider>(
                                                              context,
                                                              listen: false)
                                                          .businessnature![0]
                                                          .toString();
                                                });
                                              });
                                            });
                                          },
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Enter GSTIN Number...",
                                        hintStyle: TxtStls.fieldstyle),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.05),
                              Visibility(
                                visible: visible,
                                child: ScaleAnimatedWidget.tween(
                                  duration: Duration(milliseconds: 500),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              maxRadius: 7,
                                              backgroundColor:
                                                  Provider.of<GstProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .gstinstatus
                                                              .toString() ==
                                                          "Active"
                                                      ? Colors.green
                                                      : clsClr),
                                          SizedBox(width: 5),
                                          Text(
                                            _statusController.text.toString(),
                                            style: TxtStls.fieldstyle,
                                          ),
                                          Expanded(child: Text("")),
                                          Text(bnature,
                                              style: TxtStls.fieldstyle)
                                        ],
                                      ),
                                      space(),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 20),
                                                child: formfield(
                                                    "Invoice Id",
                                                    _invoiceController,
                                                    icnData())),
                                          ),
                                          Expanded(
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: formfield(
                                                    "Date",
                                                    _dateController,
                                                    Icon(Icons.calendar_today,
                                                        color: btnColor))),
                                          ),
                                        ],
                                      ),
                                      space(),
                                      formfield("TradeName", _nameController,
                                          icnData()),
                                      space(),
                                      formfield(
                                          "Name", _invoiceusername, icnData()),
                                      space(),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: formfield("Email",
                                                  _emailController, icnData()),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: formfield(
                                                  "Address",
                                                  _addressControoler,
                                                  Icon(
                                                    Icons.location_on_rounded,
                                                    color: btnColor,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      space(),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: formfield("PanNumber",
                                                  _panController, icnData()),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: formfield(
                                                  "PinCode",
                                                  _pincodeController,
                                                  icnData()),
                                            ),
                                          ),
                                        ],
                                      ),
                                      space(),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: InkWell(
                                              child: Container(
                                                padding: EdgeInsets.all(12.0),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: bgColor,
                                                    border: Border.all(
                                                        color: btnColor),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0))),
                                                child: Text(
                                                  "Send Invoice",
                                                  style: TxtStls.btnstyle,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(flex: 1, child: Text("")),
                                          Expanded(
                                            flex: 4,
                                            child: InkWell(
                                              child: Container(
                                                padding: EdgeInsets.all(12.0),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: btnColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0))),
                                                child: Text(
                                                  "Create Invoice",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              onTap: () {},
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        // image: DecorationImage(
                        //     image: AssetImage("assets/Images/invoicebg.jpeg"),
                        //     fit: BoxFit.cover,
                        //     filterQuality: FilterQuality.high),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: bgColor,
                      ),
                      height: size.height * 0.92,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.015,
                          vertical: size.width * 0.015),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  activeid + " Preview",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: txtColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(child: Text(" ")),
                                IconButton(
                                    onPressed: (() {
                                      setState(() {});
                                    }),
                                    icon:
                                        Icon(Icons.download, color: btnColor)),
                                IconButton(
                                    onPressed: (() {}),
                                    icon: Icon(Icons.print_sharp,
                                        color: btnColor)),
                              ],
                            ),
                            divider(),
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
                            divider(),
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

                            divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                    child: Text("# Description",
                                        style: TxtStls.fieldstyle)),
                                Expanded(
                                  flex: 7,
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
                            divider(),
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
                                                    child: Text(
                                                        ""
                                                            .toString(),
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
                            divider(),
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
                            divider(),
                            Text("Terms And Conditions:",
                                style: TxtStls.fieldtitlestyle),
                            InkWell(
                              child: Text(
                                "https://www.jrcompliance.com/terms-and-conditions",
                                style: TxtStls.fieldstyle,
                              ),
                              onTap: () {
                                launches.termsofuse();
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
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _list.map((e) => newMethod(e, () {})).toList(),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: isExpand ? 5 : 10,
                      child: Container(
                          height: size.height * 0.86,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: bgColor,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: isExpand ?size.width*0.1: size.width * 0.6,
                                  left: 10,
                                  top: 10,
                                  bottom: 10,
                                    ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: fieldColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 2),
                                    child: TextFormField(
                                      controller: _searchController1,
                                      style: TxtStls.fieldstyle,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.search,
                                              color: btnColor,
                                            ),
                                            onPressed: () {},
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Enter Customer Name...",
                                          hintStyle: TxtStls.fieldstyle),
                                    ),
                                  ),
                                ),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                itemCount: customerlist.length,
                                itemBuilder: (BuildContext context, int i) {
                                  var snp = customerlist[i];
                                  String? contactname = snp.Customername;
                                  String? cemail = snp.Customeremail;
                                  String? cphone = snp.Customerphone;
                                  return InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: bgColor,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  maxRadius: 15,
                                                  child: Icon(Icons.person,
                                                      color: btnColor,
                                                      size: 15),
                                                  backgroundColor:
                                                      btnColor.withOpacity(0.1),
                                                ),
                                                SizedBox(width: 5),
                                                Text(contactname.toString(),
                                                    style: TxtStls.fieldstyle),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    maxRadius: 15,
                                                    child: Icon(Icons.email,
                                                        color: btnColor,
                                                        size: 15),
                                                    backgroundColor: btnColor
                                                        .withOpacity(0.1),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(cemail.toString(),
                                                      style:
                                                          TxtStls.fieldstyle),
                                                ],
                                              )),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  maxRadius: 15,
                                                  child: Icon(
                                                    Icons.phone,
                                                    color: btnColor,
                                                    size: 15,
                                                  ),
                                                  backgroundColor:
                                                      btnColor.withOpacity(0.1),
                                                ),
                                                SizedBox(width: 5),
                                                Text(cphone.toString(),
                                                    style: TxtStls.fieldstyle),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.more_horiz,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isExpand = true;
                                        cusname = contactname;
                                        cusemail = cemail;
                                        cusphone = cphone;
                                      });
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(height: 7.5);
                                },
                              ),
                            ],
                          )),
                    ),
                    SizedBox(width: 10),
                    Visibility(
                      visible: isExpand,
                      child: Expanded(
                          flex: isExpand ? 5 : 0,
                          child: TranslationAnimatedWidget.tween(
                            duration: Duration(milliseconds: 200),
                            translationDisabled: Offset(400, 0),
                            translationEnabled: Offset(0, 0),
                            child: Container(
                              height: size.height * 0.860,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: bgColor,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cusname == null ? "" : cusname!,
                                            style: TxtStls.fieldstyle,
                                          ),
                                          Text(
                                              "( ${cusemail == null ? "" : cusemail!} )",
                                              style: TxtStls.fieldstyle),
                                        ],
                                      ),
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        elevation: 0.0,
                                        color: btnColor,
                                        hoverColor: Colors.transparent,
                                        hoverElevation: 0.0,
                                        onPressed: () {
                                          setState(() {
                                            qto = true;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Create " + activeid,
                                            style: TextStyle(
                                                fontSize: 12.5,
                                                color: bgColor,
                                                letterSpacing: 0.2),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )),
                    )
                  ],
                )
              ],
            ),
    );
  }

  Widget newMethod(e, callack) {
    return RaisedButton(
      elevation: 0.0,
      color: activeid == e ? btnColor : bgColor,
      hoverColor: Colors.transparent,
      hoverElevation: 0.0,
      onPressed: () {
        setState(() {
          activeid = e;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          e,
          style: TextStyle(
              fontSize: 12.5,
              color: activeid == e ? bgColor : txtColor,
              letterSpacing: 0.2),
        ),
      ),
    );
  }

  Widget formfield(title, _controller, icn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TxtStls.fieldtitlestyle),
        Container(
          decoration: deco,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 2),
            child: TextFormField(
              controller: _controller,
              style: TxtStls.fieldstyle,
              decoration: InputDecoration(
                hintText: title,
                hintStyle: TxtStls.fieldstyle,
                border: InputBorder.none,
                suffixIcon: icn,
              ),
              validator: (fullname) {
                if (fullname!.isEmpty) {
                  return "Name can not be empty";
                } else if (fullname.length < 3) {
                  return "Name should be atleast 3 letters";
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget icnData() {
    return Icon(
      Icons.horizontal_rule,
      color: fieldColor,
    );
  }

  Widget space() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * 0.025);
  }

  Widget divider() {
    return Divider(color: grClr);
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

  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  void getarrayLength() async {
    await _firebase
        .collection("InvoiceID")
        .doc("2dtDd787PkHNjpFag0H5")
        .get()
        .then((value) {
      setState(() {
        var list = List.from(value.data()!["id"]);
        String lastvalue = list.elementAt(list.length - 1);
        //   print("lastvalue is : " + lastvalue);
        updatearray(lastvalue);
      });
    });
  }

  updatearray(String lastvalue) async {
    var month = DateFormat("MM").format(DateTime.now());
    var year = DateFormat("yy").format(DateTime.now());

    int mymonth = int.parse(month);
    int myyear = int.parse(year);
    int acyear = myyear;
    int acyear1 = myyear;
    if (mymonth <= 3) {
      setState(() {
        acyear = myyear - 1;
      });
    } else {
      setState(() {
        acyear1 = myyear + 1;
      });
    }
    show() {
      if (mymonth <= 9) {
        return 0;
      } else {
        return null;
      }
    }

    String val = lastvalue.substring(6);
    //  print("pad value is : "+val);
    int addval = int.parse(val) + 1;
    // print("Added value is : " + addval.toString());
    var storeval = show().toString() +
        mymonth.toString() +
        acyear.toString() +
        acyear1.toString() +
        addval.toString();
    // print(storeval);
    setState(() {
      _invoiceController.text = "#JR" + storeval;
    });
    await _firebase.collection("InvoiceID").doc("2dtDd787PkHNjpFag0H5").update({
      "id": FieldValue.arrayUnion([storeval]),
    });
  }

  List invoicelist = ["SAC No.", "Qty.", "UnitCost.","Disc(%)",    "Amount"];
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



  // void getInvoiceData() async {
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     print(_preferences.get("desc"));
  //     print(_preferences.get("qty"));
  //     print(_preferences.get("ucost"));
  //   });
  // }
}
