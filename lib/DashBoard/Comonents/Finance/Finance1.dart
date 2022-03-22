import 'dart:typed_data';
import 'dart:ui';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/Calenders.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Models/InvoiceDescriptionModel.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Pdf/Models/CustomerModel.dart';
import 'package:test_web_app/Pdf/Models/InvoiceModel.dart';
import 'package:test_web_app/Pdf/Models/SupplierModel.dart';
import 'package:test_web_app/Pdf/PdfApi.dart';
import 'package:test_web_app/Pdf/PdfInvoiceApi.dart';
import 'package:test_web_app/PdfPage.dart';
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
  final TextEditingController _searchController1 = TextEditingController();
  final TextEditingController _invoiceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _invoiceusername = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _customersearchController =
      TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
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
  String? contactname;
  String? cemail;
  String? cphone;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: btnColor.withOpacity(0.0001),
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
      child: Column(
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
                  flex: 3,
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
                              contactname = snp.Customername;
                              cemail = snp.Customeremail;
                              cphone = snp.Customerphone;

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
                                    contactname.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.5),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cemail.toString(),
                                        style: TxtStls.fieldstyle,
                                      ),
                                      Text(
                                        cphone.toString(),
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
                                    print(i);
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
                      ))),
              SizedBox(
                width: 7.5,
              ),
              Expanded(
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: FlatButton.icon(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  color: btnColor,
                                  onPressed: () {
                                    setState(() {
                                      _dateController.text = DateTime.now()
                                          .toString()
                                          .split(" ")[0];
                                      _isLoad = true;
                                    });
                                  },
                                  icon: Icon(Icons.add, color: bgColor),
                                  label: Text(
                                    "Create New $activeid",
                                    style: TxtStls.fieldstyle1,
                                  )),
                            ),
                            SizedBox(height: size.height * 0.2),
                            Lottie.asset("assets/Lotties/empty.json",
                                animate: true, reverse: true)
                          ],
                        ),
                ),
              )
            ],
          ),
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

  Widget textField(_controller, String hintText) {
    return TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: _controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
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
                                controller: _searchController,
                                style: TxtStls.fieldstyle,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Gst Number...",
                                    hintStyle: TxtStls.fieldstyle),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 0.025,
                            padding: EdgeInsets.symmetric(vertical: 12.5),
                            color: btnColor,
                            child: Icon(
                              Icons.search,
                              color: bgColor,
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
                SizedBox(
                  height: 10,
                ),
                isgst
                    ? Expanded(
                        child: ScaleAnimatedWidget.tween(
                          duration: Duration(milliseconds: 500),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      maxRadius: 7,
                                      backgroundColor: Provider.of<GstProvider>(
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
                                  Text(bnature, style: TxtStls.fieldstyle)
                                ],
                              ),
                              space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: formfield(
                                            "Invoice Id",
                                            _invoiceController,
                                            icnData(),
                                            true)),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        MyCalenders.pickEndDate(
                                            context, _dateController);
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: formfield(
                                              "Date",
                                              _dateController,
                                              Icon(Icons.calendar_today,
                                                  color: btnColor),
                                              false)),
                                    ),
                                  ),
                                ],
                              ),
                              space(),
                              formfield("TradeName", _nameController, icnData(),
                                  true),
                              space(),
                              formfield(
                                  "Name", _invoiceusername, icnData(), true),
                              space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: formfield("Email",
                                          _emailController, icnData(), true),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: formfield(
                                          "Address",
                                          _addressControoler,
                                          Icon(
                                            Icons.location_on_rounded,
                                            color: btnColor,
                                          ),
                                          true),
                                    ),
                                  ),
                                ],
                              ),
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
                                            border: Border.all(color: btnColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        child: Text(
                                          "Create Invoice",
                                          style: TextStyle(color: Colors.white),
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
                            isAdded == true
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
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    list1[index]["item"]
                                                        .toString(),
                                                    style: TxtStls
                                                        .fieldtitlestyle2,
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
                                                    style: TxtStls
                                                        .fieldtitlestyle2,
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
                                                            .fieldtitlestyle2))),
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
                                                          .fieldtitlestyle2)),
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
                                                            .fieldtitlestyle2))),
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
                                      child: textField(
                                          _selectController, "Select Item"),

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
                                  Expanded(flex: 2, child: SizedBox()),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            isAdded == true ? SizedBox() : SizedBox(),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 10),
                              child: Container(
                                height: size.height * 0.05,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.5))),
                                          alignment: Alignment.center,
                                          child: textField(_descripController,
                                              "Item Description"),

                                          //   InvoiceFields(_selectController,"Select Item"),
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      color: bgColor,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                            ),
                                          ),
                                          //      hintText: "₹ 0",
                                          VerticalDivider(
                                            thickness: 2,
                                            color: bgColor,
                                          ),
                                          Expanded(
                                              child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 35, right: 35),
                                          ))
                                        ],
                                      ),
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      color: bgColor,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 35, right: 35),
                                            ),
                                          ),
                                          VerticalDivider(
                                            thickness: 2,
                                            color: bgColor,
                                          ),
                                          Expanded(
                                              child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 75,
                              ),
                              child: InkWell(
                                  autofocus: false,
                                  onTap: () {
                                    setState(() {
                                      isAdded = true;
                                      var _customer =
                                          Provider.of<CustmerProvider>(context,
                                              listen: false);
                                      cust.forEach((element) => _customer);
                                    });

                                    print('custom cust' + cust.toString());

                                    addingData();
                                    _rateController.clear();
                                    _qtyController2.clear();
                                    _priceController.clear();
                                    _discController.clear();
                                    _selectController.clear();
                                    _descripController.clear();
                                  },
                                  child: Text(
                                    "+ADD ITEM",
                                    style: TxtStls.btnstyle,
                                  )),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 30,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Save & Send",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.telegram_rounded,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 30,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Text(
                                  "Save  ",
                                  style: TextStyle(color: Colors.purple),
                                ),
                                onTap: () {},
                              ),
                              VerticalDivider(
                                thickness: 0.5,
                                color: Colors.purple,
                              ),
                              InkWell(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.purple),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 30,
                        width: size.width * 0.1,
                        child: Center(
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.copy_all,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Preview  ",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.purple),
                                ),
                              ],
                            ),
                            onTap: () async {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfPage()));
                              final date = DateTime.now();
                              final dueDate = date.add(Duration(days: 7));
                              print('name' + contactname.toString());
                              print('email' + cemail.toString());

                              final invoice = Invoice(
                                supplier: Supplier(
                                  name: "JR Compliance and Testing Labs",
                                  address:
                                      "Regd. Office: 705, 7th Floor,Krishna Apra Tower,Netaji Subhash Place, Pitampura,New Delhi 110034,India",
                                  paymentInfo: 'https://paypal.me/sarahfieldzz',
                                  pan: "PAN: AALFJ0070E",
                                  tan: "TAN: DELJ10631F",
                                  gst: "GST REGN NO: 07AALFJ0070E1ZO",
                                ),
                                customer: Customer(
                                  name: "Srinivas",
                                  address: "yalagala@jrcompliance.com",
                                ),
                                info: InvoiceInfo(
                                  date: date,
                                  dueDate: dueDate,
                                  description: 'My description...',
                                  number: '${DateTime.now().year}-9999',
                                ),
                                items: [
                                  InvoiceItem(
                                    description: 'Coffee',
                                    date: DateTime.now(),
                                    quantity: list1[0]["qty"],
                                    vat: 0.18,
                                    unitPrice: list1[0]["rate"],
                                  ),
                                  InvoiceItem(
                                    description: 'Water',
                                    date: DateTime.now(),
                                    quantity: 8,
                                    vat: 0.19,
                                    unitPrice: 0.99,
                                  ),
                                  InvoiceItem(
                                    description: 'Orange',
                                    date: DateTime.now(),
                                    quantity: 3,
                                    vat: 0.19,
                                    unitPrice: 2.99,
                                  ),
                                  InvoiceItem(
                                    description: 'Apple',
                                    date: DateTime.now(),
                                    quantity: 8,
                                    vat: 0.19,
                                    unitPrice: 3.99,
                                  ),
                                  InvoiceItem(
                                    description: 'Mango',
                                    date: DateTime.now(),
                                    quantity: 1,
                                    vat: 0.19,
                                    unitPrice: 1.59,
                                  ),
                                  InvoiceItem(
                                    description: 'Blue Berries',
                                    date: DateTime.now(),
                                    quantity: 5,
                                    vat: 0.19,
                                    unitPrice: 0.99,
                                  ),
                                  InvoiceItem(
                                    description: 'Lemon',
                                    date: DateTime.now(),
                                    quantity: 4,
                                    vat: 0.19,
                                    unitPrice: 1.29,
                                  ),
                                ],
                              );
                              //  final Uint8List fontData = File();
                              //  final ttf = pw.Font.ttf(fontData.buffer.asByteData());
                              //  var data = fontData.buffer.asByteData();

                              final pdfFile =
                                  await PdfInvoiceApi.generate(invoice);

                              PdfApi.openFile(pdfFile);
                            },
                          ),
                        ),
                      ),
                    ),
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
}
