import 'dart:html';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:test_web_app/DashBoard/DetailsBox.dart';

class TaskPreview extends StatefulWidget {
  const TaskPreview({Key? key}) : super(key: key);

  @override
  _TaskPreviewState createState() => _TaskPreviewState();
}

class _TaskPreviewState extends State<TaskPreview> {
  final ScrollController _scrollController = ScrollController();
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
    "Start Date",
    "End Date",
    "Members",
    "Status",
    "Actions"
  ];
  final List<bool> _tapslist = [true, true, true, true, true];
  String activeid = "List";
  bool isChecked = false;

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
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            child: Container(
              color: bgColor,
              width: 266,
              child: Row(
                children: _list.map((e) => newMethod(e, () {})).toList(),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          if (activeid == "List")
            Container(
              height: size.height * 0.845,
              child: ListView(
                controller: _scrollController,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
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
                      physics: ClampingScrollPhysics(),
                      controller: _scrollController,
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
            .where("Attachments", arrayContains: {
              "uid": _auth.currentUser!.uid.toString(),
            })
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
          return Scrollbar(
            controller: _scrollController,
            isAlwaysShown: true,
            showTrackOnHover: true,
            child: ListView.separated(
              separatorBuilder: (_, i) => SizedBox(height: 5.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                String id = snapshot.data!.docs[index]["id"];
                String taskname = snapshot.data!.docs[index]["task"];
                Timestamp startDate = snapshot.data!.docs[index]["startDate"];
                String endDate = snapshot.data!.docs[index]["endDate"];
                String priority = snapshot.data!.docs[index]["priority"];
                Timestamp lastseen = snapshot.data!.docs[index]["lastseen"];

                String cat = snapshot.data!.docs[index]["cat"];
                String newsta = snapshot.data!.docs[index]["status"];
                String prosta = snapshot.data!.docs[index]["status1"];
                String insta = snapshot.data!.docs[index]["status2"];
                String wonsta = snapshot.data!.docs[index]["status4"];
                String clsta = snapshot.data!.docs[index]["status5"];
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
                      width: 240,
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
                      ),
                    ),
                    InkWell(
                      child: Container(
                          width: 255,
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
                      onTap: () {
                        detailspopBox(context, id, taskname, startDate, endDate,
                            priority, lastseen, cat);
                      },
                    ),
                    Container(
                      width: 247,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        startDate.toDate().toString().split(" ")[0],
                        style: TxtStls.fieldstyle,
                      ),
                    ),
                    Container(
                        width: 240,
                        alignment: Alignment.centerLeft,
                        child: Text(snapshot.data!.docs[index]["endDate"],
                            style: ClrStls.endClr)),
                    Container(
                        width: 240,
                        alignment: Alignment.centerLeft,
                        child: Text(
                            snapshot.data!.docs[index]["Attachments"].length
                                .toString(),
                            style: TxtStls.fieldstyle)),
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
                                Icons.edit,
                                size: 12.5,
                                color: btnColor,
                              ),
                              onPressed: () {},
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
                                Scaffold.of(context).openEndDrawer();
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
            ),
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
            .where("Attachments", arrayContains: {
              "uid": _auth.currentUser!.uid.toString(),
            })
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
}
