import 'dart:async';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Constants/LabelText.dart';
import 'package:test_web_app/Models/MoveModel.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:test_web_app/Models/tasksearchmodel.dart';
import 'package:test_web_app/Providers/RemoveServiceProvider.dart';
import 'package:test_web_app/Providers/UpdatestatusProvider.dart';
import 'package:test_web_app/Providers/ActivityProvider.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';
import 'package:test_web_app/Providers/UserProvider.dart';
import 'package:test_web_app/Widgets/DetailsPopBox.dart';

class TaskPreview extends StatefulWidget {
  const TaskPreview({Key? key}) : super(key: key);
  @override
  _TaskPreviewState createState() => _TaskPreviewState();
}

class _TaskPreviewState extends State<TaskPreview>
    with TickerProviderStateMixin {
  final tooltipController = JustTheController();
  bool _isGraph = false;
  var newfilter;

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

  var img;


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

  Widget mytitile = Text(
    "Search Example",
    style: TextStyle(color: Colors.white),
  );
  Icon myicon = Icon(
    Icons.search,
    color: Colors.white,
  );
  final myGlobalkey = GlobalKey<ScaffoldState>();





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
  final TextEditingController _paymentRecieveController = TextEditingController();
  final TextEditingController _sampleController = TextEditingController();
  final TextEditingController _advanceController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _tdsController = TextEditingController();

  int duefilter = 0;
  @override
  void initState() {
    super.initState();
    //Future.delayed(Duration(seconds: 3)).then((value) => assignvel());
    _controller = TabController(
      length: 3,
      vsync: this,
    );

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final userdata = Provider.of<UserDataProvider>(context);

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
                  Card(
    elevation:10,
                    shape:RoundedRectangleBorder(
    borderRadius:BorderRadius.circular(10)
    ),
                    child: Container(
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
                  ),
                  SizedBox(width: size.width * 0.01),
                  PopupMenuButton(
                      offset: Offset(0, size.height * 0.037),
                      child: Container(
                        padding:EdgeInsets.symmetric(horizontal: 20,vertical:2),
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
                            child: Text("We will come soon here..."),
                          ),
                        ];
                      }),
                  SizedBox(width: size.width * 0.01),
                  PopupMenuButton(
                      offset: Offset(0, size.height * 0.037),
                      child: Container(
    padding:EdgeInsets.symmetric(horizontal: 10,vertical:2),
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
                              Icons.filter_alt_sharp,
                              color: bgColor,
                            ),
                            Text(
                              "Calenders",
                              style: TxtStls.fieldstyle1,
                            )
                          ],
                        ),
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child:  InkWell(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: btnColor.withOpacity(0.1),
                                    child:  IconButton(
                                        hoverColor: Colors.transparent,
                                        icon: Icon(Icons.date_range_outlined,
                                            color: btnColor, size: 17.5),
                                        onPressed: () {
                                          dateTimeRangePicker1();
                                        })

                                  ),
                                  SizedBox(width: 5),
                                  Text("StartDate",style: TxtStls.fieldstyle,)
                                ],
                              ),
                                onTap:(){
                                  dateTimeRangePicker1();
                                }
                            ),
                              onTap: (){},

                          ),
                          PopupMenuItem(
                          onTap: (){},
                            child: InkWell(
                                onTap: (){
                                  _selectDate(context);
                                },
                              child: Row(

                                children: [
                                  CircleAvatar(
                                    backgroundColor: btnColor.withOpacity(0.1),
                                    child:
                                         IconButton(
                                        hoverColor: Colors.transparent,
                                        onPressed: () {
                                          _selectDate(context);
                                        },
                                        icon:
                                        Icon(Icons.calendar_today, color: btnColor, size: 15))

                                  ),
                                  SizedBox(width: 5),
                                  Text("EndDate",style: TxtStls.fieldstyle,)
                                ],
                              ),
                            ),

                          ),
                          PopupMenuItem(
                            onTap:(){
                        _queryDate =null;
                        date11 = date22 = null;
                        setState((){});
                        },
                            child: Row(
                              children: [
                                CircleAvatar(child: Icon(Icons.clear,color: Colors.red),backgroundColor: Colors.red.withOpacity(0.2)),
                                SizedBox(width: 5),
                                Text("ClearFilter",style:TxtStls.fieldstyle),
                              ],
                            ),
                          ),
                        ];
                      }),
                  SizedBox(width: size.width * 0.01),
                  userdata.role == "Admin"
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


                              setState(() {
                                enddrawerkey = "Lead";
                                Scaffold.of(context).openEndDrawer();
                              });

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
          // if (activeid == "Board")
          //   Container(
          //     height: size.height * 0.845,
          //     child: Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Column(
          //               children: [
          //                 boardtitle(_clrslist[0], _boardtitlelist[0]),
          //                 SizedBox(height: size.height * 0.01),
          //                 boardmiddle("NEW")
          //               ],
          //             ),
          //             Column(
          //               children: [
          //                 boardtitle(_clrslist[1], _boardtitlelist[1]),
          //                 SizedBox(height: size.height * 0.01),
          //                 boardmiddle("PROSPECT")
          //               ],
          //             ),
          //             Column(
          //               children: [
          //                 boardtitle(_clrslist[2], _boardtitlelist[2]),
          //                 SizedBox(height: size.height * 0.01),
          //                 boardmiddle("INPROGRESS")
          //               ],
          //             ),
          //             Column(
          //               children: [
          //                 boardtitle(_clrslist[3], _boardtitlelist[3]),
          //                 SizedBox(height: size.height * 0.01),
          //                 boardmiddle("WON")
          //               ],
          //             ),
          //             Column(
          //               children: [
          //                 boardtitle(_clrslist[4], _boardtitlelist[4]),
          //                 SizedBox(height: size.height * 0.01),
          //                 boardmiddle("CLOSE")
          //               ],
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // if (activeid == "Timeline")
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         flex: 1,
          //         child: Container(
          //           color: bgColor,
          //           height: size.height * 0.845,
          //           child: Column(
          //             children: [
          //               timelinetitle(_clrslist[0], _boardtitlelist[0]),
          //               timelinetitle(_clrslist[1], _boardtitlelist[1]),
          //               timelinetitle(_clrslist[2], _boardtitlelist[2]),
          //               timelinetitle(_clrslist[3], _boardtitlelist[3]),
          //               timelinetitle(_clrslist[4], _boardtitlelist[4]),
          //             ],
          //           ),
          //         ),
          //       ),
          //       SizedBox(width: 40),
          //       Expanded(
          //         flex: 5,
          //         child: Container(
          //           color: bgColor,
          //           height: size.height * 0.845,
          //           child: ListView.builder(
          //             shrinkWrap: true,
          //             scrollDirection: Axis.horizontal,
          //             physics: AlwaysScrollableScrollPhysics(),
          //             itemCount: 30,
          //             itemBuilder: (BuildContext context, index) {
          //               return Container(
          //                 padding: EdgeInsets.all(20.0),
          //                 decoration: BoxDecoration(
          //                     borderRadius:
          //                         BorderRadius.all(Radius.circular(4.0))),
          //                 child: Text(
          //                   "$index",
          //                   style: TxtStls.fieldstyle,
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
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
        Expanded(child: SizedBox()),
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
    final alluserModellist =
        Provider.of<AllUSerProvider>(context,listen: false).alluserModellist;
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
              int CxID = snp["CxID"];
              int LeadId = snp["LeadId"];
              Timestamp startDate = snp["startDate"];
              String endDate = snp["endDate"];
              String priority = snp["priority"];
              Timestamp lastseen = snp["lastseen"];
              String cat = snp["cat"];
              String message = snp["message"];
              String status = snp["status"];
              List assignsto = snp["Attachments"];
              bool val = snp["flag"];
              String logo = snp["logo"];
              DateTime stamp = snp["time"].toDate();
              int t = stamp.difference(DateTime.now()).inSeconds;
              String createDate =
                  DateFormat("EEE | MMM").format(startDate.toDate());
              String careatedate1 =
                  DateFormat("dd, yy").format(startDate.toDate());
              DateTime dt = DateTime.parse(endDate);
              String edf = DateFormat("EEE | MMM dd,  yy").format(dt);

              // ignore: undefined_prefixed_name
              ui.platformViewRegistry.registerViewFactory(
                logo,
                (int _) => ImageElement()..src = logo,
              );
              String contactname = snp["CompanyDetails"][0]["contactperson"];
              String cemail = snp["CompanyDetails"][0]["email"];
              String cphone = snp["CompanyDetails"][0]["phone"];
              int j = snapshot.data!.docs.length;

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
                                          viewType: logo==null?"":logo,
                                        ))),
                                SizedBox(width: 2),
                                Flexible(
                                  child: Text(
                                    taskname+" (JRL-${LeadId<10?"0${LeadId}":LeadId})",
                                    style: ClrStls.tnClr,
                                  ),
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
                                      Flexible(
                                        child: Text(
                                          message,
                                          style: TxtStls.fieldstyle,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),

                                ],
                              ),
                            );
                          },
                        ),
                        shadow: Shadow(color: btnColor, blurRadius: 20),
                      ),
                      onTap: () {
                        Provider.of<ActivityProvider>(context,listen: false).getAllActivitys(id);
                        Provider.of<ActivityProvider1>(context,listen: false).getAllActivitys1(id,date1,date2);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeatailsPopBox(endDate: endDate, lastseen: lastseen, s: s, status: status, priority: priority, taskname: taskname, cat: cat, f: f, startDate: startDate, message: message, Idocid: id, CxID: CxID,assigns: assignsto.toList(),leadID: LeadId,);
                            });

                      },
                    ),
                    Container(
                      width: size.width * 0.092,
                      child: Text(
                        CxID.toString(),
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
                        Text(edf, style: ClrStls.endClr)),
                    Container(
                      width: size.width * 0.1,
                      height: 30,
                      alignment: Alignment.centerLeft,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          PopupMenuButton(
                            tooltip: "Assignee",
                            icon: Icon(
                              Icons.add_circle,
                              color: btnColor,
                            ),
                            color: bgColor,
                            itemBuilder: (context) => alluserModellist
                                .map((item) => PopupMenuItem(
                                onTap: () {

                                  img = item.auserimage;
                                  print(img);

                                  setState(() {});
                                },
                                value: item.uid,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          item.auserimage.toString()),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      item.ausername.toString(),
                                      style: TxtStls.fieldstyle,
                                    ),
                                  ],
                                )))
                                .toList(),
                            onSelected: (value) {
                              AssignServices.assign(id, value, img);
                            },
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            itemCount: assignsto.length,
                            itemBuilder: (BuildContext context, index) {
                              return ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  child: SizedBox(
                                    width: 30,
                                    height: 500,
                                    child: Image.network(
                                      assignsto[index]["image"],
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.08,
                      alignment: Alignment.centerLeft,
                      child:  dropdowns(cat,status,id),
                    ),
                    Expanded(
                        child: CountdownTimer(
                          endTime: DateTime.now().millisecondsSinceEpoch + t * 1000,
                          widgetBuilder:
                              (BuildContext context, CurrentRemainingTime? time){
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
                                          cxID = CxID.toString();
                                          dendDate = endDate.toString();
                                          enddrawerkey = "update";
                                          dstatus = status;
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
                                          cxID = CxID.toString();
                                          dendDate = endDate.toString();
                                          enddrawerkey = "move";
                                          dstatus = status;
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
    final userdata = Provider.of<UserDataProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      width: MediaQuery.of(context).size.width * 0.160,
      color: AbgColor.withOpacity(0.0001),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Tasks")
            .where("Attachments", arrayContainsAny: [
              {
                "image": userdata.imageUrl,
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
                                            enddrawerkey = "update";
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
                                            enddrawerkey = "move";
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
                    //     s,
                    //     f,
                    //     assign,
                    //     CxID);
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

  Widget dropdowns(cat,status,id) {
    Size size = MediaQuery.of(context).size;
    if (cat == "NEW") {
      return Container(
        alignment: Alignment.center,
        width: size.width * 0.1,
        decoration: BoxDecoration(
            color: StatusUpdateServices.subcatColor(status),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: PopupMenuButton(
          tooltip: "UpDate Status",
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, size.height * 0.035),
          onSelected: (value) {
            Provider.of<UpdateStatusProvider>(context,listen: false).updatestatus(id, value);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  StatusUpdateServices.statusget(status),
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
        width: size.width * 0.1,
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget1(status),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: PopupMenuButton(
          tooltip: "UpDate Status",
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, size.height * 0.035),
          onSelected: (value) {
            Provider.of<UpdateStatusProvider>(context,listen: false).updatestatus(id, value);

          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  StatusUpdateServices.statusget1(status),
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
        width: size.width * 0.1,
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget2(status),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: PopupMenuButton(
          tooltip: "UpDate Status",
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, size.height * 0.035),
          onSelected: (value) {
            Provider.of<UpdateStatusProvider>(context,listen: false).updatestatus(id, value);

          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  StatusUpdateServices.statusget2(status),
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
        width: size.width * 0.1,
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget4(status),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: PopupMenuButton(
          tooltip: "UpDate Status",
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, size.height * 0.035),
          onSelected: (value) {
            Provider.of<UpdateStatusProvider>(context,listen: false).updatestatus(id, value);

          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  StatusUpdateServices.statusget4(status),
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
      width: size.width * 0.1,
      decoration: BoxDecoration(
          color: StatusUpdateServices.statcolorget5(status),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: PopupMenuButton(
        tooltip: "UpDate Status",
        padding: EdgeInsets.zero,
        shape: TooltipShape(),
        offset: Offset(0, size.height * 0.035),
        onSelected: (value) {
          Provider.of<UpdateStatusProvider>(context,listen: false).updatestatus(id, value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                StatusUpdateServices.statusget5(status),
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

  // Widget dropdowns1(id, cat, newsta, prosta, insta, wonsta, clsta) {
  //   if (cat == "NEW") {
  //     return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
  //       alignment: Alignment.center,
  //       width: 150,
  //       decoration: BoxDecoration(
  //           color: StatusUpdateServices.statcolorget(newsta),
  //           borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //       child: Text(
  //         StatusUpdateServices.statusget(newsta),
  //         style: TxtStls.fieldstyle1,
  //       ),
  //     );
  //   } else if (cat == "PROSPECT") {
  //     return Container(
  //       alignment: Alignment.center,
  //       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
  //       width: 150,
  //       decoration: BoxDecoration(
  //           color: StatusUpdateServices.statcolorget1(prosta),
  //           borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //       child: Text(
  //         StatusUpdateServices.statusget1(prosta),
  //         style: TxtStls.fieldstyle1,
  //       ),
  //     );
  //   } else if (cat == "IN PROGRESS") {
  //     return Container(
  //       alignment: Alignment.center,
  //       width: 150,
  //       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
  //       decoration: BoxDecoration(
  //           color: StatusUpdateServices.statcolorget2(insta),
  //           borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //       child: Text(
  //         StatusUpdateServices.statusget2(insta),
  //         style: TxtStls.fieldstyle1,
  //       ),
  //     );
  //   } else if (cat == "WON") {
  //     return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
  //       alignment: Alignment.center,
  //       width: 150,
  //       decoration: BoxDecoration(
  //           color: StatusUpdateServices.statcolorget4(wonsta),
  //           borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //       child: Text(
  //         StatusUpdateServices.statusget4(wonsta),
  //         style: TxtStls.fieldstyle1,
  //       ),
  //     );
  //   }
  //   return Container(
  //     alignment: Alignment.center,
  //     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
  //     width: 130,
  //     decoration: BoxDecoration(
  //         color: StatusUpdateServices.statcolorget5(clsta),
  //         borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //     child: Text(
  //       StatusUpdateServices.statusget5(clsta),
  //       style: TxtStls.fieldstyle11,
  //     ),
  //   );
  // }

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
            Flexible(
              child: Text(
                e,
                style: TxtStls.fieldstyle1,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.cancel,
                color: bgColor,
                size: 15,
              ),
              onPressed: () {
                Provider.of<RemoveServiceProvider>(context,listen: false).removeService(id, e);
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

  var _queryDate;
  Future<void> _selectDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(3021),
        builder: (BuildContext context, Widget ?child) {
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
            child: child ??Text(""),
          );
        }
    );
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
    final userdata = Provider.of<UserDataProvider>(context);
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
                                //     s,
                                //     f,
                                //     assign,
                                //     CxID);
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
                            // Container(
                            //   width: size.width * 0.07,
                            //   alignment: Alignment.centerLeft,
                            //   child: dropdowns(id, cat, newsta, prosta, insta,
                            //       wonsta, clsta),
                            // ),
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
                                              enddrawerkey = "update";
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
                                              enddrawerkey = "move";
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
    }
    else if (_isSearching == true) {
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
                                    // Container(
                                    //   width: 200,
                                    //   alignment: Alignment.centerLeft,
                                    //   child: dropdowns(id, cat, newsta, prosta,
                                    //       insta, wonsta, clsta),
                                    // ),
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
                                                  enddrawerkey = "update";
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
                                                  enddrawerkey = "move";
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
    else if(_queryDate != null){
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
                      .where("Attachments", arrayContainsAny: [
                    {
                      "image": userdata.imageUrl,
                      "uid": _auth.currentUser!.uid.toString(),
                    }
                  ])

                      .where("endDate", isEqualTo: _queryDate)
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
                                //
                                //     s,
                                //     f,
                                //     assign,
                                //     CxID);
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
                            // Container(
                            //   width: size.width * 0.07,
                            //   alignment: Alignment.centerLeft,
                            //   child: dropdowns(id, cat, newsta, prosta, insta,
                            //       wonsta, clsta),
                            // ),
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
                                                  enddrawerkey = "update";
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
                                                  enddrawerkey = "move";
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
              Visibility(
                child: listmiddle("PROSPECT"),
                visible: _tapslist[1],
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
              Visibility(
                child: listmiddle("IN PROGRESS"),
                visible: _tapslist[2],
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
              Visibility(
                child: listmiddle("WON"),
                visible: _tapslist[3],
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
              Visibility(
                child: listmiddle("CLOSE"),
                visible: _tapslist[4],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> assignvel() async {
    final userdata = Provider.of<UserDataProvider>(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("uid");
    final List<TaskSearchModel> loadeddata = [];
    await FirebaseFirestore.instance
        .collection("Tasks")
        .where("Attachments", arrayContainsAny: [
          {"image": userdata.imageUrl, "uid": uid}
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
  dateTimeRangePicker(id) async {
    DateTimeRange? picked = await showDateRangePicker(
        builder: (BuildContext context, Widget ?child) {
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
        }
        context: context,
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
       );
    if (picked != null) {
      setState(() {
          date1 = picked.start.toString().split(" ")[0];
          date2 = picked.end.toString().split(" ")[0];
          Provider.of<ActivityProvider1>(context,listen: false).getAllActivitys1(id,date1,date2);
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
        builder: (BuildContext context, Widget ?child) {
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
        });
    if (picked != null && picked != null) {
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
    final userdata = Provider.of<UserDataProvider>(context);
    if (newfilter != null) {
      return FirebaseFirestore.instance
          .collection("Tasks")
          .where("Attachments", arrayContainsAny: [
            {
              "image": userdata.imageUrl,
              "uid": _auth.currentUser!.uid.toString(),
            }
          ])
          .where("cat", isEqualTo: cat)
          .where("status", isEqualTo: newfilter)
          .snapshots();
    }
    return FirebaseFirestore.instance
        .collection("Tasks")
        .where("Attachments", arrayContainsAny: [
          {
            "image": userdata.imageUrl,
            "uid": _auth.currentUser!.uid.toString(),
          }
        ])
        .where("cat", isEqualTo: cat)
        .snapshots();
  }
}
