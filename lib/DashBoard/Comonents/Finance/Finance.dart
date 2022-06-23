import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/Calenders.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Models/CustomerModel.dart';
import 'package:test_web_app/Models/ServicesModel.dart';
import 'package:test_web_app/PdfFiles/GetCRSServicePdf.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';
import 'package:test_web_app/Providers/LeadIDProviders.dart';
import 'package:test_web_app/Models/InvoiceDescriptionModel.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/PdfFiles/InvoiceNote.dart';
import 'package:test_web_app/Providers/GenerateCxIDProvider.dart';
import 'package:test_web_app/Providers/GetInvoiceProvider.dart';
import 'package:test_web_app/Providers/GstProvider.dart';
import 'package:test_web_app/Providers/InvoiceUpdateProvider.dart';
import 'package:test_web_app/Widgets/InvoicePopup.dart';
import '../../../Providers/CustomerProvider.dart';

class Finance extends StatefulWidget {
  Finance({Key? key}) : super(key: key);

  @override
  _FinanceState createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  bool _isCreate = false;
  bool isgst = false;
  var date1;
  var date2;

  bool isPreview = false;
  bool isServiceAdded = false;

  final List<String> currencieslist = ["INR", "USD", "GBP", "EURO"];
  String selectedValue = "INR";
  var selectedleadid;
  final List<String> statusList = [
    "Pending",
    "Received",
    "Cancelled",
    "Disputed"
  ];

  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _generatedateController = TextEditingController();
  final TextEditingController _selectedDateController = TextEditingController();
  final TextEditingController _duedatedateController = TextEditingController();
  final TextEditingController _extrenalController = TextEditingController();
  double _gstamount = 0.00;

  var radioItem;

  bool isSwitched = false;
  bool isSwitched1 = false;
  bool isSwitched2 = true;

  double total = 0;

  int? leadID;

  final _list = ["Quotation", "Performer Invoice", "Invoice"];
  var activeid = "Quotation";
  bool qto = false;
  double tbal = 0.00;
  String bnature = "Active";
  bool visible = false;
  bool isAdded = false;

  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _gstController2 = TextEditingController();
  final TextEditingController _serviceSearchController2 =
      TextEditingController();
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
  final TextEditingController _filterDateController = TextEditingController();

  List cust = [];
  List<CustomerModel> allCustomers = [];

  var popValue;

  bool isClicked = false;

  final ScrollController sc = ScrollController();
  var randomNo;
  late List<ServicesModel> allServices;

  String? selectedSamples;

  @override
  void initState() {
    var rng = new Random();
    randomNo = rng.nextInt(900000) + 100000;
    allServices = services;
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      Provider.of<CustmerProvider>(context, listen: false)
          .getCustomers(
        context,
      )
          .then((value) {
        allCustomers =
            Provider.of<CustmerProvider>(context, listen: false).customerlist;
      });
    });
    Future.delayed(Duration(seconds: 2)).then((value) {
      var userid = FirebaseAuth.instance.currentUser;
      Provider.of<UserDataProvider>(context, listen: false)
          .getEmployeesList(userid)
          .then((value) {
        // employeeDesig =
        //     Provider.of<UserDataProvider>(context, listen: false).udesignation;
        // employeePhone =
        //     Provider.of<UserDataProvider>(context, listen: false).phone;
        // employeeemail =
        //     Provider.of<UserDataProvider>(context, listen: false).email;
        // employeename =
        //     Provider.of<UserDataProvider>(context, listen: false).username;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.93,
        color: btnColor.withOpacity(0.0001),
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
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
                      SizedBox(width: 10),
                      // InkWell(
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         color: btnColor,
                      //         borderRadius: BorderRadius.circular(10)),
                      //     height: 40,
                      //     width: 40,
                      //     child: Icon(
                      //       Icons.calendar_today_sharp,
                      //       color: bgColor,
                      //     ),
                      //   ),
                      //   onTap: () {
                      //     //   dateTimeRangePicker();
                      //   },
                      // ),
                      // RaisedButton(
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(10.0))),
                      //   color: btnColor,
                      //   onPressed: () {
                      //     MyCalenders.pickFilerDate(
                      //         context, _filterDateController);
                      //   },
                      //   child: Icon(
                      //     Icons.calendar_today_outlined,
                      //     color: bgColor,
                      //   ),
                      //   // label: Text("")),
                      // ),
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
                                      suffixIcon: _customersearchController
                                              .text.isNotEmpty
                                          ? IconButton(
                                              icon: Icon(
                                                Icons.cancel,
                                                color: btnColor,
                                              ),
                                              onPressed: () {
                                                _customersearchController
                                                    .clear();
                                                searchCustomer("");
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                              },
                                            )
                                          : Icon(
                                              Icons.search,
                                              color: btnColor,
                                            ),
                                      border: InputBorder.none,
                                      hintText:
                                          "Enter Customer name or email or phone.....",
                                      hintStyle: TxtStls.fieldstyle),
                                  onChanged: searchCustomer),
                            ),
                          ),
                          SizedBox(height: 10),
                          allCustomers.length <= 0
                              ? Center(
                                  child: SpinKitFadingCube(
                                      color: btnColor, size: 15),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: allCustomers.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    var snp = allCustomers[i];
                                    return Material(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: bgColor,
                                      child: ListTile(
                                        tileColor: grClr.withOpacity(0.1),
                                        hoverColor: btnColor.withOpacity(0.2),
                                        selectedColor:
                                            btnColor.withOpacity(0.2),
                                        selectedTileColor:
                                            btnColor.withOpacity(0.2),
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
                                          backgroundColor:
                                              btnColor.withOpacity(0.1),
                                        ),
                                        onTap: () {
                                          //  print(2);

                                          setState(() {
                                            isClicked = true;
                                            Idocid = snp.Idocid;
                                            cusname = snp.Customername;
                                            cusphone = snp.Customerphone;
                                            cusemail = snp.Customeremail;
                                            cusID = snp.CxID;
                                            cusTask = snp.taskname;
                                            //startDate = snp.startDate;
                                            endDate = snp.endDate;
                                            priority = snp.priority;
                                            //lastseen = snp.lastseen;
                                            cat = snp.cat;
                                            message = snp.message;
                                            status = snp.status;
                                            s = snp.s;
                                            f = snp.f;
                                            assign = snp.assign;
                                            leadID = snp.leadId;
                                            Provider.of<GetInvoiceListProvider>(
                                                    context,
                                                    listen: false)
                                                .getInvoiceList(snp.CxID);
                                            Provider.of<LeadIdProviders>(
                                                    context,
                                                    listen: false)
                                                .getLeadIds(cusID);
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
                                    return Divider(
                                        color: grClr.withOpacity(0.5));
                                  },
                                )
                        ],
                      ))
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.all(20),
                height: size.height * 0.93,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: bgColor,
                ),
                child: isServiceAdded
                    ? _isCreate
                        ? isPreview
                            ? PreviewInvoice(context)
                            : Createinvoice(context)
                        : cusname == null
                            ? Center(
                                child: Text("Select any Customer to Proceed",
                                    style: TxtStls.fieldtitlestyle))
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          cusname.toString() +
                                              "\n(${cusemail.toString()})",
                                          style: TxtStls.fieldtitlestyle),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              primary: btnColor,
                                            ),
                                            onPressed: () {
                                              Provider.of<LeadIdProviders>(
                                                      context,
                                                      listen: false)
                                                  .getLeadIds(cusID);
                                              setState(() {
                                                _isCreate = true;
                                                _dateController.text =
                                                    DateTime.now()
                                                        .toString()
                                                        .split(" ")[0];
                                              });
                                            },
                                            icon:
                                                Icon(Icons.add, color: bgColor),
                                            label: Text(
                                              "Create New $activeid",
                                              style: TxtStls.fieldstyle1,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.05),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: titleWidget(),
                                  ),
                                  Expanded(
                                      child:
                                          Provider.of<GetInvoiceListProvider>(
                                                          context)
                                                      .invoicemodellist
                                                      .length <=
                                                  0
                                              ? Center(
                                                  child: Lottie.asset(
                                                      "assets/Lotties/empty.json"),
                                                )
                                              : ListView.separated(
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
                                                        DateTime.parse(data
                                                            .duedate
                                                            .toString());
                                                    return InkWell(
                                                      child: Container(
                                                        height:
                                                            size.height * 0.06,
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          elevation: 15,
                                                          child: Row(
                                                            children: [
                                                              Flexible(
                                                                  flex: 1,
                                                                  fit: FlexFit
                                                                      .tight,
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 10),
                                                                        child: Icon(
                                                                            Icons
                                                                                .picture_as_pdf_rounded,
                                                                            color:
                                                                                clsClr),
                                                                      ),
                                                                      Text(
                                                                        "  JR" +
                                                                            data.invoiceID.toString(),
                                                                        style: TxtStls
                                                                            .fieldtitlestyle,
                                                                      ),
                                                                    ],
                                                                  )),
                                                              Flexible(
                                                                flex: 1,
                                                                fit: FlexFit
                                                                    .tight,
                                                                child: Text(
                                                                  data.amount
                                                                      .toString(),
                                                                  style: TxtStls
                                                                      .fieldtitlestyle,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                flex: 1,
                                                                fit: FlexFit
                                                                    .tight,
                                                                child: Text(
                                                                  data.currencyType
                                                                      .toString(),
                                                                  style: TxtStls
                                                                      .fieldtitlestyle,
                                                                ),
                                                              ),
                                                              Flexible(
                                                                  flex: 1,
                                                                  fit: FlexFit
                                                                      .tight,
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .calendar_today_rounded,
                                                                          color:
                                                                              btnColor),
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                        DateFormat("dd MMMM,yyyy")
                                                                            .format(createdate),
                                                                        style: TxtStls
                                                                            .fieldtitlestyle,
                                                                      ),
                                                                    ],
                                                                  )),
                                                              Flexible(
                                                                flex: 1,
                                                                fit: FlexFit
                                                                    .tight,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    right: size
                                                                            .width *
                                                                        0.015,
                                                                    top: size
                                                                            .width *
                                                                        0.002,
                                                                    bottom: size
                                                                            .width *
                                                                        0.002,
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration: BoxDecoration(
                                                                        color: statusColor(data.status).withOpacity(
                                                                            0.25),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        DropdownButtonFormField2(
                                                                      decoration: InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          contentPadding: EdgeInsets
                                                                              .zero,
                                                                          border:
                                                                              InputBorder.none
                                                                          // border:
                                                                          //     OutlineInputBorder(
                                                                          //   borderRadius:
                                                                          //       BorderRadius
                                                                          //           .circular(
                                                                          //               10),
                                                                          // ),
                                                                          ),
                                                                      isExpanded:
                                                                          true,
                                                                      selectedItemBuilder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return statusList.map((String
                                                                            value) {
                                                                          return Text(
                                                                            data.status.toString(),
                                                                            style:
                                                                                GoogleFonts.nunito(
                                                                              textStyle: TextStyle(fontSize: 13, color: statusColor(data.status), fontWeight: FontWeight.bold),
                                                                            ),
                                                                          );
                                                                        }).toList();
                                                                      },
                                                                      hint:
                                                                          Text(
                                                                        data.status
                                                                            .toString(),
                                                                        style: GoogleFonts.nunito(
                                                                            textStyle: TextStyle(
                                                                                fontSize: 13,
                                                                                color: statusColor(data.status),
                                                                                fontWeight: FontWeight.bold)),
                                                                      ),
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_drop_down,
                                                                        color: statusColor(
                                                                            data.status),
                                                                      ),
                                                                      iconSize:
                                                                          20,
                                                                      buttonHeight:
                                                                          50,
                                                                      buttonPadding: EdgeInsets.only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              10),
                                                                      dropdownDecoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      items: statusList
                                                                          .map((item) => DropdownMenuItem<String>(
                                                                                value: item,
                                                                                child: Text(item, style: TxtStls.fieldtitlestyle),
                                                                              ))
                                                                          .toList(),
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          data.status =
                                                                              value.toString();
                                                                        });
                                                                        Provider.of<InvoiceUpdateProvider>(context, listen: false).invoiceUpdate(
                                                                            Idocid,
                                                                            data.docid,
                                                                            value);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                flex: 1,
                                                                fit: FlexFit
                                                                    .tight,
                                                                child: InkWell(
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  child: Text(
                                                                      "JRL-${data.LeadId.toString()}",
                                                                      style: TxtStls
                                                                          .fieldtitlestyle),
                                                                  onTap: () {
                                                                    // showDialog(
                                                                    //     context:
                                                                    //         context,
                                                                    //     builder:
                                                                    //         (BuildContext
                                                                    //             context) {
                                                                    //       return DeatailsPopBox(
                                                                    //         f: f
                                                                    //             as int,
                                                                    //         startDate:
                                                                    //             startDate
                                                                    //                 as Timestamp,
                                                                    //         lastseen:
                                                                    //             lastseen
                                                                    //                 as Timestamp,
                                                                    //         s: s
                                                                    //             as int,
                                                                    //         cat: cat
                                                                    //             .toString(),
                                                                    //         endDate:
                                                                    //             endDate.toString(),
                                                                    //         CxID: cusID
                                                                    //             as int,
                                                                    //         taskname:
                                                                    //             cusTask.toString(),
                                                                    //         priority:
                                                                    //             priority.toString(),
                                                                    //         status:
                                                                    //             status.toString(),
                                                                    //         assigns:
                                                                    //             assign
                                                                    //                 as List,
                                                                    //         Idocid:
                                                                    //             Idocid.toString(),
                                                                    //         message:
                                                                    //             message.toString(),
                                                                    //         leadID: leadID
                                                                    //             as int,
                                                                    //       );
                                                                    //     });
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AdvanceCustomAlert(
                                                                invoiceid: data
                                                                    .invoiceID
                                                                    .toString(),
                                                                url: data
                                                                    .invoiceurl
                                                                    .toString(),
                                                                date:
                                                                    createdate,
                                                                name: cusname
                                                                    .toString(),
                                                                email: cusemail
                                                                    .toString(),
                                                                statusColor:
                                                                    statusColor(
                                                                        data.status),
                                                                imageList:
                                                                    statusEmoji(
                                                                        data.status),
                                                                referenceID: data
                                                                    .referenceID,
                                                                internalNotes: data
                                                                    .internalNotes,
                                                                externalNotes: data
                                                                    .externalNotes,
                                                                id: data.docid,
                                                              );
                                                            });
                                                      },
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                              int index) =>
                                                          SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                )),
                                ],
                              )
                    : Container(
                        child:
                            isClicked ? productAddition(context) : SizedBox(),
                      ),
              ),
            ),
          ],
        ));
  }

  Widget newMethod(e, callack) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        primary: activeid == e ? btnColor : bgColor,
        // hoverColor: Colors.transparent,
        // hoverElevation: 0.0,
      ),
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

  Widget Createinvoice(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.76,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
                  padding: EdgeInsets.only(left: 15, right: 0, top: 2),
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
                  var provider =
                      Provider.of<GstProvider>(context, listen: false);
                  provider
                      .fetchGstData(_gstController.text.toString())
                      .whenComplete(() {
                    Future.delayed(Duration(seconds: 2)).then((value) {
                      setState(() {
                        tradename = provider.tradename.toString();
                        address = provider.principalplace.toString();
                        pan = provider.pan.toString();
                        pincode = provider.pincode.toString();
                      });
                    });
                  });
                },
                child: Container(
                  width: size.width * 0.02,
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
                flex: 4,
                child: Row(
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 13),
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
                      child: field(
                          _referenceController, "Enter Reference ID", 1, true),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
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
                              child: Text(item, style: TxtStls.fieldtitlestyle),
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
          SizedBox(height: size.height * 0.01),
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
          SizedBox(height: size.height * 0.06),
          Expanded(
            child: isgst
                ? ScaleAnimatedWidget.tween(
                    duration: Duration(milliseconds: 500),
                    child: Column(
                      children: [
                        formfield("TradeName", _tradenameController, true),
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
                                child: formfield("PanNumber", _panController,
                                    true, null, 10),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: formfield("PinCode", _pincodeController,
                                    true, null, 6),
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
                                pincode = _pincodeController.text.toString();
                                address = _addressControoler.text.toString();
                                isgst = false;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: size.height * 0.05,
                        color: btnColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            myverticalDivider(),
                            Expanded(
                              flex: 2,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "RATE",
                                    style: TxtStls.titlesstyle,
                                  )),
                            ),
                            myverticalDivider(),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text("QUANTITY",
                                        style: TxtStls.titlesstyle))),
                            myverticalDivider(),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "DISC(%)",
                                    style: TxtStls.titlesstyle,
                                  )),
                            ),
                            myverticalDivider(),
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
                      SizedBox(height: size.height * 0.06),
                      servicelist.length > 0
                          ? ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxHeight: size.height * 0.22),
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: servicelist.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                        myverticalDivider(),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                servicelist[index]["rate"]
                                                    .toString(),
                                                style: TxtStls.fieldtitlestyle,
                                              )),
                                        ),
                                        myverticalDivider(),
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                    servicelist[index]["qty"]
                                                        .toString(),
                                                    style: TxtStls
                                                        .fieldtitlestyle))),
                                        myverticalDivider(),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                  servicelist[index]["disc"]
                                                      .toString(),
                                                  style:
                                                      TxtStls.fieldtitlestyle)),
                                        ),
                                        myverticalDivider(),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                    servicelist[index]["price"]
                                                        .toString(),
                                                    style: TxtStls
                                                        .fieldtitlestyle))),
                                      ],
                                    );
                                  }),
                            )
                          : SizedBox(),
                      Container(
                        height: size.height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: field(_selectController,
                                  "Item Description", 1, true),
                            ),
                            myverticalDivider(),
                            Expanded(
                              flex: 2,
                              child: field(_rateController,
                                  "${symbol(selectedValue)} 0", 1, true),
                            ),
                            myverticalDivider(),
                            Expanded(
                                flex: 1,
                                child: field(_qtyController2, "1", 1, true)),
                            myverticalDivider(),
                            Expanded(
                              flex: 1,
                              child: field(_discController, "0 %", 1, true),
                            ),
                            myverticalDivider(),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                      autofocus: false,
                                      onTap: () {
                                        setState(() {
                                          var _customer =
                                              Provider.of<CustmerProvider>(
                                                  context,
                                                  listen: false);
                                          cust.forEach((element) => _customer);
                                        });

                                        print('custom cust' + cust.toString());
                                        addingData();
                                        total = tbal + getval();
                                        Future.delayed(
                                                Duration(milliseconds: 100))
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
                                ? field(_internalController, "Internal Notes",
                                    3, true, null, null, 200)
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "IGST/CGST/SGST(${selectedValue}) : " +
                                                symbol(selectedValue),
                                            style: TxtStls.fieldtitlestyle,
                                          ),
                                          Text(
                                            selectedValue == "INR"
                                                ? _gstamount.toStringAsFixed(2)
                                                : "0.00",
                                            style: TxtStls.fieldtitlestyle,
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
                                ? field(_extrenalController, "External Notes",
                                    3, true, null, null, 200)
                                : SizedBox(),
                          ),
                          for (int i = 1; i <= 2; i++)
                            VerticalDivider(
                              thickness: 2,
                              color: bgColor,
                            ),
                          // Expanded(
                          //   flex: 2,
                          //   child: isSwitched2
                          //       ? field(_leadController, "Lead ID", 1, true, null,
                          //           null, null)
                          //       : SizedBox(),
                          // ),
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
                                  "Select LeadID",
                                  style: TxtStls.fieldtitlestyle,
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: btnColor,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: Provider.of<LeadIdProviders>(context,
                                        listen: false)
                                    .leadidslist
                                    .map((item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(item,
                                              style: TxtStls.fieldtitlestyle),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedleadid =
                                        int.parse(value.toString());
                                  });
                                },
                              ),
                            ),
                          ),

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
                  Text("LeadId", style: TxtStls.fieldtitlestyle),
                  Switch(
                    value: isSwitched2,
                    onChanged: (value) {
                      setState(() {
                        isSwitched2 = value;
                        print(isSwitched2);
                      });
                    },
                    activeTrackColor: btnColor.withOpacity(0.2),
                    activeColor: btnColor,
                  ),
                ],
              ),
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
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: btnColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {
                    if (servicelist.length <= 0 ||
                        selectedleadid == null ||
                        tradename == null ||
                        address == null ||
                        pincode == null ||
                        pan == null ||
                        _generatedateController.text.isEmpty ||
                        _duedatedateController.text.isEmpty ||
                        _internalController.text.isEmpty ||
                        _extrenalController.text.isEmpty) {
                      toastmessage.warningmessage(context, showmessage());
                    } else {
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
    );
  }

  Widget space() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * 0.02);
  }

  Widget space2() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * 0.01);
  }

  Widget formfield(title, _controller, bool enabled, [icn, maxchars]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TxtStls.fieldtitlestyle),
        Container(
          decoration: deco,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 2),
            child: TextFormField(
              maxLength: maxchars,
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

  Widget field(_controller, hintText, maxlines, bool isenable,
      [icn, icn1, maxlength]) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: deco,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01,
        ),
        child: TextFormField(
          maxLength: maxlength,
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
                  : ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: btnColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
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
                              context,
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
                              cusID,
                              _extrenalController.text,
                              _internalController.text,
                              _referenceController.text,
                              selectedleadid);
                          isPreview = false;
                          _isCreate = false;
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

  final List _titlelist = [
    "  Inc No",
    "Amount",
    "Currency",
    "Due Date",
    "Status",
    "Lead ID"
  ];
  final _titlelist2 = [
    "SN ",
    "Name",
    "Price",
    "Tax Slab",
    "Sample Qty",
    "SAC Code",
  ];

  Widget titleWidget() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _titlelist
            .map((e) => Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e,
                      style: TxtStls.fieldtitlestyle,
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                )))
            .toList());
  }

  Color statusColor(value) {
    switch (value) {
      case "Received":
        {
          return wonClr;
        }
      case "Cancelled":
        {
          return clsClr;
        }
      case "Disputed":
        {
          return neClr;
        }
      default:
        {
          return flwClr;
        }
    }
  }

  String statusEmoji(value) {
    switch (value) {
      case "Received":
        {
          return "assets/Images/received.png";
        }
      case "Cancelled":
        {
          return "assets/Images/cancelled.png";
        }
      case "Disputed":
        {
          return "assets/Images/disputed.png";
        }
      default:
        {
          return "assets/Images/pending.png";
        }
    }
  }

  Widget myverticalDivider() {
    return VerticalDivider(
      thickness: 2,
      color: bgColor,
    );
  }

  void searchCustomer(String query) {
    final allCustomers = Provider.of<CustmerProvider>(context, listen: false)
        .customerlist
        .where((element) {
      final customertitle = element.Customername!.toLowerCase();
      final customeremail = element.Customeremail!.toLowerCase();
      final customerphone = element.Customerphone!.toLowerCase();
      final input = query.toLowerCase();
      return customertitle.contains(input) ||
          customeremail.contains(input) ||
          customerphone.contains(input);
    }).toList();
    setState(() {
      query = query;
      this.allCustomers = allCustomers;
    });
  }

  showmessage() {
    if (servicelist.length <= 0) {
      return "Add the service descrption";
    } else if (_internalController.text.isEmpty) {
      return "Enter the InternalNote";
    } else if (_extrenalController.text.isEmpty) {
      return "Enter the ExternalNote";
    } else if (_generatedateController.text.isEmpty) {
      return "Select the Genarated Date";
    } else if (_duedatedateController.text.isEmpty) {
      return "Select the Due Date";
    } else if (selectedleadid == null) {
      return "Select the Lead Id";
    } else if (tradename == null) {
      return "Enter the Trade Name";
    } else if (address == null) {
      return "Enter the Trade Address";
    } else if (pincode == null) {
      return "Enter teh Pincode";
    }
    return "Enter the PanCard Number";
  }

  dateTimeRangePicker() async {
    DateTimeRange? picked = await showDateRangePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.grey,
            splashColor: Colors.black,
            textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.black),
            ),
            accentColor: Colors.black,
            colorScheme: ColorScheme.light(
                primary: btnColor,
                primaryVariant: Colors.black,
                secondaryVariant: Colors.black,
                onSecondary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.black,
                onSurface: Colors.black,
                secondary: Colors.black),
            dialogBackgroundColor: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400, maxHeight: 450),
                child: child,
              )
            ],
          ),
        );
      },
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        date1 = picked.start.toString().split(" ")[0];
        date2 = picked.end.toString().split(" ")[0];
      });
    }
  }

  Widget productAddition(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: size.height * 0.06,
            child: iconStepper(),
          ),
        ),
        showScreen(activeStep),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    primary: btnColor),
                child: Text(
                  "PREV",
                  style: TxtStls.fieldstyle1,
                ),
                onPressed: () {
                  // showScreen(activeStep);
                  if (activeStep > 0) {
                    setState(() {
                      activeStep--;
                    });
                  }

                  // if (activeStep == 7) {
                  //   setState(() {
                  //     isServiceAdded = !isServiceAdded;
                  //   });
                  // }
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    primary: btnColor),
                child: Text(
                  "NEXT",
                  style: TxtStls.fieldstyle1,
                ),
                onPressed: () {
                  // showScreen(activeStep);
                  if (activeStep < upperBound) {
                    setState(() {
                      activeStep++;
                    });
                  }

                  // if (activeStep == 7) {
                  //   setState(() {
                  //     isServiceAdded = !isServiceAdded;
                  //   });
                  // }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool searching = false;
  Widget titleWidget2() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _titlelist2
            .map((e) => Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      e,
                      style: TxtStls.fieldstyle,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AbgColor,
                    )
                  ],
                )))
            .toList());
  }

  Widget productWidget(assetImage, text) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          child: Image.asset(
            assetImage,
            height: 15,
            width: 15,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TxtStls.fieldstyle111,
        )
      ],
    );
  }

  Widget SACCode(code) {
    return Text(
      code,
      style: TxtStls.fieldstyle,
    );
  }

  List resultFound = [];
  void searchService(String query) {
    final allServices = services.where((service) {
      final searchedService = service.name!.toLowerCase();
      final input = query.toLowerCase();
      return searchedService.contains(input);
    }).toList();
    setState(() {
      query = query;
      this.allServices = allServices;
    });
  }

  int activeStep = 0;
  int upperBound = 6;
  List filteredValue = [];
  Widget iconStepper() {
    return IconStepper(
      stepRadius: 16.0,
      icons: [
        Icon(Icons.shopping_cart),
        Icon(Icons.picture_as_pdf),
        Icon(Icons.access_alarm),
        Icon(Icons.supervised_user_circle),
        Icon(Icons.flag),
        Icon(Icons.access_alarm),
        Icon(Icons.supervised_user_circle),
      ],

      // activeStep property set to activeStep variable defined above.
      activeStep: activeStep,

      // This ensures step-tapping updates the activeStep.
      onStepReached: (index) {
        setState(() {
          activeStep = index;
        });
      },
    );
  }

  showScreen(activeStep) {
    if (activeStep == 0) {
      return serviceWidget(context);
    } else if (activeStep == 1) {
      return Createinvoice(context);
    } else if (activeStep == 2) {
      return serviceIntro(context);
    } else if (activeStep == 3) {
      return serviceWelcome(context);
    } else if (activeStep == 4) {
      return Container(
        child: Center(
          child: Text('HIIII$activeStep'),
        ),
      );
    } else if (activeStep == 5) {
      return Container(
        child: Center(
          child: Text('HIIII$activeStep'),
        ),
      );
    } else {
      return Container(
        child: Center(
          child: Text('HIIII$activeStep'),
        ),
      );
    }
  }

  Widget serviceWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.06,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Container(
                  height: size.height * 0.25,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: Container(
                          height: size.height * 0.08,
                          child: Material(
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
                                cusname.toString(),
                                style: TxtStls.fieldtitlestyle,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cusemail.toString(),
                                    style: TxtStls.fieldstyle,
                                  ),
                                  Text(
                                    cusphone.toString(),
                                    style: TxtStls.fieldstyle,
                                  ),
                                ],
                              ),
                              trailing: CircleAvatar(
                                backgroundColor: btnColor.withOpacity(0.1),
                              ),
                              onTap: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                "Choose Service",
                                style: TxtStls.fieldtitlestyle11,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                        height: size.width * 0.022,
                                        width: size.width * 0.25,
                                        decoration: BoxDecoration(
                                          color: fieldColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              bottomLeft:
                                                  Radius.circular(10.0)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 0, top: 0),
                                          child: TextField(
                                              controller:
                                                  _serviceSearchController2,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Search...",
                                                  hintStyle: TxtStls.fieldstyle,
                                                  suffixIcon:
                                                      _serviceSearchController2
                                                              .text.isNotEmpty
                                                          ? IconButton(
                                                              onPressed: () {
                                                                _serviceSearchController2
                                                                    .clear();
                                                                searchService(
                                                                    "");
                                                                FocusScope.of(
                                                                        context)
                                                                    .requestFocus(
                                                                        FocusNode());
                                                              },
                                                              icon: Icon(
                                                                  Icons.cancel))
                                                          : Icon(Icons.search)),
                                              onChanged: searchService),
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: btnColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Add",
                                          style: TxtStls.fieldstyle1,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date",
                              style: TxtStls.fieldtitlestyle11,
                            ),
                            Text(
                              "Quotation No",
                              style: TxtStls.fieldtitlestyle11,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AbgColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    child: field(
                                        _selectedDateController,
                                        DateFormat('dd/MM/yyyy')
                                            .format(DateTime.now()),
                                        1,
                                        false,
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          color: btnColor,
                                        )),
                                    onTap: () {
                                      MyCalenders.pickEndDate(
                                          context, _selectedDateController);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                      color: AbgColor.withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Text(
                                    "#" + randomNo.toString(),
                                    style: TxtStls.fieldstyle,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.15,
                            decoration: BoxDecoration(
                              color: fieldColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 0, top: 5),
                              child: TextField(
                                controller: _gstController2,
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
                                  .fetchGstData(_gstController2.text.toString())
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
                    ])),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        titleWidget2(),
        Container(
          height: size.height * 0.26,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            controller: sc,
            itemCount: allServices.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: index % 2 == 0 ? AbgColor.withOpacity(0.1) : bgColor,
                  ),
                  height: size.width * 0.025,
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 1,
                            child: Text(
                              "${index + 1}",
                              style: TxtStls.fieldstyle,
                            )),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: productWidget(
                              "assets/Images/pending.png",
                              allServices[index].name,
                            ),
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0, right: 50),
                              child: Text(
                                "\$56468",
                                style: TxtStls.fieldstyle,
                              ),
                            )),
                        Flexible(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0, right: 30),
                              child: Text(
                                "GST %",
                                style: TxtStls.fieldstyle,
                              ),
                            )),
                        Flexible(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.only(left: 0, right: 30),
                              child: Text(
                                "2 pieces",
                                style: TxtStls.fieldstyle,
                              )),
                        ),
                        Flexible(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0, right: 30),
                              child: SACCode(
                                "894456",
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text("Samples Required??"),
            textButton("Yes"),
            textButton("No"),
            SizedBox(
              width: 50,
            ),
            isChoosed
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton2<String>(
                        iconEnabledColor: btnColor,
                        iconDisabledColor: AbgColor,
                        itemPadding: EdgeInsets.only(left: 5),
                        buttonHeight: 30,
                        buttonPadding: null,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Samples",
                            style: TxtStls.fieldstyle,
                          ),
                        ),

                        // selectedItemBuilder: (BuildContext context) {
                        //   return items.map((String value) {
                        //     return Text(value.toString(),
                        //         style: TextStyle(
                        //             fontSize: 13,
                        //             color: bgColor,
                        //             fontWeight: FontWeight.bold));
                        //   }).toList();
                        // },
                        selectedItemHighlightColor: bgColor,
                        buttonDecoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: btnColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      item,
                                      style: TxtStls.fieldstyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedSamples,
                        onChanged: (value) {
                          setState(() {
                            selectedSamples = value as String;
                          });
                        },
                      ),
                    ))
                : SizedBox(),
          ],
        )
      ],
    );
  }

  final List<String> items = [
    "2 pieces",
    "3 pieces",
    "4 pieces",
    "5 pieces",
    "6 pieces",
    "7 pieces",
    "8 pieces",
    "9 pieces",
    "10 pieces"
  ];

  bool isChoosed = false;
  Widget textButton(text) {
    return TextButton(
        onPressed: () {
          if (text == "Yes") {
            setState(() {
              isChoosed = true;
            });
          } else {
            setState(() {
              isChoosed = false;
            });
          }
        },
        child: Text(text));
  }

  Widget serviceIntro(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: TextButton(
          onPressed: () async {
            int? isiserviceid;
            Provider.of<RecentFetchCXIDProvider>(context, listen: false)
                .fetchServiceId()
                .then((value) {
              isiserviceid =
                  Provider.of<RecentFetchCXIDProvider>(context, listen: false)
                      .isiserviceid;
            });
            Future.delayed(Duration(seconds: 2)).then((value) async {
              await PdfCRSService.generatePdf(context, isiserviceid!);
            });
          },
          child: const Text("CreatePdf")),
    );
  }

  Widget serviceWelcome(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: size.height * 0.05,
        right: size.height * 0.2,
      ),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/Images/invoicebg.png',
                ),
                fit: BoxFit.fill)),
        padding: EdgeInsets.only(
          left: size.height * 0.05,
          right: size.height * 0.05,
        ),
        height: size.height * 0.78,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            space2(),
            Text(
              cusname.toString(),
              style: TxtStls.fieldstyle222,
            ),
            Text(
              "Place",
              style: TxtStls.fieldstyle222,
            ),
            Text(
              "District",
              style: TxtStls.fieldstyle222,
            ),
            Text(
              "State",
              style: TxtStls.fieldstyle222,
            ),
            Text(
              "Country",
              style: TxtStls.fieldstyle222,
            ),
            Text(
              "Pincode",
              style: TxtStls.fieldstyle222,
            ),
            space(),
            Text(
              "Hello,",
              style: TxtStls.fieldstyle,
            ),
            Text(
              "Thank you for choosing JR Compliance",
              style: TxtStls.fieldstyle,
            ),
            space(),
            Text(
              "Thank you for choosing JR Compliance as your compliance partner, we admire the opportunity to provide you with the best compliance services and are sincerely welcoming you to our family.",
              style: TxtStls.fieldstyle,
            ),
            space2(),
            Text(
              "JR Compliance - Indian’s #1 compliance service provider was established in 2013 with the fundamental motive to make compliance seamless worldwide. We are proud to admit that we stand proudly among a few compliance service providers, who provide Indian and Global certification services under one roof. Till date, we have served more than 10,000 + Indian and Global brands such as Softbank, Troy, and Bombay Dyeing. With that, we pride ourselves that we have been awarded by Future Business Awards 2020 AS “Best Diversified Compliance Legal Service provider in India",
              style: TxtStls.fieldstyle,
            ),
            space2(),
            Text(
              "Moreover, we are pleased to inform you that we are the first Technical Compliance Company in India to receive this prestigious award and are also ISO 9001:2015 Certified company and featured in many National and International news platforms such as Deccan Chronicle, Hindustan Times, Zee News, and more.",
              style: TxtStls.fieldstyle,
            ),
            space2(),
            Text(
              "We are constantly working to provide superior regulatory and certification services to our clients to strive for excellence within defined time constraints, that too without compromising the accuracy of test methods and results. Additionally, at JR Compliance we are committed to provide responsive and competitive services to our clients by maintaining flexibility, adaptability, and a positive attitude while handling your project.",
              style: TxtStls.fieldstyle,
            ),
            space2(),
            Text(
              "Our clients are important to us and we assure to work promptly to ensure high customer satisfaction, now, and as long as you are our customer.",
              style: TxtStls.fieldstyle,
            ),
            space2(),
            Text(
              "Looking forward to taking this opportunity to work or associate with you to commence a valuable project.",
              style: TxtStls.fieldstyle,
            ),
            space2(),
            Text(
              "Thank you!",
              style: TxtStls.fieldstyle,
            ),
            Text(
              "Regards",
              style: TxtStls.fieldstyle,
            ),
            Text(
              "Mr.Tarun Sadana",
              style: TxtStls.fieldstyle,
            ),
            Text(
              "Sales & Marketing - BDE",
              style: TxtStls.fieldstyle,
            ),
            Text(
              "tarun@jrompliance.com",
              style: TxtStls.fieldstyle,
            ),
            Text(
              "www.jrompliance.com",
              style: TxtStls.fieldstyle,
            ),
          ],
        ),
      ),
    );
  }

  final services = <ServicesModel>[
    ServicesModel(
      name: "BIS Certificate",
    ),
    ServicesModel(
      name: "WPC Approval",
    ),
    ServicesModel(
      name: "LMPC Approval",
    ),
    ServicesModel(
      name: "ISI Certificate",
    ),
  ];
}
