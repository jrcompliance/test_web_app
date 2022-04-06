import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/CheckScreen.dart';
import 'package:test_web_app/Constants/Calenders.dart';
import 'package:test_web_app/Constants/Fileview.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:test_web_app/Models/InvoiceDescriptionModel.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Providers/GenerateCxIDProvider.dart';
import 'package:test_web_app/Providers/GetInvoiceProvider.dart';
import 'package:test_web_app/Providers/GstProvider.dart';
import 'package:test_web_app/Widgets/InvoicePopup.dart';
import 'package:url_launcher/url_launcher.dart';
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

  final List<String> currencieslist = ["INR", "USD", "GBP", "EURO"];
  String selectedValue = "INR";

  final List<String> paymentstatus = ["PAID", "PARTIALLY PAID", "CANCEL"];
  String selectedValue1 = "CANCEL";

  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _generatedateController = TextEditingController();
  final TextEditingController _duedatedateController = TextEditingController();
  final TextEditingController _extrenalController = TextEditingController();
  double _gstamount = 0.00;

  var radioItem;

  bool isSwitched = false;
  bool isSwitched1 = false;

  double total = 0;

  @override
  void initState() {
    Provider.of<CustmerProvider>(context, listen: false).getCustomers();
    super.initState();
  }

  final _list = ["Quotation", "Performer Invoice", "Invoice"];
  var activeid = "Quotation";
  bool qto = false;
  double tbal = 0.00;
  String bnature = "Active";
  bool visible = false;
  bool isAdded = false;

  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _tradenameController = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _customersearchController =
      TextEditingController();
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
                                    child: dropdowns(),
                                  ),
                                  onTap: () {
                                    Provider.of<GetInvoiceListProvider>(context,
                                            listen: false)
                                        .getInvoiceList(snp.Idocid);
                                    setState(() {
                                      cusname = snp.Customername;
                                      cusphone = snp.Customerphone;
                                      cusemail = snp.Customeremail;
                                      Idocid = snp.Idocid;
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
                        padding: EdgeInsets.all(20),
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
                                  SizedBox(height: size.height * 0.1),
                                  Expanded(
                                      child: ListView.builder(
                                          itemCount: Provider.of<
                                                      GetInvoiceListProvider>(
                                                  context)
                                              .invoicemodellist
                                              .length,
                                          itemBuilder: (_, i) {
                                            var data = Provider.of<
                                                        GetInvoiceListProvider>(
                                                    context)
                                                .invoicemodellist[i];
                                            var createdate =
                                                data.timestamp!.toDate();
                                            return InkWell(
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                ),
                                                elevation: 10.0,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 3,
                                                          child: Container(
                                                              child: Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .picture_as_pdf_rounded,
                                                                  color:
                                                                      clsClr),
                                                              Text(
                                                                "  JR" +
                                                                    data.invoiceid
                                                                        .toString(),
                                                                style: TxtStls
                                                                    .fieldtitlestyle,
                                                              ),
                                                            ],
                                                          ))),
                                                      Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .calendar_today_rounded,
                                                                    color:
                                                                        btnColor),
                                                                SizedBox(
                                                                    width: 10),
                                                                Text(
                                                                  DateFormat(
                                                                          "dd MMMM,yyyy")
                                                                      .format(
                                                                          createdate),
                                                                  style: TxtStls
                                                                      .fieldtitlestyle,
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      50.0),
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10.0)),
                                                              color: btnColor,
                                                            ),
                                                            child: Text(
                                                              data.status ==
                                                                      true
                                                                  ? "Sent"
                                                                  : "Pending",
                                                              style: TxtStls
                                                                  .fieldstyle1,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          child: Text(
                                                            data.type
                                                                .toString(),
                                                            style: TxtStls
                                                                .fieldtitlestyle,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            child: Icon(Icons
                                                                .more_horiz),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                buildPopUpDialog();
                                                print("Hey Yalagala");
                                              },
                                            );
                                          })),
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

  List servicelist = [];
  void addingData() async {
    double _rate = double.parse(_rateController.text);
    int _qty = int.parse(_qtyController2.text);
    double _disc = double.parse(_discController.text);
    double price = (_rate * _qty) - (((_rate * _qty) / 100) * _disc);
    servicelist.add(InvoiceDescriptionModel2(
      item: _selectController.text,
      qty: _qty,
      rate: _rate,
      disc: _disc,
      price: price,
    ).toJson());
    print('@@@' + servicelist.toString());

    tbal = servicelist.map((m) => (m["price"])).reduce((a, b) => a + b);
    _gstamount = tbal * 0.18;
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
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: grClr.withOpacity(0.25),
                              ),
                              child: Text(
                                "ReferenceID :",
                                style: TxtStls.fieldtitlestyle,
                              )),
                          SizedBox(width: 7.5),
                          Expanded(
                            flex: 2,
                            child: field(_referenceController,
                                "Enter Reference ID", 1, true),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: size.height * 0.05,
                        width: size.width * 0.05,
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          isExpanded: true,
                          hint: Text(
                            selectedValue,
                            style: TxtStls.fieldtitlestyle,
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: btnColor,
                          ),
                          iconSize: 30,
                          buttonHeight: 60,
                          buttonPadding: EdgeInsets.only(left: 20, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          items: currencieslist
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item,
                                        style: TxtStls.fieldtitlestyle),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value.toString();
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
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
                              formfield(
                                  "TradeName", _tradenameController, true),
                              space(),
                              formfield(
                                  "Address",
                                  _addressControoler,
                                  true,
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: btnColor,
                                  )),
                              space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: formfield(
                                          "PanNumber", _panController, true),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: formfield(
                                          "PinCode", _pincodeController, true),
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
                            servicelist.length > 0
                                ? ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: size.height * 0.22),
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: servicelist.length,
                                        itemBuilder: (context, index) {
                                          return Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                              "${servicelist[index]["item"].toString()}\n",
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        servicelist[index]
                                                                ["rate"]
                                                            .toString(),
                                                        style: TxtStls
                                                            .fieldtitlestyle,
                                                      )),
                                                ),
                                                VerticalDivider(
                                                  thickness: 2,
                                                  color: bgColor,
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            servicelist[index]
                                                                    ["qty"]
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                          servicelist[index]
                                                                  ["disc"]
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
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            servicelist[index]
                                                                    ["price"]
                                                                .toString(),
                                                            style: TxtStls
                                                                .fieldtitlestyle))),
                                              ],
                                            ),
                                          );
                                        }),
                                  )
                                : SizedBox(),
                            Container(
                              height: size.height * 0.06,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: field(_selectController,
                                        "Item Description", 1, true),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: field(_rateController,
                                        "${symbol(selectedValue)} 0", 1, true),
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child:
                                          field(_qtyController2, "1", 1, true)),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child:
                                        field(_discController, "0 %", 1, true),
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
                                              total = tbal + getval();
                                              Future.delayed(Duration(
                                                      milliseconds: 100))
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
                                              " ADD ITEM + ",
                                              style: TxtStls.btnstyle,
                                            )),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: isSwitched
                                      ? field(_internalController,
                                          "Internal Notes", 3, true)
                                      : SizedBox(),
                                ),
                                for (int i = 1; i <= 2; i++)
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                Expanded(flex: 2, child: SizedBox()),
                                for (int i = 1; i <= 2; i++)
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Sub Total (${selectedValue}) : " +
                                                symbol(selectedValue),
                                            style: TxtStls.fieldtitlestyle,
                                          ),
                                          Text(
                                            tbal == null
                                                ? "0.00"
                                                : tbal.toStringAsFixed(2),
                                            style: TxtStls.fieldtitlestyle,
                                          ),
                                        ],
                                      ),
                                      selectedValue == "INR"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "IGST/CGST/SGST(${selectedValue}) : " +
                                                      symbol(selectedValue),
                                                  style:
                                                      TxtStls.fieldtitlestyle,
                                                ),
                                                Text(
                                                  selectedValue == "INR"
                                                      ? _gstamount
                                                          .toStringAsFixed(2)
                                                      : "0.00",
                                                  style:
                                                      TxtStls.fieldtitlestyle,
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                      Divider(
                                        thickness: 0.5,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total (${selectedValue}) : " +
                                                symbol(selectedValue),
                                            style: TxtStls.fieldtitlestyle,
                                          ),
                                          Text(
                                            total.toStringAsFixed(2),
                                            style: TxtStls.fieldtitlestyle,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: isSwitched1
                                      ? field(_extrenalController,
                                          "External Notes", 3, true)
                                      : SizedBox(),
                                ),
                                for (int i = 1; i <= 2; i++)
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                Expanded(flex: 3, child: SizedBox()),
                                for (int i = 1; i <= 2; i++)
                                  VerticalDivider(
                                    thickness: 2,
                                    color: bgColor,
                                  ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        child: field(
                                            _generatedateController,
                                            "Select Generate Date",
                                            1,
                                            false,
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color: btnColor,
                                            )),
                                        onTap: () {
                                          MyCalenders.pickEndDate(
                                              context, _generatedateController);
                                        },
                                      ),
                                      SizedBox(height: size.height * 0.005),
                                      InkWell(
                                        child: field(
                                            _duedatedateController,
                                            "Select Due Date",
                                            1,
                                            false,
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color: btnColor,
                                            )),
                                        onTap: () {
                                          MyCalenders.pickEndDate(
                                              context, _duedatedateController);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text("Internal Notes", style: TxtStls.fieldtitlestyle),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: btnColor.withOpacity(0.2),
                          activeColor: btnColor,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("External Notes", style: TxtStls.fieldtitlestyle),
                        Switch(
                          value: isSwitched1,
                          onChanged: (value) {
                            setState(() {
                              isSwitched1 = value;
                              print(isSwitched1);
                            });
                          },
                          activeTrackColor: btnColor.withOpacity(0.2),
                          activeColor: btnColor,
                        ),
                      ],
                    ),
                    FlatButton.icon(
                        color: btnColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          if (servicelist.length > 0) {
                            isPreview = true;
                            setState(() {});
                            Provider.of<RecentFetchCXIDProvider>(context,
                                    listen: false)
                                .fetchRecentInvoiceid();
                          }
                        },
                        icon: Icon(Icons.copy, size: 10, color: bgColor),
                        label: Text(
                          "Preview",
                          style: TxtStls.fieldstyle1,
                        )),
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

  Widget formfield(title, _controller, bool enabled, [icn]) {
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

  var addtwoNumber = (int length) {
    const ch = "456789ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  };

  Widget PreviewInvoice(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime? duedate = DateTime.parse(_duedatedateController.text);
    DateTime? generatedate = DateTime.parse(_generatedateController.text);
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
              Provider.of<RecentFetchCXIDProvider>(context).actualinid == null
                  ? SizedBox()
                  : FlatButton.icon(
                      color: btnColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      onPressed: () {
                        var inid = Provider.of<RecentFetchCXIDProvider>(context,
                                listen: false)
                            .actualinid
                            .toString();
                        var gstno = _gstController.text == null
                            ? ""
                            : _gstController.text.toString();
                        setState(() {
                          PdfProvider.generatePdf(
                            servicelist,
                            cusname,
                            tbal,
                            inid,
                            gstno,
                            Idocid,
                            activeid,
                            selectedValue == "INR" ? _gstamount : 0.00,
                            total,
                            _generatedateController.text.toString(),
                            _duedatedateController.text.toString(),
                            selectedValue,
                          );
                        });
                      },
                      icon: Icon(Icons.save_alt_rounded,
                          color: bgColor, size: 12.5),
                      label: Text("Save", style: TxtStls.fieldstyle1))
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
                "Invoice No. : " +
                    "${Provider.of<RecentFetchCXIDProvider>(context).actualinid == null ? "" : Provider.of<RecentFetchCXIDProvider>(context).actualinid.toString()}",
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
                    "$address\n$pincode",
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
                      "Issued On : " +
                          DateFormat("dd MMM,yyyy").format(generatedate),
                      style: TxtStls.fieldstyle,
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          "Due Date : " +
                              DateFormat("dd MMM,yyyy").format(duedate),
                          style: TxtStls.fieldstyle)),
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
              itemCount: servicelist.length,
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
                                  "${servicelist[index]["item"].toString()}\n",
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
                              child: Text(servicelist[index]["rate"].toString(),
                                  style: TxtStls.fieldstyle),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(servicelist[index]["qty"].toString(),
                                  style: TxtStls.fieldstyle),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  servicelist[index]["disc"].toString() + "%",
                                  style: TxtStls.fieldstyle),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(servicelist[index]["price"].toString(),
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
                                    Idocid = snp.Idocid;
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
            isPreview == true
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
                                // Expanded(
                                //   flex: 1,
                                //   child: Container(
                                //     child: Column(
                                //       chil
                                //     ),
                                //   ),
                                // ),
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

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorbox(e) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.startToEnd,
      content: Text(e),
      backgroundColor: Colors.red,
    ));
  }

  // 1.preview of invoice
  detailspopBox(context, url) {
    Size size = MediaQuery.of(context).size;
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      backgroundColor: Colors.white.withOpacity(0.9),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          color: bgColor,
          padding: EdgeInsets.all(10.0),
          height: size.height * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "JR03212201",
                    style: TxtStls.fieldtitlestyle,
                  ),
                  CircleAvatar(
                    backgroundColor: neClr.withOpacity(0.1),
                    child: IconButton(
                      hoverColor: Colors.transparent,
                      tooltip: "Close Window",
                      icon: Icon(Icons.close),
                      color: neClr,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton.icon(
                      color: btnColor,
                      onPressed: () {
                        downloadInvoice(url);
                      },
                      icon: Icon(Icons.download_rounded, color: bgColor),
                      label: Text(
                        "Download",
                        style: TxtStls.fieldstyle1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
                  VerticalDivider(),
                  FlatButton.icon(
                      color: btnColor,
                      onPressed: () {},
                      icon: Icon(Icons.print_rounded, color: bgColor),
                      label: Text(
                        "Print",
                        style: TxtStls.fieldstyle1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
                  VerticalDivider(),
                  FlatButton.icon(
                      color: btnColor,
                      onPressed: () {
                        forwardtoemail(context);
                      },
                      icon: Icon(
                        Icons.share,
                        color: bgColor,
                      ),
                      label: Text(
                        "Forward",
                        style: TxtStls.fieldstyle1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
                  VerticalDivider(),
                  FlatButton.icon(
                      color: btnColor,
                      onPressed: () {
                        fileview1(context, "JR03212201", url);
                      },
                      icon: Icon(Icons.copy, color: bgColor),
                      label: Text(
                        "Preview",
                        style: TxtStls.fieldstyle1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
                ],
              ),
            ],
          ),
        );
      }),
    );
    showDialog(
        barrierDismissible: false,
        barrierColor: txtColor.withOpacity(0.75),
        context: context,
        builder: (_) {
          return alertDialog;
        });
  }

  // 2.Download the Invoice

  downloadInvoice(_url) async {
    if (!await launch(
      _url,
      forceWebView: true,
      forceSafariVC: true,
      enableJavaScript: true,
    )) throw 'Could not launch $_url';
  }

  // 3.Print the Invoice on A4

  printInoice() async {}

  // 4. Forward Invoice to email

  forwardtoemail(BuildContext context) async {
    print("we are sending data to email please wait");
    Navigator.pop(context);
    sendBox(context);
  }

  sendBox(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _toemailController = TextEditingController();
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      backgroundColor: Colors.white.withOpacity(0.9),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlatButton.icon(
              color: btnColor,
              onPressed: () {},
              icon: Icon(Icons.send),
              label: Text(
                "Send",
                style: TxtStls.fieldstyle1,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            )
          ],
        );
      }),
    );
    showDialog(
        barrierDismissible: false,
        barrierColor: txtColor.withOpacity(0.75),
        context: context,
        builder: (_) {
          return alertDialog;
        });
  }

  Widget field(_controller, hintText, maxlines, bool isenable, [icn, icn1]) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: deco,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01,
        ),
        child: TextFormField(
          enabled: isenable,
          cursorColor: btnColor,
          controller: _controller,
          style: TxtStls.fieldstyle,
          decoration: InputDecoration(
            prefixIcon: icn1,
            errorStyle: ClrStls.errorstyle,
            suffixIcon: icn,
            hintText: hintText,
            hintStyle: TxtStls.fieldstyle,
            border: InputBorder.none,
          ),
          maxLines: maxlines,
        ),
      ),
    );
  }

  symbol(selectedcurrency) {
    switch (selectedcurrency) {
      case "GBP":
        {
          return "£";
        }
      case "USD":
        {
          return "\$";
        }
      case "EURO":
        {
          return "€";
        }
      default:
        {
          return "₹";
        }
    }
  }

  double getval() {
    if (selectedValue == "INR") {
      return _gstamount;
    } else {
      return 0;
    }
  }

  var drobval;
  Widget dropdowns() {
    Size size = MediaQuery.of(context).size;
    return PopupMenuButton(
      tooltip: "UpDate Status",
      padding: EdgeInsets.zero,
      shape: TooltipShape(),
      offset: Offset(0, size.height * 0.035),
      onSelected: (value) {
        drobval = value;
        setState(() {});
        print(drobval);
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: "FRESH",
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: wonClr,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "FRESH",
                  style: TxtStls.fieldstyle1,
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: "ASSIGNED",
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: flwClr,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "ASSIGNED",
                  style: TxtStls.fieldstyle1,
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: "CONTACTED",
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: conClr,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "CONTACTED",
                  style: TxtStls.fieldstyle1,
                ),
              ),
            ),
          ),
        ];
      },
    );
  }

  var dropSelected;
  final TextEditingController _externalController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future ShowDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.3, vertical: size.height * 0.1),
            child: Container(
              height: size.height * 0.8,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Stack(
                children: [],
              ),
            ),
          );
        });
  }

  buildPopUpDialog() {
    Size size = MediaQuery.of(context).size;
    var alertdialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: ibgclr.withOpacity(0.1),
      titlePadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      title: Stack(
        children: [
          AppBar(
            backgroundColor: ibgclr,
            elevation: 10,
            toolbarHeight: size.height * 0.2,
            automaticallyImplyLeading: false,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(600),
                    bottomRight: Radius.circular(600))),
            title:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.red[900],
                  ),
                  onPressed: () {},
                ),
              ),
              Text(
                "Your Invoice Generated on",
                style: TextStyle(fontSize: 10),
              ),
              Text(
                "Your Invoice cancelled on",
                style: TextStyle(fontSize: 10),
              ),
            ]),
            centerTitle: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.14,
              horizontal: size.width * 0.01,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: size.height * 0.6,
              width: size.width * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trade name",
                    style: TxtStls.fieldtitlestyle,
                  ),
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: NetworkImage(
                            "https://image.shutterstock.com/image-vector/man-icon-vector-260nw-1040084344.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: Text(
                      "Customer name",
                      style: TxtStls.fieldtitlestyle,
                    ),
                    subtitle: Text(
                      "Customer Email Address",
                      style: TxtStls.fieldtitlestyle,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 5,
                          child: Text(
                            "Invoice :" + "----",
                            style: TxtStls.fieldtitlestyle,
                          )),
                      Expanded(
                          flex: 2,
                          child: FlatButton(
                            color: btnColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text("Preview", style: TxtStls.fieldstyle1),
                            onPressed: () {},
                          )),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.save_alt,
                                color: btnColor,
                              ))),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.print, color: btnColor))),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Internal Notes",
                            style: TxtStls.titlestyle14,
                          )),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                              height: size.height * 0.05,
                              child: field(_internalController, "", 1, true))),
                      Expanded(flex: 2, child: popupMenu())
                    ],
                  ),
                  spacer(),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "External Notes",
                            style: TxtStls.titlestyle14,
                          )),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                              height: size.height * 0.05,
                              child: field(_externalController, "", 1, true))),
                      Expanded(flex: 2, child: popupMenu())
                    ],
                  ),
                  spacer(),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Reference ID",
                            style: TxtStls.titlestyle14,
                          )),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                              height: size.height * 0.05,
                              child: field(_referenceController, "", 1, true))),
                      Expanded(flex: 2, child: popupMenu())
                    ],
                  ),
                  spacer(),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Email",
                            style: TxtStls.titlestyle14,
                          )),
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                              height: size.height * 0.05,
                              child: field(_emailController, "", 1, true))),
                      Expanded(flex: 2, child: popupMenu())
                    ],
                  ),
                  spacer(),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                            "Payment Status",
                            style: TxtStls.titlestyle14,
                          )),
                      Expanded(
                        flex: 4,
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            ),
                            isExpanded: true,
                            hint: Row(
                              children: [
                                Icon(
                                  Icons.wysiwyg_sharp,
                                  color: AbgColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Select",
                                  style: TextStyle(
                                      color: AbgColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: AbgColor,
                            ),
                            iconSize: 30,
                            buttonHeight: 50,
                            buttonPadding: EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: paymentstatus
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item,
                                          style: TxtStls.fieldtitlestyle),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue1 = value.toString();
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(flex: 3, child: SizedBox())
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                            "Cancelled On",
                            style: TxtStls.titlestyle14,
                          )),
                      Expanded(
                        flex: 4,
                        child: InkWell(
                          child: Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: SizedBox(
                              height: size.height * 0.05,
                              child: field(_dateController, "Calender", 1,
                                  false, Icon(Icons.calendar_today_outlined)),
                            ),
                          ),
                          onTap: () {
                            MyCalenders.pickEndDate(context, _dateController);
                          },
                        ),
                      ),
                      Expanded(flex: 3, child: SizedBox())
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.8,
            left: size.width * 0.14,
            child: FlatButton(
              color: btnColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text("Save", style: TxtStls.fieldstyle1),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertdialog;
        });
  }

  Widget spacer() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Divider(
        height: 0.5,
        color: AbgColor,
      ),
    );
  }

  Widget popupMenu() {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: PopupMenuButton(
        icon: Icon(
          Icons.more_horiz,
          color: btnColor,
        ),
        onSelected: (value) {
          setState(() {
            dropSelected = value;
          });
          print(value);
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
                value: "EDIT",
                onTap: () {},
                child: dropdecor(Icons.edit, "EDIT", _clrslist[0])),
            PopupMenuItem(
              value: "DELETE",
              onTap: () {},
              child: dropdecor(Icons.delete, "DELETE", _clrslist[1]),
            ),
            PopupMenuItem(
                value: "ADD",
                onTap: () {},
                child: dropdecor(Icons.add_circle, "ADD", _clrslist[2])),
          ];
        },
      ),
    );
  }

  final List _clrslist = [ipClr, neClr, Clrs.high];
  Widget dropdecor(IconData icon, String text, Color clr) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: clr.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Container(
              child: Icon(
            icon,
            color: clr,
            size: 13,
          )),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              text,
              style: TextStyle(
                  color: clr, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
