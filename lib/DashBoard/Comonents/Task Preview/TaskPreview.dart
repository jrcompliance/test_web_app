import 'dart:html';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:test_web_app/Constants/Fileview.dart';
import 'package:test_web_app/Constants/MoveModel.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/UserModels.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:test_web_app/Constants/slectionfiles.dart';

class TaskPreview extends StatefulWidget {
  const TaskPreview({Key? key}) : super(key: key);

  @override
  _TaskPreviewState createState() => _TaskPreviewState();
}

class _TaskPreviewState extends State<TaskPreview>
    with TickerProviderStateMixin {
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
  String activeid = "List";
  bool isChecked = false;

  int currentStep = 0;

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

  TextEditingController _paymentController = TextEditingController();
  TextEditingController _dealController = TextEditingController();
  TextEditingController _paymentRecieveController = TextEditingController();
  TextEditingController _sampleController = TextEditingController();
  TextEditingController _advanceController = TextEditingController();
  TextEditingController _taxController = TextEditingController();
  TextEditingController _balanceController = TextEditingController();
  TextEditingController _tdsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AbgColor.withOpacity(0.0001),
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                child: Container(
                  color: bgColor,
                  width: 258,
                  child: Row(
                    children: _list.map((e) => newMethod(e, () {})).toList(),
                  ),
                ),
              ),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                color: btnColor,
                elevation: 0.0,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          if (activeid == "List")
            Container(
              height: size.height * 0.845,
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: bgColor,
                    ),
                    width: size.width,
                    height: size.height * 0.31,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        listtitle(_clrslist[0], "NEW", _tapslist[0], () {
                          setState(() {
                            _tapslist[0] = !_tapslist[0];
                          });
                        }),
                        SizedBox(height: 30.0),
                        Visibility(child: listheader(), visible: _tapslist[0]),
                        SizedBox(height: 30.0),
                        Visibility(
                          child: listmiddle("NEW"),
                          visible: _tapslist[0],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: bgColor,
                    ),
                    width: size.width,
                    height: size.height * 0.31,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        listtitle(_clrslist[1], "PROSPECT", _tapslist[1], () {
                          setState(() {
                            _tapslist[1] = !_tapslist[1];
                          });
                        }),
                        SizedBox(height: 30.0),
                        listheader(),
                        SizedBox(height: 30.0),
                        listmiddle("PROSPECT"),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: bgColor,
                    ),
                    width: size.width,
                    height: size.height * 0.31,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        listtitle(_clrslist[2], "IN PROGRESS", _tapslist[2],
                            () {
                          setState(() {
                            _tapslist[2] = !_tapslist[2];
                          });
                        }),
                        SizedBox(height: 30.0),
                        listheader(),
                        SizedBox(height: 30.0),
                        listmiddle("IN PROGRESS"),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: bgColor,
                    ),
                    width: size.width,
                    height: size.height * 0.31,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        listtitle(_clrslist[3], "WON", _tapslist[3], () {
                          setState(() {
                            _tapslist[3] = !_tapslist[3];
                          });
                        }),
                        SizedBox(height: 30.0),
                        listheader(),
                        SizedBox(height: 30.0),
                        listmiddle("WON"),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: bgColor,
                    ),
                    width: size.width,
                    height: size.height * 0.31,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        listtitle(_clrslist[4], "CLOSE", _tapslist[4], () {
                          setState(() {
                            _tapslist[4] = !_tapslist[4];
                          });
                        }),
                        SizedBox(height: 30.0),
                        listheader(),
                        SizedBox(height: 30.0),
                        listmiddle("CLOSE"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                          SizedBox(height: 10),
                          boardmiddle("NEW"),
                        ],
                      ),
                      Column(
                        children: [
                          boardtitle(_clrslist[1], _boardtitlelist[1]),
                          SizedBox(height: 10),
                          boardmiddle("PROSPECT")
                        ],
                      ),
                      Column(
                        children: [
                          boardtitle(_clrslist[2], _boardtitlelist[2]),
                          SizedBox(height: 10),
                          boardmiddle("IN PROGRESS")
                        ],
                      ),
                      Column(
                        children: [
                          boardtitle(_clrslist[3], _boardtitlelist[3]),
                          SizedBox(height: 10),
                          boardmiddle("WON")
                        ],
                      ),
                      Column(
                        children: [
                          boardtitle(_clrslist[4], _boardtitlelist[4]),
                          SizedBox(height: 10),
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
    return RaisedButton.icon(
        elevation: 0.0,
        color: clr,
        hoverColor: Colors.transparent,
        highlightElevation: 0.0,
        disabledElevation: 0.0,
        onPressed: _ontap,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),
        icon: taps
            ? const Icon(
                Icons.arrow_drop_down_outlined,
                color: bgColor,
              )
            : const Icon(
                Icons.arrow_drop_up_outlined,
                color: bgColor,
              ),
        label: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(title, style: TxtStls.fieldstyle1),
        ));
  }

  Widget listheader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
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
    return Container(
      color: bgColor,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
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
            separatorBuilder: (_, i) => SizedBox(height: 5.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              String id = snapshot.data!.docs[index]["id"];
              String taskname = snapshot.data!.docs[index]["task"];
              String CxID = snapshot.data!.docs[index]["CxID"].toString();
              Timestamp startDate = snapshot.data!.docs[index]["startDate"];
              String endDate = snapshot.data!.docs[index]["endDate"];
              String priority = snapshot.data!.docs[index]["priority"];
              Timestamp lastseen = snapshot.data!.docs[index]["lastseen"];
              String cat = snapshot.data!.docs[index]["cat"];
              String message = snapshot.data!.docs[index]["message"];
              String newsta = snapshot.data!.docs[index]["status"];
              String prosta = snapshot.data!.docs[index]["status1"];
              String insta = snapshot.data!.docs[index]["status2"];
              String wonsta = snapshot.data!.docs[index]["status4"];
              String clsta = snapshot.data!.docs[index]["status5"];
              List assign = snapshot.data!.docs[index]["Attachments"];
              String logo = snapshot.data!.docs[index]["logo"];
              // ignore: undefined_prefixed_name
              ui.platformViewRegistry.registerViewFactory(
                logo,
                (int _) => ImageElement()..src = logo,
              );
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 210,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Checkbox(
                            hoverColor: btnColor.withOpacity(0.0001),
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                isChecked = value!;
                              });
                            },
                            activeColor: btnColor),
                        SizedBox(width: 5),
                        CircleAvatar(
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
                          backgroundColor: Colors.red.withOpacity(0.075),
                        ),
                        SizedBox(width: 2.5),
                        CircleAvatar(
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
                        ),
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
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: HtmlElementView(
                                      viewType: logo,
                                    ))),
                            SizedBox(width: 2),
                            Text(
                              "${taskname}",
                              style: ClrStls.tnClr,
                            ),
                          ],
                        )),
                    onTap: () {
                      detailspopBox(context, id, taskname, startDate, endDate,
                          priority, lastseen, cat, message);
                    },
                  ),
                  Container(
                    width: 180,
                    child: Text(
                      CxID,
                      style: TxtStls.fieldstyle,
                    ),
                  ),
                  Container(
                    width: 220,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      startDate.toDate().toString().split(" ")[0],
                      style: TxtStls.fieldstyle,
                    ),
                  ),
                  Container(
                      width: 205,
                      alignment: Alignment.centerLeft,
                      child: Text(snapshot.data!.docs[index]["endDate"],
                          style: ClrStls.endClr)),
                  Container(
                    width: 190,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: assign
                          .map((e) => InkWell(
                                onTap: () {
                                  AssignServices.remove(id, e);
                                },
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                    child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image.network(e["image"]))),
                              ))
                          .toList(),
                    ),
                  ),
                  Container(
                    width: 200,
                    alignment: Alignment.centerLeft,
                    child: dropdowns(
                        id, cat, newsta, prosta, insta, wonsta, clsta),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                Scaffold.of(context).openEndDrawer();
                              });
                            },
                          ),
                          backgroundColor: btnColor.withOpacity(0.075),
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
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget boardtitle(c, e) {
    return Container(
      decoration: BoxDecoration(
          color: c, borderRadius: BorderRadius.all(Radius.circular(20.0))),
      alignment: Alignment.center,
      width: 300,
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
      width: 300,
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
          if (snapshot.data!.docs.length == 0) {
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
              String id = snapshot.data!.docs[index]["id"];
              String cat = snapshot.data!.docs[index]["cat"];
              String newsta = snapshot.data!.docs[index]["status"];
              String prosta = snapshot.data!.docs[index]["status1"];
              String insta = snapshot.data!.docs[index]["status2"];
              String wonsta = snapshot.data!.docs[index]["status4"];
              String clsta = snapshot.data!.docs[index]["status5"];
              String logo = snapshot.data!.docs[index]["logo"];
              String flagres = snapshot.data!.docs[index]["priority"];
              // ignore: undefined_prefixed_name
              ui.platformViewRegistry.registerViewFactory(
                logo,
                (int _) => ImageElement()..src = logo,
              );
              return Padding(
                padding: EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 300,
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Checkbox(
                            //   value: _isCheck,
                            //   onChanged: (value) {
                            //     _isCheck = !_isCheck;
                            //     setState(() {});
                            //   },
                            //   activeColor: btnColor,
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(20.0))),
                            // ),
                            Expanded(
                                child: Text(
                              snapshot.data!.docs[index]["task"],
                              style: TxtStls.fieldstyle,
                            )),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.more_horiz)),
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: FlagService.pricolorget(flagres)
                                  .withOpacity(0.1),
                              child: PopupMenuButton(
                                offset: Offset(0, 32),
                                shape: TooltipShape(),
                                onSelected: (value) {
                                  FlagService.updateFlag(id, value.toString());
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
                            dropdowns(
                                id, cat, newsta, prosta, insta, wonsta, clsta)
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          snapshot.data!.docs[index]["message"],
                          style: TxtStls.fieldstyle,
                        ),
                      ),
                      Container(
                          width: 300,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10.0),
                          child: Text("5 Members", style: TxtStls.fieldstyle)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                            backgroundColor: Colors.red.withOpacity(0.075),
                          ),
                        ],
                      )
                    ],
                  ),
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

  Future<void> _showMyDialog(id) async {
    return showDialog<void>(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: const Text(
            'Are you sure to Delete ?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
              ),
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

  Widget dropdowns(id, cat, newsta, prosta, insta, wonsta, clsta) {
    if (cat == "NEW") {
      return Container(
        alignment: Alignment.center,
        width: 130,
        decoration: BoxDecoration(
            color: StatusUpdateServices.statcolorget(newsta),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: PopupMenuButton(
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, 32),
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
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, 32),
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
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, 32),
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
          padding: EdgeInsets.zero,
          shape: TooltipShape(),
          offset: Offset(0, 32),
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
        padding: EdgeInsets.zero,
        shape: TooltipShape(),
        offset: Offset(0, 32),
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

  detailspopBox(context, id, taskname, startDate, endDate, priority, lastseen,
      cat, message) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _certificateConroller = TextEditingController();
    String createDate = DateFormat('dd-MMM-yy').format(startDate.toDate());
    DateTime dt = DateTime.parse(endDate);
    String deadline = DateFormat('dd-MMM-yy').format(dt);
    String lastview = DateFormat('dd-MMM-yy').format(lastseen.toDate());
    String lastviewTime = DateFormat('hh:mm a').format(lastseen.toDate());
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
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
              taskname,
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
                                      message: "Agent",
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  btnColor.withOpacity(0.1),
                                              child: Icon(Icons.calendar_today,
                                                  color: btnColor),
                                            ),
                                            Text(createDate,
                                                style: TxtStls.fieldstyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onHover: (value) {
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
                                      message: "Filters",
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  btnColor.withOpacity(0.1),
                                              child: Icon(
                                                Icons.date_range,
                                                color: btnColor,
                                              ),
                                            ),
                                            Text(deadline,
                                                style: TxtStls.fieldstyle)
                                          ],
                                        ),
                                      ),
                                    ),
                                    onHover: (value) {
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
                                                child: Lottie.asset(
                                                    "assets/Lotties/lastseen.json",
                                                    fit: BoxFit.fill)),
                                          ),
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
                                  child: IconButton(
                                      hoverColor: Colors.transparent,
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add_box_rounded,
                                        color: btnColor,
                                      )),
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
                                                        "assets/Logos/upload.png"));
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
                                                          height: 40,
                                                          child: Image.asset(
                                                              "assets/Logos/upload.png"),
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
                                                                                print("Setting state");
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
                                                                                print("Setting state");
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
                                                                                print("Setting state");
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
                                                                                print("Setting state");
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
                                    child: Tooltip(
                                      message: "Agent",
                                      child: Container(
                                        padding: EdgeInsets.all(9),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  btnColor.withOpacity(0.1),
                                              child: Lottie.asset(
                                                "assets/Lotties/agent.json",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            // ListView.builder(
                                            //     shrinkWrap: true,
                                            //     scrollDirection: Axis.horizontal,
                                            //     physics: ClampingScrollPhysics(),
                                            //     itemCount: cert.length,
                                            //     itemBuilder: (_, index) {
                                            //       return ClipRRect(
                                            //           clipBehavior:
                                            //               Clip.antiAliasWithSaveLayer,
                                            //           borderRadius: BorderRadius.all(
                                            //               Radius.circular(30.0)),
                                            //           child: SizedBox(
                                            //               width: 30,
                                            //               height: 30,
                                            //               child: Image.network(
                                            //                   cert[index]["uid1"])));
                                            //     })
                                          ],
                                        ),
                                      ),
                                    ),
                                    onHover: (value) {
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
                                      message: "Filters",
                                      child: Container(
                                        padding: EdgeInsets.all(9),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  btnColor.withOpacity(0.1),
                                              child: Lottie.asset(
                                                  "assets/Lotties/filter.json"),
                                            ),
                                            Text("Await",
                                                style: TxtStls.fieldstyle)
                                          ],
                                        ),
                                      ),
                                    ),
                                    onHover: (value) {
                                      setState(() {});
                                    }),
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
                                      child: Container(
                                        child: Lottie.asset(
                                            "assets/Lotties/live.json",
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                                  onHover: (value) {
                                    setState(() {});
                                  },
                                ),
                                Column(
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
                                    SizedBox(height: 3),
                                    Container(
                                      width: 150,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: spClr,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Specification",
                                        style: TxtStls.fieldstyle1,
                                      ),
                                    ),
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
                                            "assets/Lotties/stats.json"),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
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
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.25),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            width: size.width * 0.85 / 2,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Intial Message : " + createDate,
                                    style: TxtStls.fieldstyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
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
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Tasks")
                                .where("id", isEqualTo: id)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                    alignment: Alignment.center,
                                    width: size.width * 0.85 / 2,
                                    child: Lottie.asset(
                                        "assets/Lotties/empty.json"));
                              }
                              return ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (_, i) => Divider(
                                        height: 10,
                                        color: Color(0xFFE0E0E0),
                                      ),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    List lr =
                                        snapshot.data!.docs[index]["Activity"];
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: lr.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        String statecolor = lr[index]["From"];
                                        String statecolor1 = lr[index]["To"];
                                        String date = DateFormat('dd-MMM-yy')
                                            .format(lr[index]["When"].toDate());
                                        String time = DateFormat('hh:mm a')
                                            .format(lr[index]["When"].toDate());
                                        DateTime dt1 = DateTime.parse(
                                            lr[index]["LatDate"]);
                                        String lastDate =
                                            DateFormat('dd-MMM-yy').format(dt1);

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
                                                        child: lr[index]
                                                                    ["Yes"] ==
                                                                true
                                                            ? Lottie.asset(
                                                                "assets/Lotties/success.json")
                                                            : Lottie.asset(
                                                                "assets/Lotties/fail.json"))
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
                                                                lr[index]
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
                                                                lr[index]["To"],
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
                                                                  color: lr[index]
                                                                              [
                                                                              "Bound"] ==
                                                                          "InBound"
                                                                      ? goodClr
                                                                      : avgClr,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              child: Text(
                                                                lr[index]
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
                                                                  color: avgClr,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              child: Text(
                                                                  lr[index][
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
                                                                lr[index]
                                                                    ["Who"],
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
                                                                lr[index]
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
                                  });
                            }),
                      ),
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
}
