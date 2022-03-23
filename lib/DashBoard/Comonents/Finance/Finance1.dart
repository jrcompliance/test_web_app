import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Models/InvoiceDescriptionModel.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Pdf/Models/CustomerModel.dart';
import 'package:test_web_app/Pdf/Models/InvoiceModel.dart';
import 'package:test_web_app/Pdf/Models/SupplierModel.dart';
import 'package:test_web_app/Pdf/PdfApi.dart';
import 'package:test_web_app/Pdf/PdfInvoiceApi.dart';
import 'package:test_web_app/Providers/GstProvider.dart';
import '../../../Providers/CustomerProvider.dart';

class Finance1 extends StatefulWidget {
  Finance1({Key? key}) : super(key: key);

  @override
  _Finance1State createState() => _Finance1State();
}

class _Finance1State extends State<Finance1> {
  bool _isLoad = false;
  bool isgst = false;

  bool isPreview = false;

  @override
  void initState() {
    Provider.of<CustmerProvider>(context, listen: false).getCustomers();
    super.initState();
  }

  final _list = ["Quotation", "Performer Invoice", "Invoice"];
  var activeid = "Quotation";
  bool qto = false;
  double? tbal;
  String bnature = "Active";
  bool visible = false;
  bool isAdded = false;

  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _tradenameController = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _panController = TextEditingController();

  final TextEditingController _searchController1 = TextEditingController();
  final TextEditingController _invoiceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _invoiceusername = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _customersearchController =
      TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _ucostController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _selectController = TextEditingController();
  final TextEditingController _qtyController2 = TextEditingController();
  final TextEditingController _discController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descripController = TextEditingController();
  final TextEditingController _internalController = TextEditingController();
  List cust = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: btnColor.withOpacity(0.0001),
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        child: Row(
                          children:
                              _list.map((e) => newMethod(e, () {})).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.025),
                  Container(
                      padding: EdgeInsets.all(8),
                      height: size.height * 0.845,
                      decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: fieldColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 2),
                              child: TextField(
                                controller: _customersearchController,
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
                                    hintText: "Enter Customer name",
                                    hintStyle: TxtStls.fieldstyle),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ClampingScrollPhysics(),
                            itemCount: Provider.of<CustmerProvider>(context)
                                .customerlist
                                .length,
                            itemBuilder: (BuildContext context, int i) {
                              var snp = Provider.of<CustmerProvider>(context)
                                  .customerlist[i];
                              return Material(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: bgColor,
                                child: ListTile(
                                  tileColor: grClr.withOpacity(0.1),
                                  hoverColor: btnColor.withOpacity(0.2),
                                  selectedColor: btnColor.withOpacity(0.2),
                                  selectedTileColor: btnColor.withOpacity(0.2),
                                  leading: CircleAvatar(
                                      backgroundColor:
                                          btnColor.withOpacity(0.1),
                                      child: Icon(
                                        Icons.person,
                                        color: btnColor,
                                      )),
                                  title: Text(
                                    snp.Customername.toString(),
                                    style: TxtStls.fieldtitlestyle,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snp.Customeremail.toString(),
                                        style: TxtStls.fieldstyle,
                                      ),
                                      Text(
                                        snp.Customerphone.toString(),
                                        style: TxtStls.fieldstyle,
                                      ),
                                    ],
                                  ),
                                  trailing: CircleAvatar(
                                    backgroundColor: btnColor.withOpacity(0.1),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: btnColor,
                                        )),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      cusname = snp.Customername;
                                      cusphone = snp.Customerphone;
                                      cusemail = snp.Customeremail;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(color: grClr.withOpacity(0.5));
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
                flex: 7,
                child: isPreview
                    ? PreviewInvoice(context)
                    : Container(
                        padding: EdgeInsets.all(10),
                        height: size.height * 0.93,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: bgColor,
                        ),
                        child: _isLoad
                            ? show1(context)
                            : Column(
                                children: [
                                  cusname == null
                                      ? SizedBox()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                cusname.toString() +
                                                    "\n(${cusemail.toString()})",
                                                style: TxtStls.fieldtitlestyle),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: FlatButton.icon(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  color: btnColor,
                                                  onPressed: () {
                                                    setState(() {
                                                      _dateController.text =
                                                          DateTime.now()
                                                              .toString()
                                                              .split(" ")[0];
                                                      _isLoad = true;
                                                    });
                                                  },
                                                  icon: Icon(Icons.add,
                                                      color: bgColor),
                                                  label: Text(
                                                    "Create New $activeid",
                                                    style: TxtStls.fieldstyle1,
                                                  )),
                                            ),
                                          ],
                                        ),
                                  SizedBox(height: size.height * 0.2),
                                  Lottie.asset("assets/Lotties/empty.json",
                                      animate: true, reverse: true),
                                  SizedBox(height: size.height * 0.2),
                                  cusname == null
                                      ? Text(
                                          "Select any Customer to Proceed",
                                          style: TxtStls.fieldtitlestyle,
                                        )
                                      : SizedBox()
                                ],
                              ),
                      )),
          ],
        ));
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

  Widget textField(_controller, String hintText) {
    return TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: _controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TxtStls.fieldstyle,
          focusedErrorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "value can not be empty";
          }
        });
  }

  List list1 = [];
  void addingData() async {
    double _rate = double.parse(_rateController.text);
    int _qty = int.parse(_qtyController2.text);
    double _disc = double.parse(_discController.text);
    double price = (_rate * _qty) - (((_rate * _qty) / 100) * _disc);
    list1.add(InvoiceDescriptionModel2(
      item: _selectController.text,
      qty: _qty,
      rate: _rate,
      disc: _disc,
      price: price,
    ).toJson());
    print('@@@' + list1.toString());

    tbal = list1.map((m) => (m["price"])).reduce((a, b) => a + b);
    print("Data added ");
  }

  Widget show1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
        flex: 7,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            height: size.height * 0.845,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: btnColor,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: bgColor,
                          ),
                          onPressed: () {
                            _isLoad = false;
                            isgst = false;
                            setState(() {});
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.225,
                            decoration: BoxDecoration(
                              color: fieldColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 15, right: 0, top: 2),
                              child: TextField(
                                controller: _gstController,
                                style: TxtStls.fieldstyle,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Gst Number...",
                                    hintStyle: TxtStls.fieldstyle),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              var provider = Provider.of<GstProvider>(context,
                                  listen: false);
                              provider
                                  .fetchGstData(_gstController.text.toString())
                                  .whenComplete(() {
                                Future.delayed(Duration(seconds: 2))
                                    .then((value) {
                                  setState(() {
                                    tradename = provider.tradename.toString();
                                    address =
                                        provider.principalplace.toString();
                                    pan = provider.pan.toString();
                                    pincode = provider.pincode.toString();
                                  });
                                });
                              });
                            },
                            child: Container(
                              width: size.width * 0.025,
                              padding: EdgeInsets.symmetric(vertical: 12.5),
                              color: btnColor,
                              child: Provider.of<GstProvider>(context).isLoading
                                  ? SpinKitFadingCube(
                                      color: bgColor,
                                      size: 23,
                                    )
                                  : Icon(
                                      Icons.search,
                                      color: bgColor,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        isgst = true;
                        setState(() {});
                      },
                      child: Text(
                        "Don't have Gst Number? Click Here",
                        style: ClrStls.tnClr,
                      )),
                ),
                Container(
                    color: grClr.withOpacity(0.25),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Text(
                      "ReferenceID : ${addtwoNumber(8).toString()}",
                      style: TxtStls.fieldtitlestyle,
                    )),
                SizedBox(height: size.height * 0.025),
                Container(
                  alignment: Alignment.centerLeft,
                  child: tradename == null
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tradename.toString(),
                              style: TxtStls.fieldstyle,
                            ),
                            Text(address.toString(), style: TxtStls.fieldstyle),
                            Text(pincode.toString(), style: TxtStls.fieldstyle),
                            Text(pan.toString(), style: TxtStls.fieldstyle),
                          ],
                        ),
                ),
                SizedBox(height: size.height * 0.025),
                isgst
                    ? Expanded(
                        child: ScaleAnimatedWidget.tween(
                          duration: Duration(milliseconds: 500),
                          child: Column(
                            children: [
                              formfield("TradeName", _tradenameController,
                                  icnData(), true),
                              space(),
                              formfield(
                                  "Address",
                                  _addressControoler,
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: btnColor,
                                  ),
                                  true),
                              space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: formfield("PanNumber",
                                          _panController, icnData(), true),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: formfield("PinCode",
                                          _pincodeController, icnData(), true),
                                    ),
                                  ),
                                ],
                              ),
                              space(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  backgroundColor: btnColor,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: bgColor,
                                    ),
                                    onPressed: () async {
                                      print("Hey Yalagala Srinivas");
                                      tradename =
                                          _tradenameController.text.toString();
                                      pan = _panController.text.toString();
                                      pincode =
                                          _pincodeController.text.toString();
                                      address =
                                          _addressControoler.text.toString();
                                      isgst = false;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: size.height * 0.05,
                              color: btnColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "ITEM DETAILS",
                                          style: TxtStls.titlesstyle,
                                        )),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "RATE",
                                          style: TxtStls.titlesstyle,
                                        )),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text("QUANTITY",
                                              style: TxtStls.titlesstyle))),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "DISC(%)",
                                          style: TxtStls.titlesstyle,
                                        )),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "PRICE",
                                            style: TxtStls.titlesstyle,
                                          ))),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            list1.length > 0
                                ? ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: list1.length,
                                    itemBuilder: (context, index) {
                                      return Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("${index + 1}. ",
                                                          style: TxtStls
                                                              .fieldtitlestyle),
                                                      Flexible(
                                                        child: Text(
                                                          "${list1[index]["item"].toString()}\n",
                                                          style: TxtStls
                                                              .fieldtitlestyle,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: bgColor,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    list1[index]["rate"]
                                                        .toString(),
                                                    style:
                                                        TxtStls.fieldtitlestyle,
                                                  )),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: bgColor,
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        list1[index]["qty"]
                                                            .toString(),
                                                        style: TxtStls
                                                            .fieldtitlestyle))),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: bgColor,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      list1[index]["disc"]
                                                          .toString(),
                                                      style: TxtStls
                                                          .fieldtitlestyle)),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: bgColor,
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        list1[index]["price"]
                                                            .toString(),
                                                        style: TxtStls
                                                            .fieldtitlestyle))),
                                          ],
                                        ),
                                      );
                                    })
                                : SizedBox(),
                            Container(
                              height: size.height * 0.05,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.grey
                                                  .withOpacity(0.5))),
                                      alignment: Alignment.center,
                                      child: textField(_selectController,
                                          "Item Description"),

                                      //   InvoiceFields(_selectController,"Select Item"),
                                    ),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.grey
                                                  .withOpacity(0.5))),
                                      alignment: Alignment.center,
                                      child: textField(_rateController, "₹ 0"),

                                      //  InvoiceFields(_rateController,"₹ 0"),
                                    ),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.5))),
                                          alignment: Alignment.center,
                                          child: textField(_qtyController2, "1")
                                          //InvoiceFields(_qtyController2,"1"),
                                          )),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.5))),
                                        alignment: Alignment.center,
                                        child: textField(_discController, "0 %")
                                        // InvoiceFields(_discController,"0 %"),
                                        ),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: InkWell(
                                            autofocus: false,
                                            onTap: () {
                                              setState(() {
                                                var _customer = Provider.of<
                                                        CustmerProvider>(
                                                    context,
                                                    listen: false);
                                                cust.forEach(
                                                    (element) => _customer);
                                              });

                                              print('custom cust' +
                                                  cust.toString());
                                              addingData();
                                              Future.delayed(
                                                      Duration(seconds: 1))
                                                  .then((value) {
                                                _rateController.clear();
                                                _qtyController2.clear();
                                                _priceController.clear();
                                                _discController.clear();
                                                _selectController.clear();
                                                _descripController.clear();
                                              });
                                            },
                                            child: Text(
                                              "+ADD ITEM",
                                              style: TxtStls.btnstyle,
                                            )),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 50),
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    height: 50,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: textField(
                                        _internalController, "Internal Notes"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: size.width * 0.15,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Sub Total",
                                              style: TxtStls.fieldtitlestyle,
                                            ),
                                            Text(
                                              tbal == null
                                                  ? "0.00"
                                                  : tbal.toString(),
                                              style: TxtStls.fieldtitlestyle,
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 0.5,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total",
                                              style: TxtStls.fieldtitlestyle,
                                            ),
                                            Text(
                                              "0.00",
                                              style: TxtStls.fieldtitlestyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          setState(() {
                            isPreview = true;
                          });
                        },
                        icon: Icon(Icons.copy),
                        label: Text("Preview"))
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget space() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * 0.025);
  }

  Widget formfield(title, _controller, icn, bool enabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TxtStls.fieldtitlestyle),
        Container(
          decoration: deco,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 2),
            child: TextFormField(
              enabled: enabled,
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

  var addtwoNumber = (int length) {
    const ch = "456789ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  };

  Widget PreviewInvoice(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.93,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: bgColor,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.015, vertical: size.height * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Invoice Preview",
                style: TextStyle(
                    fontSize: 15, color: txtColor, fontWeight: FontWeight.bold),
              ),
              Expanded(child: SizedBox()),
              IconButton(
                  onPressed: (() {
                    setState(() {});
                  }),
                  icon: Icon(Icons.download, color: btnColor)),
              IconButton(
                  onPressed: (() {}),
                  icon: Icon(Icons.print_sharp, color: btnColor)),
            ],
          ),
          Divider(
            color: grClr,
          ),
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
                  Text("Regd. Office: 705, 7th Floor,Krishna Apra Tower",
                      style: TxtStls.fieldstyle),
                  Text("Netaji Subhash Place, Pitampura,New Delhi 110034,India",
                      style: TxtStls.fieldstyle),
                  Text("JR Compliance and Testing Labs",
                      style: TxtStls.fieldstyle),
                  Text("PAN: AALFJ0070E", style: TxtStls.fieldstyle),
                  Text("TAN: DELJ10631F", style: TxtStls.fieldstyle),
                  Text("GST REGN NO: 07AALFJ0070E1ZO",
                      style: TxtStls.fieldstyle),
                ],
              )
            ],
          ),
          Divider(
            color: grClr,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("To,", style: TxtStls.fieldtitlestyle),
              Text(
                "Invoice No.",
                style: TxtStls.fieldtitlestyle,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$address",
                    style: TxtStls.fieldstyle,
                  ),
                  Text(
                      "GST NO- ${_gstController.text == null ? "" : _gstController.text.toString()}",
                      style: TxtStls.fieldtitlestyle),
                  Text("Kind Atten: Mr.$cusname",
                      style: TxtStls.fieldtitlestyle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Issued On: " +
                          DateFormat("dd MMM,yyyy").format(DateTime.now()),
                      style: TxtStls.fieldstyle,
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child:
                          Text("Payment Due: Paid", style: TxtStls.fieldstyle)),
                ],
              ),
            ],
          ),
          Divider(
            color: grClr,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("# Description", style: TxtStls.fieldstyle)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("SAC No", style: TxtStls.fieldstyle))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.centerRight,
                            child:
                                Text("Unit Cost", style: TxtStls.fieldstyle))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("Qty", style: TxtStls.fieldstyle))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("Disc(%)", style: TxtStls.fieldstyle))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.centerRight,
                            child:
                                Text("Amount(Rs)", style: TxtStls.fieldstyle))),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: grClr,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list1.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${index + 1}. ",
                                  style: TxtStls.fieldtitlestyle),
                              Flexible(
                                child: Text(
                                  "${list1[index]["item"].toString()}\n",
                                  style: TxtStls.fieldtitlestyle,
                                ),
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("9983", style: TxtStls.fieldstyle),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(list1[index]["rate"].toString(),
                                  style: TxtStls.fieldstyle),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(list1[index]["qty"].toString(),
                                  style: TxtStls.fieldstyle),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(list1[index]["disc"].toString() + "%",
                                  style: TxtStls.fieldstyle),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(list1[index]["price"].toString(),
                                style: TxtStls.fieldstyle),
                          ),
                        ),
                      ],
                    ))
                  ],
                );
              },
            ),
          ),
          Divider(
            color: grClr,
          ),
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
          Text("Bank Name: IDFC FIRST BANK", style: TxtStls.fieldtitlestyle),
          Text("Account Number: 10041186185", style: TxtStls.fieldtitlestyle),
          Text("IFSC Code: IDFB0040101", style: TxtStls.fieldtitlestyle),
          Text("SWIFT Code: IDFBINBBMUM", style: TxtStls.fieldtitlestyle),
          Text("Bank Address: Rohini, New Delhi-110085",
              style: TxtStls.fieldtitlestyle),
          Divider(
            color: grClr,
          ),
          Text("Terms And Conditions:", style: TxtStls.fieldtitlestyle),
          InkWell(
            child: Text(
              "https://www.jrcompliance.com/terms-and-conditions",
              style: TxtStls.fieldstyle,
            ),
            onTap: () {
              //launches.termsofuse();
            },
          ),
        ],
      ),
    );
  }

  Widget wid() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: Row(
                children: _list.map((e) => newMethod(e, () {})).toList(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.025,
        ),
        Row(
          children: [
            Expanded(
                flex: isPreview ? 4 : 3,
                child: Container(
                    padding: EdgeInsets.all(8),
                    height: size.height * 0.845,
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: fieldColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 2),
                            child: TextField(
                              controller: _customersearchController,
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
                                  hintText: "Enter Customer name",
                                  hintStyle: TxtStls.fieldstyle),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          itemCount: Provider.of<CustmerProvider>(context)
                              .customerlist
                              .length,
                          itemBuilder: (BuildContext context, int i) {
                            var snp = Provider.of<CustmerProvider>(context)
                                .customerlist[i];
                            return Material(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: bgColor,
                              child: ListTile(
                                tileColor: grClr.withOpacity(0.1),
                                hoverColor: btnColor.withOpacity(0.2),
                                selectedColor: btnColor.withOpacity(0.2),
                                selectedTileColor: btnColor.withOpacity(0.2),
                                leading: CircleAvatar(
                                    backgroundColor: btnColor.withOpacity(0.1),
                                    child: Icon(
                                      Icons.person,
                                      color: btnColor,
                                    )),
                                title: Text(
                                  snp.Customername.toString(),
                                  style: TxtStls.fieldtitlestyle,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snp.Customeremail.toString(),
                                      style: TxtStls.fieldstyle,
                                    ),
                                    Text(
                                      snp.Customerphone.toString(),
                                      style: TxtStls.fieldstyle,
                                    ),
                                  ],
                                ),
                                trailing: CircleAvatar(
                                  backgroundColor: btnColor.withOpacity(0.1),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color: btnColor,
                                      )),
                                ),
                                onTap: () {
                                  setState(() {
                                    cusname = snp.Customername;
                                    cusphone = snp.Customerphone;
                                    cusemail = snp.Customeremail;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(color: grClr.withOpacity(0.5));
                          },
                        ),
                      ],
                    ))),
            SizedBox(
              width: 7.5,
            ),
            isPreview
                ? PreviewInvoice(context)
                : Expanded(
                    flex: 7,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: size.height * 0.845,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: bgColor,
                      ),
                      child: _isLoad
                          ? show1(context)
                          : Column(
                              children: [
                                cusname == null
                                    ? SizedBox()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              cusname.toString() +
                                                  "\n(${cusemail.toString()})",
                                              style: TxtStls.fieldtitlestyle),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: FlatButton.icon(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0))),
                                                color: btnColor,
                                                onPressed: () {
                                                  setState(() {
                                                    _dateController.text =
                                                        DateTime.now()
                                                            .toString()
                                                            .split(" ")[0];
                                                    _isLoad = true;
                                                  });
                                                },
                                                icon: Icon(Icons.add,
                                                    color: bgColor),
                                                label: Text(
                                                  "Create New $activeid",
                                                  style: TxtStls.fieldstyle1,
                                                )),
                                          ),
                                        ],
                                      ),
                                SizedBox(height: size.height * 0.2),
                                Lottie.asset("assets/Lotties/empty.json",
                                    animate: true, reverse: true),
                                SizedBox(height: size.height * 0.2),
                                cusname == null
                                    ? Text(
                                        "Select any Customer to Proceed",
                                        style: TxtStls.fieldtitlestyle,
                                      )
                                    : SizedBox()
                              ],
                            ),
                    ),
                  )
          ],
        ),
      ],
    );
  }
}
