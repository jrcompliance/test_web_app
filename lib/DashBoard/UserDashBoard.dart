import 'dart:html' show ImageElement;
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_web_app/Constants/CountUp.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/UserModels.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/tasklength.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  int? chartval = 1;
  int? duelistval = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.userTasks(imageUrl);
    this.userTasks1(imageUrl);
    this.userTasks2(imageUrl);
    this.userTasks3(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AbgColor.withOpacity(0.0001),
      width: size.width,
      height: size.height * 0.93,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: Responsive.isMediumScreen(context)
                    ? size.width * 0.18
                    : size.width * 0.2,
                height: size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      maxRadius: 30.0,
                      child: Image.asset("assets/Logos/4.png"),
                      backgroundColor: Colors.blueAccent.withOpacity(0.1),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        prospectLength == null
                            ? Text("0+", style: TxtStls.numstyle)
                            : Row(
                                children: [
                                  Countup(
                                    end: prospectLength!.toDouble(),
                                    begin: 0,
                                    style: TxtStls.numstyle,
                                  ),
                                  Text(
                                    "+",
                                    style: TxtStls.numstyle,
                                  )
                                ],
                              ),
                        Text("PROSPECT", style: TxtStls.fieldstyle)
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: Responsive.isMediumScreen(context)
                    ? size.width * 0.18
                    : size.width * 0.2,
                height: size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      maxRadius: 30.0,
                      child: Image.asset("assets/Logos/1.png"),
                      backgroundColor: Colors.orangeAccent.withOpacity(0.1),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        prospectLength == null
                            ? Text("0+", style: TxtStls.numstyle)
                            : Row(
                                children: [
                                  Countup(
                                    end: newLength!.toDouble(),
                                    begin: 0,
                                    style: TxtStls.numstyle,
                                  ),
                                  Text(
                                    "+",
                                    style: TxtStls.numstyle,
                                  )
                                ],
                              ),
                        Text("NEW LEADS", style: TxtStls.fieldstyle)
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: Responsive.isMediumScreen(context)
                    ? size.width * 0.18
                    : size.width * 0.2,
                height: size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      maxRadius: 30.0,
                      child: Center(
                        child: Image.asset("assets/Logos/2.png",
                            fit: BoxFit.fill,
                            filterQuality: FilterQuality.high),
                      ),
                      backgroundColor: Colors.yellowAccent.withOpacity(0.1),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        prospectLength == null
                            ? Text("0+", style: TxtStls.numstyle)
                            : Row(
                                children: [
                                  Countup(
                                    end: ipLength!.toDouble(),
                                    begin: 0,
                                    style: TxtStls.numstyle,
                                  ),
                                  Text(
                                    "+",
                                    style: TxtStls.numstyle,
                                  )
                                ],
                              ),
                        Text("IN PROGRESS", style: TxtStls.fieldstyle)
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: Responsive.isMediumScreen(context)
                    ? size.width * 0.18
                    : size.width * 0.2,
                height: size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      maxRadius: 30.0,
                      child: Image.asset("assets/Logos/3.png",
                          fit: BoxFit.fill, filterQuality: FilterQuality.high),
                      backgroundColor: btnColor.withOpacity(0.1),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        prospectLength == null
                            ? Text("0+", style: TxtStls.numstyle)
                            : Row(
                                children: [
                                  Countup(
                                    end: wonLength!.toDouble(),
                                    begin: 0,
                                    style: TxtStls.numstyle,
                                  ),
                                  Text(
                                    "+",
                                    style: TxtStls.numstyle,
                                  )
                                ],
                              ),
                        Text("WON", style: TxtStls.fieldstyle)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  alignment: Alignment.center,
                  width: Responsive.isMediumScreen(context)
                      ? size.width * 0.48
                      : size.width * 0.5,
                  height: size.height * 0.4,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Reports", style: TxtStls.fieldtitlestyle),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz_rounded)),
                          ],
                        ),
                      )
                    ],
                  )),
              Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  alignment: Alignment.center,
                  width: Responsive.isMediumScreen(context)
                      ? size.width * 0.28
                      : size.width * 0.3,
                  height: size.height * 0.4,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            showtitle1(chartval),
                            PopupMenuButton(
                              offset: Offset(0, 32),
                              elevation: 10.0,
                              shape: TooltipShape(),
                              icon: Icon(
                                Icons.more_horiz,
                              ),
                              onSelected: (int value) {
                                chartval = value;
                                setState(() {});
                              },
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 4,
                                    child: Text(
                                      "Leads",
                                      style: TxtStls.fieldstyle,
                                    ),
                                  ),
                                  PopupMenuItem(
                                      value: 5,
                                      child: Text(
                                        "Transactions",
                                        style: TxtStls.fieldstyle,
                                      )),
                                ];
                              },
                            )
                          ],
                        ),
                      ),
                      showchart(chartval, size),
                      showbottom(chartval),
                    ],
                  )),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: size.width * 0.25,
                height: size.height * 0.06,
                child: Text("PI -Amount", style: TxtStls.numstyle),
              ),
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: size.width * 0.25,
                height: size.height * 0.06,
                child: Text("Q -Amount", style: TxtStls.numstyle),
              ),
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: size.width * 0.25,
                height: size.height * 0.06,
                child: Text("Invoice -Amount", style: TxtStls.numstyle),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  alignment: Alignment.center,
                  width: Responsive.isMediumScreen(context)
                      ? size.width * 0.48
                      : size.width * 0.5,
                  height: size.height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Recent Interactions",
                                style: TxtStls.fieldtitlestyle),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz_rounded)),
                          ],
                        ),
                      )
                    ],
                  )),
              Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  alignment: Alignment.center,
                  width: Responsive.isMediumScreen(context)
                      ? size.width * 0.28
                      : size.width * 0.3,
                  height: size.height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            showtitle(duelistval),
                            PopupMenuButton(
                              offset: Offset(0, 32),
                              elevation: 10.0,
                              shape: TooltipShape(),
                              icon: Icon(
                                Icons.more_horiz,
                              ),
                              onSelected: (int value) {
                                duelistval = value;
                                setState(() {});
                              },
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 1,
                                    child: Text(
                                      "Today's Duelist",
                                      style: TxtStls.fieldstyle,
                                    ),
                                  ),
                                  PopupMenuItem(
                                      value: 2,
                                      child: Text(
                                        "Outdated List",
                                        style: TxtStls.fieldstyle,
                                      )),
                                  PopupMenuItem(
                                    value: 3,
                                    child: Text(
                                      "Tommorrow's Duelist",
                                      style: TxtStls.fieldstyle,
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 0.23,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Tasks")
                              .where("Attachments", arrayContains: {
                                "uid": _auth.currentUser!.uid.toString(),
                                "uid1": imageUrl.toString(),
                              })
                              .where("endDate", isEqualTo: showLead(duelistval))
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
                              separatorBuilder: (_, i) => SizedBox(height: 5.0),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                String logo =
                                    snapshot.data!.docs[index]["logo"];
                                // ignore: undefined_prefixed_name
                                ui.platformViewRegistry.registerViewFactory(
                                  logo,
                                  (int _) => ImageElement()..src = logo,
                                );
                                return ListTile(
                                  leading: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: HtmlElementView(
                                            viewType: logo,
                                          ))),
                                  title: Text(
                                      snapshot.data!.docs[index]["task"],
                                      style: TxtStls.fieldtitlestyle),
                                  subtitle: Text(
                                    snapshot.data!.docs[index]["CompanyDetails"]
                                        [0]["email"],
                                    style: TxtStls.fieldstyle,
                                  ),
                                  trailing: Icon(Icons.arrow_forward),
                                  onTap: () {},
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  showtitle1(cval) {
    if (cval == 5) {
      return Text(
        "Transactions",
        style: TxtStls.fieldtitlestyle,
      );
    }
    return Text(
      "Leads Analytics",
      style: TxtStls.fieldtitlestyle,
    );
  }

  showbottom(cval) {
    if (cval == 5) {
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.circle,
                color: Colors.blueAccent.withOpacity(0.75),
                size: 15,
              ),
              label: Text(
                "Prospect",
                style: TxtStls.fieldstyle,
              )),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.circle,
                color: Colors.orangeAccent.withOpacity(0.75),
                size: 15,
              ),
              label: Text(
                "New",
                style: TxtStls.fieldstyle,
              )),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.circle,
                color: Colors.yellowAccent.withOpacity(0.75),
                size: 15,
              ),
              label: Text(
                "InProgress",
                style: TxtStls.fieldstyle,
              )),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.circle,
                color: btnColor.withOpacity(0.75),
                size: 15,
              ),
              label: Text(
                "Won",
                style: TxtStls.fieldstyle,
              )),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.circle,
              color: Colors.blueAccent.withOpacity(0.75),
              size: 15,
            ),
            label: Text(
              "Prospect",
              style: TxtStls.fieldstyle,
            )),
        TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.circle,
              color: Colors.orangeAccent.withOpacity(0.75),
              size: 15,
            ),
            label: Text(
              "New",
              style: TxtStls.fieldstyle,
            )),
        TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.circle,
              color: Colors.yellowAccent.withOpacity(0.75),
              size: 15,
            ),
            label: Text(
              "InProgress",
              style: TxtStls.fieldstyle,
            )),
        TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.circle,
              color: btnColor.withOpacity(0.75),
              size: 15,
            ),
            label: Text(
              "Won",
              style: TxtStls.fieldstyle,
            )),
      ],
    );
  }

  showchart(cval, size) {
    if (cval == 5) {
      return Container(
        height: size.height * 0.3,
        width: size.width * 0.28,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(touchCallback: (clickResponse) {
              if (clickResponse.clickHappened) {}
            }),
            sectionsSpace: 0,
            centerSpaceRadius: 50,
            startDegreeOffset: -50,
            sections: [
              PieChartSectionData(
                color: Colors.blueAccent.withOpacity(0.75),
                value: 178,
                showTitle: true,
                radius: 19,
              ),
              PieChartSectionData(
                color: Colors.orangeAccent.withOpacity(0.75),
                value: 20,
                showTitle: true,
                radius: 22,
              ),
              PieChartSectionData(
                color: Colors.yellowAccent.withOpacity(0.75),
                value: 198,
                showTitle: true,
                radius: 19,
              ),
              PieChartSectionData(
                color: btnColor.withOpacity(0.75),
                value: 12,
                showTitle: true,
                radius: 22,
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      height: size.height * 0.3,
      width: size.width * 0.28,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(touchCallback: (clickResponse) {
            if (clickResponse.clickHappened) {}
          }),
          sectionsSpace: 0,
          centerSpaceRadius: 80,
          startDegreeOffset: -60,
          sections: [
            PieChartSectionData(
              color: Colors.blueAccent.withOpacity(0.75),
              value: prospectLength == null ? 0 : prospectLength!.toDouble(),
              showTitle: true,
              radius: 25,
            ),
            PieChartSectionData(
              color: Colors.orangeAccent.withOpacity(0.75),
              value: newLength == null ? 0 : newLength!.toDouble(),
              showTitle: true,
              radius: 30,
            ),
            PieChartSectionData(
              color: Colors.yellowAccent.withOpacity(0.75),
              value: ipLength == null ? 0 : ipLength!.toDouble(),
              showTitle: true,
              radius: 25,
            ),
            PieChartSectionData(
              color: btnColor.withOpacity(0.75),
              value: wonLength == null ? 0 : wonLength!.toDouble(),
              showTitle: true,
              radius: 30,
            ),
          ],
        ),
      ),
    );
  }

  showtitle(dval) {
    if (dval == 1) {
      return Text(
        "Today's Duelist",
        style: TxtStls.fieldtitlestyle,
      );
    } else if (dval == 2) {
      return Text(
        "OutDated Leads",
        style: TxtStls.fieldtitlestyle,
      );
    } else if (dval == 3) {
      return Text(
        "Tommorrow's Duelist",
        style: TxtStls.fieldtitlestyle,
      );
    }
  }

  showLead(dval) {
    if (dval == 1) {
      return DateTime.now().toString().split(" ")[0];
    } else if (dval == 2) {
      return DateTime.now()
          .subtract(Duration(days: 1))
          .toString()
          .split(" ")[0];
    } else if (dval == 3) {
      return DateTime.now().add(Duration(days: 1)).toString().split(" ")[0];
    }
  }

  Future<void> userTasks(img) async {
    fireStore
        .collection("Tasks")
        .where("Attachments", arrayContains: {
          "uid": _auth.currentUser!.uid.toString(),
          "uid1": img.toString(),
        })
        .get()
        .then((value) {
          prospectLength = value.docs.length.toDouble();
          setState(() {});
        });
  }

  Future<void> userTasks1(img) async {
    fireStore
        .collection("Tasks")
        .where("Attachments", arrayContains: {
          "uid": _auth.currentUser!.uid.toString(),
          "uid1": img.toString(),
        })
        .get()
        .then((value) {
          newLength = value.docs.length.toDouble();
          setState(() {});
        });
  }

  Future<void> userTasks2(img) async {
    fireStore
        .collection("Tasks")
        .where("Attachments", arrayContains: {
          "uid": _auth.currentUser!.uid.toString(),
          "uid1": img.toString(),
        })
        .get()
        .then((value) {
          ipLength = value.docs.length.toDouble();
          setState(() {});
        });
  }

  Future<void> userTasks3(img) async {
    fireStore
        .collection("Tasks")
        .where("Attachments", arrayContains: {
          "uid": _auth.currentUser!.uid.toString(),
          "uid1": img.toString(),
        })
        .get()
        .then((value) {
          wonLength = value.docs.length.toDouble();
          setState(() {});
        });
  }
}

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
