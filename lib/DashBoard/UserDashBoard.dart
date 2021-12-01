import 'dart:html' show ImageElement;
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_web_app/Constants/CountUp.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:test_web_app/Constants/tasklength.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int chartval = 4;
  int duelistval = 1;

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
                        newLength == null
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
                        ipLength == null
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
                        wonLength == null
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
                            PopupMenuButton(
                              offset: Offset(0, 32),
                              elevation: 10.0,
                              shape: TooltipShape(),
                              icon: Icon(
                                Icons.more_horiz,
                              ),
                              onSelected: (int value) {},
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
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: size.height * 0.3,
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              title: ChartTitle(
                                  text: 'Half yearly sales analysis',
                                  textStyle: TxtStls.fieldstyle),
                              // Enable legend
                              legend: Legend(isVisible: true),
                              // Enable tooltip

                              series: <LineSeries<SalesData, String>>[
                                LineSeries<SalesData, String>(
                                    dataSource: <SalesData>[
                                      SalesData('Jan', 35),
                                      SalesData('Feb', 28),
                                      SalesData('Mar', 34),
                                      SalesData('Apr', 32),
                                      SalesData('May', 40)
                                    ],
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        sales.sales,
                                    // Enable data label
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true))
                              ]))
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
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 0.3,
                        width: size.width * 0.28,
                        child: showbody(chartval),
                      ),
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
                            PopupMenuButton(
                              offset: Offset(0, 32),
                              elevation: 10.0,
                              shape: TooltipShape(),
                              icon: Icon(
                                Icons.more_horiz,
                              ),
                              onSelected: (int value) {},
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
                            ),
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
                              .where("endDate", isEqualTo: showLead(duelistval))
                              .where("Attachments", arrayContains: {
                            "uid": _auth.currentUser!.uid.toString(),
                          }).snapshots(),
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
                                  onTap: () {
                                    descBox();
                                  },
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
    if (cval == 4) {
      return Text(
        "Leads Analytics",
        style: TxtStls.fieldtitlestyle,
      );
    } else if (cval == 5) {
      return Text(
        "Transactions",
        style: TxtStls.fieldtitlestyle,
      );
    }
  }

  showbody(cval) {
    if (cval == 4) {
      return PieChart(
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
              value: prospectLength == null ? 0 : prospectLength!.toDouble(),
              showTitle: true,
              radius: 19,
            ),
            PieChartSectionData(
              color: Colors.orangeAccent.withOpacity(0.75),
              value: newLength == null ? 0 : newLength!.toDouble(),
              showTitle: true,
              radius: 22,
            ),
            PieChartSectionData(
              color: Colors.yellowAccent.withOpacity(0.75),
              value: ipLength == null ? 0 : ipLength!.toDouble(),
              showTitle: true,
              radius: 19,
            ),
            PieChartSectionData(
              color: btnColor.withOpacity(0.75),
              value: wonLength == null ? 0 : wonLength!.toDouble(),
              showTitle: true,
              radius: 22,
            ),
          ],
        ),
      );
    } else if (cval == 5) {
      return PieChart(
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
      );
    }
  }

  showbottom(cval) {
    if (cval == 4) {
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
    } else if (cval == 5) {
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

  descBox() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var alertDialog = AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      backgroundColor: txtColor,
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
            Text("taskname"),
            IconButton(
              tooltip: "Close Window",
              icon: Icon(Icons.cancel_presentation),
              color: Colors.pink[400],
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: width * 0.85,
            height: height * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.08,
                  width: width * 0.85,
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
                                Lottie.asset("assets/Lotties/createdate.json"),
                                Text("createDate"),
                              ],
                            ),
                          ),
                        ),
                        onHover: (value) {},
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
                                Lottie.asset("assets/Lotties/lastdate.json",
                                    fit: BoxFit.fill),
                                Text("deadline"),
                              ],
                            ),
                          ),
                        ),
                        onHover: (value) {
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
                            width: width * 0.09,
                            child: Icon(
                              Icons.flag,
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
                                Lottie.asset("assets/Lotties/lastseen.json"),
                                Column(
                                  children: [
                                    Text("lastview"),
                                    Text(
                                      "lastviewTime",
                                      style: TextStyle(fontSize: 15),
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
                                  Lottie.asset("assets/Lotties/agent.json"),
                                ],
                              ),
                            ),
                          ),
                          onHover: (value) {},
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
                                  Text("Await")
                                ],
                              ),
                            ),
                          ),
                          onHover: (value) {}),
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
                        onHover: (value) {},
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 60 / 2,
                            width: 200,
                            child: Text(
                              " catstat",
                              style: TxtStls.stl1,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 200,
                            child: Text(
                              "scatstat",
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
                          setState(() {});
                        },
                      )
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

  //
  // Future<void> userTasks1(img) async {
  //   fireStore
  //       .collection("Tasks")
  //       .where("Attachments", arrayContains: {
  //         "uid": _auth.currentUser!.uid.toString(),
  //         "uid1": img.toString(),
  //       })
  //       .get()
  //       .then((value) {
  //         newLength = value.docs.length.toDouble();
  //         setState(() {});
  //       });
  // }
  //
  // Future<void> userTasks2(img) async {
  //   fireStore
  //       .collection("Tasks")
  //       .where("Attachments", arrayContains: {
  //         "uid": _auth.currentUser!.uid.toString(),
  //         "uid1": img.toString(),
  //       })
  //       .get()
  //       .then((value) {
  //         ipLength = value.docs.length.toDouble();
  //         setState(() {});
  //       });
  // }
  //
  // Future<void> userTasks3(img) async {
  //   fireStore
  //       .collection("Tasks")
  //       .where("Attachments", arrayContains: {
  //         "uid": _auth.currentUser!.uid.toString(),
  //         "uid1": img.toString(),
  //       })
  //       .get()
  //       .then((value) {
  //         wonLength = value.docs.length.toDouble();
  //         setState(() {});
  //       });
  // }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
