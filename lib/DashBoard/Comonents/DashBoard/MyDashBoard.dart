import 'dart:html';
import 'dart:math';
import 'dart:ui';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_web_app/Constants/Calenders.dart';
import 'package:test_web_app/Constants/Fileview.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/UserModels.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/slectionfiles.dart';
import 'package:test_web_app/DashBoard/Comonents/Charts.dart';
import 'dart:ui' as ui;

class DashBoardBodyScreen extends StatefulWidget {
  @override
  _DashBoardBodyScreenState createState() => _DashBoardBodyScreenState();
}

class _DashBoardBodyScreenState extends State<DashBoardBodyScreen> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> _movekey = GlobalKey();

  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _certificateConroller = TextEditingController();
  final TextEditingController _momoController = TextEditingController();
  final TextEditingController _comnameController = TextEditingController();
  final TextEditingController _conpersonController = TextEditingController();
  final TextEditingController _comphoController = TextEditingController();
  final TextEditingController _commailController = TextEditingController();
  final TextEditingController _comwebController = TextEditingController();
  final TextEditingController _advanceController = TextEditingController();
  final TextEditingController _dealsizeController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  bool tap1 = false;
  bool tap2 = false;
  bool tap3 = false;
  bool tap5 = false;
  bool tap6 = false;
  bool _visible = false;
  bool eble = true;
  bool eble1 = true;
  bool eble2 = true;
  bool eble3 = true;
  bool eble4 = true;
  bool _isChecked = false;
  bool _isCompany = false;
  bool _isStatic = false;
  bool _ismove = true;

  var pricol;
  var status;
  var status1;
  var status2;
  var status4;
  var status5;

  String? na;
  String radioItem = '';
  String radioItem1 = '';
  String radioItem2 = '';
  String? _choosenValue;
  String? _choosenValue1;

  final inbounditems = ["CALL", "EMAIL", "SOCIAL MEDIA"];
  final outbounditems = ["CALL", "EMAIL", "SOCIAL MEDIA", "NO RESPONSE"];

  int newlength = 0;
  int prospectlength = 0;
  int inprogresslength = 0;
  int wonlength = 0;
  int closelength = 0;

  List<bool> _isHover = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AbgColor.withOpacity(0.0001),
      width: size.width,
      height: size.height * 0.93,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // new Category
          Row(
            children: [
              tBtn(tap1, "NEW", neClr, () {
                setState(() {
                  tap1 = !tap1;
                });
              }),
              SizedBox(
                width: Responsive.isSmallScreen(context)
                    ? size.width * 0.005
                    : size.width * 0.005,
              ),
              Text(
                "${newlength.toString()}tasks",
                style: TxtStls.stl1,
              ),
              SizedBox(
                width: Responsive.isSmallScreen(context)
                    ? size.width * 0.005
                    : size.width * 0.005,
              ),
              InkWell(
                child: SizedBox(
                  width: Responsive.isSmallScreen(context)
                      ? size.width * 0.2
                      : size.width * 0.2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: grClr,
                        size: 10,
                      ),
                      Text(
                        "CREATE",
                        style: TxtStls.stl4,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  taskBox(context);
                },
              ),
            ],
          ),
          tap1
              ? Column(
                  children: [
                    head(),
                    Container(
                      width: size.width,
                      height: size.height * 0.11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          border: Border.all(color: Colors.grey)),
                      child: StreamBuilder(
                        stream: _fireStore
                            .collection("Tasks")
                            .where("Attachments", arrayContains: {
                              "uid": _auth.currentUser!.uid.toString(),
                              "uid1": imageUrl.toString(),
                            })
                            .where("cat", isEqualTo: "NEW")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Scrollbar(
                              showTrackOnHover: true,
                              isAlwaysShown: true,
                              controller: _scrollController,
                              thickness: 10,
                              hoverThickness: 10,
                              child: ListView.separated(
                                controller: _scrollController,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                separatorBuilder: (BuildContext context, i) =>
                                    Divider(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, index) {
                                  newlength = snapshot.data!.docs.length;
                                  String flagres =
                                      snapshot.data!.docs[index]["priority"];
                                  String newsta =
                                      snapshot.data!.docs[index]["status"];
                                  String newres =
                                      snapshot.data!.docs[index]["status"];
                                  List cert =
                                      snapshot.data!.docs[index]["Attachments"];

                                  return Row(
                                    children: [
                                      // Task name here...
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: size.width * 0.325,
                                        child: Text(
                                          snapshot.data!.docs[index]["task"],
                                          style: TxtStls.stl1,
                                        ),
                                      ),
                                      // Task assignee here...
                                      Container(
                                        alignment: Alignment.center,
                                        width: size.width * 0.09,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: cert
                                                .map(
                                                  (e) => CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(e["uid1"]),
                                                  ),
                                                )
                                                .toList()),
                                      ),
                                      //end Date of task here...
                                      snapshot.data!.docs[index]["endDate"] ==
                                              ""
                                          ? Container(
                                              alignment: Alignment.center,
                                              width: size.width * 0.09,
                                              child: InkWell(
                                                  onTap: () {
                                                    String id = snapshot.data!
                                                        .docs[index]["id"];
                                                    MyCalenders.pickEndDate1(
                                                        context,
                                                        id,
                                                        _endDateController);
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                  )),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              width: size.width * 0.09,
                                              child: InkWell(
                                                onTap: () {
                                                  String id = snapshot
                                                      .data!.docs[index]["id"];
                                                  MyCalenders.pickEndDate1(
                                                      context,
                                                      id,
                                                      _endDateController);
                                                  setState(() {});
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.clear,
                                                        size: 10,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          String id = snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ["id"];
                                                          EndDateOperations
                                                              .updateEdateTask1(
                                                                  id);
                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                          ["endDate"],
                                                      style: TxtStls.stl1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                      // task priority flag here....
                                      snapshot.data!.docs[index]["priority"] ==
                                              null
                                          ? Container(
                                              alignment: Alignment.center,
                                              width: size.width * 0.09,
                                              child: PopupMenuButton(
                                                color: Clrs.txtColor,
                                                onSelected: (value) {
                                                  pricol = value;
                                                  String prcl =
                                                      pricol.toString();
                                                  String id = snapshot
                                                      .data!.docs[index]["id"];
                                                  FlagService.updateFlag(
                                                      id, prcl);
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.flag,
                                                  color:
                                                      FlagService.pricolorget(
                                                          flagres),
                                                ),
                                                itemBuilder: (context) {
                                                  return [
                                                    PopupMenuItem(
                                                      value: "U",
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.clear,
                                                              color:
                                                                  Clrs.bgColor,
                                                            ),
                                                            Text(
                                                              "Clear",
                                                              style:
                                                                  TxtStls.stl2,
                                                            )
                                                          ],
                                                        )),
                                                  ];
                                                },
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              width: size.width * 0.09,
                                              child: PopupMenuButton(
                                                color: Clrs.txtColor,
                                                onSelected: (value) {
                                                  pricol = value;
                                                  String prcl =
                                                      pricol.toString();
                                                  String id = snapshot
                                                      .data!.docs[index]["id"];
                                                  FlagService.updateFlag(
                                                      id, prcl);
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.flag,
                                                  color:
                                                      FlagService.pricolorget(
                                                          flagres),
                                                ),
                                                itemBuilder: (context) {
                                                  return [
                                                    PopupMenuItem(
                                                      value: "U",
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.clear,
                                                              color:
                                                                  Clrs.bgColor,
                                                            ),
                                                            Text(
                                                              "Clear",
                                                              style:
                                                                  TxtStls.stl2,
                                                            )
                                                          ],
                                                        )),
                                                  ];
                                                },
                                              ),
                                            ),
                                      // task status here...
                                      snapshot.data!.docs[index]["status"] == ""
                                          ? Container(
                                              color: StatusUpdateServices
                                                  .statcolorget(newres),
                                              alignment: Alignment.center,
                                              width: size.width * 0.09,
                                              height: size.height * 0.04,
                                              child: PopupMenuButton(
                                                color: Clrs.txtColor,
                                                onSelected: (value) {
                                                  status = value.toString();
                                                  String stat1 =
                                                      status.toString();
                                                  String id = snapshot
                                                      .data!.docs[index]["id"];
                                                  StatusUpdateServices
                                                      .updateStatus(id, stat1);
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  StatusUpdateServices
                                                      .statusget(newsta),
                                                  style: TxtStls.stl1,
                                                ),
                                                itemBuilder: (context) {
                                                  return [
                                                    PopupMenuItem(
                                                      value: "FRESH",
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: wonClr,
                                                        child: Text(
                                                          "FRESH",
                                                          style: TxtStls.stl1,
                                                        ),
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      value: "ASSIGNED",
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: flwClr,
                                                        child: Text(
                                                          "ASSIGNED",
                                                          style: TxtStls.stl1,
                                                        ),
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      value: "CONTACTED",
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: conClr,
                                                        child: Text(
                                                          "CONTACTED",
                                                          style: TxtStls.stl1,
                                                        ),
                                                      ),
                                                    ),
                                                  ];
                                                },
                                              ),
                                            )
                                          : Container(
                                              color: StatusUpdateServices
                                                  .statcolorget(newres),
                                              alignment: Alignment.center,
                                              width: size.width * 0.09,
                                              height: size.height * 0.04,
                                              child: PopupMenuButton(
                                                color: Clrs.txtColor,
                                                onSelected: (value) {
                                                  status = value.toString();
                                                  String stat1 =
                                                      status.toString();
                                                  String id = snapshot
                                                      .data!.docs[index]["id"];
                                                  StatusUpdateServices
                                                      .updateStatus(id, stat1);
                                                  setState(() {});
                                                },
                                                child: Text(
                                                  StatusUpdateServices
                                                      .statusget(newsta),
                                                  style: TxtStls.stl1,
                                                ),
                                                itemBuilder: (context) {
                                                  return [
                                                    PopupMenuItem(
                                                      value: "FRESH",
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: wonClr,
                                                        child: Text(
                                                          "FRESH",
                                                          style: TxtStls.stl1,
                                                        ),
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      value: "ASSIGNED",
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: flwClr,
                                                        child: Text(
                                                          "ASSIGNED",
                                                          style: TxtStls.stl1,
                                                        ),
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      value: "CONTACTED",
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: conClr,
                                                        child: Text(
                                                          "CONTACTED",
                                                          style: TxtStls.stl1,
                                                        ),
                                                      ),
                                                    ),
                                                  ];
                                                },
                                              ),
                                            ),
                                      // more option here....
                                      Container(
                                        alignment: Alignment.center,
                                        width: size.width * 0.09,
                                        child: PopupMenuButton(
                                          color: Clrs.txtColor,
                                          onSelected: (value) {
                                            // check = true;
                                            if (value == "DELETE") {
                                              String id = snapshot
                                                  .data!.docs[index]["id"];
                                              CrudOperations.deleteTask(id);
                                            }
                                            if (value == "MOVE") {
                                              String taskname = snapshot
                                                  .data!.docs[index]["task"];
                                              Timestamp create = snapshot.data!
                                                  .docs[index]["startDate"];
                                              String enddate = snapshot
                                                  .data!.docs[index]["endDate"];

                                              String catstat = snapshot
                                                  .data!.docs[index]["cat"];
                                              String scatstat = newsta;
                                              Color mainclr = neClr;

                                              Color clrRes =
                                                  StatusUpdateServices
                                                      .statcolorget(newres);

                                              String id = snapshot
                                                  .data!.docs[index]["id"];
                                              int f = snapshot.data!.docs[index]
                                                  ["fail"];
                                              int s = snapshot.data!.docs[index]
                                                  ["success"];
                                              Timestamp lastseen = snapshot
                                                  .data!
                                                  .docs[index]["lastseen"];
                                              String company = snapshot.data!
                                                  .docs[index]["companyname"];
                                              List cli = snapshot.data!
                                                  .docs[index]["Certificates"];
                                              String logo = snapshot
                                                  .data!.docs[index]["logo"];
                                              String cname =
                                                  snapshot.data!.docs[index]
                                                          ["CompanyDetails"][0]
                                                      ["contactperson"];
                                              String cemail =
                                                  snapshot.data!.docs[index]
                                                          ["CompanyDetails"][0]
                                                      ["email"];

                                              String cphone =
                                                  snapshot.data!.docs[index]
                                                          ["CompanyDetails"][0]
                                                      ["phone"];

                                              enddate == ""
                                                  ? Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                      backgroundColor: txtColor,
                                                      content: Text(
                                                        "Select End Date",
                                                        style: TxtStls.stl2,
                                                      ),
                                                    ))
                                                  : descBox(
                                                      context,
                                                      taskname,
                                                      create,
                                                      enddate,
                                                      flagres,
                                                      id,
                                                      catstat,
                                                      scatstat,
                                                      mainclr,
                                                      clrRes,
                                                      s,
                                                      f,
                                                      lastseen,
                                                      cli,
                                                      logo,
                                                      company,
                                                      cname,
                                                      cemail,
                                                      cphone,
                                                      cert);
                                            }
                                          },
                                          icon: Icon(
                                            Icons.more_vert_outlined,
                                          ),
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                  value: "DELETE",
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.grey,
                                                      ),
                                                      Text(
                                                        "Delete",
                                                        style: TxtStls.stl2,
                                                      )
                                                    ],
                                                  )),
                                              PopupMenuItem(
                                                  value: "MOVE",
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .arrow_left_outlined,
                                                        color: Colors.grey,
                                                      ),
                                                      Text(
                                                        "Move To",
                                                        style: TxtStls.stl2,
                                                      )
                                                    ],
                                                  )),
                                              PopupMenuItem(
                                                  value: "CANCEL",
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.clear,
                                                        color: Colors.grey,
                                                      ),
                                                      Text(
                                                        "Cancel",
                                                        style: TxtStls.stl2,
                                                      )
                                                    ],
                                                  )),
                                            ];
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : deco(tap1, newlength),
          // Prospect Category
          Row(
            children: [
              tBtn(tap2, "PROSPECT", prosClr, () {
                tap2 = !tap2;
                setState(() {});
              }),
              SizedBox(
                width: Responsive.isSmallScreen(context)
                    ? size.width * 0.005
                    : size.width * 0.005,
              ),
              Text(
                "${prospectlength.toString()}tasks",
                style: TxtStls.stl1,
              ),
            ],
          ),
          tap2
              ? Column(
                  children: [
                    head(),
                    Container(
                      width: size.width * 1,
                      height: size.height * 0.11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          border: Border.all(color: Colors.grey)),
                      child: StreamBuilder(
                        stream: _fireStore
                            .collection("Tasks")
                            .where("Attachments", arrayContains: {
                              "uid": _auth.currentUser!.uid.toString(),
                            })
                            .where("cat", isEqualTo: "PROSPECT")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Container();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (BuildContext context, i) =>
                                  Divider(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                prospectlength = snapshot.data!.docs.length;
                                String flagres =
                                    snapshot.data!.docs[index]["priority"];
                                String prosta =
                                    snapshot.data!.docs[index]["status1"];
                                String prores =
                                    snapshot.data!.docs[index]["status1"];
                                List cert =
                                    snapshot.data!.docs[index]["Attachments"];
                                return Row(
                                  children: [
                                    // Task name here...
                                    InkWell(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        width: size.width * 0.325,
                                        child: Text(
                                          snapshot.data!.docs[index]["task"],
                                          style: TxtStls.stl1,
                                        ),
                                      ),
                                      onTap: () {
                                        //check = false;
                                        String taskname =
                                            snapshot.data!.docs[index]["task"];
                                        Timestamp create = snapshot
                                            .data!.docs[index]["startDate"];
                                        String endDate = snapshot
                                            .data!.docs[index]["endDate"];
                                        String catstat =
                                            snapshot.data!.docs[index]["cat"];
                                        String scatstat = prosta;
                                        Color mainclr = prosClr;
                                        Color clrRes =
                                            StatusUpdateServices.statcolorget1(
                                                prores);

                                        String id =
                                            snapshot.data!.docs[index]["id"];
                                        Timestamp lastseen = snapshot
                                            .data!.docs[index]["lastseen"];
                                        int f =
                                            snapshot.data!.docs[index]["fail"];
                                        int s = snapshot.data!.docs[index]
                                            ["success"];
                                        String company = snapshot
                                            .data!.docs[index]["companyname"];
                                        List cli = snapshot.data!.docs[index]
                                            ["Certificates"];
                                        String logo =
                                            snapshot.data!.docs[index]["logo"];
                                        String cname = snapshot.data!
                                                .docs[index]["CompanyDetails"]
                                            [0]["contactperson"];
                                        String cemail =
                                            snapshot.data!.docs[index]
                                                ["CompanyDetails"][0]["email"];

                                        String cphone =
                                            snapshot.data!.docs[index]
                                                ["CompanyDetails"][0]["phone"];

                                        descBox(
                                            context,
                                            taskname,
                                            create,
                                            endDate,
                                            flagres,
                                            id,
                                            catstat,
                                            scatstat,
                                            mainclr,
                                            clrRes,
                                            s,
                                            f,
                                            lastseen,
                                            cli,
                                            logo,
                                            company,
                                            cname,
                                            cemail,
                                            cphone,
                                            cert);
                                      },
                                    ),
                                    // Task assignee here...
                                    // Container(
                                    //   alignment: Alignment.center,
                                    //   width: size.width * 0.09,
                                    //   child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.center,
                                    //       children: cert
                                    //           .map(
                                    //             (e) => CircleAvatar(
                                    //               backgroundImage:
                                    //                   NetworkImage(e["uid1"]),
                                    //             ),
                                    //           )
                                    //           .toList()),
                                    // ),
                                    //end Date of task here...
                                    snapshot.data!.docs[index]["endDate"] == ""
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: InkWell(
                                                onTap: () {
                                                  String id = snapshot
                                                      .data!.docs[index]["id"];
                                                  MyCalenders.pickEndDate1(
                                                      context,
                                                      id,
                                                      _endDateController);
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.calendar_today_outlined,
                                                )),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: InkWell(
                                              onTap: () {
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                MyCalenders.pickEndDate1(
                                                    context,
                                                    id,
                                                    _endDateController);
                                                setState(() {});
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.clear,
                                                      size: 10,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        String id = snapshot
                                                            .data!
                                                            .docs[index]["id"];
                                                        EndDateOperations
                                                            .updateEdateTask1(
                                                                id);
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ["endDate"],
                                                    style: TxtStls.stl1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                    // task priority flag here....
                                    snapshot.data!.docs[index]["priority"] == ""
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                pricol = value;
                                                String prcl = pricol.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                FlagService.updateFlag(
                                                    id, prcl);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.flag,
                                                color: FlagService.pricolorget(
                                                    flagres),
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "U",
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                pricol = value;
                                                String prcl = pricol.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                FlagService.updateFlag(
                                                    id, prcl);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.flag,
                                                color: FlagService.pricolorget(
                                                    flagres),
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "U",
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                    // task status here...
                                    snapshot.data!.docs[index]["status1"] == ""
                                        ? Container(
                                            color: StatusUpdateServices
                                                .statcolorget1(prores),
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            height: size.height * 0.04,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                status1 = value;
                                                String stat2 =
                                                    status1.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                StatusUpdateServices
                                                    .updateStatus1(id, stat2);
                                                setState(() {});
                                              },
                                              child: Text(
                                                StatusUpdateServices.statusget1(
                                                    prosta),
                                                style: TxtStls.stl1,
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "AVERAGE",
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                      alignment:
                                                          Alignment.center,
                                                      color: avgClr,
                                                      child: Text(
                                                        "  AVERAGE  ",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "  GOOD  ",
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                      alignment:
                                                          Alignment.center,
                                                      color: goodClr,
                                                      child: Text(
                                                        "GOOD",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                ];
                                              },
                                            ),
                                          )
                                        : Container(
                                            color: StatusUpdateServices
                                                .statcolorget1(prores),
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            height: size.height * 0.04,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                status1 = value;
                                                String stat2 =
                                                    status1.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                StatusUpdateServices
                                                    .updateStatus1(id, stat2);
                                                setState(() {});
                                              },
                                              child: Text(
                                                StatusUpdateServices.statusget1(
                                                    prosta),
                                                style: TxtStls.stl1,
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "AVERAGE",
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                      alignment:
                                                          Alignment.center,
                                                      color: avgClr,
                                                      child: Text(
                                                        "  AVERAGE  ",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "  GOOD  ",
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                      alignment:
                                                          Alignment.center,
                                                      color: goodClr,
                                                      child: Text(
                                                        "GOOD",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                ];
                                              },
                                            ),
                                          ),
                                    // more option here....
                                    Container(
                                      alignment: Alignment.center,
                                      width: size.width * 0.09,
                                      child: PopupMenuButton(
                                        color: Clrs.txtColor,
                                        onSelected: (value) {
                                          if (value == "DELETE") {
                                            String id = snapshot
                                                .data!.docs[index]["id"];
                                            CrudOperations.deleteTask(id);
                                          }
                                          if (value == "MOVE") {
                                            String cat = snapshot
                                                .data!.docs[index]["cat"];
                                            String id = snapshot
                                                .data!.docs[index]["id"];
                                            String enddate = snapshot
                                                .data!.docs[index]["endDate"];
                                            snapshot.data!.docs[index]
                                                        ["Certificates"] ==
                                                    []
                                                ? certficateBox(
                                                    context, id, cat, enddate)
                                                : moveBox(
                                                    context, id, cat, enddate);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.more_vert_outlined,
                                        ),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              value: "DELETE",
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.pink[300],
                                                  ),
                                                  Text(
                                                    "Delete",
                                                    style: TxtStls.stl2,
                                                  )
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                                value: "MOVE",
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_left_outlined,
                                                      color: Clrs.bgColor,
                                                    ),
                                                    Text(
                                                      "Move To",
                                                      style: TxtStls.stl2,
                                                    )
                                                  ],
                                                )),
                                            PopupMenuItem(
                                                value: "CANCEL",
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.cancel,
                                                      color: Clrs.bgColor,
                                                    ),
                                                    Text(
                                                      "Cancel",
                                                      style: TxtStls.stl2,
                                                    )
                                                  ],
                                                )),
                                          ];
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : deco(tap2, prospectlength),
          // // In Progress Category
          Row(
            children: [
              tBtn(tap3, "IN PROGRESS", ipClr, () {
                tap3 = !tap3;
                setState(() {});
              }),
              SizedBox(
                width: Responsive.isSmallScreen(context)
                    ? size.width * 0.005
                    : size.width * 0.005,
              ),
              Text(
                "${inprogresslength.toString()}tasks",
                style: TxtStls.stl1,
              ),
            ],
          ),
          tap3
              ? Column(
                  children: [
                    head(),
                    Container(
                      width: size.width,
                      height: size.height * 0.11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          border: Border.all(color: Colors.grey)),
                      child: StreamBuilder(
                        stream: _fireStore
                            .collection("Tasks")
                            .where("Attachments", arrayContains: {
                              "uid": _auth.currentUser!.uid.toString(),
                              "uid1": imageUrl.toString(),
                            })
                            .where("cat", isEqualTo: "IN PROGRESS")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Container();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (BuildContext context, i) =>
                                  Divider(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                inprogresslength = snapshot.data!.docs.length;
                                String flagres =
                                    snapshot.data!.docs[index]["priority"];
                                String insta =
                                    snapshot.data!.docs[index]["status2"];
                                String inres =
                                    snapshot.data!.docs[index]["status2"];
                                List cert =
                                    snapshot.data!.docs[index]["Attachments"];
                                return Row(
                                  children: [
                                    // Task name here...
                                    InkWell(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        width: size.width * 0.325,
                                        child: Text(
                                          snapshot.data!.docs[index]["task"],
                                          style: TxtStls.stl1,
                                        ),
                                      ),
                                      onTap: () {
                                        String taskname =
                                            snapshot.data!.docs[index]["task"];
                                        Timestamp create = snapshot
                                            .data!.docs[index]["startDate"];
                                        String enddate = snapshot
                                            .data!.docs[index]["endDate"];

                                        String catstat =
                                            snapshot.data!.docs[index]["cat"];
                                        String scatstat = insta;
                                        Color mainclr = ipClr;
                                        Color clrRes =
                                            StatusUpdateServices.statcolorget2(
                                                inres);

                                        String id =
                                            snapshot.data!.docs[index]["id"];
                                        Timestamp lastseen = snapshot
                                            .data!.docs[index]["lastseen"];
                                        int f =
                                            snapshot.data!.docs[index]["fail"];
                                        int s = snapshot.data!.docs[index]
                                            ["success"];
                                        String company = snapshot
                                            .data!.docs[index]["companyname"];
                                        List cli = snapshot.data!.docs[index]
                                            ["Certificates"];
                                        String logo =
                                            snapshot.data!.docs[index]["logo"];
                                        String cname = snapshot.data!
                                                .docs[index]["CompanyDetails"]
                                            [0]["contactperson"];
                                        String cemail =
                                            snapshot.data!.docs[index]
                                                ["CompanyDetails"][0]["email"];

                                        String cphone =
                                            snapshot.data!.docs[index]
                                                ["CompanyDetails"][0]["phone"];
                                        List cert = snapshot.data!.docs[index]
                                            ["Attachments"];

                                        descBox(
                                            context,
                                            taskname,
                                            create,
                                            enddate,
                                            flagres,
                                            id,
                                            catstat,
                                            scatstat,
                                            mainclr,
                                            clrRes,
                                            s,
                                            f,
                                            lastseen,
                                            cli,
                                            logo,
                                            company,
                                            cname,
                                            cemail,
                                            cphone,
                                            cert);
                                      },
                                    ),
                                    // Task assignee here...
                                    Container(
                                      alignment: Alignment.center,
                                      width: size.width * 0.09,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: cert
                                              .map(
                                                (e) => CircleAvatar(
                                                  backgroundImage:
                                                      NetworkImage(e["uid1"]),
                                                ),
                                              )
                                              .toList()),
                                    ),

                                    //end Date of task here...
                                    snapshot.data!.docs[index]["endDate"] == ""
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: InkWell(
                                                onTap: () {
                                                  String id = snapshot
                                                      .data!.docs[index]["id"];
                                                  MyCalenders.pickEndDate1(
                                                      context,
                                                      id,
                                                      _endDateController);
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.calendar_today_outlined,
                                                )),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: InkWell(
                                              onTap: () {
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                MyCalenders.pickEndDate1(
                                                    context,
                                                    id,
                                                    _endDateController);
                                                setState(() {});
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.clear,
                                                      size: 10,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        String id = snapshot
                                                            .data!
                                                            .docs[index]["id"];
                                                        EndDateOperations
                                                            .updateEdateTask1(
                                                                id);
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ["endDate"],
                                                    style: TxtStls.stl1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                    // task priority flag here....
                                    snapshot.data!.docs[index]["priority"] == ""
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                pricol = value;
                                                String prcl = pricol.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                FlagService.updateFlag(
                                                    id, prcl);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.flag,
                                                color: FlagService.pricolorget(
                                                    flagres),
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "U",
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                pricol = value;
                                                String prcl = pricol.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                FlagService.updateFlag(
                                                    id, prcl);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.flag,
                                                color: FlagService.pricolorget(
                                                    flagres),
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "U",
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                    // task status here...
                                    snapshot.data!.docs[index]["status2"] == ""
                                        ? Container(
                                            color: StatusUpdateServices
                                                .statcolorget2(inres),
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            height: size.height * 0.04,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                status2 = value;
                                                String stat3 =
                                                    status2.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                StatusUpdateServices
                                                    .updateStatus2(id, stat3);
                                                setState(() {});
                                              },
                                              child: Text(
                                                StatusUpdateServices.statusget2(
                                                    insta),
                                                style: TxtStls.stl1,
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "FOLLOWUP",
                                                    child: Container(
                                                      color: flwClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "FOLLOWUP",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "SPECIFICATION",
                                                    child: Container(
                                                      color: spClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "SPECIFICATION",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "QUOTATION",
                                                    child: Container(
                                                      color: qtoClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "QUOTATION",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                ];
                                              },
                                            ),
                                          )
                                        : Container(
                                            color: StatusUpdateServices
                                                .statcolorget2(inres),
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            height: size.height * 0.04,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                status2 = value;
                                                String stat3 =
                                                    status2.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                StatusUpdateServices
                                                    .updateStatus2(id, stat3);
                                                setState(() {});
                                              },
                                              child: Text(
                                                StatusUpdateServices.statusget2(
                                                    insta),
                                                style: TxtStls.stl1,
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "FOLLOWUP",
                                                    child: Container(
                                                      color: flwClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "FOLLOWUP",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "SPECIFICATION",
                                                    child: Container(
                                                      color: spClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "SPECIFICATION",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "QUOTATION",
                                                    child: Container(
                                                      color: qtoClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "QUOTATION",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                ];
                                              },
                                            ),
                                          ),
                                    // more option here....
                                    Container(
                                      alignment: Alignment.center,
                                      width: size.width * 0.09,
                                      child: PopupMenuButton(
                                        color: Clrs.txtColor,
                                        onSelected: (value) {
                                          if (value == "DELETE") {
                                            String id = snapshot
                                                .data!.docs[index]["id"];
                                            CrudOperations.deleteTask(id);
                                          }
                                          if (value == "MOVE") {
                                            String cat = snapshot
                                                .data!.docs[index]["cat"];
                                            String id = snapshot
                                                .data!.docs[index]["id"];
                                            String enddate = snapshot
                                                .data!.docs[index]["endDate"];
                                            moveBox(context, id, cat, enddate);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.more_vert_outlined,
                                        ),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              value: "DELETE",
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.pink[300],
                                                  ),
                                                  Text(
                                                    "Delete",
                                                    style: TxtStls.stl2,
                                                  )
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                                value: "MOVE",
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_left_outlined,
                                                      color: Clrs.bgColor,
                                                    ),
                                                    Text(
                                                      "Move To",
                                                      style: TxtStls.stl2,
                                                    )
                                                  ],
                                                )),
                                            PopupMenuItem(
                                                value: "CANCEL",
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.cancel,
                                                      color: Clrs.bgColor,
                                                    ),
                                                    Text(
                                                      "Cancel",
                                                      style: TxtStls.stl2,
                                                    )
                                                  ],
                                                )),
                                          ];
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : deco(tap3, inprogresslength),
          // Won Category
          Row(
            children: [
              tBtn(tap5, "WON", wonClr, () {
                tap5 = !tap5;
                setState(() {});
              }),
              SizedBox(
                width: Responsive.isSmallScreen(context)
                    ? size.width * 0.005
                    : size.width * 0.005,
              ),
              Text(
                "${wonlength.toString()} tasks",
                style: TxtStls.stl1,
              ),
            ],
          ),
          tap5
              ? Column(
                  children: [
                    head(),
                    Container(
                      width: size.width,
                      height: size.height * 0.11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          border: Border.all(color: Colors.grey)),
                      child: StreamBuilder(
                        stream: _fireStore
                            .collection("Tasks")
                            .where("Attachments", arrayContains: {
                              "uid": _auth.currentUser!.uid.toString(),
                              "uid1": imageUrl.toString(),
                            })
                            .where("cat", isEqualTo: "WON")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Container();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (BuildContext context, i) =>
                                  Divider(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                wonlength = snapshot.data!.docs.length;
                                String flagres =
                                    snapshot.data!.docs[index]["priority"];
                                String wonsta =
                                    snapshot.data!.docs[index]["status4"];
                                String wonres =
                                    snapshot.data!.docs[index]["status4"];
                                List cert =
                                    snapshot.data!.docs[index]["Attachments"];
                                return Row(
                                  children: [
                                    // Task name here...
                                    InkWell(
                                      onTap: () {
                                        String taskname =
                                            snapshot.data!.docs[index]["task"];
                                        Timestamp create = snapshot
                                            .data!.docs[index]["startDate"];
                                        String enddate = snapshot
                                            .data!.docs[index]["endDate"];

                                        String catstat =
                                            snapshot.data!.docs[index]["cat"];

                                        String scatstat = wonsta;
                                        Color mainclr = wonClr;
                                        Color clrRes =
                                            StatusUpdateServices.statcolorget4(
                                                wonres);
                                        String id =
                                            snapshot.data!.docs[index]["id"];
                                        Timestamp lastseen = snapshot
                                            .data!.docs[index]["lastseen"];
                                        int f =
                                            snapshot.data!.docs[index]["fail"];
                                        int s = snapshot.data!.docs[index]
                                            ["success"];
                                        String company = snapshot
                                            .data!.docs[index]["companyname"];
                                        List cli = snapshot.data!.docs[index]
                                            ["Certificates"];
                                        String logo =
                                            snapshot.data!.docs[index]["logo"];
                                        String cname = snapshot.data!
                                                .docs[index]["CompanyDetails"]
                                            [0]["contactperson"];
                                        String cemail =
                                            snapshot.data!.docs[index]
                                                ["CompanyDetails"][0]["email"];

                                        String cphone =
                                            snapshot.data!.docs[index]
                                                ["CompanyDetails"][0]["phone"];

                                        descBox(
                                            context,
                                            taskname,
                                            create,
                                            enddate,
                                            flagres,
                                            id,
                                            catstat,
                                            scatstat,
                                            mainclr,
                                            clrRes,
                                            s,
                                            f,
                                            lastseen,
                                            cli,
                                            logo,
                                            company,
                                            cname,
                                            cemail,
                                            cphone,
                                            cert);
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        width: size.width * 0.325,
                                        child: Text(
                                          snapshot.data!.docs[index]["task"],
                                          style: TxtStls.stl1,
                                        ),
                                      ),
                                    ),
                                    // Task assignee here...
                                    Container(
                                      alignment: Alignment.center,
                                      width: size.width * 0.09,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: cert
                                              .map(
                                                (e) => CircleAvatar(
                                                  backgroundImage:
                                                      NetworkImage(e["uid1"]),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    //end Date of task here...
                                    snapshot.data!.docs[index]["endDate"] == ""
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: InkWell(
                                                onTap: () {
                                                  String id = snapshot
                                                      .data!.docs[index]["id"];
                                                  MyCalenders.pickEndDate1(
                                                      context,
                                                      id,
                                                      _endDateController);
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.calendar_today_outlined,
                                                )),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: InkWell(
                                              onTap: () {
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                MyCalenders.pickEndDate1(
                                                    context,
                                                    id,
                                                    _endDateController);
                                                setState(() {});
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.clear,
                                                      size: 10,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        String id = snapshot
                                                            .data!
                                                            .docs[index]["id"];
                                                        EndDateOperations
                                                            .updateEdateTask1(
                                                                id);
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ["endDate"],
                                                    style: TxtStls.stl1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                    // task priority flag here....
                                    snapshot.data!.docs[index]["priority"] == ""
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                pricol = value;
                                                String prcl = pricol.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                FlagService.updateFlag(
                                                    id, prcl);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.flag,
                                                color: FlagService.pricolorget(
                                                    flagres),
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "U",
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                pricol = value;
                                                String prcl = pricol.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                FlagService.updateFlag(
                                                    id, prcl);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.flag,
                                                color: FlagService.pricolorget(
                                                    flagres),
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "U",
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                    // task status here...
                                    snapshot.data!.docs[index]["status4"] == ""
                                        ? Container(
                                            color: StatusUpdateServices
                                                .statcolorget4(wonres),
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            height: size.height * 0.04,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                status4 = value;
                                                String stat4 =
                                                    status4.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                StatusUpdateServices
                                                    .updateStatus4(id, stat4);
                                                setState(() {});
                                              },
                                              child: Text(
                                                StatusUpdateServices.statusget4(
                                                    wonsta),
                                                style: TxtStls.stl11,
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "PAYMENT",
                                                    child: Container(
                                                      color: wonClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "PAYMENT",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "DOCUMENTS",
                                                    child: Container(
                                                      color: flwClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "DOCUMENTS",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "SAMPLES",
                                                    child: Container(
                                                      color: goodClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "SAMPLES",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                ];
                                              },
                                            ),
                                          )
                                        : Container(
                                            color: StatusUpdateServices
                                                .statcolorget4(wonres),
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            height: size.height * 0.04,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                status4 = value;
                                                String stat4 =
                                                    status4.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                StatusUpdateServices
                                                    .updateStatus4(id, stat4);
                                                setState(() {});
                                              },
                                              child: Text(
                                                StatusUpdateServices.statusget4(
                                                    wonsta),
                                                style: TxtStls.stl11,
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "PAYMENT",
                                                    child: Container(
                                                      color: wonClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "PAYMENT",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "DOCUMENTS",
                                                    child: Container(
                                                      color: flwClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "DOCUMENTS",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "SAMPLES",
                                                    child: Container(
                                                      color: goodClr,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "SAMPLES",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                ];
                                              },
                                            ),
                                          ),
                                    // more option here....
                                    Container(
                                      alignment: Alignment.center,
                                      width: size.width * 0.09,
                                      child: PopupMenuButton(
                                        color: Clrs.txtColor,
                                        onSelected: (value) {
                                          if (value == "DELETE") {
                                            String id = snapshot
                                                .data!.docs[index]["id"];
                                            CrudOperations.deleteTask(id);
                                          }
                                          if (value == "MOVE") {
                                            String cat = snapshot
                                                .data!.docs[index]["cat"];
                                            String id = snapshot
                                                .data!.docs[index]["id"];
                                            String enddate = snapshot
                                                .data!.docs[index]["endDate"];
                                            moveBox(context, id, cat, enddate);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.more_vert_outlined,
                                        ),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              value: "DELETE",
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.pink[300],
                                                  ),
                                                  Text(
                                                    "Delete",
                                                    style: TxtStls.stl2,
                                                  )
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                                value: "MOVE",
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_left_outlined,
                                                      color: Clrs.bgColor,
                                                    ),
                                                    Text(
                                                      "Move To",
                                                      style: TxtStls.stl2,
                                                    )
                                                  ],
                                                )),
                                            PopupMenuItem(
                                                value: "CANCEL",
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.cancel,
                                                      color: Clrs.bgColor,
                                                    ),
                                                    Text(
                                                      "Cancel",
                                                      style: TxtStls.stl2,
                                                    )
                                                  ],
                                                )),
                                          ];
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : deco(tap5, wonlength),
          // Close Category
          Row(
            children: [
              tBtn(tap6, "CLOSE", clsClr, () {
                tap6 = !tap6;
                setState(() {});
              }),
              SizedBox(
                width: Responsive.isSmallScreen(context)
                    ? size.width * 0.005
                    : size.width * 0.005,
              ),
              Text(
                "${closelength.toString()} tasks",
                style: TxtStls.stl1,
              ),
            ],
          ),
          tap6
              ? Column(
                  children: [
                    head(),
                    Container(
                      width: size.width,
                      height: size.height * 0.11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          border: Border.all(color: Colors.grey)),
                      child: StreamBuilder(
                        stream: _fireStore
                            .collection("Tasks")
                            .where("Attachments", arrayContains: {
                              "uid": _auth.currentUser!.uid.toString(),
                              "uid1": imageUrl.toString(),
                            })
                            .where("cat", isEqualTo: "CLOSE")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Container();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (BuildContext context, i) =>
                                  Divider(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                closelength = snapshot.data!.docs.length;
                                String flagres =
                                    snapshot.data!.docs[index]["priority"];
                                String clsta =
                                    snapshot.data!.docs[index]["status5"];
                                String clres =
                                    snapshot.data!.docs[index]["status5"];
                                List cert =
                                    snapshot.data!.docs[index]["Attachments"];
                                return Row(
                                  children: [
                                    // Task name here...
                                    InkWell(
                                      onTap: () {
                                        String taskname =
                                            snapshot.data!.docs[index]["task"];
                                        Timestamp create = snapshot
                                            .data!.docs[index]["startDate"];
                                        String enddate = snapshot
                                            .data!.docs[index]["endDate"];
                                        String catstat =
                                            snapshot.data!.docs[index]["cat"];
                                        String scatstat = clsta;
                                        Color mainclr = clsClr;
                                        Color clrRes =
                                            StatusUpdateServices.statcolorget5(
                                                clres);
                                        String id =
                                            snapshot.data!.docs[index]["id"];
                                        Timestamp lastseen = snapshot
                                            .data!.docs[index]["lastseen"];
                                        int f =
                                            snapshot.data!.docs[index]["fail"];
                                        int s = snapshot.data!.docs[index]
                                            ["success"];
                                        List cli = snapshot.data!.docs[index]
                                            ["Certificates"];
                                        String logo =
                                            snapshot.data!.docs[index]["logo"];
                                        String company = snapshot
                                            .data!.docs[index]["companyname"];
                                        String cname = snapshot.data!
                                                .docs[index]["CompanyDetails"]
                                            [0]["contactperson"];
                                        String cemail =
                                            snapshot.data!.docs[index]
                                                ["CompanyDetails"][0]["email"];

                                        String cphone =
                                            snapshot.data!.docs[index]
                                                ["CompanyDetails"][0]["phone"];

                                        descBox(
                                            context,
                                            taskname,
                                            create,
                                            enddate,
                                            flagres,
                                            id,
                                            catstat,
                                            scatstat,
                                            mainclr,
                                            clrRes,
                                            s,
                                            f,
                                            lastseen,
                                            cli,
                                            logo,
                                            company,
                                            cname,
                                            cemail,
                                            cphone,
                                            cert);
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        width: size.width * 0.325,
                                        child: Text(
                                          snapshot.data!.docs[index]["task"],
                                          style: TxtStls.stl1,
                                        ),
                                      ),
                                    ),
                                    // Task assignee here...
                                    Container(
                                      alignment: Alignment.center,
                                      width: size.width * 0.09,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: cert
                                              .map(
                                                (e) => CircleAvatar(
                                                  backgroundImage:
                                                      NetworkImage(e["uid1"]),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    //end Date of task here...
                                    snapshot.data!.docs[index]["endDate"] == ""
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: InkWell(
                                                onTap: () {
                                                  String id = snapshot
                                                      .data!.docs[index]["id"];
                                                  MyCalenders.pickEndDate1(
                                                      context,
                                                      id,
                                                      _endDateController);
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.calendar_today_outlined,
                                                )),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: InkWell(
                                              onTap: () {
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                MyCalenders.pickEndDate1(
                                                    context,
                                                    id,
                                                    _endDateController);
                                                setState(() {});
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.clear,
                                                      size: 10,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        String id = snapshot
                                                            .data!
                                                            .docs[index]["id"];
                                                        EndDateOperations
                                                            .updateEdateTask1(
                                                                id);
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ["endDate"],
                                                    style: TxtStls.stl1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                    // task priority flag here....
                                    snapshot.data!.docs[index]["priority"] == ""
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                pricol = value;
                                                String prcl = pricol.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                FlagService.updateFlag(
                                                    id, prcl);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.flag,
                                                color: FlagService.pricolorget(
                                                    flagres),
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "U",
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                pricol = value;
                                                String prcl = pricol.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                FlagService.updateFlag(
                                                    id, prcl);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.flag,
                                                color: FlagService.pricolorget(
                                                    flagres),
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "U",
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                    // task status here...
                                    snapshot.data!.docs[index]["status5"] == ""
                                        ? Container(
                                            color: StatusUpdateServices
                                                .statcolorget5(clres),
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            height: size.height * 0.04,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                status5 = value;
                                                String stat5 =
                                                    status5.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                StatusUpdateServices
                                                    .updateStatus5(id, stat5);
                                                setState(() {});
                                              },
                                              child: Text(
                                                StatusUpdateServices.statusget5(
                                                    clsta),
                                                style: TxtStls.stl1,
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "IRRELEVANT",
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      color: irrClr,
                                                      child: Text(
                                                        "IRRELEVANT",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "BUDGET ISSUE",
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      color: clsClr,
                                                      child: Text(
                                                        "BUDGET ISSUE",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                      value: "INFORMATIVE",
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: flwClr,
                                                        child: Text(
                                                          "INFORMATIVE",
                                                          style: TxtStls.stl1,
                                                        ),
                                                      )),
                                                  PopupMenuItem(
                                                      value: "NO ANSWER",
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: conClr,
                                                        child: Text(
                                                          "NO ANSWER",
                                                          style: TxtStls.stl1,
                                                        ),
                                                      )),
                                                ];
                                              },
                                            ),
                                          )
                                        : Container(
                                            color: StatusUpdateServices
                                                .statcolorget5(clres),
                                            alignment: Alignment.center,
                                            width: size.width * 0.09,
                                            height: size.height * 0.04,
                                            child: PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                status5 = value;
                                                String stat5 =
                                                    status5.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                StatusUpdateServices
                                                    .updateStatus5(id, stat5);
                                                setState(() {});
                                              },
                                              child: Text(
                                                StatusUpdateServices.statusget5(
                                                    clsta),
                                                style: TxtStls.stl1,
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    value: "IRRELEVANT",
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      color: irrClr,
                                                      child: Text(
                                                        "IRRELEVANT",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: "BUDGET ISSUE",
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      color: clsClr,
                                                      child: Text(
                                                        "BUDGET ISSUE",
                                                        style: TxtStls.stl1,
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                      value: "INFORMATIVE",
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: flwClr,
                                                        child: Text(
                                                          "INFORMATIVE",
                                                          style: TxtStls.stl1,
                                                        ),
                                                      )),
                                                  PopupMenuItem(
                                                      value: "NO ANSWER",
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: conClr,
                                                        child: Text(
                                                          "NO ANSWER",
                                                          style: TxtStls.stl1,
                                                        ),
                                                      )),
                                                ];
                                              },
                                            ),
                                          ),
                                    // more option here....
                                    Container(
                                      alignment: Alignment.center,
                                      width: size.width * 0.09,
                                      child: PopupMenuButton(
                                        color: Clrs.txtColor,
                                        onSelected: (value) {
                                          if (value == "DELETE") {
                                            String id = snapshot
                                                .data!.docs[index]["id"];
                                            CrudOperations.deleteTask(id);
                                          }
                                          if (value == "MOVE") {
                                            String cat = snapshot
                                                .data!.docs[index]["cat"];
                                            String id = snapshot
                                                .data!.docs[index]["id"];
                                            String enddate = snapshot
                                                .data!.docs[index]["endDate"];

                                            moveBox(context, id, cat, enddate);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.more_vert_outlined,
                                        ),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              value: "DELETE",
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.pink[300],
                                                  ),
                                                  Text(
                                                    "Delete",
                                                    style: TxtStls.stl2,
                                                  )
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                                value: "MOVE",
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_left_outlined,
                                                      color: Clrs.bgColor,
                                                    ),
                                                    Text(
                                                      "Move To",
                                                      style: TxtStls.stl2,
                                                    )
                                                  ],
                                                )),
                                            PopupMenuItem(
                                                value: "CANCEL",
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.cancel,
                                                      color: Clrs.bgColor,
                                                    ),
                                                    Text(
                                                      "Cancel",
                                                      style: TxtStls.stl2,
                                                    )
                                                  ],
                                                )),
                                          ];
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : deco(tap6, closelength),
        ],
      ),
    );
  }

  descBox(
      BuildContext context,
      taskname,
      Timestamp create,
      enddate,
      flagres,
      id,
      catstat,
      scatstat,
      Color mainclr,
      clrRes,
      s,
      f,
      Timestamp lastseen,
      cli,
      logo,
      company,
      cname,
      cemail,
      cphone,
      cert) {
    Size size = MediaQuery.of(context).size;
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      logo,
      (int _) => ImageElement()..src = logo,
    );
    String createDate = DateFormat('dd-MMM-yy').format(create.toDate());
    String lastview = DateFormat('dd-MMM-yy').format(lastseen.toDate());
    String lastviewTime = DateFormat('hh:mm a').format(lastseen.toDate());
    DateTime dt = DateTime.parse(enddate);
    String deadline = DateFormat('dd-MMM-yy').format(dt);
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      backgroundColor: Colors.white,
      title: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.grey[350],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              taskname,
              style: TxtStls.stl1,
            ),
            IconButton(
              tooltip: "Close Window",
              icon: Icon(Icons.cancel_presentation),
              color: Colors.pink[400],
              onPressed: () {
                UpdateServices.lastseenUpdate(id);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: size.width * 0.85,
            height: size.height * 0.85,
            color: bgColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.08,
                  width: size.width * 0.85,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFEEEEEE),
                    ),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        child: Tooltip(
                          message: "Create Date",
                          child: Container(
                            padding: EdgeInsets.all(9),
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: Lottie.asset(
                                      "assets/Lotties/createdate.json",
                                      fit: BoxFit.fill,
                                    )),
                                Text(createDate, style: TxtStls.stl1),
                              ],
                            ),
                          ),
                        ),
                        onHover: (value) {
                          _isHover[0] = value;
                          setState(() {});
                        },
                        onTap: () {},
                      ),
                      Container(
                        color: Color(0xFFEEEEEE),
                        height: 40,
                        width: 1,
                      ),
                      InkWell(
                        child: Tooltip(
                          message: "End Date",
                          child: Container(
                            padding: EdgeInsets.all(9),
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 35,
                                  child: Lottie.asset(
                                    "assets/Lotties/lastdate.json",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(deadline, style: TxtStls.stl1),
                              ],
                            ),
                          ),
                        ),
                        onHover: (value) {
                          _isHover[1] = value;
                          setState(() {});
                        },
                        onTap: () {},
                      ),
                      Container(
                        color: Color(0xFFEEEEEE),
                        height: 40,
                        width: 1,
                      ),
                      Tooltip(
                        message: "Priority",
                        child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.09,
                            child: Icon(
                              Icons.flag,
                              color: FlagService.pricolorget(flagres),
                            )),
                      ),
                      Container(
                        color: Color(0xFFEEEEEE),
                        height: 40,
                        width: 1,
                      ),
                      InkWell(
                        child: Tooltip(
                          message: "Last Seen",
                          child: Container(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Lottie.asset(
                                        "assets/Lotties/lastseen.json",
                                        fit: BoxFit.fill)),
                                Column(
                                  children: [
                                    Text(lastview, style: TxtStls.stl1),
                                    Text(
                                      lastviewTime,
                                      style: TextStyle(color: bt, fontSize: 15),
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
                      Container(
                        color: Color(0xFFEEEEEE),
                        height: 70,
                        width: 1,
                      ),
                      InkWell(
                          child: Tooltip(
                            message: "Agent",
                            child: Container(
                              padding: EdgeInsets.all(9),
                              width: 200,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 35,
                                    height: 35,
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
                            _isHover[3] = value;
                            setState(() {});
                          },
                          onTap: () {}),
                      Container(
                        color: Color(0xFFEEEEEE),
                        height: 40,
                        width: 1,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Tooltip(
                            message: "Filters",
                            child: Container(
                              padding: EdgeInsets.all(9),
                              width: 200,
                              child: Row(
                                children: [
                                  Lottie.asset("assets/Lotties/filter.json"),
                                  Text("Await", style: TxtStls.stl1)
                                ],
                              ),
                            ),
                          ),
                          onHover: (value) {
                            _isHover[4] = value;
                            setState(() {});
                          }),
                      Container(
                        color: Color(0xFFEEEEEE),
                        height: 40,
                        width: 1,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Tooltip(
                          message: "Current Status",
                          child: Container(
                            padding: EdgeInsets.all(9),
                            width: 125,
                            height: 50,
                            child: SizedBox(
                                child: Lottie.asset("assets/Lotties/live.json",
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        onHover: (value) {
                          _isHover[5] = value;
                          setState(() {});
                        },
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 60 / 2,
                            width: 200,
                            child: Text(
                              catstat,
                              style: TxtStls.stl1,
                            ),
                            color: mainclr,
                          ),
                          SizedBox(height: 5),
                          Container(
                            color: clrRes,
                            alignment: Alignment.center,
                            height: 25,
                            width: 200,
                            child: Text(
                              scatstat,
                              style: TxtStls.stl1,
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 20),
                      Container(
                        color: Color(0xFFEEEEEE),
                        height: 40,
                        width: 1,
                      ),
                      InkWell(
                        child: Tooltip(
                          message: "Statistics",
                          child: Container(
                            alignment: Alignment.center,
                            width: 80,
                            height: 50,
                            child: Lottie.asset("assets/Lotties/stats.json"),
                          ),
                        ),
                        onTap: () {
                          _isStatic = !_isStatic;
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.77,
                  width: size.width * 0.85,
                  color: bgColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          company == ""
                              ? ScaleAnimatedWidget.tween(
                                  duration: Duration(milliseconds: 450),
                                  scaleDisabled: 1.5,
                                  scaleEnabled: 1,
                                  child: Material(
                                    color: Colors.white,
                                    elevation: 80.0,
                                    shadowColor: Colors.white,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      color: Colors.white,
                                      alignment: Alignment.topLeft,
                                      width: size.width * 0.4045,
                                      height: size.height * 0.31,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 25,
                                                  width:
                                                      size.width * 0.4045 / 2.7,
                                                  child: Shimmer.fromColors(
                                                    child: Text(
                                                        "Fill This Details"),
                                                    baseColor: bgColor,
                                                    highlightColor: txtColor,
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 25,
                                                  width:
                                                      size.width * 0.4045 / 1.8,
                                                  child: _isChecked
                                                      ? IconButton(
                                                          icon: Icon(
                                                            Icons.check_box,
                                                            color: Colors.green,
                                                          ),
                                                          onPressed: () {
                                                            _isChecked =
                                                                _isChecked;
                                                            setState(() {});
                                                          },
                                                        )
                                                      : IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .check_box_outline_blank,
                                                            color: Colors.black,
                                                          ),
                                                          onPressed: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              _isChecked =
                                                                  _isChecked;
                                                              Navigator.pop(
                                                                  context);
                                                              eble = !eble;
                                                              eble1 = !eble1;
                                                              eble2 = !eble2;
                                                              eble3 = !eble3;
                                                              ComapnyUpdateServices
                                                                  .updateCompany(
                                                                      id,
                                                                      _comnameController,
                                                                      _comwebController);
                                                            }
                                                            cli.length <= 0
                                                                ? certficateBox(
                                                                    context,
                                                                    id,
                                                                    catstat,
                                                                    enddate)
                                                                : moveBox(
                                                                    context,
                                                                    id,
                                                                    catstat,
                                                                    enddate);

                                                            setState(() {});
                                                          },
                                                        ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: size.width * 0.4,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: size.width * 0.13,
                                                    child: Text("Organisation"),
                                                  ),
                                                  Container(
                                                    color: Color(0xFFE0E0E0),
                                                    height: 40,
                                                    width: 1,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * 0.18,
                                                          height: size.height *
                                                              0.05,
                                                          child: eble
                                                              ? form(
                                                                  _comnameController,
                                                                  (value) {
                                                                  return value.isEmpty ||
                                                                          value.length <
                                                                              6
                                                                      ? "Enter valid Company Name"
                                                                      : "null";
                                                                }, eble)
                                                              : Text(_comnameController
                                                                  .text
                                                                  .toString()),
                                                        ),
                                                        IconButton(
                                                            onPressed:
                                                                () async {
                                                              eble = !eble;
                                                              setState(() {});
                                                            },
                                                            icon: Icon(
                                                              eble
                                                                  ? Icons.check
                                                                  : Icons.edit,
                                                              size: 15,
                                                              color:
                                                                  Colors.grey,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              alignment: Alignment.centerLeft,
                                            ),
                                            Container(
                                              height: size.height * 0.001,
                                              width: size.width * 0.39,
                                              color: Color(0xFFE0E0E0),
                                            ),
                                            Container(
                                              width: size.width * 0.4,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: size.width * 0.13,
                                                    child:
                                                        Text("Company Website"),
                                                  ),
                                                  Container(
                                                    color: Color(0xFFE0E0E0),
                                                    height: 40,
                                                    width: 1,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width:
                                                              size.width * 0.18,
                                                          height: size.height *
                                                              0.05,
                                                          child: eble4
                                                              ? form(
                                                                  _comwebController,
                                                                  (value) {
                                                                  return value.isEmpty ||
                                                                          value.length <
                                                                              6
                                                                      ? "Enter valid Company website"
                                                                      : "null";
                                                                }, eble4)
                                                              : Text(_comwebController
                                                                  .text
                                                                  .toString()),
                                                        ),
                                                        IconButton(
                                                            onPressed:
                                                                () async {
                                                              eble4 = !eble4;
                                                              setState(() {});
                                                            },
                                                            icon: Icon(
                                                              eble4
                                                                  ? Icons.check
                                                                  : Icons.edit,
                                                              size: 15,
                                                              color:
                                                                  Colors.grey,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              alignment: Alignment.centerLeft,
                                            ),
                                            Container(
                                              height: size.height * 0.001,
                                              width: size.width * 0.39,
                                              color: Color(0xFFE0E0E0),
                                            ),
                                            Container(
                                              width: size.width * 0.4,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: size.width * 0.13,
                                                    child:
                                                        Text("Contact Person"),
                                                  ),
                                                  Container(
                                                    color: Color(0xFFE0E0E0),
                                                    height: 40,
                                                    width: 1,
                                                  ),
                                                  cname == ""
                                                      ? Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 8.0,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    size.width *
                                                                        0.18,
                                                                height:
                                                                    size.height *
                                                                        0.05,
                                                                child: eble1
                                                                    ? form(
                                                                        _conpersonController,
                                                                        (value) {
                                                                        return value!.isEmpty
                                                                            ? "Enter Contact Person Name"
                                                                            : null;
                                                                      }, eble1)
                                                                    : Text(_conpersonController
                                                                        .text
                                                                        .toString()),
                                                              ),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    eble1 =
                                                                        !eble1;
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  icon: Icon(
                                                                    eble1
                                                                        ? Icons
                                                                            .check
                                                                        : Icons
                                                                            .edit,
                                                                    size: 15,
                                                                    color: Colors
                                                                        .grey,
                                                                  ))
                                                            ],
                                                          ),
                                                        )
                                                      : Center(
                                                          child: Text(cname
                                                              .toString())),
                                                ],
                                              ),
                                              alignment: Alignment.centerLeft,
                                            ),
                                            Container(
                                              height: size.height * 0.001,
                                              width: size.width * 0.39,
                                              color: Color(0xFFE0E0E0),
                                            ),
                                            Container(
                                              width: size.width * 0.4,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: size.width * 0.13,
                                                    child: Text("Email"),
                                                  ),
                                                  Container(
                                                    color: Color(0xFFE0E0E0),
                                                    height: 40,
                                                    width: 1,
                                                  ),
                                                  cemail == ""
                                                      ? Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 8.0,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    size.width *
                                                                        0.18,
                                                                height:
                                                                    size.height *
                                                                        0.05,
                                                                child: eble2
                                                                    ? form(
                                                                        _commailController,
                                                                        (value) {
                                                                        return value!.isEmpty
                                                                            ? "Enter a valid email"
                                                                            : null;
                                                                      }, eble2)
                                                                    : Text(_commailController
                                                                        .text
                                                                        .toString()),
                                                              ),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    eble2 =
                                                                        !eble2;
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  icon: Icon(
                                                                    eble2
                                                                        ? Icons
                                                                            .check
                                                                        : Icons
                                                                            .edit,
                                                                    size: 15,
                                                                    color: Colors
                                                                        .grey,
                                                                  ))
                                                            ],
                                                          ),
                                                        )
                                                      : Center(
                                                          child: Text(cemail
                                                              .toString())),
                                                ],
                                              ),
                                              alignment: Alignment.centerLeft,
                                            ),
                                            Container(
                                              height: size.height * 0.001,
                                              width: size.width * 0.39,
                                              color: Color(0xFFE0E0E0),
                                            ),
                                            Container(
                                              width: size.width * 0.4,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: size.width * 0.13,
                                                    child: Text("PhoneNumber"),
                                                  ),
                                                  Container(
                                                    color: Color(0xFFE0E0E0),
                                                    height: 40,
                                                    width: 1,
                                                  ),
                                                  cphone == ""
                                                      ? Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 8.0,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    size.width *
                                                                        0.18,
                                                                height:
                                                                    size.height *
                                                                        0.05,
                                                                child: eble3
                                                                    ? form(
                                                                        _comphoController,
                                                                        (value) {
                                                                        return value!.isEmpty
                                                                            ? "Enter a valid PhoneNumber"
                                                                            : null;
                                                                      }, eble3)
                                                                    : Text(_comphoController
                                                                        .text
                                                                        .toString()),
                                                              ),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    eble3 =
                                                                        !eble3;
                                                                    setState(
                                                                      () {},
                                                                    );
                                                                  },
                                                                  icon: Icon(
                                                                    eble3
                                                                        ? Icons
                                                                            .check
                                                                        : Icons
                                                                            .edit,
                                                                    size: 15,
                                                                    color: Colors
                                                                        .grey,
                                                                  )),
                                                            ],
                                                          ),
                                                        )
                                                      : Text(cphone),
                                                ],
                                              ),
                                              alignment: Alignment.centerLeft,
                                            ),
                                            Container(
                                              height: size.height * 0.001,
                                              width: size.width * 0.39,
                                              color: Color(0xFFE0E0E0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(color: txtColor),
                                  alignment: Alignment.topLeft,
                                  width: size.width * 0.4045,
                                  height: size.height * 0.29,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: size.width * 0.4045,
                                        height: size.height * 0.07,
                                        decoration: BoxDecoration(
                                            color: bgColor,
                                            border: Border(
                                              bottom: BorderSide(
                                                width: 1,
                                                color: Color(0xFFEEEEEE),
                                              ),
                                            )),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: size.width * 0.15,
                                              child: Row(
                                                children: [
                                                  Lottie.asset(
                                                      "assets/Lotties/check1.json"),
                                                  Text("Organisation",
                                                      style: TxtStls.stl1)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Color(0xFFE0E0E0),
                                              height: 40,
                                              width: 1,
                                            ),
                                            Container(
                                                width: size.width * 0.21,
                                                child: StreamBuilder(
                                                  stream: _fireStore
                                                      .collection("Tasks")
                                                      .where("id",
                                                          isEqualTo: id)
                                                      .snapshots(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<
                                                                  QuerySnapshot>
                                                              snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Container();
                                                    }
                                                    return ListView.builder(
                                                      itemCount: snapshot
                                                          .data!.docs.length,
                                                      itemBuilder: (_, index) {
                                                        return ListTile(
                                                          leading: SizedBox(
                                                              width: 30,
                                                              height: 30,
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child: HtmlElementView(
                                                                      viewType: snapshot
                                                                          .data!
                                                                          .docs[index]["logo"]))),
                                                          title: Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index][
                                                                  "companyname"],
                                                              style:
                                                                  TxtStls.stl1),
                                                          subtitle: Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ["website"],
                                                              style:
                                                                  TxtStls.stl1),
                                                          trailing: IconButton(
                                                            icon: Icon(
                                                              Icons.edit,
                                                              color: txtColor,
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ))
                                          ],
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Container(
                                        width: size.width * 0.4045,
                                        height: size.height * 0.05,
                                        decoration: BoxDecoration(
                                          color: bgColor,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xFFEEEEEE),
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Lottie.asset(
                                                    "assets/Lotties/check.json",
                                                    fit: BoxFit.fitHeight),
                                                Text("Manage Contacts",
                                                    style: TxtStls.stl1),
                                              ],
                                            ),
                                            TextButton.icon(
                                                onPressed: () {
                                                  addContact(context, id, logo);
                                                  _isCompany = !_isCompany;
                                                  setState(() {});
                                                },
                                                icon: Icon(Icons.add,
                                                    color: txtColor),
                                                label: Text("Add New Contact",
                                                    style: TxtStls.stl1))
                                          ],
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Container(
                                        width: size.width * 0.4045,
                                        height: size.height * 0.17,
                                        color: bgColor,
                                        child: StreamBuilder(
                                          stream: _fireStore
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
                                              physics: ClampingScrollPhysics(),
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (_, index) {
                                                List<dynamic> contactlist =
                                                    snapshot.data!.docs[index]
                                                        ["CompanyDetails"];
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount:
                                                        contactlist.length,
                                                    itemBuilder: (_, i) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: size.width *
                                                                0.315,
                                                            child: Card(
                                                              color: bgColor,
                                                              elevation: 10.0,
                                                              child:
                                                                  ExpansionTile(
                                                                      childrenPadding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              20),
                                                                      textColor:
                                                                          Colors
                                                                              .indigo,
                                                                      iconColor:
                                                                          Colors
                                                                              .indigo,
                                                                      collapsedIconColor:
                                                                          Colors
                                                                              .indigo,
                                                                      leading:
                                                                          Icon(
                                                                        Icons
                                                                            .person_pin,
                                                                        color: Colors
                                                                            .indigo,
                                                                      ),
                                                                      title: Text(
                                                                          contactlist[i]
                                                                              [
                                                                              "contactperson"],
                                                                          style:
                                                                              TxtStls.stl1),
                                                                      children: [
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.call,
                                                                            color:
                                                                                txtColor,
                                                                          ),
                                                                          SizedBox(
                                                                              width: 20),
                                                                          Text(
                                                                              contactlist[i]["phone"],
                                                                              style: TxtStls.stl1)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.email,
                                                                            color:
                                                                                txtColor,
                                                                          ),
                                                                          SizedBox(
                                                                              width: 20),
                                                                          Text(
                                                                              contactlist[i]["email"],
                                                                              style: TxtStls.stl1)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: Icon(
                                                              Icons.delete,
                                                              color: txtColor,
                                                            ),
                                                            onPressed: () {
                                                              _showMyDialog(
                                                                  id,
                                                                  contactlist[
                                                                      i]);
                                                            },
                                                          ),
                                                          IconButton(
                                                            icon: Icon(
                                                              Icons.edit,
                                                              color: txtColor,
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          Container(
                            height: size.height * 0.001,
                            width: size.width * 0.39,
                            color: Color(0xFFE0E0E0),
                          ),
                          Row(
                            children: [
                              Container(
                                height: size.height * 0.20,
                                width: size.width * 0.20,
                                color: bgColor,
                                child: Column(
                                  children: [
                                    Container(
                                        width: size.width * 0.20,
                                        child: Text("Attachments :",
                                            style: TxtStls.stl1)),
                                    Container(
                                      width: size.width * 0.20,
                                      height: size.height * 0.12,
                                      child: StreamBuilder(
                                          stream: _fireStore
                                              .collection("Tasks")
                                              .where("id", isEqualTo: id)
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (!snapshot.hasData) {
                                              return Container(
                                                child: Text("Loading"),
                                              );
                                            }
                                            return ListView.separated(
                                              separatorBuilder: (_, index) =>
                                                  SizedBox(height: 1),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              physics: ClampingScrollPhysics(),
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
                                                            "assets/Logos/pdflogo.png"),
                                                      ),
                                                      title: Text(
                                                        attachments1[i]['name'],
                                                        style: TxtStls.stl1,
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.center,
                                      height: size.height * 0.05,
                                      width: size.width * 0.20,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(color: bgColor))),
                                      child: InkWell(
                                        onTap: () {
                                          FileServices.choosefile(id);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Lottie.asset(
                                                "assets/Lotties/attachments.json"),
                                            Text(
                                              "Browse",
                                              style: TxtStls.stl1,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                height: size.height * 0.20,
                                width: size.width * 0.19,
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(color: bgColor))),
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: ClampingScrollPhysics(),
                                  children: [
                                    Container(
                                      width: size.width * 0.13,
                                      child: Text("Services Obtained :",
                                          style: TxtStls.stl1),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 25.0),
                                      width: size.width * 0.19,
                                      height: size.height * 0.05,
                                      child: Material(
                                        color: grClr,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        child: TextFormField(
                                          validator: (val) {
                                            val!.isEmpty
                                                ? "Enter Certificate Name"
                                                : val;
                                          },
                                          controller: _certificateConroller,
                                          style: TextStyle(color: bgColor),
                                          decoration: InputDecoration(
                                            hintText: "Add Services",
                                            border: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: bgColor),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: txtColor),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                            ),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  CrudOperations
                                                      .certificateUpdate(
                                                    id,
                                                    _certificateConroller,
                                                  );
                                                },
                                                icon: Icon(Icons.check)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: size.width * 0.13,
                                      child: StreamBuilder(
                                          stream: _fireStore
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
                                              physics: ClampingScrollPhysics(),
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
                                                      .map(
                                                          (e) => service(e, id))
                                                      .toList(),
                                                );
                                              },
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: size.height * 0.001,
                            width: size.width * 0.39,
                            color: Color(0xFFE0E0E0),
                          ),
                          catstat == "WON"
                              ? Container(
                                  width: size.width * 0.4,
                                  height: size.height * 0.27,
                                  child: DefaultTabController(
                                    length: 4,
                                    child: Scaffold(
                                      backgroundColor: txtColor,
                                      appBar: AppBar(
                                        backgroundColor: txtColor,
                                        elevation: 0.0,
                                        automaticallyImplyLeading: false,
                                        centerTitle: true,
                                        title: TabBar(
                                          tabs: [
                                            Tab(
                                                child: Text("Advance",
                                                    style: TxtStls.stl2)),
                                            Tab(
                                                child: Text("Government Fee",
                                                    style: TxtStls.stl2)),
                                            Tab(
                                                child: Text("Testing Fee",
                                                    style: TxtStls.stl2)),
                                            Tab(
                                                child: Text("Completion",
                                                    style: TxtStls.stl2)),
                                          ],
                                        ),
                                      ),
                                      body: TabBarView(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 60.0),
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: size.width * 0.05,
                                                      child: Text("Deal Size")),
                                                  SizedBox(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.05,
                                                    child: TextFormField(
                                                      controller:
                                                          _dealsizeController,
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: Colors.white,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.black,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: size.width * 0.05,
                                                      child: Text("Advance")),
                                                  SizedBox(
                                                    width: size.width * 0.1,
                                                    height: size.height * 0.05,
                                                    child: TextFormField(
                                                      controller:
                                                          _advanceController,
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: Colors.white,
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.black,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: size.width * 0.3,
                                                height: size.height * 0.07,
                                                child: Row(
                                                  children: [
                                                    Theme(
                                                      data: ThemeData(
                                                          unselectedWidgetColor:
                                                              bgColor),
                                                      child: Radio(
                                                        activeColor: wonClr,
                                                        value:
                                                            "By JrCompliance",
                                                        groupValue: radioItem1,
                                                        onChanged: (val) {
                                                          radioItem1 =
                                                              val.toString();

                                                          setState(() {});
                                                        },
                                                        toggleable: false,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                        "assets/Logos/circlelogo.png"),
                                                    Text("By JrCompliance")
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: size.width * 0.3,
                                                height: size.height * 0.07,
                                                child: Row(
                                                  children: [
                                                    Theme(
                                                      data: ThemeData(
                                                          unselectedWidgetColor:
                                                              bgColor),
                                                      child: Radio(
                                                        activeColor: wonClr,
                                                        value: "By Client",
                                                        groupValue: radioItem1,
                                                        onChanged: (val) {
                                                          radioItem1 =
                                                              val.toString();
                                                          setState(() {});
                                                        },
                                                        toggleable: false,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: HtmlElementView(
                                                          viewType: logo),
                                                    ),
                                                    Text("By Client")
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: size.width * 0.3,
                                                height: size.height * 0.07,
                                                child: Row(
                                                  children: [
                                                    Theme(
                                                      data: ThemeData(
                                                          unselectedWidgetColor:
                                                              bgColor),
                                                      child: Radio(
                                                        activeColor: wonClr,
                                                        value:
                                                            "By JrCompliance",
                                                        groupValue: radioItem2,
                                                        onChanged: (val) {
                                                          radioItem2 =
                                                              val.toString();
                                                          setState(() {});
                                                        },
                                                        toggleable: false,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                        "assets/Logos/circlelogo.png"),
                                                    Text("By JrCompliance")
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: size.width * 0.3,
                                                height: size.height * 0.07,
                                                child: Row(
                                                  children: [
                                                    Theme(
                                                      data: ThemeData(
                                                          unselectedWidgetColor:
                                                              bgColor),
                                                      child: Radio(
                                                        activeColor: wonClr,
                                                        value: "By Client",
                                                        groupValue: radioItem2,
                                                        onChanged: (val) {
                                                          radioItem2 =
                                                              val.toString();
                                                          setState(() {});
                                                        },
                                                        toggleable: false,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: HtmlElementView(
                                                          viewType: logo),
                                                    ),
                                                    Text("By Client")
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(_dealsizeController.text
                                                  .toString() +
                                              _advanceController.text
                                                  .toString())
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Container(
                        color: Color(0xFFEEEEEE),
                        width: size.width * 0.0005,
                        height: size.height * 0.77,
                      ),
                      company == ""
                          ? Container(
                              alignment: Alignment.center,
                              width: size.width * 0.445,
                              height: size.height * 0.70,
                              child: Lottie.asset("assets/Lotties/empty.json"))
                          : Container(
                              width: size.width * 0.445,
                              height: size.height * 0.70,
                              color: bgColor,
                              child: _isStatic
                                  ? TranslationAnimatedWidget.tween(
                                      translationDisabled: Offset(200, 0),
                                      translationEnabled: Offset(0, 0),
                                      child: OpacityAnimatedWidget.tween(
                                          opacityDisabled: 0,
                                          opacityEnabled: 1,
                                          child: Column(
                                            children: [
                                              Chart(context, s, f),
                                              chart2(context, 0.0, 0.0, 0.0,
                                                  1.0, 0.0, 0.0, 0.0, 11 - 10),
                                            ],
                                          )))
                                  : Scrollbar(
                                      showTrackOnHover: true,
                                      isAlwaysShown: true,
                                      controller: _scrollController,
                                      thickness: 10,
                                      hoverThickness: 10,
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
                                            return ListView.separated(
                                                shrinkWrap: true,
                                                separatorBuilder: (_, i) =>
                                                    Divider(
                                                      height: 10,
                                                      color: Color(0xFFE0E0E0),
                                                    ),
                                                controller: _scrollController,
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  List lr = snapshot.data!
                                                      .docs[index]["Activity"];
                                                  return Column(
                                                    children: [
                                                      Text(
                                                          "First Message : " +
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ["message"],
                                                          style: TxtStls.stl1),
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: lr.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          String statecolor =
                                                              lr[index]["From"];
                                                          String statecolor1 =
                                                              lr[index]["To"];
                                                          String date = DateFormat(
                                                                  'dd-MMMM-yy')
                                                              .format(lr[index]
                                                                      ["When"]
                                                                  .toDate());
                                                          String time = DateFormat(
                                                                  'hh:mm a')
                                                              .format(lr[index]
                                                                      ["When"]
                                                                  .toDate());
                                                          DateTime dt1 =
                                                              DateTime.parse(lr[
                                                                      index]
                                                                  ["LatDate"]);
                                                          String lastDate =
                                                              DateFormat(
                                                                      'dd-MMM-yy')
                                                                  .format(dt1);

                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            child: Card(
                                                              color: bgColor,
                                                              elevation: 10.0,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5.0),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                                child: Text(
                                                                              "MoveDate : " + date,
                                                                              style: TxtStls.stl1,
                                                                            )),
                                                                            Container(child: Text("Time : " + time, style: TxtStls.stl1)),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                60),
                                                                        Container(
                                                                          color:
                                                                              Color(0xFFE0E0E0),
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              1.5,
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                60),
                                                                        Container(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child: Text("EndDate : " + lastDate, style: TxtStls.stl1)),
                                                                        SizedBox(
                                                                            width:
                                                                                60),
                                                                        Container(
                                                                          color:
                                                                              Color(0xFFE0E0E0),
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              1.5,
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                60),
                                                                        Container(
                                                                            alignment: Alignment
                                                                                .centerRight,
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                100,
                                                                            child: lr[index]["Yes"] == true
                                                                                ? Lottie.asset("assets/Lotties/success.json")
                                                                                : Lottie.asset("assets/Lotties/fail.json"))
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      height: size
                                                                              .height *
                                                                          0.001,
                                                                      width: size
                                                                              .width *
                                                                          0.45,
                                                                      color: Color(
                                                                          0xFFE0E0E0),
                                                                    ),
                                                                    Container(
                                                                        alignment:
                                                                            Alignment
                                                                                .centerLeft,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.1,
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                lr[index]["Who"],
                                                                              ),
                                                                            ),
                                                                            Text("FROM : ",
                                                                                style: TxtStls.stl1),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Container(
                                                                                alignment: Alignment.center,
                                                                                width: size.width * 0.12,
                                                                                child: Text(lr[index]["From"], style: TxtStls.stl1),
                                                                                color: FlagService.stateClr(statecolor),
                                                                              ),
                                                                            ),
                                                                            Text("TO : ",
                                                                                style: TxtStls.stl1),
                                                                            Container(
                                                                              alignment: Alignment.center,
                                                                              width: size.width * 0.12,
                                                                              child: Text(lr[index]["To"], style: TxtStls.stl1),
                                                                              color: FlagService.stateClr1(statecolor1),
                                                                            )
                                                                          ],
                                                                        )),
                                                                    Container(
                                                                      height: size
                                                                              .height *
                                                                          0.001,
                                                                      width: size
                                                                              .width *
                                                                          0.45,
                                                                      color: Color(
                                                                          0xFFE0E0E0),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Container(
                                                                        child: Row(
                                                                            children: [
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                                                                            color: lr[index]["Bound"] == "InBound"
                                                                                ? goodClr
                                                                                : avgClr,
                                                                            child:
                                                                                Text(
                                                                              lr[index]["Bound"],
                                                                              style: TxtStls.stl1,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 50),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                                                                            color:
                                                                                Colors.orange,
                                                                            child:
                                                                                Text(lr[index]["Action"], style: TxtStls.stl1),
                                                                          ),
                                                                        ])),
                                                                    Container(
                                                                        alignment:
                                                                            Alignment
                                                                                .centerLeft,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(
                                                                              width: size.width * 0.05,
                                                                              child: Text("Note", style: TxtStls.stl1),
                                                                              alignment: Alignment.centerLeft,
                                                                            ),
                                                                            Container(
                                                                              color: Color(0xFFE0E0E0),
                                                                              height: 40,
                                                                              width: 1,
                                                                            ),
                                                                            Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                padding: EdgeInsets.all(10.0),
                                                                                height: 100,
                                                                                width: size.width * 0.35,
                                                                                child: Text(lr[index]["Note"], style: TxtStls.stl1))
                                                                          ],
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          }),
                                    ),
                            ),
                    ],
                  ),
                ),
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

  // move box here
  moveBox(BuildContext context, id, cat, endDate) {
    Size size = MediaQuery.of(context).size;
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      backgroundColor: txtColor,
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: size.width * 0.20,
            height: size.height * 0.35,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _visible
                  ? TranslationAnimatedWidget.tween(
                      translationDisabled: Offset(_visible ? 25 : 0, 0),
                      translationEnabled: Offset(0, 0),
                      child: OpacityAnimatedWidget.tween(
                        opacityDisabled: 0,
                        opacityEnabled: 1,
                        child: _ismove
                            ? SingleChildScrollView(
                                child: Form(
                                  key: _movekey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2),
                                            child: Text(
                                              radioItem,
                                              style: TxtStls.stl1,
                                            ),
                                            color: radioItem == "InBound"
                                                ? goodClr
                                                : avgClr,
                                          ),
                                          SizedBox(width: 15),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 1),
                                            color: flwClr,
                                            child: radioItem == "InBound"
                                                ? Text(
                                                    _choosenValue!.toString(),
                                                    style: TxtStls.stl1,
                                                  )
                                                : Text(
                                                    _choosenValue1!.toString(),
                                                    style: TxtStls.stl1,
                                                  ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("NOTE :"),
                                            Icon(
                                              Icons.format_bold,
                                              color: bgColor,
                                            ),
                                            Icon(
                                              Icons.format_italic,
                                              color: bgColor,
                                            ),
                                          ]),
                                      SizedBox(height: 10),
                                      TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Note Can't be empty";
                                            }
                                            if (value.length < 15) {
                                              return "Add Appropriate Note";
                                            } else {
                                              return null;
                                            }
                                          },
                                          cursorColor: Colors.indigo,
                                          controller: _momoController,
                                          maxLines: 4,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                          )),
                                      SizedBox(height: 10),
                                      Text("END DATE : " + endDate),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RotatedBox(
                                            quarterTurns: -90,
                                            child: MaterialButton(
                                              elevation: 20.0,
                                              color: Colors.indigo,
                                              onPressed: () {
                                                _visible = !_visible;
                                                setState(() {});
                                              },
                                              child: Icon(Icons
                                                  .arrow_right_alt_outlined),
                                            ),
                                          ),
                                          MaterialButton(
                                            elevation: 20.0,
                                            color: Colors.indigo,
                                            onPressed: () {
                                              if (_movekey.currentState!
                                                  .validate()) {
                                                _ismove = !_ismove;
                                              }
                                              setState(() {});
                                            },
                                            child: Icon(
                                                Icons.arrow_right_alt_outlined),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      CatUpdateServices.updateCat(id);
                                      _ismove = !_ismove;
                                      _visible = !_visible;
                                      GraphValueServices.graph(endDate, id);
                                      String? val = radioItem == "InBound"
                                          ? _choosenValue
                                          : _choosenValue1;
                                      StateUpdateServices.prosUpdate(
                                          id,
                                          cat,
                                          _momoController,
                                          endDate,
                                          radioItem,
                                          val);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Container(
                                        color: prosClr,
                                        alignment: Alignment.center,
                                        width: size.width * 0.09,
                                        height: size.height * 0.04,
                                        child: Text(
                                          "PROSPECT",
                                          style: TxtStls.stl1,
                                        )),
                                  ),
                                  SizedBox(height: 15),
                                  InkWell(
                                    onTap: () {
                                      CatUpdateServices.updateCat1(id);
                                      String? val = radioItem == "InBound"
                                          ? _choosenValue
                                          : _choosenValue1;
                                      StateUpdateServices.InprosUpdate(
                                          id,
                                          cat,
                                          _momoController,
                                          endDate,
                                          radioItem,
                                          val);
                                      _visible = !_visible;
                                      _ismove = !_ismove;
                                      GraphValueServices.graph(endDate, id);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Container(
                                        color: ipClr,
                                        alignment: Alignment.center,
                                        width: size.width * 0.09,
                                        height: size.height * 0.04,
                                        child: Text("IN PROGRESS",
                                            style: TxtStls.stl1)),
                                  ),
                                  SizedBox(height: 15),
                                  InkWell(
                                    onTap: () {
                                      CatUpdateServices.updateCat3(id);
                                      String? val = radioItem == "InBound"
                                          ? _choosenValue
                                          : _choosenValue1;
                                      StateUpdateServices.wonUpdate(
                                          id,
                                          cat,
                                          _momoController,
                                          endDate,
                                          radioItem,
                                          val);
                                      _ismove = !_ismove;
                                      _visible = !_visible;
                                      GraphValueServices.graph(endDate, id);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Container(
                                        color: wonClr,
                                        alignment: Alignment.center,
                                        width: size.width * 0.09,
                                        height: size.height * 0.04,
                                        child:
                                            Text("WON", style: TxtStls.stl1)),
                                  ),
                                  SizedBox(height: 15),
                                  InkWell(
                                    onTap: () {
                                      CatUpdateServices.updateCat4(id);
                                      String? val = radioItem == "InBound"
                                          ? _choosenValue
                                          : _choosenValue1;
                                      StateUpdateServices.closeUpdate(
                                          id,
                                          cat,
                                          _momoController,
                                          endDate,
                                          radioItem,
                                          val);
                                      _ismove = !_ismove;
                                      _visible = !_visible;
                                      GraphValueServices.graph(endDate, id);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Container(
                                        color: clsClr,
                                        alignment: Alignment.center,
                                        width: size.width * 0.09,
                                        height: size.height * 0.04,
                                        child:
                                            Text("CLOSE", style: TxtStls.stl1)),
                                  ),
                                  SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RotatedBox(
                                      quarterTurns: 90,
                                      child: MaterialButton(
                                        elevation: 20.0,
                                        color: Colors.indigo,
                                        onPressed: () {
                                          _ismove = !_ismove;
                                          setState(() {});
                                        },
                                        child: Icon(
                                            Icons.arrow_right_alt_outlined),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      ),
                    )
                  : TranslationAnimatedWidget.tween(
                      translationDisabled: Offset(_visible ? -25 : 0, 0),
                      translationEnabled: Offset(0, 0),
                      child: OpacityAnimatedWidget.tween(
                        opacityDisabled: 0,
                        opacityEnabled: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Action Type :"),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: bgColor, width: 1),
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 6.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: goodClr,
                                    ),
                                    child: Row(
                                      children: [
                                        Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor: bgColor),
                                          child: Radio(
                                            activeColor: txtColor,
                                            value: "InBound",
                                            groupValue: radioItem,
                                            onChanged: (val) {
                                              radioItem = val.toString();
                                              setState(() {});
                                            },
                                            toggleable: true,
                                          ),
                                        ),
                                        Text(
                                          "INBOUND",
                                          style: TxtStls.stl1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: grClr,
                                    width: 1,
                                    height: 40,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: avgClr,
                                    ),
                                    child: Row(
                                      children: [
                                        Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor: bgColor),
                                          child: Radio(
                                            activeColor: txtColor,
                                            value: "OutBound",
                                            groupValue: radioItem,
                                            onChanged: (val) {
                                              radioItem = val.toString();
                                              setState(() {});
                                            },
                                            toggleable: true,
                                          ),
                                        ),
                                        Text(
                                          "OUTBOUND",
                                          style: TxtStls.stl1,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            radioItem == "InBound"
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      width: size.width * 1,
                                      decoration: BoxDecoration(
                                          color: goodClr,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: DropdownButton<String>(
                                        underline: Text(""),
                                        dropdownColor: txtColor,
                                        focusColor: bgColor,
                                        value: _choosenValue,
                                        style: TextStyle(color: txtColor),
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        items: inbounditems
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(color: bgColor),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text(
                                          "--choose your action--",
                                          style: TxtStls.stl1,
                                        ),
                                        onChanged: (value) {
                                          _choosenValue = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      width: size.width * 1,
                                      decoration: BoxDecoration(
                                          color: avgClr,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: DropdownButton<String>(
                                        underline: Text(""),
                                        dropdownColor: txtColor,
                                        focusColor: bgColor,
                                        value: _choosenValue1,
                                        style: TextStyle(color: txtColor),
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        items: outbounditems
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(color: bgColor),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text(
                                          "--choose your action--",
                                          style: TxtStls.stl1,
                                        ),
                                        onChanged: (value) {
                                          _choosenValue1 = value;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 50),
                            radioItem == ""
                                ? Text("Choose Action ")
                                : MaterialButton(
                                    elevation: 20.0,
                                    color: Colors.indigo,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: txtColor,
                                    ),
                                    onPressed: () {
                                      _visible = !_visible;
                                      setState(() {});
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
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

  certficateBox(BuildContext context, id, cat, endDate) {
    Size size = MediaQuery.of(context).size;
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      backgroundColor: txtColor,
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: size.width * 0.20,
            height: size.height * 0.35,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TranslationAnimatedWidget.tween(
                translationDisabled: Offset(_visible ? -25 : 0, 0),
                translationEnabled: Offset(0, 0),
                child: OpacityAnimatedWidget.tween(
                  opacityDisabled: 0,
                  opacityEnabled: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    height: size.height * 0.20,
                    width: size.width * 0.19,
                    child: Column(
                      children: [
                        Container(
                            height: 50,
                            alignment: Alignment.centerLeft,
                            child: Text("Services :")),
                        Material(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: TextFormField(
                            controller: _certificateConroller,
                            style: TextStyle(color: bgColor),
                            decoration: InputDecoration(
                              hintText: "Enter Service name",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: bgColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bgColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    CrudOperations.certificateUpdate(
                                      id,
                                      _certificateConroller,
                                    );
                                  },
                                  icon: Icon(Icons.check)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: size.width * 0.13,
                          height: size.height * 0.15,
                          child: StreamBuilder(
                              stream: _fireStore
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
                                  scrollDirection: Axis.vertical,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List certificates = snapshot
                                        .data!.docs[index]["Certificates"];
                                    String id =
                                        snapshot.data!.docs[index]["id"];
                                    return Wrap(
                                      children: certificates
                                          .map((e) => service(e, id))
                                          .toList(),
                                    );
                                  },
                                );
                              }),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                moveBox(context, id, cat, endDate);
                                setState(() {});
                              },
                              icon: Icon(Icons.arrow_right_alt_outlined),
                              label: Text("Continue")),
                        )
                      ],
                    ),
                  ),
                ),
              ),
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

  Widget form(TextEditingController con, FormFieldValidator val, bool enable) {
    return TextFormField(
      enabled: enable,
      validator: val,
      controller: con,
      decoration: InputDecoration(
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
    );
  }

  Widget comFom(TextEditingController con, FormFieldValidator val, hint) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          validator: val,
          controller: con,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: bgColor),
            hintText: hint,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
          )),
    );
  }

  Widget head() {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey,
      height: size.height * 0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: size.width * 0.325,
            child: const Text(
              "TO DO",
              style: TxtStls.stl1,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: size.width * 0.09,
            child: IconButton(
              icon: const Icon(Icons.person_add_alt_1_outlined),
              onPressed: () {},
              tooltip: "ASSIGNEE",
            ),
          ),
          Container(
            width: size.width * 0.09,
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.calendar_today_outlined),
              onPressed: () {},
              tooltip: "Set DUE DATE",
            ),
          ),
          Container(
            width: size.width * 0.09,
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.flag),
              onPressed: () {},
              tooltip: "PRIORITY",
            ),
          ),
          Container(
            width: size.width * 0.09,
            alignment: Alignment.center,
            child: const Text(
              "STATUS",
              style: TxtStls.stl11,
            ),
          ),
          Container(
              width: size.width * 0.09,
              alignment: Alignment.center,
              child: const Text(
                "ACTIONS",
                style: TxtStls.stl11,
              )),
        ],
      ),
    );
  }

  Widget tBtn(taps, title, clr, _ontap) {
    return RaisedButton.icon(
        elevation: 0.0,
        color: clr,
        onPressed: _ontap,
        icon: taps
            ? const Icon(Icons.arrow_drop_down_outlined)
            : const Icon(Icons.arrow_drop_up_outlined),
        label: Text(
          title,
          style: TxtStls.fieldstyle,
        ));
  }

  Widget service(e, id) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.only(left: 5.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              e,
              style: TxtStls.stl1,
            ),
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                CrudOperations.deleteCertifcate(id, e);
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }

  // Alert Box for task here..
  void taskBox(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var alertDialog = AlertDialog(
      backgroundColor: txtColor,
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            width: Responsive.isSmallScreen(context)
                ? size.width * 0.16
                : size.width * 0.16,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Create New Task"),
                      IconButton(
                        color: Colors.red,
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: grClr,
                      child: TextFormField(
                        cursorColor: neClr,
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Task Name' : null;
                        },
                        controller: _taskController,
                        decoration: const InputDecoration(
                            hintText: "TO DO NAME",
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: bgColor)),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      MyCalenders.pickEndDate(context, _endDateController);
                      setState(() {});
                    },
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: grClr,
                        child: TextFormField(
                          enabled: false,
                          cursorColor: neClr,
                          controller: _endDateController,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today_outlined),
                                onPressed: () {},
                              ),
                              hintText: "18-07-2000",
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: bgColor)),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    elevation: 0.0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    color: Colors.green,
                    child: const Text(
                      "Create",
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
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

  Widget deco(bool _taps, int length) {
    Size size = MediaQuery.of(context).size;
    if (length == 0) {
      return Container(
        width: size.width,
        height: size.height * 0.15,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        alignment: Alignment.center,
        child: Lottie.asset("assets/Lotties/notask.json"),
      );
    } else if (length > 0 && length <= 10) {
      return Container(
          width: size.width,
          height: size.height * 0.15,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          alignment: Alignment.center,
          child: Lottie.asset("assets/Lotties/chillwork.json"));
    } else if (length >= 10 && length <= 20) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: size.width,
              height: size.height * 0.15,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              alignment: Alignment.center,
              child: Lottie.asset("assets/Lotties/normalwork.json")),
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: size.width,
              height: size.height * 0.15,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              alignment: Alignment.center,
              child: Lottie.asset("assets/Lotties/highworkpressure.json")),
        ),
      );
    }
  }

  addContact(BuildContext context, id, logo) {
    Size size = MediaQuery.of(context).size;
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      backgroundColor: txtColor,
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            color: Colors.blueAccent[100],
            width: size.width * 0.175,
            height: size.height * 0.35,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Contact Person Name")),
                    Material(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: txtColor,
                        child: form(_conpersonController, (value) {
                          return value.isEmpty ? "Enter valid  Name" : null;
                        }, true)),
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment.topLeft, child: Text("Email id")),
                    Material(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: txtColor,
                        child: form(_commailController, (value) {
                          return value.isEmpty ? "Enter valid  Name" : null;
                        }, true)),
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Phone Number")),
                    Material(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: txtColor,
                        child: form(_comphoController, (value) {
                          return value.isEmpty || value.length < 10
                              ? "Enter valid  Name"
                              : null;
                        }, true)),
                    SizedBox(height: 10),
                    MaterialButton(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.lightBlue,
                      child: Text("ADD"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ComapnyUpdateServices.addMoreContacts(
                              id,
                              _conpersonController,
                              _commailController,
                              _comphoController);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) {
          return alertDialog;
        });
  }

  Future<void> _showMyDialog(id, element) async {
    return showDialog<void>(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: txtColor,
          title: const Text('Are you sure to Delete ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Once you delete can not retrive it!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                ComapnyUpdateServices.removeContact(id, element);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
