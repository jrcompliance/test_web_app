import 'dart:async';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Constants/Charts.dart';
import 'package:test_web_app/Constants/Fileview.dart';
import 'package:test_web_app/Constants/LabelText.dart';
import 'package:test_web_app/Models/MoveModel.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:test_web_app/Constants/slectionfiles.dart';
import 'package:test_web_app/Models/tasksearchmodel.dart';

class TaskPreview extends StatefulWidget {
  const TaskPreview({Key? key}) : super(key: key);
  @override
  _TaskPreviewState createState() => _TaskPreviewState();
}

class _TaskPreviewState extends State<TaskPreview>
    with TickerProviderStateMixin {
  final tooltipController = JustTheController();

  //search method starts from here.....

  Widget appBarTitle = Text(
    "Search Example",
    style: TextStyle(color: Colors.white),
  );
  Icon icon = Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  List<TaskSearchModel> _searchList = [];
  bool _isSearching = false;
  String _searchText = "";
  List<TaskSearchModel> searchresult = [];

  bool _isGraph = false;

  var newfilter;

  _TaskPreviewState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchController.text;
        });
      }
    });
  }

  void values() {
    _searchList = [];
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = Text(
        "Search Sample",
        style: TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _searchController.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    for (int i = 0; i < _searchList.length; i++) {
      String data = _searchList[i].taskname;
      String id = _searchList[i].id as String;
      int CxID = _searchList[i].CxID;
      Timestamp? startDate = _searchList[i].startDate;
      String endDate = _searchList[i].endDate;
      String priority = _searchList[i].priority;
      Timestamp? lastseen = _searchList[i].lastseen;
      String cat = _searchList[i].cat;
      String message = _searchList[i].message;
      String newsta = _searchList[i].newsta;
      String prosta = _searchList[i].prosta;
      String insta = _searchList[i].insta;
      String wonsta = _searchList[i].wonsta;
      String clsta = _searchList[i].clsta;
      List assign = _searchList[i].assign;
      bool val = _searchList[i].val;
      String logo = _searchList[i].logo;

      if (data.toLowerCase().contains(searchText.toLowerCase())) {
        searchresult.add(TaskSearchModel(
          id: id,
          taskname: data,
          CxID: CxID,
          startDate: startDate,
          endDate: endDate,
          priority: priority,
          lastseen: lastseen,
          cat: cat,
          message: message,
          newsta: newsta,
          prosta: prosta,
          insta: insta,
          wonsta: wonsta,
          clsta: clsta,
          assign: assign,
          val: val,
          logo: logo,
        ));
      }
    }
  }

  // search method end here....
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> _list = ["List", "Board", "Timeline"];
  final List<String> _boardtitlelist = [
    "NEW",
    "PROSPECT",
    "INPROGRESS",
    "WON",
    "CLOSE"
  ];
  final List _clrslist = [neClr, prosClr, ipClr, wonClr, clsClr];
  final List<String> _titlelist = [
    "Check Box",
    "Task Name",
    "CxID",
    "Start Date",
    "End Date",
    "Members",
    "Status",
    "Actions"
  ];
  final List<bool> _tapslist = [true, true, true, true, true];

  final List<bool> _isHover = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  String activeid = "List";
  bool isChecked = false;

  int? opts;

  TabController? _controller;
  int _selectedIndex = 0;

  var _isadvance;
  var _istds;
  var _isgst;
  var _islocation;
  var _issample;
  var _govtfee;
  var _testfee;

  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _dealController = TextEditingController();
  final TextEditingController _paymentRecieveController =
      TextEditingController();
  final TextEditingController _sampleController = TextEditingController();
  final TextEditingController _advanceController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _tdsController = TextEditingController();

  int duefilter = 0;

  final filterlist = [
    "Fresh",
    "Assigned",
    "Contacted",
    "Good",
    "Average",
    "Followup",
    "Specification",
    "Quotation",
    "Payment",
    "Sample",
    "Document",
    "Irrelevent",
    "Informative",
    "BudgetIssue",
    "NoResponse",
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this,
    );
    Future.delayed(Duration(seconds: 3)).then((value) => assignvel());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AbgColor.withOpacity(0.0001),
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Row(
                  children: _list.map((e) => newMethod(e, () {})).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 2),
                      child: TextField(
                        controller: _searchController,
                        style: TxtStls.fieldstyle,
                        decoration: new InputDecoration(
                            suffixIcon: _isSearching
                                ? IconButton(
                                    icon: Icon(
                                      Icons.cancel,
                                      color: btnColor,
                                    ),
                                    onPressed: () {
                                      _handleSearchEnd();
                                    },
                                  )
                                : Icon(Icons.search, color: btnColor),
                            border: InputBorder.none,
                            hintText: "Search...",
                            hintStyle: TxtStls.fieldstyle),
                        onChanged: searchOperation,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.01),
                  PopupMenuButton(
                      offset: Offset(0, size.height * 0.037),
                      child: Container(
                        width: size.width * 0.05,
                        height: size.height * 0.035,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            gradient: LinearGradient(colors: [
                              Colors.pinkAccent,
                              Colors.deepPurpleAccent
                            ])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.filter_list_rounded,
                              color: bgColor,
                            ),
                            Text(
                              "Short",
                              style: TxtStls.fieldstyle1,
                            )
                          ],
                        ),
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text("TEC"),
                          ),
                          PopupMenuItem(
                            child: Text("BIS"),
                          ),
                          PopupMenuItem(
                            child: Text("ISI"),
                          ),
                        ];
                      }),
                  SizedBox(width: size.width * 0.01),
                  CircleAvatar(
                    backgroundColor: btnColor.withOpacity(0.1),
                    child: IconButton(
                        hoverColor: Colors.transparent,
                        icon: Icon(Icons.calendar_today_rounded,
                            color: btnColor, size: 17.5),
                        onPressed: () {
                          dateTimeRangePicker1();
                        }),
                  ),
                  SizedBox(width: size.width * 0.01),
                  role == "Admin"
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              gradient: LinearGradient(colors: [
                                Colors.pinkAccent,
                                Colors.deepPurpleAccent
                              ])),
                          child: RaisedButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            onPressed: () {
                              lead = "Lead";
                              Scaffold.of(context).openEndDrawer();
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.add,
                              color: bgColor,
                            ),
                            label: Text(
                              "Create New Lead",
                              style: TxtStls.fieldstyle1,
                            ),
                            color: Colors.transparent,
                            elevation: 0.0,
                          ),
                        )
                      : SizedBox(),
                ],
              )
            ],
          ),
          SizedBox(height: size.height * 0.01),
          if (activeid == "List")
            SizedBox(height: size.height * 0.845, child: serachandfilter()),
          if (activeid == "Board")
            Container(
              height: size.height * 0.845,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          boardtitle(_clrslist[0], _boardtitlelist[0]),
                          SizedBox(height: size.height * 0.01),
                          boardmiddle("NEW")
                        ],
                      ),
                      Column(
                        children: [
                          boardtitle(_clrslist[1], _boardtitlelist[1]),
                          SizedBox(height: size.height * 0.01),
                          boardmiddle("PROSPECT")
                        ],
                      ),
                      Column(
                        children: [
                          boardtitle(_clrslist[2], _boardtitlelist[2]),
                          SizedBox(height: size.height * 0.01),
                          boardmiddle("INPROGRESS")
                        ],
                      ),
                      Column(
                        children: [
                          boardtitle(_clrslist[3], _boardtitlelist[3]),
                          SizedBox(height: size.height * 0.01),
                          boardmiddle("WON")
                        ],
                      ),
                      Column(
                        children: [
                          boardtitle(_clrslist[4], _boardtitlelist[4]),
                          SizedBox(height: size.height * 0.01),
                          boardmiddle("CLOSE")
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          if (activeid == "Timeline")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: bgColor,
                    height: size.height * 0.845,
                    child: Column(
                      children: [
                        timelinetitle(_clrslist[0], _boardtitlelist[0]),
                        timelinetitle(_clrslist[1], _boardtitlelist[1]),
                        timelinetitle(_clrslist[2], _boardtitlelist[2]),
                        timelinetitle(_clrslist[3], _boardtitlelist[3]),
                        timelinetitle(_clrslist[4], _boardtitlelist[4]),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: bgColor,
                    height: size.height * 0.845,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: 30,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
                          child: Text(
                            "$index",
                            style: TxtStls.fieldstyle,
                          ),
                        );
                      },
                    ),
                  ),
                ),
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
          date11 = null;
          date22 = null;
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

  Widget listtitle(clr, title, taps, _ontap) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: _ontap,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))),
            child: Container(
              width: size.width * 0.1,
              height: size.height * 0.05,
              decoration: BoxDecoration(
                color: clr,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              child: Row(
                children: [
                  taps
                      ? const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: bgColor,
                        )
                      : const Icon(
                          Icons.arrow_drop_up_outlined,
                          color: bgColor,
                        ),
                  Text(title, style: TxtStls.fieldstyle1)
                ],
              ),
            ),
          ),
        ),
        Expanded(child: Text("")),
        _queryDate == null
            ? CircleAvatar(
                backgroundColor: btnColor.withOpacity(0.1),
                child: IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon:
                        Icon(Icons.calendar_today, color: btnColor, size: 15)),
              )
            : CircleAvatar(
                backgroundColor: btnColor.withOpacity(0.1),
                child: IconButton(
                    onPressed: () {
                      _queryDate = null;
                      setState(() {});
                    },
                    icon: Icon(Icons.close, color: btnColor, size: 15)),
              ),
        PopupMenuButton(
          tooltip: "Filters",
          padding: EdgeInsets.zero,
          offset: Offset(0, size.height * 0.035),
          onSelected: (value) {
            newfilter = value;
            setState(() {});
          },
          onCanceled: () {
            newfilter = null;
            setState(() {});
          },
          child: Container(
              alignment: Alignment.center,
              width: size.width * 0.05,
              height: size.height * 0.035,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  gradient: LinearGradient(
                      colors: [Colors.pinkAccent, Colors.deepPurpleAccent])),
              child: Text("Filters", style: TxtStls.fieldstyle1)),
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
        ),
      ],
    );
  }

  Widget listheader() {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.018),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _titlelist
            .map((e) => Row(
                  children: [
                    Text(
                      e,
                      style: TxtStls.fieldtitlestyle2,
                    ),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      color: AbgColor.withOpacity(0.75),
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget listmiddle(cat) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.2,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.018),
      child: StreamBuilder(
        stream: qry(cat),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SpinKitFadingCube(
                color: btnColor,
                size: 20,
              ),
            );
          }
          if (snapshot.data!.docs.length == 0) {
            return Center(
                child: Text(
              "No Leads Found",
              style: TxtStls.fieldtitlestyle,
            ));
          }
          return ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            separatorBuilder: (_, i) => Divider(height: 5.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              var snp = snapshot.data!.docs[index];
              int s = snp["success"];
              int f = snp["fail"];
              String id = snp["id"];
              String taskname = snp["task"];
              String CxID = snp["CxID"].toString();
              Timestamp startDate = snp["startDate"];
              String endDate = snp["endDate"];
              String priority = snp["priority"];
              Timestamp lastseen = snp["lastseen"];
              String cat = snp["cat"];
              String message = snp["message"];
              String newsta = snp["status"];
              String prosta = snp["status1"];
              String insta = snp["status2"];
              String wonsta = snp["status4"];
              String clsta = snp["status5"];
              List assign = snp["Attachments"];
              bool val = snp["flag"];
              String logo = snp["logo"];
              DateTime stamp = snp["time"].toDate();
              int t = stamp.difference(DateTime.now()).inSeconds;
              String createDate =
                  DateFormat("EEE | MMM").format(startDate.toDate());
              String careatedate1 =
                  DateFormat("dd, yy").format(startDate.toDate());
              DateTime dt = DateTime.parse(endDate);
              String edf = DateFormat("EEE | MMM").format(dt);

              String edf1 = DateFormat("dd, yy").format(dt);
              // ignore: undefined_prefixed_name
              ui.platformViewRegistry.registerViewFactory(
                logo,
                (int _) => ImageElement()..src = logo,
              );
              String contactname = snp["CompanyDetails"][0]["contactperson"];
              String cemail = snp["CompanyDetails"][0]["email"];
              String cphone = snp["CompanyDetails"][0]["phone"];
              //List comment = snapshot.data.docs.;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.115,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Checkbox(
                            hoverColor: btnColor.withOpacity(0.0001),
                            value: val,
                            onChanged: (value) {
                              setState(() {
                                GraphValueServices.update(id, value);
                              });
                            },
                            activeColor: btnColor),
                        SizedBox(width: 5),
                        val
                            ? CircleAvatar(
                                maxRadius: 15,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.timer_off_rounded,
                                    size: 12.5,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _showMyDialog1(id);
                                  },
                                ),
                                backgroundColor: Colors.red.withOpacity(0.075),
                              )
                            : SizedBox(),
                        SizedBox(width: 2.5),
                        val
                            ? CircleAvatar(
                                maxRadius: 15,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 12.5,
                                    color: btnColor,
                                  ),
                                  onPressed: () {},
                                ),
                                backgroundColor: btnColor.withOpacity(0.075),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  InkWell(
                    onHover: (value) {},
                    child: JustTheTooltip(
                      showWhenUnlinked: true,
                      controller: tooltipController,
                      showDuration: Duration(seconds: 1),
                      offset: -40.0,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      preferredDirection: AxisDirection.right,
                      child: Container(
                          width: size.width * 0.115,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: HtmlElementView(
                                        viewType: logo,
                                      ))),
                              SizedBox(width: 2),
                              Text(
                                taskname,
                                style: ClrStls.tnClr,
                              ),
                            ],
                          )),
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setstate) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10.0),
                            width: size.width * 0.2,
                            height: size.height * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 15,
                                      child: Icon(Icons.person,
                                          color: btnColor, size: 15),
                                      backgroundColor:
                                          btnColor.withOpacity(0.1),
                                    ),
                                    SizedBox(width: 5),
                                    Text(contactname,
                                        style: TxtStls.fieldstyle),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 15,
                                      child: Icon(Icons.email,
                                          color: btnColor, size: 15),
                                      backgroundColor:
                                          btnColor.withOpacity(0.1),
                                    ),
                                    SizedBox(width: 5),
                                    Text(cemail, style: TxtStls.fieldstyle),
                                  ],
                                ),
                                Row(
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
                                    Text(cphone, style: TxtStls.fieldstyle),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 15,
                                      child: Icon(
                                        Icons.message_rounded,
                                        color: btnColor,
                                        size: 15,
                                      ),
                                      backgroundColor:
                                          btnColor.withOpacity(0.1),
                                    ),
                                    SizedBox(width: 5),
                                    // comment.length == 0
                                    //     ? Text("No Comments",
                                    //         style: TxtStls.fieldstyle)
                                    //     : Flexible(
                                    //         child: Text(
                                    //           comment[comment.length - 1]
                                    //               ["Note"],
                                    //           style: TxtStls.fieldstyle,
                                    //           softWrap: true,
                                    //           overflow: TextOverflow.ellipsis,
                                    //         ),
                                    //       )
                                  ],
                                ),
                                StatefulBuilder(
                                  builder: (thisLowerContext, innerSetState) {
                                    return MaterialButton(
                                      color: btnColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: Text("More",
                                          style: TxtStls.fieldstyle1),
                                      onPressed: () {
                                        print("Hey yala......");
                                        detailspopBox(
                                            context,
                                            id,
                                            taskname,
                                            startDate,
                                            endDate,
                                            priority,
                                            lastseen,
                                            cat,
                                            message,
                                            newsta,
                                            prosta,
                                            insta,
                                            wonsta,
                                            clsta,
                                            s,
                                            f,
                                            assign,
                                            CxID);
                                        setState(() {});
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      shadow: Shadow(color: btnColor, blurRadius: 20),
                    ),
                    onTap: () {
                      detailspopBox(
                          context,
                          id,
                          taskname,
                          startDate,
                          endDate,
                          priority,
                          lastseen,
                          cat,
                          message,
                          newsta,
                          prosta,
                          insta,
                          wonsta,
                          clsta,
                          s,
                          f,
                          assign,
                          CxID);
                    },
                  ),
                  Container(
                    width: size.width * 0.092,
                    child: Text(
                      CxID,
                      style: TxtStls.fieldstyle,
                    ),
                  ),
                  Container(
                    width: size.width * 0.111,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      createDate.toString() + " ${careatedate1.toString()}",
                      style: TxtStls.fieldstyle,
                    ),
                  ),
                  Container(
                      width: size.width * 0.1,
                      alignment: Alignment.centerLeft,
                      child:
                          Text(" ${edf}" + " ${edf1}", style: ClrStls.endClr)),
                  Container(
                    width: size.width * 0.1,
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: ClampingScrollPhysics(),
                          itemCount: assign.length,
                          itemBuilder: (BuildContext context, index) {
                            return ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                child: SizedBox(
                                  width: 30,
                                  height: 500,
                                  child: Image.network(
                                    assign[index]["image"],
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ));
                          },
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("EmployeeData")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              var snp = snapshot.data!.docs;
                              String? img;
                              if (snapshot.hasError) {
                                return Container();
                              }
                              return PopupMenuButton(
                                tooltip: "Assignee",
                                icon: Icon(
                                  Icons.add_circle,
                                  color: btnColor,
                                ),
                                color: bgColor,
                                itemBuilder: (context) => snp
                                    .map((item) => PopupMenuItem(
                                        onTap: () {
                                          img = item.get("uimage");
                                          setState(() {});
                                        },
                                        value: item.get("uid"),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  item.get("uimage")),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              item.get("uname"),
                                              style: TxtStls.fieldstyle,
                                            ),
                                          ],
                                        )))
                                    .toList(),
                                onSelected: (value) {
                                  AssignServices.assign(id, value, img);
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.08,
                    alignment: Alignment.centerLeft,
                    child: dropdowns(
                        id, cat, newsta, prosta, insta, wonsta, clsta),
                  ),
                  Expanded(
                      child: CountdownTimer(
                    endTime: DateTime.now().millisecondsSinceEpoch + t * 1000,
                    widgetBuilder:
                        (BuildContext context, CurrentRemainingTime? time) {
                      if (time == null) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                tooltip: "Update",
                                icon: Icon(
                                  Icons.update,
                                  size: 12.5,
                                  color: btnColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    did = id;
                                    dcat = cat;
                                    dname = taskname;
                                    cxID = CxID;
                                    dendDate = endDate.toString();
                                    lead = "update";
                                    Scaffold.of(context).openEndDrawer();
                                  });
                                },
                              ),
                              backgroundColor: btnColor.withOpacity(0.075),
                            ),
                            CircleAvatar(
                              child: IconButton(
                                tooltip: "Move",
                                icon: Icon(
                                  Icons.fast_forward,
                                  size: 12.5,
                                  color: btnColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    did = id;
                                    dcat = cat;
                                    dname = taskname;
                                    cxID = CxID;
                                    dendDate = endDate.toString();
                                    lead = "move";
                                    Scaffold.of(context).openEndDrawer();
                                  });
                                },
                              ),
                              backgroundColor: btnColor.withOpacity(0.075),
                            ),
                          ],
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LabelText(
                              label: "Hrs",
                              value:
                                  "${time.hours == null ? 0 : time.hours.toString()}"),
                          LabelText(
                              label: "Min",
                              value:
                                  "${time.min == null ? 0 : time.min.toString()}"),
                          LabelText(
                              label: "Sec", value: "${time.sec.toString()}"),
                        ],
                      );
                    },
                  ))
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget boardtitle(c, e) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: c, borderRadius: BorderRadius.all(Radius.circular(20.0))),
      alignment: Alignment.center,
      width: size.width * 0.125,
      padding: EdgeInsets.all(8.0),
      child: Text(
        e,
        style: TextStyle(
            fontSize: 15,
            color: bgColor,
            letterSpacing: 0.2,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget boardmiddle(cat) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      width: MediaQuery.of(context).size.width * 0.160,
      color: AbgColor.withOpacity(0.0001),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Tasks")
            .where("Attachments", arrayContainsAny: [
              {
                "image": imageUrl,
                "uid": _auth.currentUser!.uid.toString(),
              }
            ])
            .where("cat", isEqualTo: cat)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SpinKitFadingCube(
                color: btnColor,
                size: 20,
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
              "No Data Found",
              style: TxtStls.fieldtitlestyle,
            ));
          }
          return GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              var snp = snapshot.data!.docs[index];
              String id = snp["id"];
              String taskname = snp["task"];
              int s = snp["success"];
              int f = snp['fail'];
              String CxID = snp["CxID"].toString();
              Timestamp startDate = snp["startDate"];
              String endDate = snp["endDate"];
              String priority = snp["priority"];
              Timestamp lastseen = snp["lastseen"];
              String cat = snp["cat"];
              String message = snp["message"];
              String newsta = snp["status"];
              String prosta = snp["status1"];
              String insta = snp["status2"];
              String wonsta = snp["status4"];
              String clsta = snp["status5"];
              List assign = snp["Attachments"];
              bool val = snp["flag"];
              String logo = snp["logo"];
              DateTime stamp = snp["time"].toDate();
              int t = stamp.difference(DateTime.now()).inSeconds;
              // ignore: undefined_prefixed_name
              ui.platformViewRegistry.registerViewFactory(
                logo,
                (int _) => ImageElement()..src = logo,
              );
              String flagres = snapshot.data!.docs[index]["priority"];
              // ignore: undefined_prefixed_name
              ui.platformViewRegistry.registerViewFactory(
                logo,
                (int _) => ImageElement()..src = logo,
              );
              return Padding(
                padding: EdgeInsets.all(4.0),
                child: InkWell(
                  child: Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                  snapshot.data!.docs[index]["task"],
                                  style: TxtStls.fieldstyle,
                                )),
                                CircleAvatar(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      size: 12.5,
                                      color: btnColor,
                                    ),
                                    onPressed: () {},
                                  ),
                                  backgroundColor: btnColor.withOpacity(0.075),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 300,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      FlagService.pricolorget(flagres)
                                          .withOpacity(0.1),
                                  child: PopupMenuButton(
                                    offset: Offset(0, 32),
                                    shape: TooltipShape(),
                                    onSelected: (value) {
                                      FlagService.updateFlag(
                                          id, value.toString());
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.flag,
                                      color: FlagService.pricolorget(flagres),
                                    ),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          value: "U",
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.flag,
                                                color: Clrs.urgent,
                                              ),
                                              Text(
                                                "Urgent",
                                                style: TxtStls.stl2,
                                              )
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                            value: "E",
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.clear,
                                                  color: Clrs.bgColor,
                                                ),
                                                Text(
                                                  "Clear",
                                                  style: TxtStls.stl2,
                                                )
                                              ],
                                            )),
                                      ];
                                    },
                                  ),
                                ),
                                dropdowns(id, cat, newsta, prosta, insta,
                                    wonsta, clsta)
                              ],
                            ),
                          ),
                          Container(
                            width: 300,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              snapshot.data!.docs[index]["message"],
                              style: TxtStls.fieldstyle,
                            ),
                          ),
                          Container(
                              width: 300,
                              height: 50,
                              alignment: Alignment.centerLeft,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: assign.length,
                                  itemBuilder: (_, index) {
                                    return ClipRRect(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                        child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: Image.network(
                                                assign[index]["image"])));
                                  })),
                          CountdownTimer(
                            endTime: DateTime.now().millisecondsSinceEpoch +
                                t * 1000,
                            widgetBuilder: (BuildContext context,
                                CurrentRemainingTime? time) {
                              if (time == null) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.update,
                                          size: 12.5,
                                          color: btnColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            did = id;
                                            dcat = cat;
                                            dname = taskname;
                                            cxID = CxID;
                                            dendDate = endDate.toString();
                                            lead = "update";
                                            Scaffold.of(context)
                                                .openEndDrawer();
                                          });
                                        },
                                      ),
                                      backgroundColor:
                                          btnColor.withOpacity(0.075),
                                    ),
                                    SizedBox(width: 10),
                                    CircleAvatar(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 12.5,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          _showMyDialog(id);
                                        },
                                      ),
                                      backgroundColor:
                                          Colors.red.withOpacity(0.075),
                                    ),
                                    SizedBox(width: 10),
                                    CircleAvatar(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.fast_forward,
                                          size: 12.5,
                                          color: btnColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            did = id;
                                            dcat = cat;
                                            dname = taskname;
                                            cxID = CxID;
                                            dendDate = endDate.toString();
                                            lead = "move";
                                            Scaffold.of(context)
                                                .openEndDrawer();
                                          });
                                        },
                                      ),
                                      backgroundColor:
                                          btnColor.withOpacity(0.075),
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    child: IconButton(
                                      tooltip: "Stop Timer",
                                      icon: Icon(
                                        Icons.timer_off_rounded,
                                        size: 12.5,
                                        color: btnColor,
                                      ),
                                      onPressed: () {
                                        _showMyDialog1(id);
                                      },
                                    ),
                                    backgroundColor:
                                        btnColor.withOpacity(0.075),
                                  ),
                                  LabelText(
                                      label: "Hrs",
                                      value:
                                          "${time.hours == null ? 0 : time.hours.toString()}"),
                                  LabelText(
                                      label: "Min",
                                      value:
                                          "${time.min == null ? 0 : time.min.toString()}"),
                                  LabelText(
                                      label: "Sec", value: time.sec.toString()),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    detailspopBox(
                        context,
                        id,
                        taskname,
                        startDate,
                        endDate,
                        priority,
                        lastseen,
                        cat,
                        message,
                        newsta,
                        prosta,
                        insta,
                        wonsta,
                        clsta,
                        s,
                        f,
                        assign,
                        CxID);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget timelinetitle(c, e) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
            color: c, borderRadius: BorderRadius.all(Radius.circular(10.0))),
        alignment: Alignment.center,
        width: 300,
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              e,
              style: TextStyle(
                  fontSize: 15,
                  color: bgColor,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.arrow_right,
              color: bgColor,
            )
          ],
        ),
      ),
    );
  }

  Widget dropdowns(id, cat, newsta, prosta, insta, wonsta, clsta) {
    Size size = MediaQuery.of(context).size;
    if (cat == "NEW") {
      return Container(
        alignment: Alignment.center,
        width: size.width * 0.1,
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget(newsta),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: PopupMenuButton(
          tooltip: "UpDate Status",
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, size.height * 0.035),
          onSelected: (value) {
            StatusUpdateServices.updateStatus(id, value.toString());
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  StatusUpdateServices.statusget(newsta),
                  style: TxtStls.fieldstyle1,
                ),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: bgColor,
                )
              ],
            ),
          ),
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
        ),
      );
    } else if (cat == "PROSPECT") {
      return Container(
        alignment: Alignment.center,
        width: 130,
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget1(prosta),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: PopupMenuButton(
          tooltip: "UpDate Status",
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, size.height * 0.035),
          onSelected: (value) {
            StatusUpdateServices.updateStatus1(id, value.toString());
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  StatusUpdateServices.statusget1(prosta),
                  style: TxtStls.fieldstyle1,
                ),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: bgColor,
                )
              ],
            ),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: "AVERAGE",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: avgClr,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "   AVERAGE   ",
                      style: TxtStls.fieldstyle1,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: "GOOD",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: goodClr,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "   GOOD   ",
                      style: TxtStls.fieldstyle1,
                    ),
                  ),
                ),
              ),
            ];
          },
        ),
      );
    } else if (cat == "IN PROGRESS") {
      return Container(
        alignment: Alignment.center,
        width: 140,
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget2(insta),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: PopupMenuButton(
          tooltip: "UpDate Status",
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, size.height * 0.035),
          onSelected: (value) {
            StatusUpdateServices.updateStatus2(id, value.toString());
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  StatusUpdateServices.statusget2(insta),
                  style: TxtStls.fieldstyle1,
                ),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: bgColor,
                )
              ],
            ),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: "FOLLOWUP",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: flwClr,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "FOLLOWUP",
                      style: TxtStls.fieldstyle1,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: "SPECIFICATION",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: spClr,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "SPECIFICATION",
                      style: TxtStls.fieldstyle1,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: "QUOTATION",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: qtoClr,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "QUOTATION",
                      style: TxtStls.fieldstyle1,
                    ),
                  ),
                ),
              ),
            ];
          },
        ),
      );
    } else if (cat == "WON") {
      return Container(
        alignment: Alignment.center,
        width: 130,
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget4(wonsta),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: PopupMenuButton(
          tooltip: "UpDate Status",
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, size.height * 0.035),
          onSelected: (value) {
            StatusUpdateServices.updateStatus4(id, value.toString());
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  StatusUpdateServices.statusget4(wonsta),
                  style: TxtStls.fieldstyle1,
                ),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: bgColor,
                )
              ],
            ),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: "PAYMENT",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: wonClr,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "PAYMENT",
                      style: TxtStls.fieldstyle1,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: "DOCUMENTS",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: flwClr,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "DOCUMENTS",
                      style: TxtStls.fieldstyle1,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: "SAMPLES",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: goodClr,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "SAMPLES",
                      style: TxtStls.fieldstyle1,
                    ),
                  ),
                ),
              ),
            ];
          },
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      width: 130,
      decoration: BoxDecoration(
          color: StatusUpdateServices.statcolorget5(clsta),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: PopupMenuButton(
        tooltip: "UpDate Status",
        padding: EdgeInsets.zero,
        shape: TooltipShape(),
        offset: Offset(0, size.height * 0.035),
        onSelected: (value) {
          StatusUpdateServices.updateStatus5(id, value.toString());
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                StatusUpdateServices.statusget5(clsta),
                style: TxtStls.fieldstyle11,
              ),
              Icon(
                Icons.arrow_drop_down_outlined,
                color: bgColor,
              )
            ],
          ),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: "IRRELEVANT",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: irrClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "IRRELEVANT",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: "BUDGET ISSUE",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: clsClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "BUDGET ISSUE",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: "INFORMATIVE",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: flwClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "INFORMATIVE",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: "NO ANSWER",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: conClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "NO ANSWER",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            )
          ];
        },
      ),
    );
  }

  Widget dropdowns1(id, cat, newsta, prosta, insta, wonsta, clsta) {
    if (cat == "NEW") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        alignment: Alignment.center,
        width: 150,
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget(newsta),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Text(
          StatusUpdateServices.statusget(newsta),
          style: TxtStls.fieldstyle1,
        ),
      );
    } else if (cat == "PROSPECT") {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        width: 150,
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget1(prosta),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Text(
          StatusUpdateServices.statusget1(prosta),
          style: TxtStls.fieldstyle1,
        ),
      );
    } else if (cat == "IN PROGRESS") {
      return Container(
        alignment: Alignment.center,
        width: 150,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget2(insta),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Text(
          StatusUpdateServices.statusget2(insta),
          style: TxtStls.fieldstyle1,
        ),
      );
    } else if (cat == "WON") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        alignment: Alignment.center,
        width: 150,
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget4(wonsta),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Text(
          StatusUpdateServices.statusget4(wonsta),
          style: TxtStls.fieldstyle1,
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      width: 130,
      decoration: BoxDecoration(
          color: StatusUpdateServices.statcolorget5(clsta),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Text(
        StatusUpdateServices.statusget5(clsta),
        style: TxtStls.fieldstyle11,
      ),
    );
  }

  Widget filters(cat) {
    Size size = MediaQuery.of(context).size;
    if (cat == "NEW") {
      return PopupMenuButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(ui.Radius.circular(10))),
        offset: Offset(size.width * 0.01, size.height * 0.01),
        onSelected: (value) {
          setState(() {});
        },
        child: Icon(
          Icons.filter_list,
          color: btnColor,
        ),
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
    } else if (cat == "PROSPECT") {
      return PopupMenuButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(ui.Radius.circular(10))),
        offset: Offset(size.width * 0.01, size.height * 0.01),
        onSelected: (value) {
          setState(() {});
        },
        child: Icon(
          Icons.filter_list,
          color: btnColor,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: "AVERAGE",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: avgClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "   AVERAGE   ",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: "GOOD",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: goodClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "   GOOD   ",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            ),
          ];
        },
      );
    } else if (cat == "IN PROGRESS") {
      return PopupMenuButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(ui.Radius.circular(10))),
        offset: Offset(size.width * 0.01, size.height * 0.01),
        onSelected: (value) {
          setState(() {});
        },
        child: Icon(
          Icons.filter_list,
          color: btnColor,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: "FOLLOWUP",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: flwClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "FOLLOWUP",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: "SPECIFICATION",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: spClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "SPECIFICATION",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: "QUOTATION",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: qtoClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "QUOTATION",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            ),
          ];
        },
      );
    } else if (cat == "WON") {
      return PopupMenuButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(ui.Radius.circular(10))),
        offset: Offset(size.width * 0.01, size.height * 0.01),
        onSelected: (value) {
          setState(() {});
        },
        child: Icon(
          Icons.filter_list,
          color: btnColor,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: "PAYMENT",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: wonClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "PAYMENT",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: "DOCUMENTS",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: flwClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "DOCUMENTS",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              value: "SAMPLES",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: goodClr,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "SAMPLES",
                    style: TxtStls.fieldstyle1,
                  ),
                ),
              ),
            ),
          ];
        },
      );
    }
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(ui.Radius.circular(10))),
      offset: Offset(size.width * 0.01, size.height * 0.01),
      onSelected: (value) {
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Icon(
          Icons.filter_list,
          color: btnColor,
        ),
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: "IRRELEVANT",
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: irrClr,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "IRRELEVANT",
                  style: TxtStls.fieldstyle1,
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: "BUDGET ISSUE",
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: clsClr,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "BUDGET ISSUE",
                  style: TxtStls.fieldstyle1,
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: "INFORMATIVE",
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: flwClr,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "INFORMATIVE",
                  style: TxtStls.fieldstyle1,
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: "NO ANSWER",
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: conClr,
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "NO ANSWER",
                  style: TxtStls.fieldstyle1,
                ),
              ),
            ),
          )
        ];
      },
    );
  }

  var first;
  var last;

  detailspopBox(context, id, taskname, startDate, endDate, priority, lastseen,
      cat, message, newsta, prosta, insta, wonsta, clsta, s, f, assign, cxid) {
    bool isSelected = false;
    Size size = MediaQuery.of(context).size;
    TextEditingController _certificateConroller = TextEditingController();
    String createDate =
        DateFormat('EEE | MMM dd, yy').format(startDate.toDate());
    DateTime dt = DateTime.parse(endDate);
    String deadline = DateFormat('EEE | MMM dd, yy').format(dt);
    String lastview = DateFormat('EEE | MMM dd, yy').format(lastseen.toDate());
    String lastviewTime = DateFormat('hh:mm a').format(lastseen.toDate());
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      backgroundColor: Colors.white.withOpacity(0.9),
      title: Container(
        width: size.width * 0.85,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 150,
              child: Image.asset("assets/Logos/Controlifylogo.png",
                  filterQuality: FilterQuality.high, fit: BoxFit.fill),
            ),
            Text(
              cxid,
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
                  UpdateServices.lastseenUpdate(id);
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: size.width * 0.85,
            height: size.height * 0.85,
            decoration: BoxDecoration(
              color: AbgColor.withOpacity(0.0001),
            ),
            child: Row(
              children: [
                Container(
                  width: size.width * 0.85 / 2,
                  height: size.height * 0.85,
                  color: AbgColor.withOpacity(0.0001),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width * 0.85 / 2,
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    child: Tooltip(
                                      message: "Create Date",
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor:
                                                    btnColor.withOpacity(0.1),
                                                child: _isHover[0]
                                                    ? Lottie.asset(
                                                        "assets/Lotties/createdate.json",
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .calendar_today_outlined,
                                                        color: btnColor,
                                                        size: 20,
                                                      )),
                                            Text(createDate,
                                                style: TxtStls.fieldstyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onHover: (value) {
                                      _isHover[0] = value;
                                      setState(() {});
                                    },
                                    onTap: () {}),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: Tooltip(
                                      message: "End Date",
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor:
                                                    btnColor.withOpacity(0.1),
                                                child: Lottie.asset(
                                                    "assets/Lotties/lastdate.json",
                                                    animate: _isHover[1])),
                                            Text(deadline,
                                                style: TxtStls.fieldstyle)
                                          ],
                                        ),
                                      ),
                                    ),
                                    onHover: (value) {
                                      _isHover[1] = value;
                                      setState(() {});
                                    }),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                Tooltip(
                                  message: "Priority",
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            FlagService.pricolorget(priority)
                                                .withOpacity(0.1),
                                        child: Icon(
                                          Icons.flag,
                                          color:
                                              FlagService.pricolorget(priority),
                                        ),
                                      )),
                                ),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                InkWell(
                                  child: Tooltip(
                                    message: "Last Seen",
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  btnColor.withOpacity(0.1),
                                              child: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: _isHover[2]
                                                    ? Lottie.asset(
                                                        "assets/Lotties/lastseen.json",
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Icon(
                                                        Icons.remove_red_eye,
                                                        color: btnColor,
                                                        size: 32,
                                                      ),
                                              )),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(lastview,
                                                  style: TxtStls.fieldstyle),
                                              Text(
                                                lastviewTime,
                                                style: TxtStls.fieldstyle,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  onHover: (value) {
                                    _isHover[2] = value;
                                    setState(() {});
                                  },
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width * 0.85 / 2,
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                            btnColor.withOpacity(0.1),
                                        child:
                                            Icon(Icons.work, color: btnColor)),
                                    Text("Organisation",
                                        style: TxtStls.fieldstyle)
                                  ],
                                ),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                Container(
                                    width: size.width * 0.85 / 3.3,
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("Tasks")
                                          .where("id", isEqualTo: id)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        }
                                        return ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (_, index) {
                                            return ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                    btnColor.withOpacity(0.2),
                                                child: SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child: HtmlElementView(
                                                      viewType: snapshot.data!
                                                          .docs[index]["logo"]),
                                                ),
                                              ),
                                              title: Text(
                                                  snapshot.data!.docs[index]
                                                      ["companyname"],
                                                  style: TxtStls.fieldstyle),
                                              trailing: CircleAvatar(
                                                maxRadius: 15,
                                                child: IconButton(
                                                  hoverColor:
                                                      Colors.transparent,
                                                  icon: Icon(
                                                    Icons.edit,
                                                    size: 12.5,
                                                    color: btnColor,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                                backgroundColor:
                                                    btnColor.withOpacity(0.075),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            width: size.width * 0.85 / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          btnColor.withOpacity(0.1),
                                      child: Lottie.asset(
                                          "assets/Lotties/check.json",
                                          fit: BoxFit.fitHeight),
                                    ),
                                    Text("Manage Contacts",
                                        style: TxtStls.fieldstyle),
                                  ],
                                ),
                                Container(
                                  width: size.width * 0.85 / 3.1,
                                  alignment: Alignment.centerRight,
                                  child: PopupMenuButton(
                                    offset: Offset(size.width * 0.4, 32),
                                    elevation: 10.0,
                                    icon: Icon(
                                      Icons.add_box_rounded,
                                      color: btnColor,
                                    ),
                                    onSelected: (int value) {
                                      opts = value;
                                      setState(() {});
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                            value: 2,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: neClr.withOpacity(0.1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    size: 15,
                                                    color: neClr,
                                                  ),
                                                  Text(
                                                    "Delete",
                                                    style: ClrStls.endClr,
                                                  )
                                                ],
                                              ),
                                            )),
                                      ];
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            width: size.width * 0.85 / 2,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Tasks")
                                  .where("id", isEqualTo: id)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (_, index) {
                                    List<dynamic> contactlist = snapshot
                                        .data!.docs[index]["CompanyDetails"];
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        itemCount: contactlist.length,
                                        itemBuilder: (_, i) {
                                          return Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Card(
                                              elevation: 10,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                height: 50,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                          contactlist[i]
                                                              ["contactperson"],
                                                          style: TxtStls
                                                              .fieldstyle),
                                                    ),
                                                    Expanded(
                                                        flex: 3,
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              WidgetSpan(
                                                                child: Icon(
                                                                  Icons.mail,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 15,
                                                                ),
                                                              ),
                                                              WidgetSpan(
                                                                child: SizedBox(
                                                                  width: 5,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                  text: contactlist[
                                                                          i]
                                                                      ["email"],
                                                                  style: TxtStls
                                                                      .fieldstyle),
                                                            ],
                                                          ),
                                                        )),
                                                    Expanded(
                                                      flex: 3,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                Icons.call,
                                                                color: AbgColor,
                                                                size: 15,
                                                              ),
                                                            ),
                                                            WidgetSpan(
                                                              child: SizedBox(
                                                                width: 5,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                                text:
                                                                    contactlist[
                                                                            i][
                                                                        "phone"],
                                                                style: TxtStls
                                                                    .fieldstyle),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              btnColor
                                                                  .withOpacity(
                                                                      0.1),
                                                          child:
                                                              PopupMenuButton(
                                                            offset:
                                                                Offset(-50, 32),
                                                            elevation: 10.0,
                                                            shape:
                                                                TooltipShape(),
                                                            icon: Icon(
                                                              Icons.more_horiz,
                                                              color: btnColor,
                                                            ),
                                                            onSelected:
                                                                (int value) {
                                                              opts = value;
                                                              setState(() {});
                                                            },
                                                            itemBuilder:
                                                                (context) {
                                                              return [
                                                                PopupMenuItem(
                                                                    value: 1,
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(5)),
                                                                        color: btnColor
                                                                            .withOpacity(0.1),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.edit,
                                                                            size:
                                                                                15,
                                                                            color:
                                                                                btnColor,
                                                                          ),
                                                                          Text(
                                                                            "Edit",
                                                                            style:
                                                                                ClrStls.tnClr,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )),
                                                                PopupMenuItem(
                                                                    value: 2,
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(5)),
                                                                        color: neClr
                                                                            .withOpacity(0.1),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.delete,
                                                                            size:
                                                                                15,
                                                                            color:
                                                                                neClr,
                                                                          ),
                                                                          Text(
                                                                            "Delete",
                                                                            style:
                                                                                ClrStls.endClr,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )),
                                                              ];
                                                            },
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Attachments :",
                                          style: TxtStls.fieldtitlestyle),
                                      Container(
                                        width: size.width * 0.20,
                                        height: size.height * 0.12,
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection("Tasks")
                                                .where("id", isEqualTo: id)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container(
                                                    width: 100,
                                                    height: 100,
                                                    child: Image.asset(
                                                        "assets/Images/pdf.png"));
                                              }
                                              return ListView.separated(
                                                separatorBuilder: (_, index) =>
                                                    SizedBox(height: 1),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    AlwaysScrollableScrollPhysics(),
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  List attachments1 =
                                                      snapshot.data!.docs[index]
                                                          ["Attachments1"];
                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        attachments1.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            i) {
                                                      return ListTile(
                                                        leading: SizedBox(
                                                          height: size.height *
                                                              0.05,
                                                          child: Image.asset(
                                                              "assets/Images/pdf.png",
                                                              filterQuality:
                                                                  FilterQuality
                                                                      .high,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        title: Text(
                                                          attachments1[i]
                                                              ['name'],
                                                          style: TxtStls
                                                              .fieldstyle,
                                                        ),
                                                        onTap: () {
                                                          fileview1(
                                                              context,
                                                              attachments1[i]
                                                                  ["name"],
                                                              attachments1[i]
                                                                  ["url"]);
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            }),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.center,
                                        height: size.height * 0.05,
                                        width: size.width * 0.20,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: txtColor
                                                        .withOpacity(0.5)))),
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          color: btnColor,
                                          child: Text("Upload",
                                              style: TxtStls.fieldstyle1),
                                          onPressed: () {
                                            FileServices.choosefile(id);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Services Obtained :",
                                          style: TxtStls.fieldtitlestyle),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7)),
                                                  color: bgColor),
                                              child: Card(
                                                color: bgColor,
                                                elevation: 25,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                7))),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15,
                                                      right: 15,
                                                      top: 2),
                                                  child: TextFormField(
                                                    controller:
                                                        _certificateConroller,
                                                    style: TxtStls.fieldstyle,
                                                    decoration: InputDecoration(
                                                      hintText: "Type...",
                                                      hintStyle:
                                                          TxtStls.fieldstyle,
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.add_box,
                                              color: btnColor,
                                            ),
                                            onPressed: () {
                                              CrudOperations.certificateUpdate(
                                                id,
                                                _certificateConroller,
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection("Tasks")
                                                .where("id", isEqualTo: id)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              }
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    AlwaysScrollableScrollPhysics(),
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  List certificates =
                                                      snapshot.data!.docs[index]
                                                          ["Certificates"];
                                                  String id = snapshot
                                                      .data!.docs[index]["id"];
                                                  return Wrap(
                                                    children: certificates
                                                        .map((e) =>
                                                            service(e, id))
                                                        .toList(),
                                                  );
                                                },
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: cat == "WON"
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: bgColor,
                                  ),
                                  child: DefaultTabController(
                                    initialIndex: _selectedIndex,
                                    length: 3,
                                    child: Scaffold(
                                      backgroundColor: bgColor,
                                      appBar: AppBar(
                                        toolbarHeight: 30,
                                        backgroundColor: bgColor,
                                        elevation: 0.0,
                                        automaticallyImplyLeading: false,
                                        centerTitle: true,
                                        title: TabBar(
                                          controller: _controller,
                                          indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: neClr,
                                          ),
                                          tabs: [
                                            Tab(child: Text("Payment Terms 1")),
                                            Tab(child: Text("Payment Terms 2")),
                                            Tab(child: Text("Comments")),
                                          ],
                                        ),
                                      ),
                                      body: TabBarView(
                                        controller: _controller,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 80,
                                                      width: 1,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Advance required",
                                                            style: TxtStls
                                                                .fieldtitlestyle),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                value: "YES",
                                                                groupValue:
                                                                    _isadvance,
                                                                onChanged:
                                                                    (value) {
                                                                  _isadvance =
                                                                      value;
                                                                  setState(
                                                                      () {});
                                                                }),
                                                            Text("YES",
                                                                style: TxtStls
                                                                    .fieldstyle)
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                value: "NO",
                                                                groupValue:
                                                                    _isadvance,
                                                                onChanged:
                                                                    (value) {
                                                                  _isadvance =
                                                                      value;
                                                                  setState(
                                                                      () {});
                                                                }),
                                                            Text("NO",
                                                                style: TxtStls
                                                                    .fieldstyle)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 80,
                                                      width: 1,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("TDS Applicable",
                                                            style: TxtStls
                                                                .fieldtitlestyle),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                value: "YES",
                                                                groupValue:
                                                                    _istds,
                                                                onChanged:
                                                                    (value) {
                                                                  _istds =
                                                                      value;
                                                                  setState(
                                                                      () {});
                                                                }),
                                                            Text("YES",
                                                                style: TxtStls
                                                                    .fieldstyle)
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                value: "NO",
                                                                groupValue:
                                                                    _istds,
                                                                onChanged:
                                                                    (value) {
                                                                  _istds =
                                                                      value;
                                                                  setState(
                                                                      () {});
                                                                }),
                                                            Text("NO",
                                                                style: TxtStls
                                                                    .fieldstyle)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 80,
                                                      width: 1,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("GST Applicable",
                                                            style: TxtStls
                                                                .fieldtitlestyle),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                value: "YES",
                                                                groupValue:
                                                                    _isgst,
                                                                onChanged:
                                                                    (value) {
                                                                  _isgst =
                                                                      value;
                                                                  setState(
                                                                      () {});
                                                                }),
                                                            Text("YES",
                                                                style: TxtStls
                                                                    .fieldstyle)
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                value: "NO",
                                                                groupValue:
                                                                    _isgst,
                                                                onChanged:
                                                                    (value) {
                                                                  _isgst =
                                                                      value;
                                                                  setState(
                                                                      () {});
                                                                }),
                                                            Text("NO",
                                                                style: TxtStls
                                                                    .fieldstyle)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 80,
                                                      width: 1,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Clients Location",
                                                            style: TxtStls
                                                                .fieldtitlestyle),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                value:
                                                                    "Domestic",
                                                                groupValue:
                                                                    _islocation,
                                                                onChanged:
                                                                    (value) {
                                                                  _islocation =
                                                                      value;
                                                                  setState(
                                                                      () {});
                                                                }),
                                                            Text("Domestic",
                                                                style: TxtStls
                                                                    .fieldstyle)
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                value:
                                                                    "International",
                                                                groupValue:
                                                                    _islocation,
                                                                onChanged:
                                                                    (value) {
                                                                  _islocation =
                                                                      value;
                                                                  setState(
                                                                      () {});
                                                                }),
                                                            Text(
                                                                "International",
                                                                style: TxtStls
                                                                    .fieldstyle)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 80,
                                                      width: 1,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Sample required",
                                                            style: TxtStls
                                                                .fieldtitlestyle),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                value: "YES",
                                                                groupValue:
                                                                    _issample,
                                                                onChanged:
                                                                    (value) {
                                                                  _issample =
                                                                      value;
                                                                  setState(
                                                                      () {});
                                                                }),
                                                            Text("YES",
                                                                style: TxtStls
                                                                    .fieldstyle)
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Radio(
                                                                value: "NO",
                                                                groupValue:
                                                                    _issample,
                                                                onChanged:
                                                                    (value) {
                                                                  _issample =
                                                                      value;
                                                                  setState(
                                                                      () {});
                                                                }),
                                                            Text("NO",
                                                                style: TxtStls
                                                                    .fieldstyle)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 80,
                                                      width: 1,
                                                    ),
                                                  ],
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: CircleAvatar(
                                                    backgroundColor: btnColor
                                                        .withOpacity(0.1),
                                                    child: IconButton(
                                                      icon: Icon(
                                                          Icons
                                                              .arrow_forward_rounded,
                                                          color: btnColor),
                                                      onPressed: () {
                                                        _controller!.animateTo(
                                                            _selectedIndex +=
                                                                1);
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 100,
                                                      width: 1,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text("Slab Percentage",
                                                            style: TxtStls
                                                                .fieldtitlestyle),
                                                        Container(
                                                          width: 170,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("Advance : ",
                                                                  style: TxtStls
                                                                      .fieldstyle),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 70,
                                                                height: 25,
                                                                decoration:
                                                                    deco,
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              4,
                                                                          right:
                                                                              2,
                                                                          bottom:
                                                                              12,
                                                                        ),
                                                                        child:
                                                                            TextFormField(
                                                                          style:
                                                                              TxtStls.fieldstyle,
                                                                          decoration:
                                                                              InputDecoration(border: InputBorder.none),
                                                                          controller:
                                                                              _advanceController,
                                                                          keyboardType:
                                                                              TextInputType.numberWithOptions(
                                                                            decimal:
                                                                                false,
                                                                            signed:
                                                                                true,
                                                                          ),
                                                                          inputFormatters: <
                                                                              TextInputFormatter>[],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          30.0,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          InkWell(
                                                                            child:
                                                                                Icon(
                                                                              Icons.arrow_drop_up,
                                                                              size: 12.0,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              int currentValue = int.parse(_advanceController.text);
                                                                              setState(() {
                                                                                currentValue++;
                                                                                _advanceController.text = (currentValue).toString(); // incrementing value
                                                                              });
                                                                            },
                                                                          ),
                                                                          InkWell(
                                                                            child:
                                                                                Icon(
                                                                              Icons.arrow_drop_down,
                                                                              size: 12.0,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              int currentValue = int.parse(_advanceController.text);
                                                                              setState(() {
                                                                                currentValue--;
                                                                                _advanceController.text = (currentValue > 0 ? currentValue : 0).toString(); // decrementing value
                                                                              });
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          width: 170,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("Tax : ",
                                                                  style: TxtStls
                                                                      .fieldstyle),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 70,
                                                                height: 25,
                                                                decoration:
                                                                    deco,
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              4,
                                                                          right:
                                                                              2,
                                                                          bottom:
                                                                              12,
                                                                        ),
                                                                        child:
                                                                            TextFormField(
                                                                          style:
                                                                              TxtStls.fieldstyle,
                                                                          decoration:
                                                                              InputDecoration(border: InputBorder.none),
                                                                          controller:
                                                                              _taxController,
                                                                          keyboardType:
                                                                              TextInputType.numberWithOptions(
                                                                            decimal:
                                                                                false,
                                                                            signed:
                                                                                true,
                                                                          ),
                                                                          inputFormatters: <
                                                                              TextInputFormatter>[],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          30.0,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          InkWell(
                                                                            child:
                                                                                Icon(
                                                                              Icons.arrow_drop_up,
                                                                              size: 12.0,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              int currentValue = int.parse(_taxController.text);
                                                                              setState(() {
                                                                                currentValue++;
                                                                                _taxController.text = (currentValue).toString(); // incrementing value
                                                                              });
                                                                            },
                                                                          ),
                                                                          InkWell(
                                                                            child:
                                                                                Icon(
                                                                              Icons.arrow_drop_down,
                                                                              size: 12.0,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              int currentValue = int.parse(_taxController.text);
                                                                              setState(() {
                                                                                currentValue--;
                                                                                _taxController.text = (currentValue > 0 ? currentValue : 0).toString(); // decrementing value
                                                                              });
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          width: 170,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("Balance : ",
                                                                  style: TxtStls
                                                                      .fieldstyle),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 70,
                                                                height: 25,
                                                                decoration:
                                                                    deco,
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              4,
                                                                          right:
                                                                              2,
                                                                          bottom:
                                                                              12,
                                                                        ),
                                                                        child:
                                                                            TextFormField(
                                                                          style:
                                                                              TxtStls.fieldstyle,
                                                                          decoration:
                                                                              InputDecoration(border: InputBorder.none),
                                                                          controller:
                                                                              _balanceController,
                                                                          keyboardType:
                                                                              TextInputType.numberWithOptions(
                                                                            decimal:
                                                                                false,
                                                                            signed:
                                                                                true,
                                                                          ),
                                                                          inputFormatters: <
                                                                              TextInputFormatter>[],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          30.0,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          InkWell(
                                                                            child:
                                                                                Icon(
                                                                              Icons.arrow_drop_up,
                                                                              size: 12.0,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              int currentValue = int.parse(_balanceController.text);
                                                                              setState(() {
                                                                                currentValue++;
                                                                                _balanceController.text = (currentValue).toString(); // incrementing value
                                                                              });
                                                                            },
                                                                          ),
                                                                          InkWell(
                                                                            child:
                                                                                Icon(
                                                                              Icons.arrow_drop_down,
                                                                              size: 12.0,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              int currentValue = int.parse(_balanceController.text);
                                                                              setState(() {
                                                                                currentValue--;
                                                                                _balanceController.text = (currentValue > 0 ? currentValue : 0).toString(); // decrementing value
                                                                              });
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          width: 170,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("TDS : ",
                                                                  style: TxtStls
                                                                      .fieldstyle),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 70,
                                                                height: 25,
                                                                decoration:
                                                                    deco,
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              4,
                                                                          right:
                                                                              2,
                                                                          bottom:
                                                                              12,
                                                                        ),
                                                                        child:
                                                                            TextFormField(
                                                                          style:
                                                                              TxtStls.fieldstyle,
                                                                          decoration:
                                                                              InputDecoration(border: InputBorder.none),
                                                                          controller:
                                                                              _tdsController,
                                                                          keyboardType:
                                                                              TextInputType.numberWithOptions(
                                                                            decimal:
                                                                                false,
                                                                            signed:
                                                                                true,
                                                                          ),
                                                                          inputFormatters: <
                                                                              TextInputFormatter>[],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          30.0,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          InkWell(
                                                                            child:
                                                                                Icon(
                                                                              Icons.arrow_drop_up,
                                                                              size: 12.0,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              int currentValue = int.parse(_tdsController.text);
                                                                              setState(() {
                                                                                currentValue++;
                                                                                _tdsController.text = (currentValue).toString(); // incrementing value
                                                                              });
                                                                            },
                                                                          ),
                                                                          InkWell(
                                                                            child:
                                                                                Icon(
                                                                              Icons.arrow_drop_down,
                                                                              size: 12.0,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              int currentValue = int.parse(_tdsController.text);
                                                                              setState(() {
                                                                                currentValue--;
                                                                                _tdsController.text = (currentValue > 0 ? currentValue : 0).toString(); // decrementing value
                                                                              });
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 80,
                                                      width: 1,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Fee Payment",
                                                            style: TxtStls
                                                                .fieldtitlestyle),
                                                        Row(
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "Government Fee",
                                                                    style: TxtStls
                                                                        .fieldtitlestyle),
                                                                Row(
                                                                  children: [
                                                                    Radio(
                                                                        value:
                                                                            "Client",
                                                                        groupValue:
                                                                            _govtfee,
                                                                        onChanged:
                                                                            (value) {
                                                                          _govtfee =
                                                                              value;
                                                                          setState(
                                                                              () {});
                                                                        }),
                                                                    Text(
                                                                        "By Client",
                                                                        style: TxtStls
                                                                            .fieldstyle)
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Radio(
                                                                        value:
                                                                            "jr",
                                                                        groupValue:
                                                                            _govtfee,
                                                                        onChanged:
                                                                            (value) {
                                                                          _govtfee =
                                                                              value;
                                                                          setState(
                                                                              () {});
                                                                        }),
                                                                    Text(
                                                                        "By JrCompliance",
                                                                        style: TxtStls
                                                                            .fieldstyle)
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(width: 10),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "Testing Fee",
                                                                    style: TxtStls
                                                                        .fieldtitlestyle),
                                                                Row(
                                                                  children: [
                                                                    Radio(
                                                                        value:
                                                                            "Client",
                                                                        groupValue:
                                                                            _testfee,
                                                                        onChanged:
                                                                            (value) {
                                                                          _testfee =
                                                                              value;
                                                                          setState(
                                                                              () {});
                                                                        }),
                                                                    Text(
                                                                        "By Client",
                                                                        style: TxtStls
                                                                            .fieldstyle)
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Radio(
                                                                        value:
                                                                            "jr",
                                                                        groupValue:
                                                                            _testfee,
                                                                        onChanged:
                                                                            (value) {
                                                                          _testfee =
                                                                              value;
                                                                          setState(
                                                                              () {});
                                                                        }),
                                                                    Text(
                                                                        "By JrCompliance",
                                                                        style: TxtStls
                                                                            .fieldstyle)
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 80,
                                                      width: 1,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Container(
                                                          width: 270,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  "Deal Size : ",
                                                                  style: TxtStls
                                                                      .fieldstyle),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 120,
                                                                height: 30,
                                                                decoration:
                                                                    deco,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 2,
                                                                    right: 2,
                                                                    bottom:
                                                                        12.5,
                                                                  ),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        _dealController,
                                                                    style: TxtStls
                                                                        .fieldstyle,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintStyle:
                                                                          TxtStls
                                                                              .fieldstyle,
                                                                      border: InputBorder
                                                                          .none,
                                                                    ),
                                                                    validator:
                                                                        (fullname) {
                                                                      if (fullname!
                                                                          .isEmpty) {
                                                                        return "Name can not be empty";
                                                                      } else if (fullname
                                                                              .length <
                                                                          3) {
                                                                        return "Name should be atleast 3 letters";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          width: 270,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  "Payment Recieved Date : ",
                                                                  style: TxtStls
                                                                      .fieldstyle),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 120,
                                                                height: 30,
                                                                decoration:
                                                                    deco,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 2,
                                                                    right: 2,
                                                                    bottom:
                                                                        12.5,
                                                                  ),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        _paymentRecieveController,
                                                                    style: TxtStls
                                                                        .fieldstyle,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintStyle:
                                                                          TxtStls
                                                                              .fieldstyle,
                                                                      border: InputBorder
                                                                          .none,
                                                                    ),
                                                                    validator:
                                                                        (fullname) {
                                                                      if (fullname!
                                                                          .isEmpty) {
                                                                        return "Name can not be empty";
                                                                      } else if (fullname
                                                                              .length <
                                                                          3) {
                                                                        return "Name should be atleast 3 letters";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          width: 270,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  "Samples Recieved Date : ",
                                                                  style: TxtStls
                                                                      .fieldstyle),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 120,
                                                                height: 30,
                                                                decoration:
                                                                    deco,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 2,
                                                                    right: 2,
                                                                    bottom:
                                                                        12.5,
                                                                  ),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        _sampleController,
                                                                    style: TxtStls
                                                                        .fieldstyle,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintStyle:
                                                                          TxtStls
                                                                              .fieldstyle,
                                                                      border: InputBorder
                                                                          .none,
                                                                    ),
                                                                    validator:
                                                                        (fullname) {
                                                                      if (fullname!
                                                                          .isEmpty) {
                                                                        return "Name can not be empty";
                                                                      } else if (fullname
                                                                              .length <
                                                                          3) {
                                                                        return "Name should be atleast 3 letters";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 80,
                                                      width: 1,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: btnColor
                                                          .withOpacity(0.1),
                                                      child: IconButton(
                                                        icon: Icon(
                                                            Icons
                                                                .arrow_back_rounded,
                                                            color: btnColor),
                                                        onPressed: () {
                                                          _controller!.animateTo(
                                                              _selectedIndex -=
                                                                  1);
                                                        },
                                                      ),
                                                    ),
                                                    CircleAvatar(
                                                      backgroundColor: btnColor
                                                          .withOpacity(0.1),
                                                      child: IconButton(
                                                        icon: Icon(
                                                            Icons
                                                                .arrow_forward_rounded,
                                                            color: btnColor),
                                                        onPressed: () {
                                                          _controller!.animateTo(
                                                              _selectedIndex +=
                                                                  1);
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          tab3(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.85 / 2,
                  height: size.height * 0.85,
                  color: AbgColor.withOpacity(0.0001),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width * 0.85 / 2,
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Tooltip(
                                              message: "Agents",
                                              child: assign.length == 0
                                                  ? CircleAvatar(
                                                      backgroundColor: btnColor
                                                          .withOpacity(0.1),
                                                      child: Lottie.asset(
                                                        "assets/Lotties/agent.json",
                                                        fit: BoxFit.fill,
                                                        animate: _isHover[3],
                                                      ))
                                                  : SizedBox()),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              physics: ClampingScrollPhysics(),
                                              itemCount: assign.length,
                                              itemBuilder: (_, index) {
                                                return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    child: SizedBox(
                                                        width: 35,
                                                        height: 30,
                                                        child: Image.network(
                                                            assign[index]
                                                                ["image"],
                                                            fit: BoxFit.cover,
                                                            filterQuality:
                                                                FilterQuality
                                                                    .high)));
                                              })
                                        ],
                                      ),
                                    ),
                                    onHover: (value) {
                                      _isHover[3] = value;
                                      setState(() {});
                                    },
                                    onTap: () {}),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                date1 == null && date2 == null
                                    ? InkWell(
                                        onTap: () {
                                          dateTimeRangePicker();
                                        },
                                        child: Tooltip(
                                          message: "Filters",
                                          child: Container(
                                            padding: EdgeInsets.all(9),
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    btnColor.withOpacity(0.1),
                                                child: Lottie.asset(
                                                    "assets/Lotties/filter.json",
                                                    animate: _isHover[4])),
                                          ),
                                        ),
                                        onHover: (value) {
                                          _isHover[4] = value;
                                          setState(() {});
                                        })
                                    : InkWell(
                                        child: Tooltip(
                                          message: "Clear Filters",
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  btnColor.withOpacity(0.1),
                                              child: Icon(Icons.cancel,
                                                  color: btnColor)),
                                        ),
                                        onTap: () {
                                          date1 = null;
                                          date2 = null;
                                          setState(() {});
                                        },
                                      ),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Tooltip(
                                    message: "Current Status",
                                    child: CircleAvatar(
                                      backgroundColor:
                                          btnColor.withOpacity(0.1),
                                      child: _isHover[5]
                                          ? Lottie.asset(
                                              "assets/Lotties/live.json",
                                              fit: BoxFit.fill,
                                              reverse: true,
                                              animate: _isHover[5])
                                          : SizedBox(
                                              width: 35,
                                              height: 20,
                                              child: Image.asset(
                                                "assets/Images/live.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    ),
                                  ),
                                  onHover: (value) {
                                    _isHover[5] = value;
                                    setState(() {});
                                  },
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: StatusUpdateServices.CatColor(
                                              cat),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      alignment: Alignment.center,
                                      child: Text(
                                        cat,
                                        style: TxtStls.fieldstyle1,
                                      ),
                                    ),
                                    dropdowns1(id, cat, newsta, prosta, insta,
                                        wonsta, clsta),
                                  ],
                                ),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                InkWell(
                                  child: Tooltip(
                                    message: "Statistics",
                                    child: CircleAvatar(
                                      backgroundColor:
                                          btnColor.withOpacity(0.1),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Lottie.asset(
                                              "assets/Lotties/stats.json",
                                              height: 20,
                                              animate: _isHover[6])),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _isGraph = !_isGraph;
                                    });
                                  },
                                  onHover: (value) {
                                    _isHover[6] = value;
                                    setState(() {});
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.01),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.25),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            width: size.width * 0.85 / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    child: Text(taskname,
                                        style: TxtStls.fieldstyle)),
                                Expanded(
                                  child: Text(
                                    "Intial Message : " + createDate,
                                    style: TxtStls.fieldstyle,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    message,
                                    style: TxtStls.fieldtitlestyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 8,
                          child: _isGraph
                              ? Chart(context, s, f)
                              : StreamBuilder(
                                  stream: date1 == null
                                      ? FirebaseFirestore.instance
                                          .collection("Tasks")
                                          .doc(id)
                                          .collection("Activitys")
                                          .snapshots()
                                      : FirebaseFirestore.instance
                                          .collection("Tasks")
                                          .doc(id)
                                          .collection("Activitys")
                                          .where("queryDate",
                                              isGreaterThanOrEqualTo: date1)
                                          .where("queryDate",
                                              isLessThanOrEqualTo: date2)
                                          .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container();
                                    } else if (snapshot.data!.docs.isEmpty) {
                                      return Text(
                                        "No History Found",
                                        style: TxtStls.fieldtitlestyle,
                                      );
                                    }

                                    return ListView.separated(
                                      shrinkWrap: true,
                                      separatorBuilder: (_, i) => Divider(
                                        height: 10,
                                        color: Color(0xFFE0E0E0),
                                      ),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        String statecolor =
                                            snapshot.data!.docs[index]["From"];
                                        String statecolor1 =
                                            snapshot.data!.docs[index]["To"];
                                        String date =
                                            DateFormat("EEE | MMM dd, yy")
                                                .format(snapshot
                                                    .data!.docs[index]["When"]
                                                    .toDate());
                                        String time = DateFormat('hh:mm a')
                                            .format(snapshot
                                                .data!.docs[index]["When"]
                                                .toDate());
                                        DateTime dt1 = DateTime.parse(snapshot
                                            .data!.docs[index]["LatDate"]);
                                        String lastDate =
                                            DateFormat("EEE | MMM dd, yy")
                                                .format(dt1);

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                color: bgColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              btnColor
                                                                  .withOpacity(
                                                                      0.1),
                                                          child: Icon(
                                                              Icons
                                                                  .fast_forward,
                                                              color: btnColor),
                                                        ),
                                                        Text(
                                                          date,
                                                          style: TxtStls
                                                              .fieldstyle,
                                                        ),
                                                      ],
                                                    )),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 40,
                                                      width: 1,
                                                    ),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundColor:
                                                                  btnColor
                                                                      .withOpacity(
                                                                          0.1),
                                                              child: Icon(
                                                                  Icons.timer,
                                                                  color:
                                                                      btnColor),
                                                            ),
                                                            Text(time,
                                                                style: TxtStls
                                                                    .fieldstyle),
                                                          ],
                                                        )),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 40,
                                                      width: 1,
                                                    ),
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundColor:
                                                                  btnColor
                                                                      .withOpacity(
                                                                          0.1),
                                                              child: Icon(
                                                                  Icons
                                                                      .date_range,
                                                                  color:
                                                                      btnColor),
                                                            ),
                                                            Text(lastDate,
                                                                style: TxtStls
                                                                    .fieldstyle),
                                                          ],
                                                        )),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 40,
                                                      width: 1,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 50,
                                                      child: snapshot.data!
                                                                      .docs[index]
                                                                  ["Yes"] ==
                                                              true
                                                          ? InkWell(
                                                              onTap: () {},
                                                              onHover: (value) {
                                                                _isHover[7] =
                                                                    value;
                                                                setState(() {});
                                                              },
                                                              child: CircleAvatar(
                                                                  backgroundColor:
                                                                      btnColor
                                                                          .withOpacity(
                                                                              0.2),
                                                                  child: _isHover[
                                                                          7]
                                                                      ? Lottie.asset(
                                                                          "assets/Lotties/success.json",
                                                                          reverse:
                                                                              true)
                                                                      : Image.asset(
                                                                          "assets/Images/success.png")))
                                                          : InkWell(
                                                              onTap: () {},
                                                              onHover: (value) {
                                                                _isHover[8] =
                                                                    value;
                                                                setState(() {});
                                                              },
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    btnColor
                                                                        .withOpacity(
                                                                            0.1),
                                                                child: _isHover[
                                                                        8]
                                                                    ? Lottie.asset(
                                                                        "assets/Lotties/fail.json",
                                                                        reverse:
                                                                            true)
                                                                    : SizedBox(
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                        child: Image
                                                                            .network(
                                                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDEsuB-R1e4XmwavhpVzH1RxhZPQSj1XcLAA&usqp=CAU",
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                              )),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  height: size.height * 0.001,
                                                  color: Color(0xFFE0E0E0),
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text("From",
                                                              style: TxtStls
                                                                  .fieldstyle),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 120,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10.0)),
                                                              color: FlagService
                                                                  .stateClr(
                                                                      statecolor),
                                                            ),
                                                            child: Text(
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ["From"],
                                                                style: TxtStls
                                                                    .fieldstyle1),
                                                          ),
                                                          Text("TO",
                                                              style: TxtStls
                                                                  .fieldstyle),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.0),
                                                            width: 120,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10.0)),
                                                              color: FlagService
                                                                  .stateClr1(
                                                                      statecolor1),
                                                            ),
                                                            child: Text(
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ["To"],
                                                                style: TxtStls
                                                                    .fieldstyle1),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      color: Color(0xFFE0E0E0),
                                                      height: 40,
                                                      width: 1,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundColor:
                                                                  btnColor
                                                                      .withOpacity(
                                                                          0.1),
                                                              child: Icon(
                                                                  Icons
                                                                      .videogame_asset,
                                                                  color:
                                                                      btnColor),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(4.0),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 150,
                                                              decoration: BoxDecoration(
                                                                  color: snapshot.data!.docs[index]
                                                                              [
                                                                              "Bound"] ==
                                                                          "InBound"
                                                                      ? goodClr
                                                                      : flwClr,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              child: Text(
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ["Bound"],
                                                                style: TxtStls
                                                                    .fieldstyle1,
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(4.0),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                  color: clr(snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      "Action"]),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              child: Text(
                                                                  snapshot.data!
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      "Action"],
                                                                  style: TxtStls
                                                                      .fieldstyle1),
                                                            ),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Text("Notes : ",
                                                                style: TxtStls
                                                                    .fieldstyle),
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                snapshot.data!
                                                                        .docs[
                                                                    index]["Who"],
                                                                style: TxtStls
                                                                    .fieldstyle,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0)),
                                                        ),
                                                        elevation: 10,
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            height: 100,
                                                            width: size.width *
                                                                0.35,
                                                            child: Text(
                                                                snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ["Note"],
                                                                style: TxtStls
                                                                    .notestyle)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  })),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return alertDialog;
        });
  }

  Color clr(action) {
    if (action == "CALL") {
      return wonClr;
    } else if (action == "EMAIL") {
      return avgClr;
    } else if (action == "SOCIAL MEDIA") {
      return btnColor;
    } else {
      return clsClr;
    }
  }

  Widget service(e, id) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.only(left: 5.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: neClr),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              e,
              style: TxtStls.fieldstyle1,
            ),
            IconButton(
              icon: const Icon(
                Icons.cancel,
                color: bgColor,
                size: 15,
              ),
              onPressed: () {
                CrudOperations.deleteCertifcate(id, e);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(id) async {
    return showDialog<void>(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title:
              Text('Are you sure to Delete ?', style: TxtStls.fieldtitlestyle),
          actions: <Widget>[
            MaterialButton(
              color: grClr,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Text('Cancel', style: TxtStls.fieldstyle1),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: clsClr,
              child: Text('Delete', style: TxtStls.fieldstyle1),
              onPressed: () {
                CrudOperations.deleteTask(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog1(id) async {
    return showDialog<void>(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: Text('Are you sure to StopTimer ?',
              style: TxtStls.fieldtitlestyle),
          actions: <Widget>[
            MaterialButton(
              color: grClr,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Text('Cancel', style: TxtStls.fieldstyle1),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: clsClr,
              child: Text('Stop', style: TxtStls.fieldstyle1),
              onPressed: () {
                CrudOperations.stoptimer(id);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget tab3() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: deco,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 2,
              ),
              child: TextFormField(
                controller: _paymentController,
                maxLines: 5,
                style: TxtStls.fieldstyle,
                decoration: InputDecoration(
                  hintText: "Enter a valid Comment",
                  hintStyle: TxtStls.fieldstyle,
                  border: InputBorder.none,
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
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: btnColor.withOpacity(0.1),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: btnColor),
                    onPressed: () {
                      _controller!.animateTo(_selectedIndex -= 1);
                    },
                  ),
                ),
                MaterialButton(
                  color: btnColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    "Save",
                    style: TxtStls.fieldstyle1,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //  showLead(dval, context) {
  //   if (dval == 1) {
  //     return DateTime.now().toString().split(" ")[0];
  //   } else if (dval == 2) {
  //     return DateTime.now()
  //         .subtract(Duration(days: 1))
  //         .toString()
  //         .split(" ")[0];
  //   } else if (dval == 3) {
  //     return DateTime.now().add(Duration(days: 1)).toString().split(" ")[0];
  //   } else if (dval == 4) {
  //     _selectDate(context);
  //   }
  // }

  var _queryDate;
  Future<void> _selectDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(3021));
    if (pickedDate != null) {
      _queryDate = pickedDate.toString().split(" ")[0];
      setState(() {});
    } else {
      _queryDate = null;
    }
  }

  // var _queryDate1;
  // Future<void> _selectDate1(BuildContext context) async {
  //   var pickedDate = await showDateRangePicker(
  //       context: context,
  //       firstDate: DateTime(2022),
  //       lastDate: DateTime.now(),
  //       builder: (context, child) {
  //         return Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.only(top: 50.0),
  //               child: Container(
  //                 height: MediaQuery.of(context).size.height * 0.6,
  //                 width: MediaQuery.of(context).size.width * 0.4,
  //                 child: child,
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  //   if (pickedDate != null) {
  //     print(pickedDate);
  //     _queryDate1 = pickedDate.toString().split(" ")[0];
  //     setState(() {});
  //   } else {
  //     _queryDate1 = null;
  //   }
  // }

  Widget serachandfilter() {
    Size size = MediaQuery.of(context).size;
    if (date11 != null && date22 != null) {
      return Container(
        width: size.width,
        height: size.height * 0.845,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Column(
          children: [
            Expanded(flex: 1, child: listheader()),
            Expanded(
              flex: 9,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Tasks")
                      .where("qDate", isGreaterThanOrEqualTo: date11)
                      .where('qDate', isLessThanOrEqualTo: date22)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SpinKitFadingCube(
                          color: btnColor,
                          size: 25,
                        ),
                      );
                    }
                    if (snapshot.data!.docs.length == 0) {
                      return Center(
                          child: Text(
                        "No Data Found",
                        style: TxtStls.fieldtitlestyle,
                      ));
                    }
                    return ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (_, i) => Divider(height: 5.0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        var snp = snapshot.data!.docs[index];
                        String id = snp["id"];
                        String taskname = snp["task"];
                        int s = snp["success"];
                        int f = snp['fail'];
                        String CxID = snp["CxID"].toString();
                        Timestamp startDate = snp["startDate"];
                        String endDate = snp["endDate"];
                        String priority = snp["priority"];
                        Timestamp lastseen = snp["lastseen"];
                        String cat = snp["cat"];
                        String message = snp["message"];
                        String newsta = snp["status"];
                        String prosta = snp["status1"];
                        String insta = snp["status2"];
                        String wonsta = snp["status4"];
                        String clsta = snp["status5"];
                        List assign = snp["Attachments"];
                        bool val = snp["flag"];
                        String logo = snp["logo"];
                        DateTime stamp = snp["time"].toDate();
                        int t = stamp.difference(DateTime.now()).inSeconds;
                        String createDate =
                            DateFormat("EEE | MMM").format(startDate.toDate());
                        String careatedate1 =
                            DateFormat("dd, yy").format(startDate.toDate());
                        DateTime dt = DateTime.parse(endDate);
                        String edf = DateFormat("EEE | MMM").format(dt);

                        String edf1 = DateFormat("dd, yy").format(dt);
                        // ignore: undefined_prefixed_name
                        ui.platformViewRegistry.registerViewFactory(
                          logo,
                          (int _) => ImageElement()..src = logo,
                        );
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.115,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Checkbox(
                                      hoverColor: btnColor.withOpacity(0.0001),
                                      value: val,
                                      onChanged: (value) {
                                        setState(() {
                                          GraphValueServices.update(id, value);
                                        });
                                      },
                                      activeColor: btnColor),
                                  SizedBox(width: 5),
                                  val
                                      ? CircleAvatar(
                                          maxRadius: 15,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.timer_off_rounded,
                                              size: 12.5,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              _showMyDialog1(id);
                                            },
                                          ),
                                          backgroundColor:
                                              Colors.red.withOpacity(0.075),
                                        )
                                      : SizedBox(),
                                  SizedBox(width: 2.5),
                                  val
                                      ? CircleAvatar(
                                          maxRadius: 15,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              size: 12.5,
                                              color: btnColor,
                                            ),
                                            onPressed: () {},
                                          ),
                                          backgroundColor:
                                              btnColor.withOpacity(0.075),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            InkWell(
                              onHover: (value) {},
                              child: Container(
                                  width: size.width * 0.115,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              child: HtmlElementView(
                                                viewType: logo,
                                              ))),
                                      SizedBox(width: 2),
                                      Text(
                                        taskname,
                                        style: ClrStls.tnClr,
                                      ),
                                    ],
                                  )),
                              onTap: () {
                                detailspopBox(
                                    context,
                                    id,
                                    taskname,
                                    startDate,
                                    endDate,
                                    priority,
                                    lastseen,
                                    cat,
                                    message,
                                    newsta,
                                    prosta,
                                    insta,
                                    wonsta,
                                    clsta,
                                    s,
                                    f,
                                    assign,
                                    CxID);
                              },
                            ),
                            Container(
                              width: size.width * 0.092,
                              child: Text(
                                CxID,
                                style: TxtStls.fieldstyle,
                              ),
                            ),
                            Container(
                              width: size.width * 0.111,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                createDate.toString() +
                                    " ${careatedate1.toString()}",
                                style: TxtStls.fieldstyle,
                              ),
                            ),
                            Container(
                                width: size.width * 0.1,
                                alignment: Alignment.centerLeft,
                                child: Text(" ${edf}" + " ${edf1}",
                                    style: ClrStls.endClr)),
                            Container(
                              width: size.width * 0.1,
                              height: 30,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: assign.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: SizedBox(
                                            width: 30,
                                            height: 500,
                                            child: Image.network(
                                              assign[index]["image"],
                                              fit: BoxFit.cover,
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ));
                                    },
                                  ),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("EmployeeData")
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        var snp = snapshot.data!.docs;
                                        String? img;
                                        if (!snapshot.hasData) {
                                          return Container();
                                        }
                                        return PopupMenuButton(
                                          tooltip: "Assignee",
                                          icon: Icon(
                                            Icons.add_circle,
                                            color: btnColor,
                                          ),
                                          color: bgColor,
                                          itemBuilder: (context) => snp
                                              .map((item) => PopupMenuItem(
                                                  onTap: () {
                                                    img = item.get("uimage");
                                                    setState(() {});
                                                  },
                                                  value: item.get("uid"),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(item
                                                                .get("uimage")),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        item.get("uname"),
                                                        style:
                                                            TxtStls.fieldstyle,
                                                      ),
                                                    ],
                                                  )))
                                              .toList(),
                                          onSelected: (value) {
                                            AssignServices.assign(
                                                id, value, img);
                                          },
                                        );
                                      }),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.07,
                              alignment: Alignment.centerLeft,
                              child: dropdowns(id, cat, newsta, prosta, insta,
                                  wonsta, clsta),
                            ),
                            Expanded(
                                child: CountdownTimer(
                              endTime: DateTime.now().millisecondsSinceEpoch +
                                  t * 1000,
                              widgetBuilder: (BuildContext context,
                                  CurrentRemainingTime? time) {
                                if (time == null) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CircleAvatar(
                                        child: IconButton(
                                          tooltip: "Update",
                                          icon: Icon(
                                            Icons.update,
                                            size: 12.5,
                                            color: btnColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              did = id;
                                              dcat = cat;
                                              dname = taskname;
                                              cxID = CxID;
                                              dendDate = endDate.toString();
                                              lead = "update";
                                              Scaffold.of(context)
                                                  .openEndDrawer();
                                            });
                                          },
                                        ),
                                        backgroundColor:
                                            btnColor.withOpacity(0.075),
                                      ),
                                      CircleAvatar(
                                        child: IconButton(
                                          tooltip: "Move",
                                          icon: Icon(
                                            Icons.fast_forward,
                                            size: 12.5,
                                            color: btnColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              did = id;
                                              dcat = cat;
                                              dname = taskname;
                                              cxID = CxID;
                                              dendDate = endDate.toString();
                                              lead = "move";
                                              Scaffold.of(context)
                                                  .openEndDrawer();
                                            });
                                          },
                                        ),
                                        backgroundColor:
                                            btnColor.withOpacity(0.075),
                                      ),
                                    ],
                                  );
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    LabelText(
                                        label: "Hrs",
                                        value:
                                            "${time.hours == null ? 0 : time.hours.toString()}"),
                                    LabelText(
                                        label: "Min",
                                        value:
                                            "${time.min == null ? 0 : time.min.toString()}"),
                                    LabelText(
                                        label: "Sec",
                                        value: "${time.sec.toString()}"),
                                  ],
                                );
                              },
                            ))
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else if (_isSearching == true) {
      return searchresult.length != 0 || _searchController.text.isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                children: [
                  Expanded(flex: 1, child: listheader()),
                  Expanded(
                    flex: 9,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: ListView.separated(
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (_, i) => Divider(height: 5.0),
                          itemCount: searchresult.length,
                          itemBuilder: (_, index) {
                            String id = searchresult[index].id as String;
                            String taskname =
                                searchresult[index].taskname as String;
                            int CxID = searchresult[index].CxID as int;
                            Timestamp startDate = searchresult[index].startDate;
                            String endDate =
                                searchresult[index].endDate as String;
                            String priority = searchresult[index].priority;
                            Timestamp lastseen = searchresult[index].lastseen;
                            String cat = searchresult[index].cat;
                            String message = searchresult[index].message;
                            String newsta = searchresult[index].newsta;
                            String prosta = searchresult[index].prosta;
                            String insta = searchresult[index].insta;
                            String wonsta = searchresult[index].wonsta;
                            String clsta = searchresult[index].clsta;
                            List? assign = searchresult[index].assign;
                            bool val = searchresult[index].val;
                            var logo = searchresult[index].logo;
                            // DateTime stamp =
                            //     searchresult[index].startDate as DateTime;
                            // int t = stamp.difference(DateTime.now()).inSeconds;
                            String createDate = DateFormat("EEE | MMM")
                                .format(startDate.toDate());
                            String careatedate1 =
                                DateFormat("dd, yy").format(startDate.toDate());
                            DateTime dt = DateTime.parse(endDate);
                            String edf = DateFormat("EEE | MMM").format(dt);

                            String edf1 = DateFormat("dd, yy").format(dt);
                            // ignore: undefined_prefixed_name
                            ui.platformViewRegistry.registerViewFactory(
                              logo,
                              (var _) => ImageElement()..src = logo,
                            );
                            return Stack(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 210,
                                      height: 50,
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Checkbox(
                                              hoverColor:
                                                  btnColor.withOpacity(0.0001),
                                              value: val,
                                              onChanged: (value) {
                                                setState(() {
                                                  GraphValueServices.update(
                                                      id, value);
                                                });
                                              },
                                              activeColor: btnColor),
                                          SizedBox(width: 5),
                                          val
                                              ? CircleAvatar(
                                                  maxRadius: 15,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 12.5,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      _showMyDialog(id);
                                                    },
                                                  ),
                                                  backgroundColor: Colors.red
                                                      .withOpacity(0.075),
                                                )
                                              : SizedBox(),
                                          SizedBox(width: 2.5),
                                          val
                                              ? CircleAvatar(
                                                  maxRadius: 15,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.edit,
                                                      size: 12.5,
                                                      color: btnColor,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  backgroundColor: btnColor
                                                      .withOpacity(0.075),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      child: Container(
                                          width: 230,
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      child: HtmlElementView(
                                                        viewType: logo,
                                                      ))),
                                              SizedBox(width: 2),
                                              Text(
                                                taskname,
                                                style: ClrStls.tnClr,
                                              ),
                                            ],
                                          )),
                                      onTap: () {
                                        // detailspopBox(
                                        //     context,
                                        //     id,
                                        //     taskname,
                                        //     startDate,
                                        //     endDate,
                                        //     priority,
                                        //     lastseen,
                                        //     cat,
                                        //     message,
                                        //     newsta,
                                        //     prosta,
                                        //     insta,
                                        //     wonsta,
                                        //     clsta);
                                      },
                                    ),
                                    Container(
                                      width: 180,
                                      child: Text(
                                        CxID.toString(),
                                        style: TxtStls.fieldstyle,
                                      ),
                                    ),
                                    Container(
                                      width: 220,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        createDate.toString() +
                                            " ${careatedate1.toString()}",
                                        style: TxtStls.fieldstyle,
                                      ),
                                    ),
                                    Container(
                                        width: 205,
                                        alignment: Alignment.centerLeft,
                                        child: Text(" ${edf}" + " ${edf1}",
                                            style: ClrStls.endClr)),
                                    Container(
                                      width: 190,
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: assign
                                            .map((e) => ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40.0)),
                                                child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: Image.network(
                                                        e["image"]))))
                                            .toList(),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      alignment: Alignment.centerLeft,
                                      child: dropdowns(id, cat, newsta, prosta,
                                          insta, wonsta, clsta),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.update,
                                                size: 12.5,
                                                color: btnColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  did = id;
                                                  dcat = cat;
                                                  dname = taskname;
                                                  cxID = CxID.toString();
                                                  dendDate = endDate.toString();
                                                  lead = "update";
                                                  Scaffold.of(context)
                                                      .openEndDrawer();
                                                });
                                              },
                                            ),
                                            backgroundColor:
                                                btnColor.withOpacity(0.075),
                                          ),
                                          CircleAvatar(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.fast_forward,
                                                size: 12.5,
                                                color: btnColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  did = id;
                                                  dcat = cat;
                                                  dname = taskname;
                                                  cxID = CxID.toString();
                                                  dendDate = endDate.toString();
                                                  lead = "move";
                                                  Scaffold.of(context)
                                                      .openEndDrawer();
                                                });
                                              },
                                            ),
                                            backgroundColor:
                                                btnColor.withOpacity(0.075),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                        )),
                  ),
                ],
              ),
            )
          : SizedBox();
    }
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      scrollDirection: Axis.vertical,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: bgColor,
          ),
          width: size.width,
          height: _tapslist[0] ? size.height * 0.33 : size.height * 0.09,
          child: Column(
            children: [
              listtitle(_clrslist[0], "NEW", _tapslist[0], () {
                setState(() {
                  _tapslist[0] = !_tapslist[0];
                });
              }),
              SizedBox(height: size.height * 0.01),
              Visibility(
                child: listheader(),
                visible: _tapslist[0],
              ),
              SizedBox(height: size.height * 0.01),
              Visibility(
                child: listmiddle("NEW"),
                visible: _tapslist[0],
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: bgColor,
          ),
          width: size.width,
          height: _tapslist[1] ? size.height * 0.33 : size.height * 0.09,
          child: Column(
            children: [
              listtitle(_clrslist[1], "PROSPECT", _tapslist[1], () {
                setState(() {
                  _tapslist[1] = !_tapslist[1];
                });
              }),
              SizedBox(height: size.height * 0.01),
              Visibility(
                child: listheader(),
                visible: _tapslist[1],
              ),
              SizedBox(height: size.height * 0.01),
              // Visibility(
              //   child: listmiddle("PROSPECT"),
              //   visible: _tapslist[1],
              // ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: bgColor,
          ),
          width: size.width,
          height: _tapslist[2] ? size.height * 0.33 : size.height * 0.09,
          child: Column(
            children: [
              listtitle(_clrslist[2], "IN PROGRESS", _tapslist[2], () {
                setState(() {
                  _tapslist[2] = !_tapslist[2];
                });
              }),
              SizedBox(height: size.height * 0.01),
              Visibility(
                child: listheader(),
                visible: _tapslist[2],
              ),
              SizedBox(height: size.height * 0.01),
              // Visibility(
              //   child: listmiddle("IN PROGRESS"),
              //   visible: _tapslist[2],
              // ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: bgColor,
          ),
          width: size.width,
          height: _tapslist[3] ? size.height * 0.33 : size.height * 0.09,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              listtitle(_clrslist[3], "WON", _tapslist[3], () {
                setState(() {
                  _tapslist[3] = !_tapslist[3];
                });
              }),
              SizedBox(height: size.height * 0.01),
              Visibility(
                child: listheader(),
                visible: _tapslist[3],
              ),
              SizedBox(height: size.height * 0.01),
              // Visibility(
              //   child: listmiddle("WON"),
              //   visible: _tapslist[3],
              // ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: bgColor,
          ),
          width: size.width,
          height: _tapslist[4] ? size.height * 0.33 : size.height * 0.09,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              listtitle(_clrslist[4], "CLOSE", _tapslist[4], () {
                setState(() {
                  _tapslist[4] = !_tapslist[4];
                });
              }),
              SizedBox(height: size.height * 0.01),
              Visibility(
                child: listheader(),
                visible: _tapslist[4],
              ),
              SizedBox(height: size.height * 0.01),
              // Visibility(
              //   child: listmiddle("CLOSE"),
              //   visible: _tapslist[4],
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> assignvel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("uid");
    final List<TaskSearchModel> loadeddata = [];
    await FirebaseFirestore.instance
        .collection("Tasks")
        .where("Attachments", arrayContainsAny: [
          {"image": imageUrl, "uid": uid}
        ])
        .snapshots()
        .listen((event) {
          event.docs.forEach((element) {
            values();
            loadeddata.add(
              TaskSearchModel(
                  id: element.data()["id"],
                  taskname: element.data()["task"],
                  CxID: element.data()["CxID"],
                  endDate: element.data()["endDate"],
                  startDate: element.data()["startDate"],
                  priority: element.data()["priority"],
                  lastseen: element.data()["lastseen"],
                  cat: element.data()["cat"],
                  message: element.data()["message"],
                  newsta: element.data()["status"],
                  prosta: element.data()["status1"],
                  insta: element.data()["status2"],
                  wonsta: element.data()["status4"],
                  clsta: element.data()["status5"],
                  assign: element.data()["Attachments"],
                  val: element.data()["flag"],
                  logo: element.data()["logo"]),
            );
            setState(() {
              _searchList = loadeddata;
            });
          });
        });
  }

  var date1;
  var date2;
  dateTimeRangePicker() async {
    DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400, maxHeight: 450),
                child: child,
              )
            ],
          );
        });
    if (picked != null && picked != null) {
      print(picked.start.toString().split(" ")[0]);
      print(picked.end.toString().split(" ")[0]);
      setState(() {
        date1 = picked.start.toString().split(" ")[0];
        date2 = picked.end.toString().split(" ")[0];
      });
    }
  }

  var date11;
  var date22;
  dateTimeRangePicker1() async {
    DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400, maxHeight: 450),
                child: child,
              )
            ],
          );
        });
    if (picked != null && picked != null) {
      print(picked.start.toString().split(" ")[0]);
      print(picked.end.toString().split(" ")[0]);
      setState(() {
        date11 = picked.start.toString().split(" ")[0];
        date22 = picked.end.toString().split(" ")[0];
      });
    }
  }

  final rangelist = ["Today", "Yesterday", "Choose Date", "Choose Date Range"];
  String rangeid = "";
  TextEditingController _myController = TextEditingController();
  Stream<QuerySnapshot<Object?>> qry(cat) {
    if (newfilter != null) {
      return FirebaseFirestore.instance
          .collection("Tasks")
          .where("Attachments", arrayContainsAny: [
            {
              "image": imageUrl,
              "uid": _auth.currentUser!.uid.toString(),
            }
          ])
          .where("cat", isEqualTo: cat)
          .where("status", isEqualTo: newfilter)
          .snapshots();
    } else if (_queryDate != null) {
      return FirebaseFirestore.instance
          .collection("Tasks")
          .where("Attachments", arrayContainsAny: [
            {
              "image": imageUrl,
              "uid": _auth.currentUser!.uid.toString(),
            }
          ])
          .where("cat", isEqualTo: cat)
          .where("endDate", isEqualTo: _queryDate)
          .snapshots();
    }
    return FirebaseFirestore.instance
        .collection("Tasks")
        .where("Attachments", arrayContainsAny: [
          {
            "image": imageUrl,
            "uid": _auth.currentUser!.uid.toString(),
          }
        ])
        .where("cat", isEqualTo: cat)
        .snapshots();
  }
}

// class MyCompondQuerys {
//   static getCatProQuery(id) {
//     return FirebaseFirestore.instance
//         .collection("Tasks")
//         .doc(id)
//         .collection("Activitys")
//         .orderBy("When", descending: true)
//         .where("date",
//             isGreaterThan: DateTime.now()
//                 .subtract(Duration(days: 1))
//                 .toString()
//                 .split(" ")[0])
//         .where("date",
//             isLessThanOrEqualTo: DateTime.now().toString().split(" ")[0])
//         .snapshots();
//   }

//   static getCatProQuery1(id) {
//     return FirebaseFirestore.instance
//         .collection("Tasks")
//         .doc(id)
//         .collection("Activitys")
//         .orderBy("When", descending: true)
//         .limit(2)
//         .snapshots();
//   }

//   static getCatProQuery2(id) {
//     return FirebaseFirestore.instance
//         .collection("Tasks")
//         .doc(id)
//         .collection("Activitys")
//         .orderBy("When", descending: true)
//         .limit(3)
//         .snapshots();
//   }

//   static getCatProQuery3(id) {
//     return FirebaseFirestore.instance
//         .collection("Tasks")
//         .doc(id)
//         .collection("Activitys")
//         .orderBy("When", descending: true)
//         .limit(4)
//         .snapshots();
//   }

//   static getCatProQuery4(id) {
//     return FirebaseFirestore.instance
//         .collection("Tasks")
//         .doc(id)
//         .collection("Activitys")
//         .orderBy("When", descending: true)
//         .snapshots();
//   }
// }
