import 'dart:html';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_web_app/Constants/reusable.dart';

class TaskPreview extends StatefulWidget {
  const TaskPreview({Key? key}) : super(key: key);

  @override
  _TaskPreviewState createState() => _TaskPreviewState();
}

class _TaskPreviewState extends State<TaskPreview> {
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _list = ["List", "Board", "Timeline"];
  List<String> _boardtitlelist = [
    "NEW",
    "PROSPECT",
    "INPROGRESS",
    "WON",
    "CLOSE"
  ];
  List _clrslist = [neClr, prosClr, ipClr, wonClr, clsClr];
  List<String> _titlelist = [
    "Check Box",
    "Task Name",
    "Start Date",
    "End Date",
    "Members",
    "Status",
    "Actions"
  ];
  String activeid = "List";
  int i = 1;
  bool _isCheck = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AbgColor.withOpacity(0.0001),
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: bgColor.withOpacity(0.0001),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              height: size.height * 0.07,
              alignment: Alignment.center,
              child: Row(
                children: _list.map((e) => newMethod(e, i++, () {})).toList(),
              )),
          SizedBox(height: 10.0),
          if (activeid == "List")
            Container(
              height: size.height * 0.845,
              child: Scrollbar(
                controller: _scrollController,
                isAlwaysShown: true,
                showTrackOnHover: true,
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      padding: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: bgColor,
                      ),
                      width: size.width,
                      height: size.height * 0.3,
                      child: Column(
                        children: [
                          listtitle("NEW"),
                          SizedBox(height: 30.0),
                          listheader(),
                          SizedBox(height: 30.0),
                          listmiddle(),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      padding: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: bgColor,
                      ),
                      width: size.width,
                      height: size.height * 0.3,
                      child: Column(
                        children: [
                          listtitle("PROSPECT"),
                          SizedBox(height: 30.0),
                          listheader(),
                          SizedBox(height: 30.0),
                          listmiddle(),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      padding: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: bgColor,
                      ),
                      width: size.width,
                      height: size.height * 0.3,
                      child: Column(
                        children: [
                          listtitle("INPROGRESS"),
                          SizedBox(height: 30.0),
                          listheader(),
                          SizedBox(height: 30.0),
                          listmiddle(),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      padding: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: bgColor,
                      ),
                      width: size.width,
                      height: size.height * 0.3,
                      child: Column(
                        children: [
                          listtitle("WON"),
                          SizedBox(height: 30.0),
                          listheader(),
                          SizedBox(height: 30.0),
                          listmiddle(),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      padding: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: bgColor,
                      ),
                      width: size.width,
                      height: size.height * 0.3,
                      child: Column(
                        children: [
                          listtitle("CLOSE"),
                          SizedBox(height: 30.0),
                          listheader(),
                          SizedBox(height: 30.0),
                          listmiddle(),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
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
                          boardmiddle("INPROGRESS")
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
            Container(
              color: txtColor,
              height: size.height * 0.845,
            ),
        ],
      ),
    );
  }

  Widget newMethod(e, i, callack) {
    return RaisedButton(
      elevation: 0.0,
      color: activeid == e ? btnColor : bgColor,
      onPressed: () {
        setState(() => activeid = e);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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

  Widget listtitle(title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TxtStls.fieldtitlestyle,
        ),
        Text("See More")
      ],
    );
  }

  Widget listheader() {
    return Row(
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
    );
  }

  Widget listmiddle() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Tasks")
            .where("endDate", isEqualTo: "2021-12-01")
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
          return ListView.separated(
            separatorBuilder: (_, i) => SizedBox(height: 5.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
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
                    child: Checkbox(
                        value: _isCheck,
                        onChanged: (value) {
                          setState(() {
                            _isCheck = !_isCheck;
                          });
                        },
                        activeColor: btnColor),
                  ),
                  Container(
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
                            snapshot.data!.docs[index]["task"],
                            style: ClrStls.tnClr,
                          ),
                        ],
                      )),
                  Container(
                    width: 247,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      snapshot.data!.docs[index]["startDate"]
                          .toDate()
                          .toString()
                          .split(" ")[0],
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
                      child: Text("5 Members", style: TxtStls.fieldstyle)),
                  Container(
                    width: 200,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text("pending",
                          style: TextStyle(
                              fontSize: 12.5,
                              color: bgColor,
                              letterSpacing: 0.2)),
                      color: neClr,
                    ),
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
                              Icons.delete,
                              size: 12.5,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          ),
                          backgroundColor: Colors.red.withOpacity(0.075),
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
            fontSize: 17.5,
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
              String logo = snapshot.data!.docs[index]["logo"];
              // ignore: undefined_prefixed_name
              ui.platformViewRegistry.registerViewFactory(
                logo,
                (int _) => ImageElement()..src = logo,
              );
              return Padding(
                padding: const EdgeInsets.all(4.0),
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
                            Checkbox(
                              value: _isCheck,
                              onChanged: (value) {
                                _isCheck = !_isCheck;
                                setState(() {});
                              },
                              activeColor: btnColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
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
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: ipClr,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              width: 100,
                              child: Text(
                                "LOW",
                                style: TxtStls.fieldstyle,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  color: Colors.yellow),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              width: 100,
                              child: Text(
                                "On Track",
                                style: TxtStls.fieldstyle,
                              ),
                            ),
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
                              onPressed: () {},
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
}
