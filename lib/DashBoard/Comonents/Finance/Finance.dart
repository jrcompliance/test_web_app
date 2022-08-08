import 'dart:async';
import 'dart:math';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer%202.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:test_web_app/Constants/Calenders.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:test_web_app/Models/CustomerModel.dart';
import 'package:test_web_app/Models/ScopeofWorkModel.dart';
import 'package:test_web_app/Models/ServicesModel.dart';
import 'package:test_web_app/Models/UserModel2.dart';
import 'package:test_web_app/PdfFiles/GetCRSServicePdf.dart';
import 'package:test_web_app/PdfFiles/GetFMCSServicePdf.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';
import 'package:test_web_app/Providers/LeadIDProviders.dart';
import 'package:test_web_app/Models/InvoiceDescriptionModel.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/PdfFiles/InvoiceNote.dart';
import 'package:test_web_app/Providers/GenerateCxIDProvider.dart';
import 'package:test_web_app/Providers/GetInvoiceProvider.dart';
import 'package:test_web_app/Providers/GstProvider.dart';
import 'package:test_web_app/Providers/InvoiceUpdateProvider.dart';
import 'package:test_web_app/Providers/ServiceSaveProvider.dart';
import 'package:test_web_app/Widgets/InvoicePopup.dart';
import 'package:zefyrka/zefyrka.dart';
import '../../../PdfFiles/GetISIServicePdf.dart';
import '../../../Providers/CustomerProvider.dart';

class Finance extends StatefulWidget {
  Finance({Key? key}) : super(key: key);

  @override
  _FinanceState createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  Map<String, TextEditingController> _controllerMap = Map();
  Map<int, TextEditingController> _controllerMap2 = Map();
  bool _isCreate = false;
  bool isgst = false;
  var date1;
  var date2;
  var invoiceid;

  bool isPreview = false;
  bool isServiceAdded = false;

  final List<String> currencieslist = ["INR", "USD", "GBP", "EURO"];
  final List<String> escalations = [
    "Prashant Thakur",
    "Tarun Sadana",
    "Lalit Gupta",
    "Rishikesh Mishra"
  ];

  //[{"id":4,"name":"1","email":"admin","password":"dc4b79a9200aa4630fee652bb5d7f232c503b77fb3b66df99b21ec3ff105f623","user_type":"1","created_on":"2020-01-13 12:50:28","updated_on":"2020-01-14 11:42:05","flags":"00000"},{"id":31,"name":"avi","email":"asdf@gmail.com","password":"dc4b79a9200aa4630fee652bb5d7f232c503b77fb3b66df99b21ec3ff105f623","user_type":"1","created_on":"2020-03-15 11:39:16","updated_on":"2020-03-15 11:39:16","flags":null}]
  final List escalationslist = [
    {'name': "Prashant Thakur", 'email': "", 'phone': "", 'img': ""},
    {'name': "Tarun Sadana", 'email': "", 'phone': "", 'img': ""},
    {'name': "Lalit Gupta", 'email': "", 'phone': "", 'img': ""},
    {'name': "Rishikesh Mishra", 'email': "", 'phone': "", 'img': ""}
  ];

  String selectedValue = "INR";
  var selectedleadid;
  final List<String> statusList = [
    "Pending",
    "Received",
    "Cancelled",
    "Disputed"
  ];

  late ZefyrController zefyrTermsController;
  late ZefyrController zefyrScopeController;
  late ZefyrController zefyrExclusionsController;
  late FocusNode focusNode;

  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _generatedateController = TextEditingController();
  final TextEditingController _selectedDateController = TextEditingController();
  final TextEditingController _duedatedateController = TextEditingController();
  final TextEditingController _externalController = TextEditingController();
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
  final TextEditingController _subjectController = TextEditingController();
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
  // final TextEditingController _filterDateController = TextEditingController();
  // final TextEditingController _serviceController1 = TextEditingController();
  // late TextEditingController scopeofwork1;
  // late TextEditingController scopeofwork2;
  // late TextEditingController scopeofwork3;
  // late TextEditingController scopeofwork4;
  // late TextEditingController scopeofwork5;
  // late TextEditingController scopeofwork6;
  // late TextEditingController scopeofwork7;
  // late TextEditingController scopeofwork8;
  // late TextEditingController scopeofwork9;
  // late TextEditingController scopeofwork10;

  List cust = [];
  List<CustomerModel> allCustomers = [];

  var popValue;

  bool isClicked = false;
  String? eimageurl;
  String? eemail;
  String? ephone;
  String? ename;
  String? edesig;

  final ScrollController sc = ScrollController();
  var randomNo;
  late List<ServicesModel> allServices;
  List<ScopeofWorkModel> scopeofwork = [];

  String? selectedSamples;
  String selectedPerson = "Select";

  bool isImageDropSelected = false;

  @override
  void initState() {
    var rng = new Random();
    randomNo = rng.nextInt(900000) + 100000;
    allServices = services;
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Provider.of<CustmerProvider>(context, listen: false)
          .getCustomers(
        context,
      )
          .then((value) {
        allCustomers =
            Provider.of<CustmerProvider>(context, listen: false).customerlist;
      });
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      var userid = FirebaseAuth.instance.currentUser;
      Provider.of<UserDataProvider>(context, listen: false)
          .getEmployeesList(userid)
          .then((value) {
        eimageurl =
            Provider.of<UserDataProvider>(context, listen: false).imageUrl;
        edesig =
            Provider.of<UserDataProvider>(context, listen: false).udesignation;
        ephone = Provider.of<UserDataProvider>(context, listen: false).phone;
        eemail = Provider.of<UserDataProvider>(context, listen: false).email;
        ename = Provider.of<UserDataProvider>(context, listen: false).username;
      });
    });
    // final document = _loadDocument();
    zefyrScopeController = ZefyrController();
    zefyrTermsController = ZefyrController();
    zefyrExclusionsController = ZefyrController();
    focusNode = FocusNode();

    // scopeofwork1 = TextEditingController(text: value1);
    // scopeofwork2 = TextEditingController(text: value2);
    // scopeofwork3 = TextEditingController(text: value3);
    // scopeofwork4 = TextEditingController(text: value4);
    // scopeofwork5 = TextEditingController(text: value5);
    // scopeofwork6 = TextEditingController(text: value6);
    // scopeofwork7 = TextEditingController(text: value7);
    // scopeofwork8 = TextEditingController(text: value8);
    // scopeofwork9 = TextEditingController(text: value9);
    // scopeofwork10 = TextEditingController(text: value10);
    // scopeofwork.add(ScopeofWorkModel(text: value1));
    // scopeofwork.add(ScopeofWorkModel(text: value2));
    // scopeofwork.add(ScopeofWorkModel(text: value3));
    // scopeofwork.add(ScopeofWorkModel(text: value4));
    // scopeofwork.add(ScopeofWorkModel(text: value5));
    // scopeofwork.add(ScopeofWorkModel(text: value6));
    // scopeofwork.add(ScopeofWorkModel(text: value7));
    // scopeofwork.add(ScopeofWorkModel(text: value8));
    // scopeofwork.add(ScopeofWorkModel(text: value9));
    // scopeofwork.add(ScopeofWorkModel(text: value10));
  }

  // NotusDocument _loadDocument() {
  //   final Delta delta = Delta()..insert("uyfwhfu iwehfu iwefhewiuf\n");
  //   // ..insert(
  //   //   "uyfwhfuiwehfuiwefhewiuf\n",
  //   // )
  //   // ..insert("yuruqhu\n")
  //   // ..insert('jkiahdfuiahaiuhkjsjvi\n');
  //
  //   final data = scopeOfWork2;
  //   return NotusDocument.fromJson(data);
  //   // return NotusDocument.fromDelta(delta);
  // }

  // @override
  // void dispose() {
  // //  int index = 0;
  //   //   index = index + 1;
  //   // scopeofwork1.clear();
  //   // scopeofwork2.clear();
  //   // scopeofwork3.clear();
  //   // scopeofwork4.clear();
  //   // scopeofwork5.clear();
  //   // scopeofwork6.clear();
  //   // scopeofwork7.clear();
  //   // scopeofwork8.clear();
  //   // scopeofwork9.clear();
  //   // scopeofwork10.clear();
  //   // _getscopeController(index).clear();
  //   super.dispose();
  // }

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
                  Row(children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          children:
                              _list.map((e) => newMethod(e, () {})).toList(),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: size.height * 0.025),
                  Container(
                      padding: const EdgeInsets.all(8),
                      height: size.height * 0.84,
                      decoration: const BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: fieldColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 2),
                              child: TextField(
                                  controller: _customersearchController,
                                  style: TxtStls.fieldstyle,
                                  decoration: InputDecoration(
                                      suffixIcon: _customersearchController
                                              .text.isNotEmpty
                                          ? IconButton(
                                              icon: const Icon(
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
                                          : const Icon(
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
                          const SizedBox(height: 10),
                          allCustomers.isEmpty
                              ? const Center(
                                  child: SpinKitFadingCube(
                                      color: btnColor, size: 15),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: allCustomers.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    var snp = allCustomers[i];
                                    return Material(
                                      borderRadius: const BorderRadius.all(
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
                                            child: const Icon(
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
                                        shape: const RoundedRectangleBorder(
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
            const SizedBox(width: 10),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: size.height * 0.93,
                decoration: const BoxDecoration(
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
                                              shape:
                                                  const RoundedRectangleBorder(
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
                                            icon: const Icon(Icons.add,
                                                color: bgColor),
                                            label: Text(
                                              "Create New $activeid",
                                              style: TxtStls.fieldstyle1,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.05),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: titleWidget(),
                                  ),
                                  Expanded(
                                      child:
                                          Provider.of<GetInvoiceListProvider>(
                                                      context)
                                                  .invoicemodellist
                                                  .isEmpty
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
                                                                      const Padding(
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
                                                                      const Icon(
                                                                          Icons
                                                                              .calendar_today_rounded,
                                                                          color:
                                                                              btnColor),
                                                                      const SizedBox(
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
                                                                      decoration: const InputDecoration(
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
                                                                      buttonPadding: const EdgeInsets
                                                                              .only(
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
                        child: isClicked
                            ? productAddition(context)
                            : const SizedBox(),
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
      height: size.height * 0.77,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: size.width * 0.225,
                decoration: const BoxDecoration(
                  color: fieldColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 0, top: 2),
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
                    Future.delayed(const Duration(seconds: 2)).then((value) {
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
                  padding: const EdgeInsets.symmetric(vertical: 12.5),
                  color: btnColor,
                  child: Provider.of<GstProvider>(context).isLoading
                      ? const SpinKitFadingCube(
                          color: bgColor,
                          size: 23,
                        )
                      : const Icon(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: grClr.withOpacity(0.25),
                        ),
                        child: Text(
                          "ReferenceID :",
                          style: TxtStls.fieldtitlestyle,
                        )),
                    const SizedBox(width: 7.5),
                    Expanded(
                      flex: 2,
                      child: field(
                          _referenceController, "Enter Reference ID", 1, true),
                    )
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: const SizedBox(),
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
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: btnColor,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
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
                ? const SizedBox()
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
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      children: [
                        formfield("TradeName", _tradenameController, true),
                        space(),
                        formfield(
                            "Address",
                            _addressControoler,
                            true,
                            const Icon(
                              Icons.location_on_rounded,
                              color: btnColor,
                            )),
                        space(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: formfield("PanNumber", _panController,
                                    true, null, 10),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
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
                              icon: const Icon(
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
                          : const SizedBox(),
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
                                        Future.delayed(const Duration(
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
                                      child: const Text(
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
                                : const SizedBox(),
                          ),
                          for (int i = 1; i <= 2; i++)
                            const VerticalDivider(
                              thickness: 2,
                              color: bgColor,
                            ),
                          const Expanded(flex: 2, child: const SizedBox()),
                          for (int i = 1; i <= 2; i++)
                            const VerticalDivider(
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
                                    : const SizedBox(),
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
                                ? field(_externalController, "External Notes",
                                    3, true, null, null, 200)
                                : const SizedBox(),
                          ),
                          for (int i = 1; i <= 2; i++)
                            const VerticalDivider(
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
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: btnColor,
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
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
                            const VerticalDivider(
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
                                      const Icon(
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
                                      const Icon(
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
                        _externalController.text.isEmpty) {
                      toastmessage.warningmessage(context, showmessage());
                    } else {
                      isPreview = true;
                      setState(() {});
                      Provider.of<RecentFetchCXIDProvider>(context,
                              listen: false)
                          .fetchRecentInvoiceid();
                    }
                  },
                  icon: const Icon(Icons.copy, size: 10, color: bgColor),
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
  // Widget halfspace() {
  //   Size size = MediaQuery.of(context).size;
  //   return SizedBox(height: size.height * 0.02);
  // }

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
            padding: const EdgeInsets.only(left: 15, right: 15, top: 2),
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

  Widget field2(_controller, hintText, maxlines, bool isenable, onchanged,
      [icn, icn1, maxlength]) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: deco3,
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
          onFieldSubmitted: (_) {
            setState(() {});
          },
          onChanged: onchanged,
        ),
      ),
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

  Widget field3(_controller, hintText, maxlines, bool isenable,
      [icn, icn1, maxlength]) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: deco3,
      child: Padding(
        padding: EdgeInsets.only(
            top: size.width * 0.002,
            bottom: size.width * 0.002,
            left: size.width * 0.01),
        // padding: EdgeInsets.symmetric(
        //     // horizontal: size.width * 0.01,
        //     ),
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
      decoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
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
              const Text(
                "Invoice Preview",
                style: TextStyle(
                    fontSize: 15, color: txtColor, fontWeight: FontWeight.bold),
              ),
              const Expanded(child: const SizedBox()),
              Provider.of<RecentFetchCXIDProvider>(context).actualinid == null
                  ? const SizedBox()
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
                            _externalController.text,
                            _internalController.text,
                            _referenceController.text,
                            selectedleadid,
                          );
                          isPreview = false;
                          _isCreate = false;
                        });
                      },
                      icon: const Icon(Icons.save_alt_rounded,
                          color: bgColor, size: 12.5),
                      label: Text("Save", style: TxtStls.fieldstyle1))
            ],
          ),
          const Divider(
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
              const Expanded(child: const SizedBox()),
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
          const Divider(
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
          const Divider(
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
          const Divider(
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
          const Divider(
            color: grClr,
          ),
          Text("Bank Details:",
              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
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
          const Divider(
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
  final _titlelist3 = [
    "SN",
    "Standard",
    "Sample Qty",
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
                    const Icon(Icons.arrow_drop_down)
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
    return const VerticalDivider(
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
    } else if (_externalController.text.isEmpty) {
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
            textTheme: const TextTheme(
              subtitle1: const TextStyle(color: Colors.black),
              button: const TextStyle(color: Colors.black),
            ),
            accentColor: Colors.black,
            colorScheme: const ColorScheme.light(
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
                constraints:
                    const BoxConstraints(maxWidth: 400, maxHeight: 450),
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
        const Expanded(
          flex: 1,
          child: const SizedBox(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  primary: bgColor),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AbgColor.withOpacity(0.02))),
                child: Text(
                  "PREVIOUS",
                  style: TxtStls.fieldstyle111,
                ),
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
            SizedBox(
              width: size.width * 0.01,
            ),
            ElevatedButton(
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
                    const Icon(
                      Icons.arrow_drop_down,
                      color: AbgColor,
                    )
                  ],
                )))
            .toList());
  }

  Widget page3TitleWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _titlelist3
              .map((e) => Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      e,
                      style: TxtStls.fieldstyle,
                    ),
                  ))
              .toList()),
    );
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
        const SizedBox(
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
      icons: const [
        Icon(Icons.design_services),
        Icon(Icons.insert_drive_file_rounded),
        Icon(Icons.insert_drive_file),
        Icon(Icons.file_copy_rounded),
        Icon(Icons.local_fire_department_rounded),
        Icon(Icons.remove_red_eye),
        Icon(Icons.done_all_rounded),
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

  var serviceurl;
  showScreen(activeStep) {
    if (activeStep == 0) {
      return serviceWidget(context);
    } else if (activeStep == 1) {
      return Createinvoice(context);
    } else if (activeStep == 2) {
      return paymentsService(context);
    } else if (activeStep == 3) {
      return scopeandTerms(context);
    } else if (activeStep == 4) {
      return escalationScreen(context);
    } else if (activeStep == 5) {
      Provider.of<RecentFetchCXIDProvider>(context, listen: false)
          .fetchRecentInvoiceid()
          .then((value) {
        invoiceid = Provider.of<RecentFetchCXIDProvider>(context, listen: false)
            .actualinid
            .toString();
      });
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () async {
                  var gstno = _gstController.text == null
                      ? ""
                      : _gstController.text.toString();
                  print(invoiceid.toString());
                  int? isiserviceid;
                  // Provider.of<RecentFetchCXIDProvider>(context, listen: false)
                  //     .fetchISIServiceId()
                  //     .then((value) async {
                  //   isiserviceid = Provider.of<RecentFetchCXIDProvider>(context,
                  //           listen: false)
                  //       .isiserviceid;
                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  CollectionReference reference =
                      await firestore.collection("Services");
                  serviceurl = reference.doc(Idocid).get();
                  print("service--urol--" + serviceurl.toString());
                  FirebaseStorage storage = FirebaseStorage.instance;

                  var url =
                      await storage.refFromURL(serviceurl.toString()).getData();
                  print('erdrttyftyyu' + url.toString());

                  // });
                  // int? fmcsserviceid;
                  // Provider.of<RecentFetchCXIDProvider>(context, listen: false)
                  //     .fetchFMCSServiceId()
                  //     .then((value) {
                  //   fmcsserviceid =
                  //       Provider.of<RecentFetchCXIDProvider>(context, listen: false)
                  //           .fmcsserviceid;
                  // });
                  // int? crsserviceid;
                  // Provider.of<RecentFetchCXIDProvider>(context, listen: false)
                  //     .fetchCRSServiceId()
                  //     .then((value) {
                  //   crsserviceid = Provider.of<RecentFetchCXIDProvider>(context,
                  //           listen: false)
                  //       .crsserviceid;
                  // });
                  // Future.delayed(Duration(seconds: 2)).then((value) async {
                  //   await PdfISIService.generatePdf(
                  //       context: context,
                  //       cusname: cusname.toString(),
                  //       tbal: tbal,
                  //       total: total,
                  //       gstAmount: selectedValue == "INR" ? _gstamount : 0.00,
                  //       selectedValue: selectedValue,
                  //       isiserviceid: isiserviceid!,
                  //       Servicelist: servicelist,
                  //       activeid: activeid.toString(),
                  //       actualinid: invoiceid.toString(),
                  //       cxID: cusID.toString(),
                  //       docid: Idocid.toString(),
                  //       duedate: _duedatedateController.text,
                  //       externalNotes: _externalController.text,
                  //       gstNo: gstno,
                  //       internalNotes: _internalController.text.toString(),
                  //       invoicedate: _generatedateController.text.toString(),
                  //       LeadId: leadID.toString(),
                  //       eimageurl: eimageurl.toString(),
                  //       ename: ename.toString(),
                  //       eemail: eemail.toString(),
                  //       ephone: ephone.toString(),
                  //       edesig: edesig.toString(),
                  //       referenceID: _referenceController.text);
                  // });
                  // Future.delayed(Duration(seconds: 2)).then((value) async {
                  //   await PdfFMCSService.generatePdf(
                  //       context: context,
                  //       cusname: cusname.toString(),
                  //       tbal: tbal,
                  //       total: total,
                  //       gstAmount: selectedValue == "INR" ? _gstamount : 0.00,
                  //       selectedValue: selectedValue,
                  //       fmcsserviceid: fmcsserviceid!,
                  //       Servicelist: servicelist,
                  //       activeid: activeid.toString(),
                  //       actualinid: invoiceid.toString(),
                  //       cxID: cusID.toString(),
                  //       docid: Idocid.toString(),
                  //       duedate: _duedatedateController.text,
                  //       externalNotes: _externalController.text,
                  //       gstNo: gstno,
                  //       internalNotes: _internalController.text.toString(),
                  //       invoicedate: _generatedateController.text.toString(),
                  //       LeadId: leadID.toString(),
                  //       referenceID: _referenceController.text);
                  // });
                  // Future.delayed(Duration(seconds: 2)).then((value) async {
                  //   await PdfCRSService.generatePdf(
                  //       context: context,
                  //       cusname: cusname.toString(),
                  //       tbal: tbal,
                  //       total: total,
                  //       gstAmount: selectedValue == "INR" ? _gstamount : 0.00,
                  //       selectedValue: selectedValue,
                  //       crsserviceid: crsserviceid!,
                  //       Servicelist: servicelist,
                  //       activeid: activeid.toString(),
                  //       actualinid: invoiceid.toString(),
                  //       cxID: cusID.toString(),
                  //       docid: Idocid.toString(),
                  //       duedate: _duedatedateController.text,
                  //       externalNotes: _externalController.text,
                  //       gstNo: gstno,
                  //       internalNotes: _internalController.text.toString(),
                  //       invoicedate: _generatedateController.text.toString(),
                  //       LeadId: leadID.toString(),
                  //       referenceID: _referenceController.text);
                  // });
                },
                child: const Text("Create Pdf")),
            TextButton(
                onPressed: () async {
                  // PdfDocument doc = await PdfDocument.fromUrl()
                  pdfview();
                  print(serviceurl.toString());
                },
                child: Text("view pdf")),
            pdfview(),
          ],
        ),
      );
    } else {
      return Container(
        child: serviceIntro(context),
      );
    }
  }

  Widget pdfview() {
    return Container(
      height: 500,
      width: 500,
      child: ListView.builder(itemBuilder: (context, index) {
        return Container(
            child: SfPdfViewer.network(serviceurl[index].toString()));
      }),
    );
  }

  Widget paymentsService(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: bgColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(color: btnColor.withOpacity(0.6)),
              ),
              onPressed: () {},
            ),
          ),
        ),
        space(),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  "Standard and Sample Qty",
                  style: TxtStls.fieldtitlestyle11,
                ),
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                    onPressed: () {},
                    icon: const CircleAvatar(
                        radius: 40.0,
                        child: Icon(
                          Icons.add,
                          size: 10.0,
                        ))),
              ),
            ],
          ),
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 4,
                //   fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(
                    "SN",
                    style: TxtStls.fieldstyle,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                //   fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Standard",
                    style: TxtStls.fieldstyle,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                //  fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    "Sample Qty",
                    style: TxtStls.fieldstyle,
                  ),
                ),
              ),
            ]),
        space(),
        SizedBox(
          height: size.height * 0.26,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            controller: sc,
            itemCount: allServices.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color:
                          index % 2 == 0 ? AbgColor.withOpacity(0.1) : bgColor,
                    ),
                    height: size.width * 0.03,
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "${index + 1}",
                                      style: TxtStls.fieldstyle,
                                    )),
                                //     const SizedBox(width: 10,),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 0.0),
                                    child: productWidget(
                                      "assets/Images/pending.png",
                                      allServices[index].name,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Material(
                                shadowColor: AbgColor.withOpacity(0.2),
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(20.0),
                                color: bgColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AbgColor.withOpacity(0.5),
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: const Offset(5.0,
                                            5.0), // shadow direction: bottom right
                                      )
                                    ],
                                  ),
                                  height: size.width * 0.015,
                                  child: field3(
                                      _getController(
                                          allServices[index].name.toString()),
                                      "Type",
                                      1,
                                      true),
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, top: 5.0),
                                        child: Material(
                                            shadowColor:
                                                AbgColor.withOpacity(0.2),
                                            elevation: 5.0,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: bgColor,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AbgColor.withOpacity(
                                                        0.5),
                                                    blurRadius: 2.0,
                                                    spreadRadius: 0.0,
                                                    offset: const Offset(5.0,
                                                        5.0), // shadow direction: bottom right
                                                  )
                                                ],
                                              ),
                                              height: size.width * 0.015,
                                              child: field3(
                                                  _getController(
                                                      allServices[index]
                                                          .qty
                                                          .toString()),
                                                  "Type",
                                                  1,
                                                  true),
                                            )))),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 20.0),
                                        child: popupMenu(
                                            "EDIT",
                                            "DELETE",
                                            index,
                                            btnColor,
                                            neClr,
                                            Icons.edit,
                                            Icons.delete))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  //   print(allServices[index].name);
                },
              );
            },
          ),
        ),
        space(),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                "Payment Terms",
                style: TxtStls.fieldtitlestyle11,
              )),
              Flexible(
                flex: 1,
                child: IconButton(
                    onPressed: () {},
                    icon: const CircleAvatar(
                        radius: 40.0,
                        child: Icon(
                          Icons.add,
                          size: 10.0,
                        ))),
              ),
            ],
          ),
        ),
        space(),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 6,
                //   fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(
                    "Stage",
                    style: TxtStls.fieldstyle,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                //   fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    "Amount",
                    style: TxtStls.fieldstyle,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                //  fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Text(
                    "Percentage",
                    style: TxtStls.fieldstyle,
                  ),
                ),
              ),
            ]),
        space(),
        SizedBox(
          height: size.height * 0.2,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            controller: sc,
            itemCount: allServices.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color:
                          index % 2 == 0 ? AbgColor.withOpacity(0.1) : bgColor,
                    ),
                    height: size.width * 0.03,
                    padding: const EdgeInsets.only(left: 20.0, right: 50),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 80.0),
                                child: Material(
                                    elevation: 10.0,
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: bgColor,
                                    child: SizedBox(
                                      height: size.width * 0.016,
                                      child: field3(
                                          _getController(
                                              stages[index].toString()),
                                          "Type",
                                          1,
                                          true),
                                    ))),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Material(
                                          elevation: 10.0,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: bgColor,
                                          child: SizedBox(
                                            height: size.width * 0.014,
                                            child: field3(
                                                _getController(
                                                    amount[index].toString()),
                                                'Type',
                                                1,
                                                true),
                                          )),
                                    ),
                                    Flexible(
                                        child: Text(
                                      "or",
                                      style: TxtStls.fieldtitlestyle3,
                                    ))
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50.0, top: 10.0),
                                    child: Material(
                                      elevation: 10.0,
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: bgColor,
                                      child: SizedBox(
                                        height: size.width * 0.016,
                                        child: field3(
                                            _getController(
                                              percentage[index].toString(),
                                            ),
                                            'Type',
                                            1,
                                            true),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 20.0),
                                        child: popupMenu(
                                            "EDIT",
                                            "DELETE",
                                            index,
                                            btnColor,
                                            neClr,
                                            Icons.edit,
                                            Icons.delete))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  //   print(allServices[index].name);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // final quill.QuillController _quillController = quill.QuillController.basic();
  double fontSelected = 12.0;
  List<double> fontSizeList = [
    12.0,
    14.0,
    16.0,
    18.0,
    20.0,
    22.0,
    24.0,
    26.0,
    28.0,
    30.0,
    32.0,
    34.0,
    36.0,
  ];
  String imageDropValue = "1";
  var imageDropList = [
    Image.asset("assets/Logos/BIS_logo.png"),
    Image.asset("assets/Logos/CRS_logo6.png"),
    Image.asset("assets/Logos/FMCS_logo3.png"),
  ];
  bool isBullettapped = false;
  bool isNumberBulletTapped = false;
  Widget scopeandTerms(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double rightpad = size.width * 0.3;
    ScrollController scopeListController = ScrollController();
    ScrollController scopeListController2 = ScrollController();
    return Column(
      children: [
        // const SizedBox(height: 30,),
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: bgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
            ),
            child: Text(
              "Cancel",
              style: TextStyle(color: btnColor.withOpacity(0.6)),
            ),
            onPressed: () {},
          ),
        ),
        space2(),
        scoperow("Scope of Work", scopetext),
        space2(),
        Material(
          color: AbgColor.withOpacity(0.2),
          // elevation: 0.5,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Column(
            children: [
              SizedBox(
                  height: size.height * 0.2,
                  child: Container(
                    color: AbgColor.withOpacity(0.2),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ZefyrEditor(
                          controller: zefyrScopeController,
                          embedBuilder: (context, node) {
                            return Text(
                              scopetext,
                              style: TxtStls.fieldstyle,
                            );
                          },
                        )),
                  )),

              ZefyrToolbar.basic(controller: zefyrScopeController),
              // Padding(
              //   padding:
              //       EdgeInsets.only(left: 20.0, right: rightpad, bottom: 10.0),
              //   child: Material(
              //     color: AbgColor.withOpacity(0.2),
              //     //       // elevation: 1.0,
              //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              //     child: Container(
              //       height: size.height * 0.04,
              //       decoration: BoxDecoration(color: bgColor),
              //       child: Row(
              //         children: [
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           InkWell(
              //             child: Text(
              //               'B',
              //               style: TxtStls.tapstylebold,
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 boldpressed = !boldpressed;
              //               });
              //             },
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           InkWell(
              //             child: Text(
              //               "U",
              //               style: TxtStls.tapstyleunderline,
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 underlinepressed = !underlinepressed;
              //               });
              //             },
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           InkWell(
              //             child: Text(
              //               'I',
              //               style: TxtStls.tapstyleitalic,
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 italicpressed = !italicpressed;
              //               });
              //             },
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Container(
              //             height: 30,
              //             width: 65,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(8.0),
              //                 border: Border.all(color: AbgColor)),
              //             child: DropdownButton<double>(
              //               underline: Container(),
              //               hint: Padding(
              //                 padding: const EdgeInsets.only(left: 8.0),
              //                 child: Text(
              //                   "A",
              //                   style: TxtStls.tapstylebold,
              //                 ),
              //               ),
              //               // Initial Value
              //
              //               // Down Arrow Icon
              //               icon: const Padding(
              //                 padding: EdgeInsets.only(right: 8.0),
              //                 child: Icon(
              //                   Icons.arrow_drop_down_rounded,
              //                   size: 14.0,
              //                 ),
              //               ),
              //
              //               // Array list of items
              //               items: fontSizeList
              //                   .map((item) => DropdownMenuItem<double>(
              //                         value: item,
              //                         child: Text(
              //                           item.toString(),
              //                           style: TxtStls.fieldstyle,
              //                         ),
              //                       ))
              //                   .toList(),
              //               //  value: dropdownfonts,
              //
              //               onChanged: (double? newValue) {
              //                 setState(() {
              //                   fontSelected = newValue!;
              //
              //                   print(fontSelected);
              //                   print(imageDropValue);
              //                 });
              //               },
              //             ),
              //           ),
              //           Container(
              //             height: 30,
              //             width: 65,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(8.0),
              //                 border: Border.all(color: AbgColor)),
              //             child: DropdownButton<String>(
              //               underline: Container(),
              //               hint: Padding(
              //                   padding: const EdgeInsets.only(left: 8.0),
              //                   child:
              //                       Image.asset("assets/Logos/BIS_logo.png")),
              //               // Initial Value
              //
              //               // Down Arrow Icon
              //               icon: const Padding(
              //                 padding: EdgeInsets.only(right: 8.0),
              //                 child: Icon(
              //                   Icons.arrow_drop_down_rounded,
              //                   size: 14.0,
              //                 ),
              //               ),
              //
              //               // Array list of items
              //               items: [
              //                 DropdownMenuItem(
              //                   child: imageDropItems("", imageDropList[0]),
              //                   value: "1",
              //                 ),
              //                 DropdownMenuItem(
              //                   child: imageDropItems("", imageDropList[1]),
              //                   value: "2",
              //                 ),
              //                 DropdownMenuItem(
              //                   child: imageDropItems("", imageDropList[2]),
              //                   value: "3",
              //                   onTap: () {},
              //                 ),
              //               ],
              //               value: imageDropValue,
              //
              //               onChanged: (newValue) {
              //                 setState(() {
              //                   imageDropValue = newValue.toString();
              //                   print(imageDropValue);
              //                   print(textAlignment(imageDropValue));
              //                 });
              //               },
              //             ),
              //           ),
              //           InkWell(
              //             child: Container(
              //                 height: 30,
              //                 width: 30,
              //                 decoration: BoxDecoration(
              //                     border: Border.all(
              //                         color: isBullettapped
              //                             ? btnColor
              //                             : Colors.transparent),
              //                     borderRadius: BorderRadius.circular(5.0)),
              //                 child: Image.asset("assets/Logos/BIS_logo.png")),
              //             onTap: () {
              //               setState(() {
              //                 isBullettapped = !isBullettapped;
              //               });
              //             },
              //           ),
              //           InkWell(
              //             child: Container(
              //                 height: 30,
              //                 width: 30,
              //                 decoration: BoxDecoration(
              //                     border: Border.all(
              //                         color: isNumberBulletTapped
              //                             ? btnColor
              //                             : Colors.transparent),
              //                     borderRadius: BorderRadius.circular(5.0)),
              //                 child: Image.asset("assets/Logos/CRS_logo6.png")),
              //             onTap: () {
              //               setState(() {
              //                 isNumberBulletTapped = !isNumberBulletTapped;
              //               });
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        // listview(scopeofwork),
        space2(),
        scoperow("Terms and Conditions", terms),
        // termsrow(
        //   "Terms and Conditions",
        // ),
        space2(),
        Material(
          color: AbgColor.withOpacity(0.2),
          //       // elevation: 1.0,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Column(
            children: [
              SizedBox(
                  height: size.height * 0.2,
                  child: Material(
                    color: AbgColor.withOpacity(0.2),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ZefyrEditor(
                          controller: zefyrTermsController,
                          embedBuilder: (context, node) {
                            return Text(
                              terms,
                              style: TxtStls.fieldstyle,
                            );
                          },
                        )),
                  )),

              ZefyrToolbar.basic(controller: zefyrTermsController),
              // Padding(
              //   padding:
              //       EdgeInsets.only(left: 20.0, right: rightpad, bottom: 10.0),
              //   child: Material(
              //     color: AbgColor.withOpacity(0.2),
              //     //       // elevation: 1.0,
              //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              //     child: Container(
              //       height: size.height * 0.04,
              //       decoration: BoxDecoration(color: bgColor),
              //       child: Row(
              //         children: [
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           InkWell(
              //             child: Text(
              //               'B',
              //               style: TxtStls.tapstylebold,
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 boldpressed = !boldpressed;
              //               });
              //             },
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           InkWell(
              //             child: Text(
              //               "U",
              //               style: TxtStls.tapstyleunderline,
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 underlinepressed = !underlinepressed;
              //               });
              //             },
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           InkWell(
              //             child: Text(
              //               'I',
              //               style: TxtStls.tapstyleitalic,
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 italicpressed = !italicpressed;
              //               });
              //             },
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Container(
              //             height: 30,
              //             width: 65,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(8.0),
              //                 border: Border.all(color: AbgColor)),
              //             child: DropdownButton<double>(
              //               underline: Container(),
              //               hint: Padding(
              //                 padding: const EdgeInsets.only(left: 8.0),
              //                 child: Text(
              //                   "A",
              //                   style: TxtStls.tapstylebold,
              //                 ),
              //               ),
              //               // Initial Value
              //
              //               // Down Arrow Icon
              //               icon: const Padding(
              //                 padding: EdgeInsets.only(right: 8.0),
              //                 child: Icon(
              //                   Icons.arrow_drop_down_rounded,
              //                   size: 14.0,
              //                 ),
              //               ),
              //
              //               // Array list of items
              //               items: fontSizeList
              //                   .map((item) => DropdownMenuItem<double>(
              //                         value: item,
              //                         child: Text(
              //                           item.toString(),
              //                           style: TxtStls.fieldstyle,
              //                         ),
              //                       ))
              //                   .toList(),
              //               //  value: dropdownfonts,
              //
              //               onChanged: (double? newValue) {
              //                 setState(() {
              //                   fontSelected = newValue!;
              //
              //                   print(fontSelected);
              //                   print(imageDropValue);
              //                 });
              //               },
              //             ),
              //           ),
              //           Container(
              //             height: 30,
              //             width: 65,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(8.0),
              //                 border: Border.all(color: AbgColor)),
              //             child: DropdownButton<String>(
              //               underline: Container(),
              //               hint: Padding(
              //                   padding: const EdgeInsets.only(left: 8.0),
              //                   child:
              //                       Image.asset("assets/Logos/BIS_logo.png")),
              //               // Initial Value
              //
              //               // Down Arrow Icon
              //               icon: const Padding(
              //                 padding: EdgeInsets.only(right: 8.0),
              //                 child: Icon(
              //                   Icons.arrow_drop_down_rounded,
              //                   size: 14.0,
              //                 ),
              //               ),
              //
              //               // Array list of items
              //               items: [
              //                 DropdownMenuItem(
              //                   child: imageDropItems("", imageDropList[0]),
              //                   value: "1",
              //                 ),
              //                 DropdownMenuItem(
              //                   child: imageDropItems("", imageDropList[1]),
              //                   value: "2",
              //                 ),
              //                 DropdownMenuItem(
              //                   child: imageDropItems("", imageDropList[2]),
              //                   value: "3",
              //                   onTap: () {},
              //                 ),
              //               ],
              //               value: imageDropValue,
              //
              //               onChanged: (newValue) {
              //                 setState(() {
              //                   imageDropValue = newValue.toString();
              //                   print(imageDropValue);
              //                   print(textAlignment(imageDropValue));
              //                 });
              //               },
              //             ),
              //           ),
              //           InkWell(
              //             child: Container(
              //                 height: 30,
              //                 width: 30,
              //                 decoration: BoxDecoration(
              //                     border: Border.all(
              //                         color: isBullettapped
              //                             ? btnColor
              //                             : Colors.transparent),
              //                     borderRadius: BorderRadius.circular(5.0)),
              //                 child: Image.asset("assets/Logos/BIS_logo.png")),
              //             onTap: () {
              //               setState(() {
              //                 isBullettapped = !isBullettapped;
              //               });
              //             },
              //           ),
              //           InkWell(
              //             child: Container(
              //                 height: 30,
              //                 width: 30,
              //                 decoration: BoxDecoration(
              //                     border: Border.all(
              //                         color: isNumberBulletTapped
              //                             ? btnColor
              //                             : Colors.transparent),
              //                     borderRadius: BorderRadius.circular(5.0)),
              //                 child: Image.asset("assets/Logos/CRS_logo6.png")),
              //             onTap: () {
              //               setState(() {
              //                 isNumberBulletTapped = !isNumberBulletTapped;
              //               });
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        //  listview(terms),
      ],
    );
  }

  Widget imageDropItems(String text, var image) {
    return Row(
      children: [
        Text(
          text,
          style: TxtStls.fieldstyle,
        ),
        const SizedBox(
          width: 2.0,
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          child: image,
        ),
      ],
    );
  }

  var exclusions = "";
  var terms =
      "The services provided by JR Compliance are governed by our https://www.jrcompliance.com/terms-and-conditions.\nIn case you face difficulty in obtaining our Terms and conditions from our official website, contact your designated representative immediately to receive a copy of the same.\nTo know the information regarding purchase and billing,visit - https://www.jrcompliance.com/purchase-and-billing.\nTo know more about our privacy policies, visit - https://www.jrcompliance.com/privacy-policy";
  final TextEditingController scopeEditController = TextEditingController();
  final TextEditingController termsEditController = TextEditingController();
  final TextEditingController escalationEditController =
      TextEditingController();
  edit(List list, TextEditingController controller, [model]) {
    setState(() {
      list.add(controller.text);
      controller.clear();
      // print("scope of work length--" + list.length.toString());
    });
  }

  scopeedit(TextEditingController controller) {
    setState(() {
      scopeofwork1;
      controller.clear();
    });
  }

  Widget scoperow(String text, text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            text,
            style: TxtStls.fieldtitlestyle11,
          ),
        ),
        Flexible(
          flex: 1,
          child: InkWell(
            child: const Icon(
              Icons.copy,
              size: 20.0,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    predefinedtextDialog(context, text2),
              );
              //  print("scope---" + scopetext.toString());
              print("terms---" + terms.toString());
            },
          ),
          // child: field2(scopeEditController, "", 1, true,
          //     scopeedit(scopeEditController), const Icon(Icons.edit)),
        ),
      ],
    );
  }

  String scopetext =
      'We assist you to know whether a product falls under the purview of concernedauthority.\nFor comprehensible guidance, we will first scrutinize the certificationrequirements of a product.\nWe will provide you information regarding a number of samples required forproduct testing because product sample requirements differ depending onproduct type.\nWe will educate you about the registration process, benefits, documentsrequired, including any query you may have regarding the same.\nBeing a reputed compliance consultant, we will provide you technical and non-technical support.\nJR Compliance offers competitive and excellent services to our clients bymeeting the startled queries/demands.\nTo ensure the utmost convenience of our client, we will also assist you in thecustom clearance of the sample product.\nWe are available 24*7 to make sure our clients get what they expect from us,thus, we will provide you with the finest solution to your queries.';

  Widget predefinedtextDialog(BuildContext context, text) {
    bool tapped = false;
    final key = new GlobalKey<ScaffoldState>();
    return AlertDialog(
      key: key,
      contentPadding: const EdgeInsets.all(0.0),
      contentTextStyle: TxtStls.fieldstyle,
      content: InkWell(
        child: Tooltip(
          message: tapped == true ? 'copied' : 'tap to copy',
          child: Text(
            text,
            style: TxtStls.fieldstyle,
          ),
        ),
        onTap: () {
          Clipboard.setData(ClipboardData(text: text));
          setState(() {
            tapped = !tapped;
            print(tapped);
            Navigator.of(context, rootNavigator: true).pop();
          });
          // key.currentState!.showSnackBar( const SnackBar(
          //   content:  Text("Copied to Clipboard"),
          // ));
        },
      ),
    );
  }

  // Widget escalationrow(String text) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Flexible(
  //         flex: 1,
  //         child: Text(
  //           text,
  //           style: TxtStls.fieldtitlestyle11,
  //         ),
  //       ),
  //       Flexible(
  //         flex: 1,
  //         child: field2(
  //             escalationEditController,
  //             "",
  //             1,
  //             true,
  //             edit(escalations, escalationEditController),
  //             const Icon(Icons.edit)),
  //       ),
  //     ],
  //   );
  // }

  // Widget termsrow(String text) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Flexible(
  //         flex: 1,
  //         child: Text(
  //           text,
  //           style: TxtStls.fieldtitlestyle11,
  //         ),
  //       ),
  //       Flexible(
  //         flex: 1,
  //         child: field2(termsEditController, "", 1, true,
  //             edit(terms, termsEditController), const Icon(Icons.edit)),
  //         // child: ElevatedButton.icon(
  //         //   style: ElevatedButton.styleFrom(
  //         //     primary: bgColor,
  //         //     shape: RoundedRectangleBorder(
  //         //         borderRadius: BorderRadius.circular(8.0)),
  //         //   ),
  //         //   label: const Icon(
  //         //     Icons.edit,
  //         //     color: AbgColor,
  //         //     size: 16,
  //         //   ),
  //         //   onPressed: () {
  //         //     setState(() {
  //         //       _isscopeeditPressed = true;
  //         //     });
  //         //   _isscopeeditPressed ? scopeEditExpanded(8): null;
  //         //
  //         //     // list.forEach((element) {
  //         //     //   element.toString().trim();
  //         //     // });
  //         //   }, icon: const Icon(
  //         //   Icons.edit,
  //         //   color: AbgColor,
  //         //   size: 16,
  //         // ),
  //         // ),
  //       ),
  //     ],
  //   );
  // }

  Widget dropdecor(String text, [Color? clr, IconData? icon]) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: clr?.withOpacity(0.05),
      ),
      child: Row(
        children: [
          SizedBox(
              child: Icon(
            icon,
            color: clr,
            size: 13,
          )),
          space(),
          SizedBox(
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

  // Widget listview(List list) {
  //   Size size = MediaQuery.of(context).size;
  //
  //   return Material(
  //       color: AbgColor.withOpacity(0.2),
  //       // elevation: 1.0,
  //       borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(
  //             height: size.height * 0.22,
  //             child: ListView(
  //               children: List.generate(
  //                 list.length,
  //                 (index) => Flexible(
  //                     flex: 1,
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(left: 20.0),
  //                       child: _editTitleTextField(list[index].toString()),
  //                     )),
  //               ),
  //             ),
  //             // ListView(children: [
  //             //   Flexible(
  //             //       flex: 1,
  //             //       child: Padding(
  //             //         padding: const EdgeInsets.only(left: 20.0),
  //             //         child: _editTitleTextField(list[0].toString()),
  //             //       )),
  //             //   Flexible(
  //             //       flex: 1,
  //             //       child: Padding(
  //             //         padding: const EdgeInsets.only(left: 20.0),
  //             //         child: _editTitleTextField(list[1].toString()),
  //             //       )),
  //             //   Flexible(
  //             //       flex: 1,
  //             //       child: Padding(
  //             //         padding: const EdgeInsets.only(left: 20.0),
  //             //         child: _editTitleTextField(list[2].toString()),
  //             //       )),
  //             //   Flexible(
  //             //       flex: 1,
  //             //       child: Padding(
  //             //         padding: const EdgeInsets.only(left: 20.0),
  //             //         child: _editTitleTextField(list[3].toString()),
  //             //       )),
  //             //   Flexible(
  //             //       flex: 1,
  //             //       child: Padding(
  //             //         padding: const EdgeInsets.only(left: 20.0),
  //             //         child: _editTitleTextField(list[4].toString()),
  //             //       )),
  //             //   Flexible(
  //             //       flex: 1,
  //             //       child: Padding(
  //             //         padding: const EdgeInsets.only(left: 20.0),
  //             //         child: _editTitleTextField(list[5].toString()),
  //             //       )),
  //             //   Flexible(
  //             //       flex: 1,
  //             //       child: Padding(
  //             //         padding: const EdgeInsets.only(left: 20.0),
  //             //         child: _editTitleTextField(list[6].toString()),
  //             //       )),
  //             // ]
  //             // ),
  //           ),
  //           Padding(
  //             padding:
  //                 EdgeInsets.only(left: 20.0, right: rightpad, bottom: 10.0),
  //             child: Container(
  //               height: size.height * 0.04,
  //               decoration: BoxDecoration(color: Colors.red),
  //             ),
  //           )
  //         ],
  //       ));
  // }

  bool _isEditingText = false;
  bool editable = false;

  String value1 =
      "We assist you to know whether a product falls under the purview of concerned authority.";
  String value2 =
      "For comprehensible guidance, we will first scrutinize the certification requirements of a product.";
  String value3 =
      "We will provide you information regarding a number of samples required for product testing because product sample requirements differ depending on product type.";
  String value4 =
      "We will educate you about the registration process, benefits, documents required, including any query you may have regarding the same.";
  String value5 =
      "Being a reputed compliance consultant, we will provide you technical and non- technical support.";
  String value6 =
      "JR Compliance offers competitive and excellent services to our clients by meeting the startled queries/demands.";
  String value7 =
      "To ensure the utmost convenience of our client, we will also assist you in the custom clearance of the sample product.";
  String value8 =
      "Our consultants will invest their sustained efforts to meet the startled queries or demands of concerned authorities.";
  String value9 =
      "Obtaining a certificate is no easy task, however, there is no better place to obtain it than JR Compliance because we will analyze the product requirements to give clear guidelines.";
  String value10 =
      "We are available 24*7 to make sure our clients get what they expect from us, thus, we will provide you with the finest solution to your queries.";
  bool boldpressed = false;
  // List scopeofwork1 = [
  //   "We are available 24*7 to make sure our clients get what they expect from us, thus, we will provide you with the finest solution to your queries.",
  // ];
  var scopeofwork1 = ScopeofWorkModel(text: "fsfwefewfw");

  var scopeOfWork2 = [
    {
      "text":
          "We are available 24*7 to make sure our clients get what they expect from us, thus, we will provide you with the finest solution to your queries."
    },
    // {
    //   "text":
    //       "We are available 24*7 to make sure our clients get what they expect from us, thus, we will provide you with the finest solution to your queries."
    // },
  ];
  bool underlinepressed = false;
  bool italicpressed = false;

  TextAlign textAlignment(imageDropValue) {
    switch (imageDropValue) {
      case "1":
        {
          return TextAlign.left;
        }
      case "2":
        {
          return TextAlign.center;
        }
      case "3":
        {
          return TextAlign.right;
        }
      default:
        {
          return TextAlign.left;
        }
    }
  }

  // void editScopeofWork(String newText, int index) {
  //   setState(() {
  //     scopeofwork[index].text = newText.toString();
  //   });
  // }
  String tappedText = "";
  Widget _editableTextField(int index) {
    if (_isEditingText) {
      return TextField(
        style: boldpressed
            ? TxtStls.tapstylebold
            : underlinepressed
                ? TxtStls.tapstyleunderline
                : italicpressed
                    ? TxtStls.tapstyleitalic
                    : GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: txtColor,
                            fontSize: fontSelected,
                            letterSpacing: 0.2),
                        color: txtColor,
                        letterSpacing: 0.2,
                        fontSize: fontSelected),
        textAlign: textAlignment(imageDropValue),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        onSubmitted: (newValue) {
          setState(() {
            _isEditingText = false;
            scopeofwork[index].text = newValue;
            //   print("newvalue--" + newValue.toString());
            print("tappedtext--" + tappedText.toString());
            tappedText = "";
          });
        },
        autofocus: true,
        controller: _getscopeController(index),
      );
    }
    return InkWell(
        onTap: () {
          // setState(() {
          //   _isEditingText = true;
          //   //  print("tapped index--" + scopeofwork[index].text.toString());
          //   tappedText = scopeofwork[index].text.toString();
          // });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isBullettapped
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Container(
                        height: 5.0,
                        width: 5.0,
                        decoration: BoxDecoration(
                            color: txtColor,
                            borderRadius: BorderRadius.circular(2.0)),
                      ),
                    )
                  : SizedBox(),
              isNumberBulletTapped
                  ? Padding(
                      padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                      child: Text(
                        "${index + 1}" + ".",
                        style: TxtStls.tapstylebold,
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                width: isBullettapped
                    ? 20.0
                    : isNumberBulletTapped
                        ? 20.0
                        : 0.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: isNumberBulletTapped ? 5.0 : 0.0),
                child: Text(
                  scopeofwork[index].text.toString(),
                  style: boldpressed
                      ? TxtStls.tapstylebold
                      : underlinepressed
                          ? TxtStls.tapstyleunderline
                          : italicpressed
                              ? TxtStls.tapstyleitalic
                              : GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      color: txtColor,
                                      fontSize: fontSelected,
                                      letterSpacing: 0.2),
                                  color: txtColor,
                                  letterSpacing: 0.2,
                                  fontSize: fontSelected),
                  textAlign: textAlignment(imageDropValue),
                ),
              ),
            ],
          ),
        ));
  }

  // Widget _editableTextField1() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           value1 = newValue;
  //           _isEditingText = !_isEditingText;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork1,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         value1,
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }
  //
  // Widget _editableTextField2() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           value2 = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork2,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         value2,
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }
  //
  // Widget _editableTextField3() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           value3 = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork3,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         value3,
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }
  //
  // Widget _editableTextField4() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           value4 = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork4,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         value4,
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }
  //
  // Widget _editableTextField5() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           value5 = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork5,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         value5,
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }
  //
  // Widget _editableTextField6() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           value6 = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork6,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         value6,
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }
  //
  // Widget _editableTextField7() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           value7 = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork7,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         value7,
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }
  //
  // Widget _editableTextField8() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           value8 = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork8,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         value8,
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }
  //
  // Widget _editableTextField9() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           value9 = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork9,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         value9,
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }

  // Widget _editableTextField10() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           scopeofwork[10] = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork10,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         scopeofwork[10],
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }

  // Widget _editableTextField11() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           scopeEditController.text = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork10,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         scopeEditController.text == null ? "" : scopeofwork[11],
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }

  // Widget _editableTextField12() {
  //   if (_isEditingText) {
  //     return TextField(
  //       style: boldpressed
  //           ? TxtStls.tapstylebold
  //           : underlinepressed
  //               ? TxtStls.tapstyleunderline
  //               : italicpressed
  //                   ? TxtStls.tapstyleitalic
  //                   : GoogleFonts.nunito(
  //                       textStyle: TextStyle(
  //                           color: txtColor,
  //                           fontSize: fontSelected,
  //                           letterSpacing: 0.2),
  //                       color: txtColor,
  //                       letterSpacing: 0.2,
  //                       fontSize: fontSelected),
  //       textAlign: textAlignment(imageDropValue),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //       ),
  //       onSubmitted: (newValue) {
  //         setState(() {
  //           scopeEditController.text = newValue;
  //           _isEditingText = false;
  //         });
  //       },
  //       autofocus: true,
  //       controller: scopeofwork10,
  //     );
  //   }
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText = true;
  //         });
  //       },
  //       child: Text(
  //         scopeEditController.text == null ? "" : scopeofwork[12],
  //         style: boldpressed
  //             ? TxtStls.tapstylebold
  //             : underlinepressed
  //                 ? TxtStls.tapstyleunderline
  //                 : italicpressed
  //                     ? TxtStls.tapstyleitalic
  //                     : GoogleFonts.nunito(
  //                         textStyle: TextStyle(
  //                             color: txtColor,
  //                             fontSize: fontSelected,
  //                             letterSpacing: 0.2),
  //                         color: txtColor,
  //                         letterSpacing: 0.2,
  //                         fontSize: fontSelected),
  //         textAlign: textAlignment(imageDropValue),
  //       ));
  // }

  var newList;
  bool isDelete = false;
  Widget popupMenu(value1, value2, index,
      [Color? clr1, Color? clr2, IconData? icon, IconData? icon2]) {
    bool _ispopped = false;
    return PopupMenuButton(
      shape: const TooltipShape(),
      offset: const Offset(-5, -50),
      icon: const Icon(
        Icons.more_horiz,
        color: btnColor,
      ),
      onSelected: (value) {
        setState(() {
          if (value == value2) {
            var item = allServices.removeAt(index);
            newList = List.from(
                allServices.where((x) => allServices.indexOf(x) != item));
            print("list--" + newList.toString() + "item--" + item.toString());
            isDelete = true;
          } else if (value == value1) {
            print(allServices.length);
          }
          popValue = value;
        });
        print(value);
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
              value: value1,
              onTap: () {},
              child: dropdecor(value1, clr1, icon)),
          PopupMenuItem(
            value: value2,
            onTap: () {},
            child: dropdecor(value2, clr2, icon2),
          ),
        ];
      },
    );
  }

  Widget serviceWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: size.height * 0.3,
                  decoration: const BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.25,
                          child: Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            color: bgColor,
                            child: ListTile(
                              tileColor: grClr.withOpacity(0.1),
                              hoverColor: btnColor.withOpacity(0.2),
                              selectedColor: btnColor.withOpacity(0.2),
                              selectedTileColor: btnColor.withOpacity(0.2),
                              leading: CircleAvatar(
                                  backgroundColor: btnColor.withOpacity(0.1),
                                  child: const Icon(
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
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: size.width * 0.022,
                            width: size.width * 0.25,
                            decoration: const BoxDecoration(
                              color: fieldColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 0, top: 0),
                              child: TextField(
                                controller: _subjectController,
                                style: TxtStls.fieldstyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Subject...",
                                  hintStyle: TxtStls.fieldstyle,
                                ),
                                // onChanged: (value) {
                                //   setState(() {
                                //     _subjectController.text = value;
                                //   });
                                // }
                              ),
                            )),
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
                            const SizedBox(height: 10),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: size.width * 0.022,
                                        width: size.width * 0.25,
                                        decoration: const BoxDecoration(
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
                                              style: TxtStls.fieldstyle,
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
                                                              icon: const Icon(
                                                                  Icons.cancel))
                                                          : const Icon(
                                                              Icons.search)),
                                              onChanged: searchService),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: btnColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          child: Text(
                                            "Add",
                                            style: TxtStls.fieldstyle1,
                                          ),
                                          onTap: () {},
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
                      const SizedBox(height: 5),
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
                                        const Icon(
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
                                  padding: const EdgeInsets.all(16.0),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.132,
                            decoration: const BoxDecoration(
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
                                Future.delayed(const Duration(seconds: 2))
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.5),
                              color: btnColor,
                              child: Provider.of<GstProvider>(context).isLoading
                                  ? const SpinKitFadingCube(
                                      color: bgColor,
                                      size: 23,
                                    )
                                  : const Icon(
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
        const SizedBox(
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
              return InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color:
                          index % 2 == 0 ? AbgColor.withOpacity(0.1) : bgColor,
                    ),
                    height: size.width * 0.025,
                    padding: const EdgeInsets.only(left: 50, right: 50),
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
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: productWidget(
                                "assets/Images/pending.png",
                                allServices[index].name,
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 50),
                                child: Text(
                                  "\$56468",
                                  style: TxtStls.fieldstyle,
                                ),
                              )),
                          Flexible(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 30),
                                child: Text(
                                  "GST %",
                                  style: TxtStls.fieldstyle,
                                ),
                              )),
                          Flexible(
                            flex: 1,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 30),
                                child: Text(
                                  "2 pieces",
                                  style: TxtStls.fieldstyle,
                                )),
                          ),
                          Flexible(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 30),
                                child: SACCode(
                                  "894456",
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  print(allServices[index].name);
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Text("Samples Required??"),
            textButton("Yes"),
            textButton("No"),
            const SizedBox(
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
                        itemPadding: const EdgeInsets.only(left: 5),
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
                : const SizedBox(),
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
  final List<String> coloritems = [];

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
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AbgColor.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(
                            12.0) //                 <--- border radius here
                        ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                )),
            Text(
              'Sending Window',
              style: TxtStls.fieldtitlestyle11,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Text(
                'Recepient',
                style: TxtStls.fieldstyle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    height: 60,
                    width: 500,
                    decoration: decoration(),
                    // child: Row(
                    //   children: [
                    //     //multiple ternary operator syntax
                    //     // iscleared
                    //     //     ? const SizedBox()
                    //     //     : cusemail.toString() == null
                    //     //         ? const SizedBox()
                    //     //         : emaildeco(cusemail.toString()),
                    //     // iscleared
                    //     //     ? const SizedBox()
                    //     //     : popupcontroller1.text == null
                    //     //         ? const SizedBox()
                    //     //         : emaildeco(
                    //     //             popupcontroller1.text.toString(),
                    //     //           ),
                    //     // iscleared && popupcontroller2.text == null
                    //     //     ? const SizedBox()
                    //     //     : emaildeco(
                    //     //         popupcontroller2.text.toString(),
                    //     //       ),
                    //   ],
                    // ),
                    //BoxDecoration
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: emaillist.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Row(
                              children: [
                                emaildeco(emaillist[index], index),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  child: CircleAvatar(
                    backgroundColor: Colors.indigo,
                    radius: 15,
                    child: Icon(Icons.add),
                  ),
                  onTap: () {
                    setState(() {
                      // iscleared = !iscleared;
                      // print(iscleared);
                    });
                    _showPopupMenu();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Text(
                'Subject',
                style: TxtStls.fieldstyle,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                height: 50,
                width: 350,
                decoration: decoration(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    _subjectController.text == null
                        ? ""
                        : _subjectController.text.toString(),
                    style: TxtStls.fieldstyle,
                  ),
                ), //BoxDecoration
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Text(
                'Standard',
                style: TxtStls.fieldstyle,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Material(
                color: AbgColor.withOpacity(0.2),
                //       // elevation: 1.0,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Column(
                  children: [
                    SizedBox(
                        height: size.height * 0.2,
                        child: Material(
                          color: AbgColor.withOpacity(0.2),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ZefyrEditor(
                                controller: zefyrExclusionsController,
                                embedBuilder: (context, node) {
                                  return Text(
                                    exclusions,
                                    style: TxtStls.fieldstyle,
                                  );
                                },
                              )),
                        )),
                    ZefyrToolbar.basic(controller: zefyrExclusionsController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List emaillist = ["$cusemail"];

  Widget emaildeco(String text, int index) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AbgColor.withOpacity(0.2)),
                color: Colors.red,
                borderRadius: BorderRadius.circular(12.0)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    text,
                    style: TxtStls.fieldstyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AbgColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(16.0)),
                    child: const Icon(
                      Icons.close,
                      size: 16.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            )),
      ),
      onTap: () {
        setState(() {
          emaillist.removeAt(index);
        });
        // iscleared = !iscleared;
        // print(iscleared);
      },
    );
  }

  bool iscleared = false;
  bool isclearedemail1 = false;
  bool isclearedemail2 = false;

  final TextEditingController popupcontroller1 = TextEditingController();
  final TextEditingController popupcontroller2 = TextEditingController();
  void _showPopupMenu() async {
    Size size = MediaQuery.of(context).size;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(size.width * 0.78, size.height * 0.3,
          size.width * 0.22, size.height * 0.7),
      items: [
        PopupMenuItem<String>(
            child: TextField(
              controller: popupcontroller1,
              decoration: InputDecoration(
                  hintText: "type an email", hintStyle: TxtStls.fieldstyle),
              onSubmitted: (String text) {
                setState(() {
                  popupcontroller1.text = text;
                  emaillist.add(popupcontroller1.text);
                  popupcontroller1.clear();
                });
              },
            ),
            value: popupcontroller1.text),
        // PopupMenuItem<String>(
        //     child: TextField(
        //       controller: popupcontroller2,
        //       decoration: InputDecoration(
        //           hintText: "type an email2", hintStyle: TxtStls.fieldstyle),
        //       onSubmitted: (String text) {
        //         setState(() {
        //           popupcontroller2.text = text;
        //           emaillist.add(popupcontroller2.text);
        //           popupcontroller2.clear();
        //         });
        //       },
        //     ),
        //     value: popupcontroller2.text),
      ],
      elevation: 8.0,
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      // color: Color(0XFF1485C9),
      border: Border.all(
          color: Colors.black,
          width: 0.1,
          style: BorderStyle.solid), //Border.all

      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
        bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      ),
      //BorderRadius.only
      /************************************/
      /* The BoxShadow widget  is here */
      /************************************/
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: const Offset(
            1.0,
            1.0,
          ),
          blurRadius: 1.0,
          spreadRadius: 1.0,
        ), //BoxShadow
        BoxShadow(
          color: Colors.white,
          offset: const Offset(0.0, 0.0),
          blurRadius: 1.0,
          spreadRadius: 1.0,
        ), //BoxShadow
      ],
    );
  }

  final services = <ServicesModel>[
    ServicesModel(name: "BIS Certificate", qty: 1),
    ServicesModel(name: "WPC Approval", qty: 2),
    ServicesModel(name: "LMPC Approval", qty: 3),
    ServicesModel(name: "ISI Certificate", qty: 4),
  ];
  TextEditingController _getController(String name) {
    var controller = _controllerMap[name];
    if (controller == null) {
      controller = TextEditingController(text: "");
      _controllerMap[name] = controller;
    }
    return controller;
  }

  TextEditingController _getscopeController(int index) {
    var controller = _controllerMap2[index];
    if (controller == null) {
      controller = TextEditingController(text: tappedText.toString());
      _controllerMap2[index] = controller;
    }
    return controller;
  }

  List stages = ['Stage1', 'Stage2', 'Stage3', 'Stage4', 'Stage5'];
  List amount = [
    'amount1',
    'amount2',
    'amount3',
    'amount4',
    'amount5',
    'amount6'
  ];
  List percentage = [
    'percentage1',
    'percentage2',
    'percentage3',
    'percentage4',
    'percentage5',
    'percentage6'
  ];

  Widget escalationScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: bgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
            ),
            child: Text(
              "Cancel",
              style: TextStyle(color: btnColor.withOpacity(0.6)),
            ),
            onPressed: () {},
          ),
        ),
        space(),
        scoperow("Exclusions", "Go back and Please type something"),
        // escalationrow(
        //   "Exclusions",
        // ),
        space(),
        Material(
          color: AbgColor.withOpacity(0.2),
          //       // elevation: 1.0,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Column(
            children: [
              SizedBox(
                  height: size.height * 0.2,
                  child: Material(
                    color: AbgColor.withOpacity(0.2),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ZefyrEditor(
                          controller: zefyrExclusionsController,
                          embedBuilder: (context, node) {
                            return Text(
                              exclusions,
                              style: TxtStls.fieldstyle,
                            );
                          },
                        )),
                  )),

              ZefyrToolbar.basic(controller: zefyrExclusionsController),
              // Padding(
              //   padding:
              //       EdgeInsets.only(left: 20.0, right: rightpad, bottom: 10.0),
              //   child: Material(
              //     color: AbgColor.withOpacity(0.2),
              //     //       // elevation: 1.0,
              //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              //     child: Container(
              //       height: size.height * 0.04,
              //       decoration: BoxDecoration(color: bgColor),
              //       child: Row(
              //         children: [
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           InkWell(
              //             child: Text(
              //               'B',
              //               style: TxtStls.tapstylebold,
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 boldpressed = !boldpressed;
              //               });
              //             },
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           InkWell(
              //             child: Text(
              //               "U",
              //               style: TxtStls.tapstyleunderline,
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 underlinepressed = !underlinepressed;
              //               });
              //             },
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           InkWell(
              //             child: Text(
              //               'I',
              //               style: TxtStls.tapstyleitalic,
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 italicpressed = !italicpressed;
              //               });
              //             },
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Container(
              //             height: 30,
              //             width: 65,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(8.0),
              //                 border: Border.all(color: AbgColor)),
              //             child: DropdownButton<double>(
              //               underline: Container(),
              //               hint: Padding(
              //                 padding: const EdgeInsets.only(left: 8.0),
              //                 child: Text(
              //                   "A",
              //                   style: TxtStls.tapstylebold,
              //                 ),
              //               ),
              //               // Initial Value
              //
              //               // Down Arrow Icon
              //               icon: const Padding(
              //                 padding: EdgeInsets.only(right: 8.0),
              //                 child: Icon(
              //                   Icons.arrow_drop_down_rounded,
              //                   size: 14.0,
              //                 ),
              //               ),
              //
              //               // Array list of items
              //               items: fontSizeList
              //                   .map((item) => DropdownMenuItem<double>(
              //                         value: item,
              //                         child: Text(
              //                           item.toString(),
              //                           style: TxtStls.fieldstyle,
              //                         ),
              //                       ))
              //                   .toList(),
              //               //  value: dropdownfonts,
              //
              //               onChanged: (double? newValue) {
              //                 setState(() {
              //                   fontSelected = newValue!;
              //
              //                   print(fontSelected);
              //                   print(imageDropValue);
              //                 });
              //               },
              //             ),
              //           ),
              //           Container(
              //             height: 30,
              //             width: 65,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(8.0),
              //                 border: Border.all(color: AbgColor)),
              //             child: DropdownButton<String>(
              //               underline: Container(),
              //               hint: Padding(
              //                   padding: const EdgeInsets.only(left: 8.0),
              //                   child:
              //                       Image.asset("assets/Logos/BIS_logo.png")),
              //               // Initial Value
              //
              //               // Down Arrow Icon
              //               icon: const Padding(
              //                 padding: EdgeInsets.only(right: 8.0),
              //                 child: Icon(
              //                   Icons.arrow_drop_down_rounded,
              //                   size: 14.0,
              //                 ),
              //               ),
              //
              //               // Array list of items
              //               items: [
              //                 DropdownMenuItem(
              //                   child: imageDropItems("", imageDropList[0]),
              //                   value: "1",
              //                 ),
              //                 DropdownMenuItem(
              //                   child: imageDropItems("", imageDropList[1]),
              //                   value: "2",
              //                 ),
              //                 DropdownMenuItem(
              //                   child: imageDropItems("", imageDropList[2]),
              //                   value: "3",
              //                   onTap: () {},
              //                 ),
              //               ],
              //               value: imageDropValue,
              //
              //               onChanged: (newValue) {
              //                 setState(() {
              //                   imageDropValue = newValue.toString();
              //                   print(imageDropValue);
              //                   print(textAlignment(imageDropValue));
              //                 });
              //               },
              //             ),
              //           ),
              //           InkWell(
              //             child: Container(
              //                 height: 30,
              //                 width: 30,
              //                 decoration: BoxDecoration(
              //                     border: Border.all(
              //                         color: isBullettapped
              //                             ? btnColor
              //                             : Colors.transparent),
              //                     borderRadius: BorderRadius.circular(5.0)),
              //                 child: Image.asset("assets/Logos/BIS_logo.png")),
              //             onTap: () {
              //               setState(() {
              //                 isBullettapped = !isBullettapped;
              //               });
              //             },
              //           ),
              //           InkWell(
              //             child: Container(
              //                 height: 30,
              //                 width: 30,
              //                 decoration: BoxDecoration(
              //                     border: Border.all(
              //                         color: isNumberBulletTapped
              //                             ? btnColor
              //                             : Colors.transparent),
              //                     borderRadius: BorderRadius.circular(5.0)),
              //                 child: Image.asset("assets/Logos/CRS_logo6.png")),
              //             onTap: () {
              //               setState(() {
              //                 isNumberBulletTapped = !isNumberBulletTapped;
              //               });
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        space(),
        Align(
          alignment: Alignment.centerLeft,
          child: Flexible(
              flex: 1,
              child: Text(
                "Escalations",
                style: TxtStls.fieldtitlestyle11,
              )),
        ),
        space(),
        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "Priority Levels",
                    style: TxtStls.fieldstyle,
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(
                      "Standard",
                      style: TxtStls.fieldstyle,
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    "",
                    style: TxtStls.fieldstyle,
                  )),
            ],
          ),
        ),
        space(),
        escalationLevels(),
        escalationLevels2(),
        escalationLevels3(),
        // SizedBox(
        //   height: size.height*0.26,
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     scrollDirection: Axis.vertical,
        //     controller: sc,
        //     itemCount: 2,
        //     itemBuilder: (context, index) {
        //       return InkWell(
        //         child: Padding(
        //           padding: const EdgeInsets.only(
        //             left: 20.0,
        //             right: 40.0,
        //           ),
        //           child: Container(
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5.0),
        //               color:
        //               index % 2 == 0 ? AbgColor.withOpacity(0.1) : bgColor,
        //             ),
        //             height: size.width * 0.03,
        //             child: Center(
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   Expanded(
        //                     flex: 2,
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children:  [
        //                      const   Expanded(
        //                             flex: 1,
        //                            child: CircleAvatar(radius: 12,child: Icon(Icons.signal_cellular_alt_rounded),),),
        //                         //     const SizedBox(width: 10,),
        //                         Expanded(
        //                           flex: 2,
        //                           child: Padding(
        //                             padding: const EdgeInsets.only(right: 0.0),
        //                             child: Text("Level1",style: TxtStls.fieldstyle,),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Padding(
        //                         padding:
        //                         const EdgeInsets.only(left: 0, right: 80.0),
        //                         child: Material(
        //                             elevation: 10.0,
        //                             borderRadius: BorderRadius.circular(20.0),
        //                             color: bgColor,
        //                             child: SizedBox(
        //                               height: size.width * 0.02,
        //                               width: size.width *0.02,
        //                               child:DropdownButtonFormField2(
        //                                 decoration: InputDecoration(
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.zero,
        //                                   border: OutlineInputBorder(
        //                                     borderRadius: BorderRadius.circular(15),
        //                                   ),
        //                                 ),
        //                                 isExpanded: true,
        //                                 hint: Text(
        //                                   selectedPerson,
        //                                   style: TxtStls.fieldtitlestyle,
        //                                 ),
        //                                 icon: const Icon(
        //                                   Icons.arrow_drop_down,
        //                                   color: AbgColor,
        //                                 ),
        //                                 iconSize: 30,
        //                                 buttonHeight: 60,
        //                                 buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        //                                 dropdownDecoration: BoxDecoration(
        //                                   borderRadius: BorderRadius.circular(15),
        //                                 ),
        //                                 items: escaltionslist
        //                                     .map((item) => DropdownMenuItem(
        //                                   value: item,
        //                                   child:  Expanded(
        //                                     flex: 1,
        //                                     child: ListTile(
        //                                       leading: CircleAvatar(child: Image.network(escaltionslist[index]['img'].toString(),)),
        //                                       title: Column(
        //                                         crossAxisAlignment: CrossAxisAlignment.start,
        //                                         children: [
        //                                           Text(escaltionslist[index]['name'].toString(),style: TxtStls.fieldstyle,),
        //                                           Text(escaltionslist[index]['email'].toString(),style: TxtStls.fieldstyle,),
        //                                           Text(escaltionslist[index]['phone'].toString(),style: TxtStls.fieldstyle,),
        //
        //                                       ],),
        //                                     ),
        //                                   ),
        //                                   // child: Text(item, style: TxtStls.fieldtitlestyle),
        //                                 ))
        //                                     .toList(),
        //                                 onChanged: (value) {
        //                                   setState(() {
        //                                     selectedPerson = value.toString();
        //                                   });
        //                                 },
        //                               ),
        //                             ))),
        //                   ),
        //                  const Expanded(flex: 2, child: Text(""))
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //         onTap: () {
        //           //   print(allServices[index].name);
        //         },
        //       );
        //     },
        //   ),
        // ),
        // for(int i=0;i<= 3;i++)
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5.0),
        //     color:
        //      AbgColor.withOpacity(0.1),
        //   ),
        //   height: size.width * 0.03,
        //   child: Center(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Expanded(
        //           flex: 2,
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children:  [
        //               const   Expanded(
        //                 flex: 1,
        //                 child: CircleAvatar(radius: 12,child: Icon(Icons.signal_cellular_alt_rounded),),),
        //               //     const SizedBox(width: 10,),
        //               Expanded(
        //                 flex: 2,
        //                 child: Padding(
        //                   padding: const EdgeInsets.only(right: 0.0),
        //                   child: Text("Level 1",style: TxtStls.fieldstyle,),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Expanded(
        //           flex: 2,
        //           child: Padding(
        //               padding:
        //               const EdgeInsets.only(left: 0, right: 80.0),
        //               child: Material(
        //                   elevation: 10.0,
        //                   borderRadius: BorderRadius.circular(20.0),
        //                   color: bgColor,
        //                   child: SizedBox(
        //                     height: size.width * 0.02,
        //                     width: size.width *0.02,
        //                     child:DropdownButtonFormField2(
        //                       decoration: InputDecoration(
        //                         isDense: true,
        //                         contentPadding: EdgeInsets.zero,
        //                         border: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(15),
        //                         ),
        //                       ),
        //                       isExpanded: true,
        //                       hint: Text(
        //                         selectedPerson,
        //                         style: TxtStls.fieldtitlestyle,
        //                       ),
        //                       icon: const Icon(
        //                         Icons.arrow_drop_down,
        //                         color: AbgColor,
        //                       ),
        //                       iconSize: 30,
        //                       buttonHeight: 60,
        //                       buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        //                       dropdownDecoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(15),
        //                       ),
        //                       items: escalations
        //                           .map((item) => DropdownMenuItem(
        //                         value: item,
        //                         child:  Expanded(
        //                           flex: 2,
        //                           child: ListTile(
        //                             leading: CircleAvatar(child: Image.network(escalationslist[i]['img'].toString(),)),
        //                             title: Column(
        //                               crossAxisAlignment: CrossAxisAlignment.start,
        //                               children: [
        //                                 Text(escalationslist[i]['name'].toString(),style: TxtStls.fieldstyle,),
        //                                 Text(escalationslist[i]['email'].toString(),style: TxtStls.fieldstyle,),
        //                                 Text(escalationslist[i]['phone'].toString(),style: TxtStls.fieldstyle,),
        //
        //                               ],),
        //                           ),
        //                         ),
        //                         // child: Text(item, style: TxtStls.fieldtitlestyle),
        //                       ))
        //                           .toList(),
        //                       onChanged: (value) {
        //                         setState(() {
        //                           selectedPerson = value.toString();
        //                         });
        //                       },
        //                     ),
        //                   ))),
        //         ),
        //         const Expanded(flex: 2, child: Text(""))
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }

  String? person1;
  String? person2;
  String? person3;
  Widget escalationLevels() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      color: AbgColor.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 50.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    child: Icon(Icons.signal_cellular_alt_rounded),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: Text(
                        "Level1",
                        style: TxtStls.fieldstyle,
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Expanded(
              flex: 2,
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                    color: bgColor,
                    boxShadow: const [
                      BoxShadow(offset: Offset(0.1, 0.1), spreadRadius: 0.5)
                    ],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.transparent)),
                child: DropDown<String>(
                  showUnderline: false,
                  items: const <String>[
                    "Prashant Thakur",
                    "Tarun Sadana",
                    "Lalit Gupta",
                    "Rishikesh Mishra"
                  ],
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AbgColor,
                  ),
                  customWidgets: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Prashant Thakur",
                                style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tarun Sadana",
                                style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lalit Gupta", style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rishikesh Mishra",
                                style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                  ],
                  hint: const Text("Select Person"),
                  onChanged: (selectedPerson) {
                    setState(() {
                      person1 = selectedPerson;
                      print(person1.toString());
                    });
                  },
                ),
              ),
            ),
          ),
          const Expanded(flex: 2, child: Text("")),
        ],
      ),
    );
  }

  Widget escalationLevels2() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      color: bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 50.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    child: Icon(Icons.signal_cellular_alt_rounded),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: Text(
                        "Level2",
                        style: TxtStls.fieldstyle,
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Expanded(
              flex: 2,
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                    color: bgColor,
                    boxShadow: const [
                      BoxShadow(offset: Offset(0.1, 0.1), spreadRadius: 0.5)
                    ],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.transparent)),
                child: DropDown<String>(
                  showUnderline: false,
                  items: const <String>[
                    "Prashant Thakur",
                    "Tarun Sadana",
                    "Lalit Gupta",
                    "Rishikesh Mishra"
                  ],
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AbgColor,
                  ),
                  customWidgets: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Prashant Thakur",
                                style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tarun Sadana",
                                style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lalit Gupta", style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rishikesh Mishra",
                                style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                  ],
                  hint: const Text("Select Person"),
                  onChanged: (selectedPerson) {
                    setState(() {
                      person2 = selectedPerson;
                      print(person2.toString());
                    });
                  },
                ),
              ),
            ),
          ),
          const Expanded(flex: 2, child: Text(""))
        ],
      ),
    );
  }

  Widget escalationLevels3() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      color: AbgColor.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 50.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    child: Icon(Icons.signal_cellular_alt_rounded),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: Text(
                        "Level1",
                        style: TxtStls.fieldstyle,
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Expanded(
              flex: 2,
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                    color: bgColor,
                    boxShadow: const [
                      BoxShadow(offset: Offset(0.1, 0.1), spreadRadius: 0.5)
                    ],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.transparent)),
                child: DropDown<String>(
                  showUnderline: false,
                  items: const <String>[
                    "Prashant Thakur",
                    "Tarun Sadana",
                    "Lalit Gupta",
                    "Rishikesh Mishra"
                  ],
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AbgColor,
                  ),
                  customWidgets: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Prashant Thakur",
                                style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tarun Sadana",
                                style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lalit Gupta", style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://raw.githubusercontent.com/rrousselGit/provider/master/resources/expanded_devtools.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rishikesh Mishra",
                                style: TxtStls.smallfieldstyle),
                            Text("prashant@jrcompliance.com",
                                style: TxtStls.smallfieldstyle),
                            Text("+91 96679 55225",
                                style: TxtStls.smallfieldstyle),
                          ],
                        )
                      ],
                    ),
                  ],
                  hint: const Text("Select Person"),
                  onChanged: (selectedPerson) {
                    setState(() {
                      person3 = selectedPerson;
                      print(person3.toString());
                    });
                  },
                ),
              ),
            ),
          ),
          const Expanded(flex: 2, child: Text(""))
        ],
      ),
    );
  }
}

// import 'dart:async';
// import 'dart:math';
// import 'dart:ui';
// import 'package:animated_widgets/widgets/scale_animated.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:im_stepper/stepper.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:test_web_app/Constants/Calenders.dart';
// import 'package:test_web_app/Constants/reusable.dart';
// import 'package:test_web_app/Models/CustomerModel.dart';
// import 'package:test_web_app/Models/ServicesModel.dart';
// import 'package:test_web_app/Models/UserModel2.dart';
// import 'package:test_web_app/PdfFiles/GetCRSServicePdf.dart';
// import 'package:test_web_app/PdfFiles/GetFMCSServicePdf.dart';
// import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';
// import 'package:test_web_app/Providers/LeadIDProviders.dart';
// import 'package:test_web_app/Models/InvoiceDescriptionModel.dart';
// import 'package:test_web_app/Models/UserModels.dart';
// import 'package:test_web_app/PdfFiles/InvoiceNote.dart';
// import 'package:test_web_app/Providers/GenerateCxIDProvider.dart';
// import 'package:test_web_app/Providers/GetInvoiceProvider.dart';
// import 'package:test_web_app/Providers/GstProvider.dart';
// import 'package:test_web_app/Providers/InvoiceUpdateProvider.dart';
// import 'package:test_web_app/Widgets/InvoicePopup.dart';
// import '../../../PdfFiles/GetISIServicePdf.dart';
// import '../../../Providers/CustomerProvider.dart';
//
// class Finance extends StatefulWidget {
//   Finance({Key? key}) : super(key: key);
//
//   @override
//   _FinanceState createState() => _FinanceState();
// }
//
// class _FinanceState extends State<Finance> {
//   bool _isCreate = false;
//   bool isgst = false;
//   var date1;
//   var date2;
//   var invoiceid;
//
//   bool isPreview = false;
//   bool isServiceAdded = false;
//
//   final List<String> currencieslist = ["INR", "USD", "GBP", "EURO"];
//   String selectedValue = "INR";
//   var selectedleadid;
//   final List<String> statusList = [
//     "Pending",
//     "Received",
//     "Cancelled",
//     "Disputed"
//   ];
//
//   final TextEditingController _referenceController = TextEditingController();
//   final TextEditingController _generatedateController = TextEditingController();
//   final TextEditingController _selectedDateController = TextEditingController();
//   final TextEditingController _duedatedateController = TextEditingController();
//   final TextEditingController _externalController = TextEditingController();
//   double _gstamount = 0.00;
//
//   var radioItem;
//
//   bool isSwitched = false;
//   bool isSwitched1 = false;
//   bool isSwitched2 = true;
//
//   double total = 0;
//
//   int? leadID;
//
//   final _list = ["Quotation", "Performer Invoice", "Invoice"];
//   var activeid = "Quotation";
//   bool qto = false;
//   double tbal = 0.00;
//   String bnature = "Active";
//   bool visible = false;
//   bool isAdded = false;
//
//   final TextEditingController _gstController = TextEditingController();
//   final TextEditingController _gstController2 = TextEditingController();
//   final TextEditingController _serviceSearchController2 =
//       TextEditingController();
//   final TextEditingController _subjectController = TextEditingController();
//   final TextEditingController _tradenameController = TextEditingController();
//   final TextEditingController _addressControoler = TextEditingController();
//   final TextEditingController _pincodeController = TextEditingController();
//   final TextEditingController _panController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _customersearchController =
//       TextEditingController();
//   final TextEditingController _rateController = TextEditingController();
//   final TextEditingController _selectController = TextEditingController();
//   final TextEditingController _qtyController2 = TextEditingController();
//   final TextEditingController _discController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _descripController = TextEditingController();
//   final TextEditingController _internalController = TextEditingController();
//   final TextEditingController _filterDateController = TextEditingController();
//
//   List cust = [];
//   List<CustomerModel> allCustomers = [];
//
//   var popValue;
//
//   bool isClicked = false;
//   String? eimageurl;
//   String? eemail;
//   String? ephone;
//   String? ename;
//   String? edesig;
//
//   final ScrollController sc = ScrollController();
//   var randomNo;
//   late List<ServicesModel> allServices;
//
//   String? selectedSamples;
//
//   @override
//   void initState() {
//     var rng = new Random();
//     randomNo = rng.nextInt(900000) + 100000;
//     allServices = services;
//     super.initState();
//     Future.delayed(Duration(seconds: 2)).then((value) {
//       Provider.of<CustmerProvider>(context, listen: false)
//           .getCustomers(
//         context,
//       )
//           .then((value) {
//         allCustomers =
//             Provider.of<CustmerProvider>(context, listen: false).customerlist;
//       });
//     });
//     Future.delayed(Duration(seconds: 2)).then((value) {
//       var userid = FirebaseAuth.instance.currentUser;
//       Provider.of<UserDataProvider>(context, listen: false)
//           .getEmployeesList(userid)
//           .then((value) {
//         eimageurl =
//             Provider.of<UserDataProvider>(context, listen: false).imageUrl;
//         edesig =
//             Provider.of<UserDataProvider>(context, listen: false).udesignation;
//         ephone = Provider.of<UserDataProvider>(context, listen: false).phone;
//         eemail = Provider.of<UserDataProvider>(context, listen: false).email;
//         ename = Provider.of<UserDataProvider>(context, listen: false).username;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//         height: size.height * 0.93,
//         color: btnColor.withOpacity(0.0001),
//         width: size.width,
//         padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
//         child: Row(
//           children: [
//             Flexible(
//               fit: FlexFit.tight,
//               flex: 3,
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                         child: Row(
//                           children:
//                               _list.map((e) => newMethod(e, () {})).toList(),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       // InkWell(
//                       //   child: Container(
//                       //     decoration: BoxDecoration(
//                       //         color: btnColor,
//                       //         borderRadius: BorderRadius.circular(10)),
//                       //     height: 40,
//                       //     width: 40,
//                       //     child: Icon(
//                       //       Icons.calendar_today_sharp,
//                       //       color: bgColor,
//                       //     ),
//                       //   ),
//                       //   onTap: () {
//                       //     //   dateTimeRangePicker();
//                       //   },
//                       // ),
//                       // RaisedButton(
//                       //   shape: RoundedRectangleBorder(
//                       //       borderRadius:
//                       //           BorderRadius.all(Radius.circular(10.0))),
//                       //   color: btnColor,
//                       //   onPressed: () {
//                       //     MyCalenders.pickFilerDate(
//                       //         context, _filterDateController);
//                       //   },
//                       //   child: Icon(
//                       //     Icons.calendar_today_outlined,
//                       //     color: bgColor,
//                       //   ),
//                       //   // label: Text("")),
//                       // ),
//                     ],
//                   ),
//                   SizedBox(height: size.height * 0.025),
//                   Container(
//                       padding: EdgeInsets.all(8),
//                       height: size.height * 0.845,
//                       decoration: BoxDecoration(
//                           color: bgColor,
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: fieldColor,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10.0))),
//                             child: Padding(
//                               padding:
//                                   EdgeInsets.only(left: 15, right: 15, top: 2),
//                               child: TextField(
//                                   controller: _customersearchController,
//                                   style: TxtStls.fieldstyle,
//                                   decoration: InputDecoration(
//                                       suffixIcon: _customersearchController
//                                               .text.isNotEmpty
//                                           ? IconButton(
//                                               icon: Icon(
//                                                 Icons.cancel,
//                                                 color: btnColor,
//                                               ),
//                                               onPressed: () {
//                                                 _customersearchController
//                                                     .clear();
//                                                 searchCustomer("");
//                                                 FocusScope.of(context)
//                                                     .requestFocus(FocusNode());
//                                               },
//                                             )
//                                           : Icon(
//                                               Icons.search,
//                                               color: btnColor,
//                                             ),
//                                       border: InputBorder.none,
//                                       hintText:
//                                           "Enter Customer name or email or phone.....",
//                                       hintStyle: TxtStls.fieldstyle),
//                                   onChanged: searchCustomer),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           allCustomers.length <= 0
//                               ? Center(
//                                   child: SpinKitFadingCube(
//                                       color: btnColor, size: 15),
//                                 )
//                               : ListView.separated(
//                                   shrinkWrap: true,
//                                   scrollDirection: Axis.vertical,
//                                   physics: ClampingScrollPhysics(),
//                                   itemCount: allCustomers.length,
//                                   itemBuilder: (BuildContext context, int i) {
//                                     var snp = allCustomers[i];
//                                     return Material(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0)),
//                                       color: bgColor,
//                                       child: ListTile(
//                                         tileColor: grClr.withOpacity(0.1),
//                                         hoverColor: btnColor.withOpacity(0.2),
//                                         selectedColor:
//                                             btnColor.withOpacity(0.2),
//                                         selectedTileColor:
//                                             btnColor.withOpacity(0.2),
//                                         leading: CircleAvatar(
//                                             backgroundColor:
//                                                 btnColor.withOpacity(0.1),
//                                             child: Icon(
//                                               Icons.person,
//                                               color: btnColor,
//                                             )),
//                                         title: Text(
//                                           snp.Customername.toString(),
//                                           style: TxtStls.fieldtitlestyle,
//                                         ),
//                                         subtitle: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               snp.Customeremail.toString(),
//                                               style: TxtStls.fieldstyle,
//                                             ),
//                                             Text(
//                                               snp.Customerphone.toString(),
//                                               style: TxtStls.fieldstyle,
//                                             ),
//                                           ],
//                                         ),
//                                         trailing: CircleAvatar(
//                                           backgroundColor:
//                                               btnColor.withOpacity(0.1),
//                                         ),
//                                         onTap: () {
//                                           //  print(2);
//
//                                           setState(() {
//                                             isClicked = true;
//                                             Idocid = snp.Idocid;
//                                             cusname = snp.Customername;
//                                             cusphone = snp.Customerphone;
//                                             cusemail = snp.Customeremail;
//                                             cusID = snp.CxID;
//                                             cusTask = snp.taskname;
//                                             //startDate = snp.startDate;
//                                             endDate = snp.endDate;
//                                             priority = snp.priority;
//                                             //lastseen = snp.lastseen;
//                                             cat = snp.cat;
//                                             message = snp.message;
//                                             status = snp.status;
//                                             s = snp.s;
//                                             f = snp.f;
//                                             assign = snp.assign;
//                                             leadID = snp.leadId;
//                                             Provider.of<GetInvoiceListProvider>(
//                                                     context,
//                                                     listen: false)
//                                                 .getInvoiceList(snp.CxID);
//                                             Provider.of<LeadIdProviders>(
//                                                     context,
//                                                     listen: false)
//                                                 .getLeadIds(cusID);
//                                           });
//                                         },
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(10.0))),
//                                       ),
//                                     );
//                                   },
//                                   separatorBuilder:
//                                       (BuildContext context, int index) {
//                                     return Divider(
//                                         color: grClr.withOpacity(0.5));
//                                   },
//                                 )
//                         ],
//                       ))
//                 ],
//               ),
//             ),
//             SizedBox(width: 10),
//             Expanded(
//               flex: 7,
//               child: Container(
//                 padding: EdgeInsets.all(20),
//                 height: size.height * 0.93,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   color: bgColor,
//                 ),
//                 child: isServiceAdded
//                     ? _isCreate
//                         ? isPreview
//                             ? PreviewInvoice(context)
//                             : Createinvoice(context)
//                         : cusname == null
//                             ? Center(
//                                 child: Text("Select any Customer to Proceed",
//                                     style: TxtStls.fieldtitlestyle))
//                             : Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                           cusname.toString() +
//                                               "\n(${cusemail.toString()})",
//                                           style: TxtStls.fieldtitlestyle),
//                                       Align(
//                                         alignment: Alignment.centerRight,
//                                         child: ElevatedButton.icon(
//                                             style: ElevatedButton.styleFrom(
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(
//                                                               10.0))),
//                                               primary: btnColor,
//                                             ),
//                                             onPressed: () {
//                                               Provider.of<LeadIdProviders>(
//                                                       context,
//                                                       listen: false)
//                                                   .getLeadIds(cusID);
//                                               setState(() {
//                                                 _isCreate = true;
//                                                 _dateController.text =
//                                                     DateTime.now()
//                                                         .toString()
//                                                         .split(" ")[0];
//                                               });
//                                             },
//                                             icon:
//                                                 Icon(Icons.add, color: bgColor),
//                                             label: Text(
//                                               "Create New $activeid",
//                                               style: TxtStls.fieldstyle1,
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: size.height * 0.05),
//                                   Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: titleWidget(),
//                                   ),
//                                   Expanded(
//                                       child:
//                                           Provider.of<GetInvoiceListProvider>(
//                                                           context)
//                                                       .invoicemodellist
//                                                       .length <=
//                                                   0
//                                               ? Center(
//                                                   child: Lottie.asset(
//                                                       "assets/Lotties/empty.json"),
//                                                 )
//                                               : ListView.separated(
//                                                   itemCount: Provider.of<
//                                                               GetInvoiceListProvider>(
//                                                           context)
//                                                       .invoicemodellist
//                                                       .length,
//                                                   itemBuilder: (_, i) {
//                                                     var data = Provider.of<
//                                                                 GetInvoiceListProvider>(
//                                                             context)
//                                                         .invoicemodellist[i];
//                                                     var createdate =
//                                                         DateTime.parse(data
//                                                             .duedate
//                                                             .toString());
//                                                     return InkWell(
//                                                       child: Container(
//                                                         height:
//                                                             size.height * 0.06,
//                                                         child: Material(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       10.0),
//                                                           elevation: 15,
//                                                           child: Row(
//                                                             children: [
//                                                               Flexible(
//                                                                   flex: 1,
//                                                                   fit: FlexFit
//                                                                       .tight,
//                                                                   child: Row(
//                                                                     children: [
//                                                                       Padding(
//                                                                         padding:
//                                                                             EdgeInsets.only(left: 10),
//                                                                         child: Icon(
//                                                                             Icons
//                                                                                 .picture_as_pdf_rounded,
//                                                                             color:
//                                                                                 clsClr),
//                                                                       ),
//                                                                       Text(
//                                                                         "  JR" +
//                                                                             data.invoiceID.toString(),
//                                                                         style: TxtStls
//                                                                             .fieldtitlestyle,
//                                                                       ),
//                                                                     ],
//                                                                   )),
//                                                               Flexible(
//                                                                 flex: 1,
//                                                                 fit: FlexFit
//                                                                     .tight,
//                                                                 child: Text(
//                                                                   data.amount
//                                                                       .toString(),
//                                                                   style: TxtStls
//                                                                       .fieldtitlestyle,
//                                                                 ),
//                                                               ),
//                                                               Flexible(
//                                                                 flex: 1,
//                                                                 fit: FlexFit
//                                                                     .tight,
//                                                                 child: Text(
//                                                                   data.currencyType
//                                                                       .toString(),
//                                                                   style: TxtStls
//                                                                       .fieldtitlestyle,
//                                                                 ),
//                                                               ),
//                                                               Flexible(
//                                                                   flex: 1,
//                                                                   fit: FlexFit
//                                                                       .tight,
//                                                                   child: Row(
//                                                                     children: [
//                                                                       Icon(
//                                                                           Icons
//                                                                               .calendar_today_rounded,
//                                                                           color:
//                                                                               btnColor),
//                                                                       SizedBox(
//                                                                           width:
//                                                                               5),
//                                                                       Text(
//                                                                         DateFormat("dd MMMM,yyyy")
//                                                                             .format(createdate),
//                                                                         style: TxtStls
//                                                                             .fieldtitlestyle,
//                                                                       ),
//                                                                     ],
//                                                                   )),
//                                                               Flexible(
//                                                                 flex: 1,
//                                                                 fit: FlexFit
//                                                                     .tight,
//                                                                 child: Padding(
//                                                                   padding:
//                                                                       EdgeInsets
//                                                                           .only(
//                                                                     right: size
//                                                                             .width *
//                                                                         0.015,
//                                                                     top: size
//                                                                             .width *
//                                                                         0.002,
//                                                                     bottom: size
//                                                                             .width *
//                                                                         0.002,
//                                                                   ),
//                                                                   child:
//                                                                       Container(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .center,
//                                                                     decoration: BoxDecoration(
//                                                                         color: statusColor(data.status).withOpacity(
//                                                                             0.25),
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(10)),
//                                                                     child:
//                                                                         DropdownButtonFormField2(
//                                                                       decoration: InputDecoration(
//                                                                           isDense:
//                                                                               true,
//                                                                           contentPadding: EdgeInsets
//                                                                               .zero,
//                                                                           border:
//                                                                               InputBorder.none
//                                                                           // border:
//                                                                           //     OutlineInputBorder(
//                                                                           //   borderRadius:
//                                                                           //       BorderRadius
//                                                                           //           .circular(
//                                                                           //               10),
//                                                                           // ),
//                                                                           ),
//                                                                       isExpanded:
//                                                                           true,
//                                                                       selectedItemBuilder:
//                                                                           (BuildContext
//                                                                               context) {
//                                                                         return statusList.map((String
//                                                                             value) {
//                                                                           return Text(
//                                                                             data.status.toString(),
//                                                                             style:
//                                                                                 GoogleFonts.nunito(
//                                                                               textStyle: TextStyle(fontSize: 13, color: statusColor(data.status), fontWeight: FontWeight.bold),
//                                                                             ),
//                                                                           );
//                                                                         }).toList();
//                                                                       },
//                                                                       hint:
//                                                                           Text(
//                                                                         data.status
//                                                                             .toString(),
//                                                                         style: GoogleFonts.nunito(
//                                                                             textStyle: TextStyle(
//                                                                                 fontSize: 13,
//                                                                                 color: statusColor(data.status),
//                                                                                 fontWeight: FontWeight.bold)),
//                                                                       ),
//                                                                       icon:
//                                                                           Icon(
//                                                                         Icons
//                                                                             .arrow_drop_down,
//                                                                         color: statusColor(
//                                                                             data.status),
//                                                                       ),
//                                                                       iconSize:
//                                                                           20,
//                                                                       buttonHeight:
//                                                                           50,
//                                                                       buttonPadding: EdgeInsets.only(
//                                                                           left:
//                                                                               20,
//                                                                           right:
//                                                                               10),
//                                                                       dropdownDecoration:
//                                                                           BoxDecoration(
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(10),
//                                                                       ),
//                                                                       items: statusList
//                                                                           .map((item) => DropdownMenuItem<String>(
//                                                                                 value: item,
//                                                                                 child: Text(item, style: TxtStls.fieldtitlestyle),
//                                                                               ))
//                                                                           .toList(),
//                                                                       onChanged:
//                                                                           (value) {
//                                                                         setState(
//                                                                             () {
//                                                                           data.status =
//                                                                               value.toString();
//                                                                         });
//                                                                         Provider.of<InvoiceUpdateProvider>(context, listen: false).invoiceUpdate(
//                                                                             Idocid,
//                                                                             data.docid,
//                                                                             value);
//                                                                       },
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Flexible(
//                                                                 flex: 1,
//                                                                 fit: FlexFit
//                                                                     .tight,
//                                                                 child: InkWell(
//                                                                   hoverColor: Colors
//                                                                       .transparent,
//                                                                   child: Text(
//                                                                       "JRL-${data.LeadId.toString()}",
//                                                                       style: TxtStls
//                                                                           .fieldtitlestyle),
//                                                                   onTap: () {
//                                                                     // showDialog(
//                                                                     //     context:
//                                                                     //         context,
//                                                                     //     builder:
//                                                                     //         (BuildContext
//                                                                     //             context) {
//                                                                     //       return DeatailsPopBox(
//                                                                     //         f: f
//                                                                     //             as int,
//                                                                     //         startDate:
//                                                                     //             startDate
//                                                                     //                 as Timestamp,
//                                                                     //         lastseen:
//                                                                     //             lastseen
//                                                                     //                 as Timestamp,
//                                                                     //         s: s
//                                                                     //             as int,
//                                                                     //         cat: cat
//                                                                     //             .toString(),
//                                                                     //         endDate:
//                                                                     //             endDate.toString(),
//                                                                     //         CxID: cusID
//                                                                     //             as int,
//                                                                     //         taskname:
//                                                                     //             cusTask.toString(),
//                                                                     //         priority:
//                                                                     //             priority.toString(),
//                                                                     //         status:
//                                                                     //             status.toString(),
//                                                                     //         assigns:
//                                                                     //             assign
//                                                                     //                 as List,
//                                                                     //         Idocid:
//                                                                     //             Idocid.toString(),
//                                                                     //         message:
//                                                                     //             message.toString(),
//                                                                     //         leadID: leadID
//                                                                     //             as int,
//                                                                     //       );
//                                                                     //     });
//                                                                   },
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       onTap: () {
//                                                         showDialog(
//                                                             context: context,
//                                                             builder:
//                                                                 (BuildContext
//                                                                     context) {
//                                                               return AdvanceCustomAlert(
//                                                                 invoiceid: data
//                                                                     .invoiceID
//                                                                     .toString(),
//                                                                 url: data
//                                                                     .invoiceurl
//                                                                     .toString(),
//                                                                 date:
//                                                                     createdate,
//                                                                 name: cusname
//                                                                     .toString(),
//                                                                 email: cusemail
//                                                                     .toString(),
//                                                                 statusColor:
//                                                                     statusColor(
//                                                                         data.status),
//                                                                 imageList:
//                                                                     statusEmoji(
//                                                                         data.status),
//                                                                 referenceID: data
//                                                                     .referenceID,
//                                                                 internalNotes: data
//                                                                     .internalNotes,
//                                                                 externalNotes: data
//                                                                     .externalNotes,
//                                                                 id: data.docid,
//                                                               );
//                                                             });
//                                                       },
//                                                     );
//                                                   },
//                                                   separatorBuilder:
//                                                       (BuildContext context,
//                                                               int index) =>
//                                                           SizedBox(
//                                                     height: size.height * 0.01,
//                                                   ),
//                                                 )),
//                                 ],
//                               )
//                     : Container(
//                         child:
//                             isClicked ? productAddition(context) : SizedBox(),
//                       ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Widget newMethod(e, callack) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         elevation: 0.0,
//         primary: activeid == e ? btnColor : bgColor,
//         // hoverColor: Colors.transparent,
//         // hoverElevation: 0.0,
//       ),
//       onPressed: () {
//         setState(() {
//           activeid = e;
//         });
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Text(
//           e,
//           style: TextStyle(
//               fontSize: 12.5,
//               color: activeid == e ? bgColor : txtColor,
//               letterSpacing: 0.2),
//         ),
//       ),
//     );
//   }
//
//   List servicelist = [];
//
//   void addingData() async {
//     double _rate = double.parse(_rateController.text);
//     int _qty = int.parse(_qtyController2.text);
//     double _disc = double.parse(_discController.text);
//     double price = (_rate * _qty) - (((_rate * _qty) / 100) * _disc);
//     servicelist.add(InvoiceDescriptionModel2(
//       item: _selectController.text,
//       qty: _qty,
//       rate: _rate,
//       disc: _disc,
//       price: price,
//     ).toJson());
//     print('@@@' + servicelist.toString());
//
//     tbal = servicelist.map((m) => (m["price"])).reduce((a, b) => a + b);
//     _gstamount = tbal * 0.18;
//     print("Data added ");
//   }
//
//   Widget Createinvoice(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * 0.78,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 width: size.width * 0.225,
//                 decoration: BoxDecoration(
//                   color: fieldColor,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10.0),
//                       bottomLeft: Radius.circular(10.0)),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 15, right: 0, top: 2),
//                   child: TextField(
//                     controller: _gstController,
//                     style: TxtStls.fieldstyle,
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Enter Gst Number...",
//                         hintStyle: TxtStls.fieldstyle),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   var provider =
//                       Provider.of<GstProvider>(context, listen: false);
//                   provider
//                       .fetchGstData(_gstController.text.toString())
//                       .whenComplete(() {
//                     Future.delayed(Duration(seconds: 2)).then((value) {
//                       setState(() {
//                         tradename = provider.tradename.toString();
//                         address = provider.principalplace.toString();
//                         pan = provider.pan.toString();
//                         pincode = provider.pincode.toString();
//                       });
//                     });
//                   });
//                 },
//                 child: Container(
//                   width: size.width * 0.02,
//                   padding: EdgeInsets.symmetric(vertical: 12.5),
//                   color: btnColor,
//                   child: Provider.of<GstProvider>(context).isLoading
//                       ? SpinKitFadingCube(
//                           color: bgColor,
//                           size: 23,
//                         )
//                       : Icon(
//                           Icons.search,
//                           color: bgColor,
//                         ),
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton(
//                 onPressed: () {
//                   isgst = true;
//                   setState(() {});
//                 },
//                 child: Text(
//                   "Don't have Gst Number? Click Here",
//                   style: ClrStls.tnClr,
//                 )),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: Row(
//                   children: [
//                     Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 13),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: grClr.withOpacity(0.25),
//                         ),
//                         child: Text(
//                           "ReferenceID :",
//                           style: TxtStls.fieldtitlestyle,
//                         )),
//                     SizedBox(width: 7.5),
//                     Expanded(
//                       flex: 2,
//                       child: field(
//                           _referenceController, "Enter Reference ID", 1, true),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: SizedBox(),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: SizedBox(
//                   height: size.height * 0.05,
//                   width: size.width * 0.05,
//                   child: DropdownButtonFormField2(
//                     decoration: InputDecoration(
//                       isDense: true,
//                       contentPadding: EdgeInsets.zero,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     isExpanded: true,
//                     hint: Text(
//                       selectedValue,
//                       style: TxtStls.fieldtitlestyle,
//                     ),
//                     icon: Icon(
//                       Icons.arrow_drop_down,
//                       color: btnColor,
//                     ),
//                     iconSize: 30,
//                     buttonHeight: 60,
//                     buttonPadding: EdgeInsets.only(left: 20, right: 10),
//                     dropdownDecoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     items: currencieslist
//                         .map((item) => DropdownMenuItem<String>(
//                               value: item,
//                               child: Text(item, style: TxtStls.fieldtitlestyle),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedValue = value.toString();
//                       });
//                     },
//                   ),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(height: size.height * 0.01),
//           Container(
//             alignment: Alignment.centerLeft,
//             child: tradename == null
//                 ? SizedBox()
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         tradename.toString(),
//                         style: TxtStls.fieldstyle,
//                       ),
//                       Text(address.toString(), style: TxtStls.fieldstyle),
//                       Text(pincode.toString(), style: TxtStls.fieldstyle),
//                       Text(pan.toString(), style: TxtStls.fieldstyle),
//                     ],
//                   ),
//           ),
//           SizedBox(height: size.height * 0.06),
//           Expanded(
//             child: isgst
//                 ? ScaleAnimatedWidget.tween(
//                     duration: Duration(milliseconds: 500),
//                     child: Column(
//                       children: [
//                         formfield("TradeName", _tradenameController, true),
//                         space(),
//                         formfield(
//                             "Address",
//                             _addressControoler,
//                             true,
//                             Icon(
//                               Icons.location_on_rounded,
//                               color: btnColor,
//                             )),
//                         space(),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(right: 20),
//                                 child: formfield("PanNumber", _panController,
//                                     true, null, 10),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 20),
//                                 child: formfield("PinCode", _pincodeController,
//                                     true, null, 6),
//                               ),
//                             ),
//                           ],
//                         ),
//                         space(),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: CircleAvatar(
//                             backgroundColor: btnColor,
//                             child: IconButton(
//                               icon: Icon(
//                                 Icons.arrow_forward_ios_rounded,
//                                 color: bgColor,
//                               ),
//                               onPressed: () async {
//                                 print("Hey Yalagala Srinivas");
//                                 tradename =
//                                     _tradenameController.text.toString();
//                                 pan = _panController.text.toString();
//                                 pincode = _pincodeController.text.toString();
//                                 address = _addressControoler.text.toString();
//                                 isgst = false;
//                                 setState(() {});
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: size.height * 0.05,
//                         color: btnColor,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               flex: 4,
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "ITEM DETAILS",
//                                     style: TxtStls.titlesstyle,
//                                   )),
//                             ),
//                             myverticalDivider(),
//                             Expanded(
//                               flex: 2,
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "RATE",
//                                     style: TxtStls.titlesstyle,
//                                   )),
//                             ),
//                             myverticalDivider(),
//                             Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                     alignment: Alignment.center,
//                                     child: Text("QUANTITY",
//                                         style: TxtStls.titlesstyle))),
//                             myverticalDivider(),
//                             Expanded(
//                               flex: 1,
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "DISC(%)",
//                                     style: TxtStls.titlesstyle,
//                                   )),
//                             ),
//                             myverticalDivider(),
//                             Expanded(
//                                 flex: 2,
//                                 child: Container(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       "PRICE",
//                                       style: TxtStls.titlesstyle,
//                                     ))),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.06),
//                       servicelist.length > 0
//                           ? ConstrainedBox(
//                               constraints:
//                                   BoxConstraints(maxHeight: size.height * 0.22),
//                               child: ListView.builder(
//                                   scrollDirection: Axis.vertical,
//                                   shrinkWrap: true,
//                                   itemCount: servicelist.length,
//                                   itemBuilder: (context, index) {
//                                     return Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Expanded(
//                                           flex: 4,
//                                           child: Container(
//                                               alignment: Alignment.centerLeft,
//                                               child: Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text("${index + 1}. ",
//                                                       style: TxtStls
//                                                           .fieldtitlestyle),
//                                                   Flexible(
//                                                     child: Text(
//                                                       "${servicelist[index]["item"].toString()}\n",
//                                                       style: TxtStls
//                                                           .fieldtitlestyle,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )),
//                                         ),
//                                         myverticalDivider(),
//                                         Expanded(
//                                           flex: 2,
//                                           child: Container(
//                                               alignment: Alignment.center,
//                                               child: Text(
//                                                 servicelist[index]["rate"]
//                                                     .toString(),
//                                                 style: TxtStls.fieldtitlestyle,
//                                               )),
//                                         ),
//                                         myverticalDivider(),
//                                         Expanded(
//                                             flex: 1,
//                                             child: Container(
//                                                 alignment: Alignment.center,
//                                                 child: Text(
//                                                     servicelist[index]["qty"]
//                                                         .toString(),
//                                                     style: TxtStls
//                                                         .fieldtitlestyle))),
//                                         myverticalDivider(),
//                                         Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                               alignment: Alignment.center,
//                                               child: Text(
//                                                   servicelist[index]["disc"]
//                                                       .toString(),
//                                                   style:
//                                                       TxtStls.fieldtitlestyle)),
//                                         ),
//                                         myverticalDivider(),
//                                         Expanded(
//                                             flex: 2,
//                                             child: Container(
//                                                 alignment: Alignment.center,
//                                                 child: Text(
//                                                     servicelist[index]["price"]
//                                                         .toString(),
//                                                     style: TxtStls
//                                                         .fieldtitlestyle))),
//                                       ],
//                                     );
//                                   }),
//                             )
//                           : SizedBox(),
//                       Container(
//                         height: size.height * 0.06,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               flex: 4,
//                               child: field(_selectController,
//                                   "Item Description", 1, true),
//                             ),
//                             myverticalDivider(),
//                             Expanded(
//                               flex: 2,
//                               child: field(_rateController,
//                                   "${symbol(selectedValue)} 0", 1, true),
//                             ),
//                             myverticalDivider(),
//                             Expanded(
//                                 flex: 1,
//                                 child: field(_qtyController2, "1", 1, true)),
//                             myverticalDivider(),
//                             Expanded(
//                               flex: 1,
//                               child: field(_discController, "0 %", 1, true),
//                             ),
//                             myverticalDivider(),
//                             Expanded(
//                                 flex: 2,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   child: InkWell(
//                                       autofocus: false,
//                                       onTap: () {
//                                         setState(() {
//                                           var _customer =
//                                               Provider.of<CustmerProvider>(
//                                                   context,
//                                                   listen: false);
//                                           cust.forEach((element) => _customer);
//                                         });
//
//                                         print('custom cust' + cust.toString());
//                                         addingData();
//                                         total = tbal + getval();
//                                         Future.delayed(
//                                                 Duration(milliseconds: 100))
//                                             .then((value) {
//                                           _rateController.clear();
//                                           _qtyController2.clear();
//                                           _priceController.clear();
//                                           _discController.clear();
//                                           _selectController.clear();
//                                           _descripController.clear();
//                                         });
//                                       },
//                                       child: Text(
//                                         " ADD ITEM + ",
//                                         style: TxtStls.btnstyle,
//                                       )),
//                                 )),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             flex: 4,
//                             child: isSwitched
//                                 ? field(_internalController, "Internal Notes",
//                                     3, true, null, null, 200)
//                                 : SizedBox(),
//                           ),
//                           for (int i = 1; i <= 2; i++)
//                             VerticalDivider(
//                               thickness: 2,
//                               color: bgColor,
//                             ),
//                           Expanded(flex: 2, child: SizedBox()),
//                           for (int i = 1; i <= 2; i++)
//                             VerticalDivider(
//                               thickness: 2,
//                               color: bgColor,
//                             ),
//                           Expanded(
//                             flex: 4,
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Sub Total (${selectedValue}) : " +
//                                           symbol(selectedValue),
//                                       style: TxtStls.fieldtitlestyle,
//                                     ),
//                                     Text(
//                                       tbal == null
//                                           ? "0.00"
//                                           : tbal.toStringAsFixed(2),
//                                       style: TxtStls.fieldtitlestyle,
//                                     ),
//                                   ],
//                                 ),
//                                 selectedValue == "INR"
//                                     ? Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             "IGST/CGST/SGST(${selectedValue}) : " +
//                                                 symbol(selectedValue),
//                                             style: TxtStls.fieldtitlestyle,
//                                           ),
//                                           Text(
//                                             selectedValue == "INR"
//                                                 ? _gstamount.toStringAsFixed(2)
//                                                 : "0.00",
//                                             style: TxtStls.fieldtitlestyle,
//                                           ),
//                                         ],
//                                       )
//                                     : SizedBox(),
//                                 Divider(
//                                   thickness: 0.5,
//                                   color: Colors.grey.withOpacity(0.5),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Total (${selectedValue}) : " +
//                                           symbol(selectedValue),
//                                       style: TxtStls.fieldtitlestyle,
//                                     ),
//                                     Text(
//                                       total.toStringAsFixed(2),
//                                       style: TxtStls.fieldtitlestyle,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             flex: 4,
//                             child: isSwitched1
//                                 ? field(_externalController, "External Notes",
//                                     3, true, null, null, 200)
//                                 : SizedBox(),
//                           ),
//                           for (int i = 1; i <= 2; i++)
//                             VerticalDivider(
//                               thickness: 2,
//                               color: bgColor,
//                             ),
//                           // Expanded(
//                           //   flex: 2,
//                           //   child: isSwitched2
//                           //       ? field(_leadController, "Lead ID", 1, true, null,
//                           //           null, null)
//                           //       : SizedBox(),
//                           // ),
//                           Expanded(
//                             flex: 2,
//                             child: SizedBox(
//                               height: size.height * 0.05,
//                               width: size.width * 0.05,
//                               child: DropdownButtonFormField2(
//                                 decoration: InputDecoration(
//                                   isDense: true,
//                                   contentPadding: EdgeInsets.zero,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                 ),
//                                 isExpanded: true,
//                                 hint: Text(
//                                   "Select LeadID",
//                                   style: TxtStls.fieldtitlestyle,
//                                 ),
//                                 icon: Icon(
//                                   Icons.arrow_drop_down,
//                                   color: btnColor,
//                                 ),
//                                 iconSize: 30,
//                                 buttonHeight: 60,
//                                 buttonPadding:
//                                     EdgeInsets.only(left: 20, right: 10),
//                                 dropdownDecoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 items: Provider.of<LeadIdProviders>(context,
//                                         listen: false)
//                                     .leadidslist
//                                     .map((item) => DropdownMenuItem(
//                                           value: item,
//                                           child: Text(item,
//                                               style: TxtStls.fieldtitlestyle),
//                                         ))
//                                     .toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedleadid =
//                                         int.parse(value.toString());
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//
//                           for (int i = 1; i <= 2; i++)
//                             VerticalDivider(
//                               thickness: 2,
//                               color: bgColor,
//                             ),
//                           Expanded(
//                             flex: 3,
//                             child: Column(
//                               children: [
//                                 InkWell(
//                                   child: field(
//                                       _generatedateController,
//                                       "Select Generate Date",
//                                       1,
//                                       false,
//                                       Icon(
//                                         Icons.calendar_today_outlined,
//                                         color: btnColor,
//                                       )),
//                                   onTap: () {
//                                     MyCalenders.pickEndDate(
//                                         context, _generatedateController);
//                                   },
//                                 ),
//                                 SizedBox(height: size.height * 0.005),
//                                 InkWell(
//                                   child: field(
//                                       _duedatedateController,
//                                       "Select Due Date",
//                                       1,
//                                       false,
//                                       Icon(
//                                         Icons.calendar_today_outlined,
//                                         color: btnColor,
//                                       )),
//                                   onTap: () {
//                                     MyCalenders.pickEndDate(
//                                         context, _duedatedateController);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//           ),
//           Row(
//             children: [
//               Row(
//                 children: [
//                   Text("LeadId", style: TxtStls.fieldtitlestyle),
//                   Switch(
//                     value: isSwitched2,
//                     onChanged: (value) {
//                       setState(() {
//                         isSwitched2 = value;
//                         print(isSwitched2);
//                       });
//                     },
//                     activeTrackColor: btnColor.withOpacity(0.2),
//                     activeColor: btnColor,
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text("Internal Notes", style: TxtStls.fieldtitlestyle),
//                   Switch(
//                     value: isSwitched,
//                     onChanged: (value) {
//                       setState(() {
//                         isSwitched = value;
//                         print(isSwitched);
//                       });
//                     },
//                     activeTrackColor: btnColor.withOpacity(0.2),
//                     activeColor: btnColor,
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text("External Notes", style: TxtStls.fieldtitlestyle),
//                   Switch(
//                     value: isSwitched1,
//                     onChanged: (value) {
//                       setState(() {
//                         isSwitched1 = value;
//                         print(isSwitched1);
//                       });
//                     },
//                     activeTrackColor: btnColor.withOpacity(0.2),
//                     activeColor: btnColor,
//                   ),
//                 ],
//               ),
//               ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     primary: btnColor,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5)),
//                   ),
//                   onPressed: () {
//                     if (servicelist.length <= 0 ||
//                         selectedleadid == null ||
//                         tradename == null ||
//                         address == null ||
//                         pincode == null ||
//                         pan == null ||
//                         _generatedateController.text.isEmpty ||
//                         _duedatedateController.text.isEmpty ||
//                         _internalController.text.isEmpty ||
//                         _externalController.text.isEmpty) {
//                       toastmessage.warningmessage(context, showmessage());
//                     } else {
//                       isPreview = true;
//                       setState(() {});
//                       Provider.of<RecentFetchCXIDProvider>(context,
//                               listen: false)
//                           .fetchRecentInvoiceid();
//                     }
//                   },
//                   icon: Icon(Icons.copy, size: 10, color: bgColor),
//                   label: Text(
//                     "Preview",
//                     style: TxtStls.fieldstyle1,
//                   )),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget space() {
//     Size size = MediaQuery.of(context).size;
//     return SizedBox(height: size.height * 0.02);
//   }
//
//   Widget space2() {
//     Size size = MediaQuery.of(context).size;
//     return SizedBox(height: size.height * 0.01);
//   }
//
//   Widget formfield(title, _controller, bool enabled, [icn, maxchars]) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(title, style: TxtStls.fieldtitlestyle),
//         Container(
//           decoration: deco,
//           child: Padding(
//             padding: EdgeInsets.only(left: 15, right: 15, top: 2),
//             child: TextFormField(
//               maxLength: maxchars,
//               enabled: enabled,
//               controller: _controller,
//               style: TxtStls.fieldstyle,
//               decoration: InputDecoration(
//                 hintText: title,
//                 hintStyle: TxtStls.fieldstyle,
//                 border: InputBorder.none,
//                 suffixIcon: icn,
//               ),
//               validator: (fullname) {
//                 if (fullname!.isEmpty) {
//                   return "Name can not be empty";
//                 } else if (fullname.length < 3) {
//                   return "Name should be atleast 3 letters";
//                 } else {
//                   return null;
//                 }
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget field(_controller, hintText, maxlines, bool isenable,
//       [icn, icn1, maxlength]) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       decoration: deco,
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: size.width * 0.01,
//         ),
//         child: TextFormField(
//           maxLength: maxlength,
//           enabled: isenable,
//           cursorColor: btnColor,
//           controller: _controller,
//           style: TxtStls.fieldstyle,
//           decoration: InputDecoration(
//             prefixIcon: icn1,
//             errorStyle: ClrStls.errorstyle,
//             suffixIcon: icn,
//             hintText: hintText,
//             hintStyle: TxtStls.fieldstyle,
//             border: InputBorder.none,
//           ),
//           maxLines: maxlines,
//         ),
//       ),
//     );
//   }
//
//   Widget PreviewInvoice(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     DateTime? duedate = DateTime.parse(_duedatedateController.text);
//     DateTime? generatedate = DateTime.parse(_generatedateController.text);
//     return Container(
//       height: size.height * 0.93,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//         color: bgColor,
//       ),
//       padding: EdgeInsets.symmetric(
//           horizontal: size.width * 0.015, vertical: size.height * 0.015),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Invoice Preview",
//                 style: TextStyle(
//                     fontSize: 15, color: txtColor, fontWeight: FontWeight.bold),
//               ),
//               Expanded(child: SizedBox()),
//               Provider.of<RecentFetchCXIDProvider>(context).actualinid == null
//                   ? SizedBox()
//                   : ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         primary: btnColor,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5.0)),
//                       ),
//                       onPressed: () {
//                         var inid = Provider.of<RecentFetchCXIDProvider>(context,
//                                 listen: false)
//                             .actualinid
//                             .toString();
//                         var gstno = _gstController.text == null
//                             ? ""
//                             : _gstController.text.toString();
//                         setState(() {
//                           PdfProvider.generatePdf(
//                             context,
//                             servicelist,
//                             cusname,
//                             tbal,
//                             inid,
//                             gstno,
//                             Idocid,
//                             activeid,
//                             selectedValue == "INR" ? _gstamount : 0.00,
//                             total,
//                             _generatedateController.text.toString(),
//                             _duedatedateController.text.toString(),
//                             selectedValue,
//                             cusID,
//                             _externalController.text,
//                             _internalController.text,
//                             _referenceController.text,
//                             selectedleadid,
//                           );
//                           isPreview = false;
//                           _isCreate = false;
//                         });
//                       },
//                       icon: Icon(Icons.save_alt_rounded,
//                           color: bgColor, size: 12.5),
//                       label: Text("Save", style: TxtStls.fieldstyle1))
//             ],
//           ),
//           Divider(
//             color: grClr,
//           ),
//           Row(
//             children: [
//               SizedBox(
//                 height: size.height * 0.15,
//                 width: size.width * 0.175,
//                 child: Image.asset(
//                   "assets/Logos/jrlogo.png",
//                   filterQuality: FilterQuality.high,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Expanded(child: SizedBox()),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text("JR Compliance and Testing Labs",
//                       style: TxtStls.fieldstyle),
//                   Text("Regd. Office: 705, 7th Floor,Krishna Apra Tower",
//                       style: TxtStls.fieldstyle),
//                   Text("Netaji Subhash Place, Pitampura,New Delhi 110034,India",
//                       style: TxtStls.fieldstyle),
//                   Text("JR Compliance and Testing Labs",
//                       style: TxtStls.fieldstyle),
//                   Text("PAN: AALFJ0070E", style: TxtStls.fieldstyle),
//                   Text("TAN: DELJ10631F", style: TxtStls.fieldstyle),
//                   Text("GST REGN NO: 07AALFJ0070E1ZO",
//                       style: TxtStls.fieldstyle),
//                 ],
//               )
//             ],
//           ),
//           Divider(
//             color: grClr,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("To,", style: TxtStls.fieldtitlestyle),
//               Text(
//                 "Invoice No. : " +
//                     "${Provider.of<RecentFetchCXIDProvider>(context).actualinid == null ? "" : Provider.of<RecentFetchCXIDProvider>(context).actualinid.toString()}",
//                 style: TxtStls.fieldtitlestyle,
//               )
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "$address\n$pincode",
//                     style: TxtStls.fieldstyle,
//                   ),
//                   Text(
//                       "GST NO- ${_gstController.text == null ? "" : _gstController.text.toString()}",
//                       style: TxtStls.fieldtitlestyle),
//                   Text("Kind Atten: Mr.$cusname",
//                       style: TxtStls.fieldtitlestyle),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       "Issued On : " +
//                           DateFormat("dd MMM,yyyy").format(generatedate),
//                       style: TxtStls.fieldstyle,
//                     ),
//                   ),
//                   Align(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                           "Due Date : " +
//                               DateFormat("dd MMM,yyyy").format(duedate),
//                           style: TxtStls.fieldstyle)),
//                 ],
//               ),
//             ],
//           ),
//           Divider(
//             color: grClr,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(child: Text("# Description", style: TxtStls.fieldstyle)),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                         flex: 1,
//                         child: Container(
//                             alignment: Alignment.centerRight,
//                             child: Text("SAC No", style: TxtStls.fieldstyle))),
//                     Expanded(
//                         flex: 1,
//                         child: Container(
//                             alignment: Alignment.centerRight,
//                             child:
//                                 Text("Unit Cost", style: TxtStls.fieldstyle))),
//                     Expanded(
//                         flex: 1,
//                         child: Container(
//                             alignment: Alignment.centerRight,
//                             child: Text("Qty", style: TxtStls.fieldstyle))),
//                     Expanded(
//                         flex: 1,
//                         child: Container(
//                             alignment: Alignment.centerRight,
//                             child: Text("Disc(%)", style: TxtStls.fieldstyle))),
//                     Expanded(
//                         flex: 1,
//                         child: Container(
//                             alignment: Alignment.centerRight,
//                             child:
//                                 Text("Amount(Rs)", style: TxtStls.fieldstyle))),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Divider(
//             color: grClr,
//           ),
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: servicelist.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Container(
//                           alignment: Alignment.centerLeft,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("${index + 1}. ",
//                                   style: TxtStls.fieldtitlestyle),
//                               Flexible(
//                                 child: Text(
//                                   "${servicelist[index]["item"].toString()}\n",
//                                   style: TxtStls.fieldtitlestyle,
//                                 ),
//                               ),
//                             ],
//                           )),
//                     ),
//                     Expanded(
//                         child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Container(
//                             alignment: Alignment.centerRight,
//                             child: Text("9983", style: TxtStls.fieldstyle),
//                           ),
//                         ),
//                         Expanded(
//                             flex: 1,
//                             child: Container(
//                               alignment: Alignment.centerRight,
//                               child: Text(servicelist[index]["rate"].toString(),
//                                   style: TxtStls.fieldstyle),
//                             )),
//                         Expanded(
//                             flex: 1,
//                             child: Container(
//                               alignment: Alignment.centerRight,
//                               child: Text(servicelist[index]["qty"].toString(),
//                                   style: TxtStls.fieldstyle),
//                             )),
//                         Expanded(
//                             flex: 1,
//                             child: Container(
//                               alignment: Alignment.centerRight,
//                               child: Text(
//                                   servicelist[index]["disc"].toString() + "%",
//                                   style: TxtStls.fieldstyle),
//                             )),
//                         Expanded(
//                           flex: 1,
//                           child: Container(
//                             alignment: Alignment.centerRight,
//                             child: Text(servicelist[index]["price"].toString(),
//                                 style: TxtStls.fieldstyle),
//                           ),
//                         ),
//                       ],
//                     ))
//                   ],
//                 );
//               },
//             ),
//           ),
//           Divider(
//             color: grClr,
//           ),
//           Text("Bank Details:",
//               style: GoogleFonts.nunito(
//                   textStyle: TextStyle(
//                       fontSize: 13,
//                       color: txtColor,
//                       fontWeight: FontWeight.bold,
//                       decoration: TextDecoration.underline),
//                   fontSize: 13,
//                   color: txtColor,
//                   fontWeight: FontWeight.bold,
//                   decoration: TextDecoration.underline)),
//           Text("Company Name: JR Compliance And Testing Labs",
//               style: TxtStls.fieldtitlestyle),
//           Text("Bank Name: IDFC FIRST BANK", style: TxtStls.fieldtitlestyle),
//           Text("Account Number: 10041186185", style: TxtStls.fieldtitlestyle),
//           Text("IFSC Code: IDFB0040101", style: TxtStls.fieldtitlestyle),
//           Text("SWIFT Code: IDFBINBBMUM", style: TxtStls.fieldtitlestyle),
//           Text("Bank Address: Rohini, New Delhi-110085",
//               style: TxtStls.fieldtitlestyle),
//           Divider(
//             color: grClr,
//           ),
//           Text("Terms And Conditions:", style: TxtStls.fieldtitlestyle),
//           InkWell(
//             child: Text(
//               "https://www.jrcompliance.com/terms-and-conditions",
//               style: TxtStls.fieldstyle,
//             ),
//             onTap: () {
//               //launches.termsofuse();
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   symbol(selectedcurrency) {
//     switch (selectedcurrency) {
//       case "GBP":
//         {
//           return "£";
//         }
//       case "USD":
//         {
//           return "\$";
//         }
//       case "EURO":
//         {
//           return "€";
//         }
//       default:
//         {
//           return "₹";
//         }
//     }
//   }
//
//   double getval() {
//     if (selectedValue == "INR") {
//       return _gstamount;
//     } else {
//       return 0;
//     }
//   }
//
//   final List _titlelist = [
//     "  Inc No",
//     "Amount",
//     "Currency",
//     "Due Date",
//     "Status",
//     "Lead ID"
//   ];
//   final _titlelist2 = [
//     "SN ",
//     "Name",
//     "Price",
//     "Tax Slab",
//     "Sample Qty",
//     "SAC Code",
//   ];
//
//   Widget titleWidget() {
//     return Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: _titlelist
//             .map((e) => Flexible(
//                 flex: 1,
//                 fit: FlexFit.tight,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       e,
//                       style: TxtStls.fieldtitlestyle,
//                     ),
//                     Icon(Icons.arrow_drop_down)
//                   ],
//                 )))
//             .toList());
//   }
//
//   Color statusColor(value) {
//     switch (value) {
//       case "Received":
//         {
//           return wonClr;
//         }
//       case "Cancelled":
//         {
//           return clsClr;
//         }
//       case "Disputed":
//         {
//           return neClr;
//         }
//       default:
//         {
//           return flwClr;
//         }
//     }
//   }
//
//   String statusEmoji(value) {
//     switch (value) {
//       case "Received":
//         {
//           return "assets/Images/received.png";
//         }
//       case "Cancelled":
//         {
//           return "assets/Images/cancelled.png";
//         }
//       case "Disputed":
//         {
//           return "assets/Images/disputed.png";
//         }
//       default:
//         {
//           return "assets/Images/pending.png";
//         }
//     }
//   }
//
//   Widget myverticalDivider() {
//     return VerticalDivider(
//       thickness: 2,
//       color: bgColor,
//     );
//   }
//
//   void searchCustomer(String query) {
//     final allCustomers = Provider.of<CustmerProvider>(context, listen: false)
//         .customerlist
//         .where((element) {
//       final customertitle = element.Customername!.toLowerCase();
//       final customeremail = element.Customeremail!.toLowerCase();
//       final customerphone = element.Customerphone!.toLowerCase();
//       final input = query.toLowerCase();
//       return customertitle.contains(input) ||
//           customeremail.contains(input) ||
//           customerphone.contains(input);
//     }).toList();
//     setState(() {
//       query = query;
//       this.allCustomers = allCustomers;
//     });
//   }
//
//   showmessage() {
//     if (servicelist.length <= 0) {
//       return "Add the service descrption";
//     } else if (_internalController.text.isEmpty) {
//       return "Enter the InternalNote";
//     } else if (_externalController.text.isEmpty) {
//       return "Enter the ExternalNote";
//     } else if (_generatedateController.text.isEmpty) {
//       return "Select the Genarated Date";
//     } else if (_duedatedateController.text.isEmpty) {
//       return "Select the Due Date";
//     } else if (selectedleadid == null) {
//       return "Select the Lead Id";
//     } else if (tradename == null) {
//       return "Enter the Trade Name";
//     } else if (address == null) {
//       return "Enter the Trade Address";
//     } else if (pincode == null) {
//       return "Enter teh Pincode";
//     }
//     return "Enter the PanCard Number";
//   }
//
//   dateTimeRangePicker() async {
//     DateTimeRange? picked = await showDateRangePicker(
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData(
//             primarySwatch: Colors.grey,
//             splashColor: Colors.black,
//             textTheme: TextTheme(
//               subtitle1: TextStyle(color: Colors.black),
//               button: TextStyle(color: Colors.black),
//             ),
//             accentColor: Colors.black,
//             colorScheme: ColorScheme.light(
//                 primary: btnColor,
//                 primaryVariant: Colors.black,
//                 secondaryVariant: Colors.black,
//                 onSecondary: Colors.black,
//                 onPrimary: Colors.white,
//                 surface: Colors.black,
//                 onSurface: Colors.black,
//                 secondary: Colors.black),
//             dialogBackgroundColor: Colors.white,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ConstrainedBox(
//                 constraints: BoxConstraints(maxWidth: 400, maxHeight: 450),
//                 child: child,
//               )
//             ],
//           ),
//         );
//       },
//       context: context,
//       firstDate: DateTime(2022),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         date1 = picked.start.toString().split(" ")[0];
//         date2 = picked.end.toString().split(" ")[0];
//       });
//     }
//   }
//
//   Widget productAddition(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Align(
//           alignment: Alignment.topRight,
//           child: Container(
//             height: size.height * 0.06,
//             child: iconStepper(),
//           ),
//         ),
//         showScreen(activeStep),
//         Expanded(
//           flex: 1,
//           child: SizedBox(),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0)),
//                     primary: btnColor),
//                 child: Text(
//                   "PREV",
//                   style: TxtStls.fieldstyle1,
//                 ),
//                 onPressed: () {
//                   // showScreen(activeStep);
//                   if (activeStep > 0) {
//                     setState(() {
//                       activeStep--;
//                     });
//                   }
//
//                   // if (activeStep == 7) {
//                   //   setState(() {
//                   //     isServiceAdded = !isServiceAdded;
//                   //   });
//                   // }
//                 },
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0)),
//                     primary: btnColor),
//                 child: Text(
//                   "NEXT",
//                   style: TxtStls.fieldstyle1,
//                 ),
//                 onPressed: () {
//                   // showScreen(activeStep);
//                   if (activeStep < upperBound) {
//                     setState(() {
//                       activeStep++;
//                     });
//                   }
//
//                   // if (activeStep == 7) {
//                   //   setState(() {
//                   //     isServiceAdded = !isServiceAdded;
//                   //   });
//                   // }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   bool searching = false;
//   Widget titleWidget2() {
//     return Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: _titlelist2
//             .map((e) => Flexible(
//                 flex: 1,
//                 fit: FlexFit.tight,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       e,
//                       style: TxtStls.fieldstyle,
//                     ),
//                     Icon(
//                       Icons.arrow_drop_down,
//                       color: AbgColor,
//                     )
//                   ],
//                 )))
//             .toList());
//   }
//
//   Widget productWidget(assetImage, text) {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 15,
//           child: Image.asset(
//             assetImage,
//             height: 15,
//             width: 15,
//             fit: BoxFit.fill,
//             filterQuality: FilterQuality.high,
//           ),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Text(
//           text,
//           style: TxtStls.fieldstyle111,
//         )
//       ],
//     );
//   }
//
//   Widget SACCode(code) {
//     return Text(
//       code,
//       style: TxtStls.fieldstyle,
//     );
//   }
//
//   List resultFound = [];
//   void searchService(String query) {
//     final allServices = services.where((service) {
//       final searchedService = service.name!.toLowerCase();
//       final input = query.toLowerCase();
//       return searchedService.contains(input);
//     }).toList();
//     setState(() {
//       query = query;
//       this.allServices = allServices;
//     });
//   }
//
//   int activeStep = 0;
//   int upperBound = 6;
//   List filteredValue = [];
//   Widget iconStepper() {
//     return IconStepper(
//       stepRadius: 16.0,
//       icons: [
//         Icon(Icons.shopping_cart),
//         Icon(Icons.picture_as_pdf),
//         Icon(Icons.access_alarm),
//         Icon(Icons.supervised_user_circle),
//         Icon(Icons.flag),
//         Icon(Icons.access_alarm),
//         Icon(Icons.supervised_user_circle),
//       ],
//
//       // activeStep property set to activeStep variable defined above.
//       activeStep: activeStep,
//
//       // This ensures step-tapping updates the activeStep.
//       onStepReached: (index) {
//         setState(() {
//           activeStep = index;
//         });
//       },
//     );
//   }
//
//   showScreen(activeStep) {
//     if (activeStep == 0) {
//       return serviceWidget(context);
//     } else if (activeStep == 1) {
//       return Createinvoice(context);
//     } else if (activeStep == 2) {
//       Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//           .fetchRecentInvoiceid()
//           .then((value) {
//         invoiceid = Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//             .actualinid
//             .toString();
//       });
//       return serviceIntro(context);
//     } else if (activeStep == 3) {
//       return serviceWelcome(context);
//     } else if (activeStep == 4) {
//       return Container(
//         child: Center(
//           child: Text('HIIII$activeStep'),
//         ),
//       );
//     } else if (activeStep == 5) {
//       return Container(
//         child: Center(
//           child: Text('HIIII$activeStep'),
//         ),
//       );
//     } else {
//       return Container(
//         child: Center(
//           child: Text('HIIII$activeStep'),
//         ),
//       );
//     }
//   }
//
//   Widget serviceWidget(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: size.height * 0.06,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Flexible(
//                 fit: FlexFit.tight,
//                 flex: 2,
//                 child: Container(
//                   height: size.height * 0.3,
//                   decoration: BoxDecoration(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           height: size.height * 0.08,
//                           width: size.width * 0.25,
//                           child: Material(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)),
//                             color: bgColor,
//                             child: ListTile(
//                               tileColor: grClr.withOpacity(0.1),
//                               hoverColor: btnColor.withOpacity(0.2),
//                               selectedColor: btnColor.withOpacity(0.2),
//                               selectedTileColor: btnColor.withOpacity(0.2),
//                               leading: CircleAvatar(
//                                   backgroundColor: btnColor.withOpacity(0.1),
//                                   child: Icon(
//                                     Icons.person,
//                                     color: btnColor,
//                                   )),
//                               title: Text(
//                                 cusname.toString(),
//                                 style: TxtStls.fieldtitlestyle,
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     cusemail.toString(),
//                                     style: TxtStls.fieldstyle,
//                                   ),
//                                   Text(
//                                     cusphone.toString(),
//                                     style: TxtStls.fieldstyle,
//                                   ),
//                                 ],
//                               ),
//                               trailing: CircleAvatar(
//                                 backgroundColor: btnColor.withOpacity(0.1),
//                               ),
//                               onTap: () {},
//                               shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10.0))),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Container(
//                             height: size.width * 0.022,
//                             width: size.width * 0.25,
//                             decoration: BoxDecoration(
//                               color: fieldColor,
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(10.0),
//                                   bottomLeft: Radius.circular(10.0)),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 15, right: 0, top: 0),
//                               child: TextField(
//                                 controller: _subjectController,
//                                 style: TxtStls.fieldstyle,
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: "Subject...",
//                                   hintStyle: TxtStls.fieldstyle,
//                                 ),
//                                 // onChanged: (value) {
//                                 //   setState(() {
//                                 //     _subjectController.text = value;
//                                 //   });
//                                 // }
//                               ),
//                             )),
//                       ),
//                       Container(
//                         height: size.height * 0.12,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Flexible(
//                               flex: 1,
//                               child: Text(
//                                 "Choose Service",
//                                 style: TxtStls.fieldtitlestyle11,
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             Container(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Container(
//                                         height: size.width * 0.022,
//                                         width: size.width * 0.25,
//                                         decoration: BoxDecoration(
//                                           color: fieldColor,
//                                           borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(10.0),
//                                               bottomLeft:
//                                                   Radius.circular(10.0)),
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 15, right: 0, top: 0),
//                                           child: TextField(
//                                               controller:
//                                                   _serviceSearchController2,
//                                               style: TxtStls.fieldstyle,
//                                               decoration: InputDecoration(
//                                                   border: InputBorder.none,
//                                                   hintText: "Search...",
//                                                   hintStyle: TxtStls.fieldstyle,
//                                                   suffixIcon:
//                                                       _serviceSearchController2
//                                                               .text.isNotEmpty
//                                                           ? IconButton(
//                                                               onPressed: () {
//                                                                 _serviceSearchController2
//                                                                     .clear();
//                                                                 searchService(
//                                                                     "");
//                                                                 FocusScope.of(
//                                                                         context)
//                                                                     .requestFocus(
//                                                                         FocusNode());
//                                                               },
//                                                               icon: Icon(
//                                                                   Icons.cancel))
//                                                           : Icon(Icons.search)),
//                                               onChanged: searchService),
//                                         )),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(10.0),
//                                     child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           primary: btnColor,
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0))),
//                                       onPressed: () {},
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: InkWell(
//                                           child: Text(
//                                             "Add",
//                                             style: TxtStls.fieldstyle1,
//                                           ),
//                                           onTap: () {},
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//             Flexible(
//                 fit: FlexFit.tight,
//                 flex: 1,
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 60),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Date",
//                               style: TxtStls.fieldtitlestyle11,
//                             ),
//                             Text(
//                               "Quotation No",
//                               style: TxtStls.fieldtitlestyle11,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Flexible(
//                             flex: 2,
//                             fit: FlexFit.tight,
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 10),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: AbgColor.withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(16.0)),
//                                 child: Expanded(
//                                   flex: 2,
//                                   child: InkWell(
//                                     child: field(
//                                         _selectedDateController,
//                                         DateFormat('dd/MM/yyyy')
//                                             .format(DateTime.now()),
//                                         1,
//                                         false,
//                                         Icon(
//                                           Icons.calendar_today_outlined,
//                                           color: btnColor,
//                                         )),
//                                     onTap: () {
//                                       MyCalenders.pickEndDate(
//                                           context, _selectedDateController);
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             flex: 2,
//                             fit: FlexFit.tight,
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 40),
//                               child: Container(
//                                   padding: EdgeInsets.all(16.0),
//                                   decoration: BoxDecoration(
//                                       color: AbgColor.withOpacity(0.1),
//                                       borderRadius:
//                                           BorderRadius.circular(12.0)),
//                                   child: Text(
//                                     "#" + randomNo.toString(),
//                                     style: TxtStls.fieldstyle,
//                                   )),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             width: size.width * 0.132,
//                             decoration: BoxDecoration(
//                               color: fieldColor,
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(10.0),
//                                   bottomLeft: Radius.circular(10.0)),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 15, right: 0, top: 5),
//                               child: TextField(
//                                 controller: _gstController2,
//                                 style: TxtStls.fieldstyle,
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: "Enter Gst Number...",
//                                     hintStyle: TxtStls.fieldstyle),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               var provider = Provider.of<GstProvider>(context,
//                                   listen: false);
//                               provider
//                                   .fetchGstData(_gstController2.text.toString())
//                                   .whenComplete(() {
//                                 Future.delayed(Duration(seconds: 2))
//                                     .then((value) {
//                                   setState(() {
//                                     tradename = provider.tradename.toString();
//                                     address =
//                                         provider.principalplace.toString();
//                                     pan = provider.pan.toString();
//                                     pincode = provider.pincode.toString();
//                                   });
//                                 });
//                               });
//                             },
//                             child: Container(
//                               width: size.width * 0.025,
//                               padding: EdgeInsets.symmetric(vertical: 12.5),
//                               color: btnColor,
//                               child: Provider.of<GstProvider>(context).isLoading
//                                   ? SpinKitFadingCube(
//                                       color: bgColor,
//                                       size: 23,
//                                     )
//                                   : Icon(
//                                       Icons.search,
//                                       color: bgColor,
//                                     ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ])),
//           ],
//         ),
//         SizedBox(
//           height: 50,
//         ),
//         titleWidget2(),
//         Container(
//           height: size.height * 0.26,
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             controller: sc,
//             itemCount: allServices.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     left: 10,
//                     right: 10,
//                   ),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       color:
//                           index % 2 == 0 ? AbgColor.withOpacity(0.1) : bgColor,
//                     ),
//                     height: size.width * 0.025,
//                     padding: EdgeInsets.only(left: 50, right: 50),
//                     child: Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Flexible(
//                               flex: 1,
//                               child: Text(
//                                 "${index + 1}",
//                                 style: TxtStls.fieldstyle,
//                               )),
//                           Flexible(
//                             flex: 1,
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 10),
//                               child: productWidget(
//                                 "assets/Images/pending.png",
//                                 allServices[index].name,
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                               flex: 1,
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 0, right: 50),
//                                 child: Text(
//                                   "\$56468",
//                                   style: TxtStls.fieldstyle,
//                                 ),
//                               )),
//                           Flexible(
//                               flex: 1,
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 0, right: 30),
//                                 child: Text(
//                                   "GST %",
//                                   style: TxtStls.fieldstyle,
//                                 ),
//                               )),
//                           Flexible(
//                             flex: 1,
//                             child: Padding(
//                                 padding: EdgeInsets.only(left: 0, right: 30),
//                                 child: Text(
//                                   "2 pieces",
//                                   style: TxtStls.fieldstyle,
//                                 )),
//                           ),
//                           Flexible(
//                               flex: 1,
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 0, right: 30),
//                                 child: SACCode(
//                                   "894456",
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   print(allServices[index].name);
//                 },
//               );
//             },
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Row(
//           children: [
//             Text("Samples Required??"),
//             textButton("Yes"),
//             textButton("No"),
//             SizedBox(
//               width: 50,
//             ),
//             isChoosed
//                 ? Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: DropdownButton2<String>(
//                         iconEnabledColor: btnColor,
//                         iconDisabledColor: AbgColor,
//                         itemPadding: EdgeInsets.only(left: 5),
//                         buttonHeight: 30,
//                         buttonPadding: null,
//                         hint: Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: Text(
//                             "Samples",
//                             style: TxtStls.fieldstyle,
//                           ),
//                         ),
//
//                         // selectedItemBuilder: (BuildContext context) {
//                         //   return items.map((String value) {
//                         //     return Text(value.toString(),
//                         //         style: TextStyle(
//                         //             fontSize: 13,
//                         //             color: bgColor,
//                         //             fontWeight: FontWeight.bold));
//                         //   }).toList();
//                         // },
//                         selectedItemHighlightColor: bgColor,
//                         buttonDecoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           color: btnColor.withOpacity(0.4),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         items: items
//                             .map((item) => DropdownMenuItem<String>(
//                                   value: item,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 8.0),
//                                     child: Text(
//                                       item,
//                                       style: TxtStls.fieldstyle,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ))
//                             .toList(),
//                         value: selectedSamples,
//                         onChanged: (value) {
//                           setState(() {
//                             selectedSamples = value as String;
//                           });
//                         },
//                       ),
//                     ))
//                 : SizedBox(),
//           ],
//         )
//       ],
//     );
//   }
//
//   final List<String> items = [
//     "2 pieces",
//     "3 pieces",
//     "4 pieces",
//     "5 pieces",
//     "6 pieces",
//     "7 pieces",
//     "8 pieces",
//     "9 pieces",
//     "10 pieces"
//   ];
//
//   bool isChoosed = false;
//   Widget textButton(text) {
//     return TextButton(
//         onPressed: () {
//           if (text == "Yes") {
//             setState(() {
//               isChoosed = true;
//             });
//           } else {
//             setState(() {
//               isChoosed = false;
//             });
//           }
//         },
//         child: Text(text));
//   }
//
//   Widget serviceIntro(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Center(
//       child: TextButton(
//           onPressed: () async {
//             var gstno = _gstController.text == null
//                 ? ""
//                 : _gstController.text.toString();
//             print(invoiceid.toString());
//             int? isiserviceid;
//             Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//                 .fetchISIServiceId()
//                 .then((value) {
//               isiserviceid =
//                   Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//                       .isiserviceid;
//             });
//             int? fmcsserviceid;
//             Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//                 .fetchFMCSServiceId()
//                 .then((value) {
//               fmcsserviceid =
//                   Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//                       .fmcsserviceid;
//             });
//             int? crsserviceid;
//             Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//                 .fetchCRSServiceId()
//                 .then((value) {
//               crsserviceid =
//                   Provider.of<RecentFetchCXIDProvider>(context, listen: false)
//                       .crsserviceid;
//             });
//             Future.delayed(Duration(seconds: 2)).then((value) async {
//               await PdfISIService.generatePdf(
//                   context: context,
//                   cusname: cusname.toString(),
//                   tbal: tbal,
//                   total: total,
//                   gstAmount: selectedValue == "INR" ? _gstamount : 0.00,
//                   selectedValue: selectedValue,
//                   isiserviceid: isiserviceid!,
//                   Servicelist: servicelist,
//                   activeid: activeid.toString(),
//                   actualinid: invoiceid.toString(),
//                   cxID: cusID.toString(),
//                   docid: Idocid.toString(),
//                   duedate: _duedatedateController.text,
//                   externalNotes: _externalController.text,
//                   gstNo: gstno,
//                   internalNotes: _internalController.text.toString(),
//                   invoicedate: _generatedateController.text.toString(),
//                   LeadId: leadID.toString(),
//                   eimageurl: eimageurl.toString(),
//                   ename: ename.toString(),
//                   eemail: eemail.toString(),
//                   ephone: ephone.toString(),
//                   edesig: edesig.toString(),
//                   referenceID: _referenceController.text);
//             });
//             // Future.delayed(Duration(seconds: 2)).then((value) async {
//             //   await PdfFMCSService.generatePdf(
//             //       context: context,
//             //       cusname: cusname.toString(),
//             //       tbal: tbal,
//             //       total: total,
//             //       gstAmount: selectedValue == "INR" ? _gstamount : 0.00,
//             //       selectedValue: selectedValue,
//             //       fmcsserviceid: fmcsserviceid!,
//             //       Servicelist: servicelist,
//             //       activeid: activeid.toString(),
//             //       actualinid: invoiceid.toString(),
//             //       cxID: cusID.toString(),
//             //       docid: Idocid.toString(),
//             //       duedate: _duedatedateController.text,
//             //       externalNotes: _externalController.text,
//             //       gstNo: gstno,
//             //       internalNotes: _internalController.text.toString(),
//             //       invoicedate: _generatedateController.text.toString(),
//             //       LeadId: leadID.toString(),
//             //       referenceID: _referenceController.text);
//             // });
//             // Future.delayed(Duration(seconds: 2)).then((value) async {
//             //   await PdfCRSService.generatePdf(         context: context,
//             //       cusname: cusname.toString(),
//             //       tbal: tbal,
//             //       total: total,
//             //       gstAmount: selectedValue == "INR" ? _gstamount : 0.00,
//             //       selectedValue: selectedValue,
//             //       crsserviceid: crsserviceid!,
//             //       Servicelist: servicelist,
//             //       activeid: activeid.toString(),
//             //       actualinid: invoiceid.toString(),
//             //       cxID: cusID.toString(),
//             //       docid: Idocid.toString(),
//             //       duedate: _duedatedateController.text,
//             //       externalNotes: _externalController.text,
//             //       gstNo: gstno,
//             //       internalNotes: _internalController.text.toString(),
//             //       invoicedate: _generatedateController.text.toString(),
//             //       LeadId: leadID.toString(),
//             //       referenceID: _referenceController.text);
//             // });
//           },
//           child: const Text("CreatePdf")),
//     );
//   }
//
//   Widget serviceWelcome(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: EdgeInsets.only(
//         left: size.height * 0.05,
//         right: size.height * 0.2,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(
//                   'assets/Images/invoicebg.png',
//                 ),
//                 fit: BoxFit.fill)),
//         padding: EdgeInsets.only(
//           left: size.height * 0.05,
//           right: size.height * 0.05,
//         ),
//         height: size.height * 0.78,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             space2(),
//             Text(
//               cusname.toString(),
//               style: TxtStls.fieldstyle222,
//             ),
//             Text(
//               "Place",
//               style: TxtStls.fieldstyle222,
//             ),
//             Text(
//               "District",
//               style: TxtStls.fieldstyle222,
//             ),
//             Text(
//               "State",
//               style: TxtStls.fieldstyle222,
//             ),
//             Text(
//               "Country",
//               style: TxtStls.fieldstyle222,
//             ),
//             Text(
//               "Pincode",
//               style: TxtStls.fieldstyle222,
//             ),
//             space(),
//             Text(
//               "Hello,",
//               style: TxtStls.fieldstyle,
//             ),
//             Text(
//               "Thank you for choosing JR Compliance",
//               style: TxtStls.fieldstyle,
//             ),
//             space(),
//             Text(
//               "Thank you for choosing JR Compliance as your compliance partner, we admire the opportunity to provide you with the best compliance services and are sincerely welcoming you to our family.",
//               style: TxtStls.fieldstyle,
//             ),
//             space2(),
//             Text(
//               "JR Compliance - Indian’s #1 compliance service provider was established in 2013 with the fundamental motive to make compliance seamless worldwide. We are proud to admit that we stand proudly among a few compliance service providers, who provide Indian and Global certification services under one roof. Till date, we have served more than 10,000 + Indian and Global brands such as Softbank, Troy, and Bombay Dyeing. With that, we pride ourselves that we have been awarded by Future Business Awards 2020 AS “Best Diversified Compliance Legal Service provider in India",
//               style: TxtStls.fieldstyle,
//             ),
//             space2(),
//             Text(
//               "Moreover, we are pleased to inform you that we are the first Technical Compliance Company in India to receive this prestigious award and are also ISO 9001:2015 Certified company and featured in many National and International news platforms such as Deccan Chronicle, Hindustan Times, Zee News, and more.",
//               style: TxtStls.fieldstyle,
//             ),
//             space2(),
//             Text(
//               "We are constantly working to provide superior regulatory and certification services to our clients to strive for excellence within defined time constraints, that too without compromising the accuracy of test methods and results. Additionally, at JR Compliance we are committed to provide responsive and competitive services to our clients by maintaining flexibility, adaptability, and a positive attitude while handling your project.",
//               style: TxtStls.fieldstyle,
//             ),
//             space2(),
//             Text(
//               "Our clients are important to us and we assure to work promptly to ensure high customer satisfaction, now, and as long as you are our customer.",
//               style: TxtStls.fieldstyle,
//             ),
//             space2(),
//             Text(
//               "Looking forward to taking this opportunity to work or associate with you to commence a valuable project.",
//               style: TxtStls.fieldstyle,
//             ),
//             space2(),
//             Text(
//               "Thank you!",
//               style: TxtStls.fieldstyle,
//             ),
//             Text(
//               "Regards",
//               style: TxtStls.fieldstyle,
//             ),
//             Text(
//               "Mr.Tarun Sadana",
//               style: TxtStls.fieldstyle,
//             ),
//             Text(
//               "Sales & Marketing - BDE",
//               style: TxtStls.fieldstyle,
//             ),
//             Text(
//               "tarun@jrompliance.com",
//               style: TxtStls.fieldstyle,
//             ),
//             Text(
//               "www.jrompliance.com",
//               style: TxtStls.fieldstyle,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   final services = <ServicesModel>[
//     ServicesModel(
//       name: "BIS Certificate",
//     ),
//     ServicesModel(
//       name: "WPC Approval",
//     ),
//     ServicesModel(
//       name: "LMPC Approval",
//     ),
//     ServicesModel(
//       name: "ISI Certificate",
//     ),
//   ];
// }
