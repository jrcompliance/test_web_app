import 'dart:html' show ImageElement;
import 'dart:ui' as ui;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_web_app/Constants/CountUp.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:test_web_app/Models/tasklength.dart';
import 'package:test_web_app/Providers/EmergencyTaskProvider.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  int chartval = 4;
  int duelistval = 1;
  showLead() {
    if (duelistval == 1) {
      return DateTime.now().toString().split(" ")[0];
    } else if (duelistval == 2) {
      return DateTime.now()
          .subtract(Duration(days: 1))
          .toString()
          .split(" ")[0];
    } else if (duelistval == 3) {
      return DateTime.now().add(Duration(days: 1)).toString().split(" ")[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AbgColor.withOpacity(0.0001),
      width: size.width,
      height: size.height * 0.93,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cover(Row(
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
              )),
              cover(Row(
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
              )),
              cover(Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    maxRadius: 30.0,
                    child: Center(
                      child: Image.asset("assets/Logos/2.png",
                          fit: BoxFit.fill, filterQuality: FilterQuality.high),
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
              )),
              cover(Row(
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
              )),
            ],
          ),
          space(),
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
                        height: size.height * 0.28,
                        width: size.width * 0.28,
                        child: showbody(chartval),
                      ),
                      showbottom(chartval),
                    ],
                  )),
            ],
          ),
          space(),
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
          space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [RecentInteractions(), EmergencyLeads()],
          ),
        ],
      ),
    );
  }

  Widget space() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * 0.02);
  }

  Widget cover(child) {
    Size size = MediaQuery.of(context).size;
    return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
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
                ))));
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

  Widget RecentInteractions() {
    Size size = MediaQuery.of(context).size;
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 10.0,
        child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            height: size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text("Recent Interactions",
                      style: TxtStls.fieldtitlestyle),
                )
              ],
            )),
      ),
    );
  }

  Widget EmergencyLeads() {
    Size size = MediaQuery.of(context).size;
    final emergencylist =
        Provider.of<EmergencyTaskProvider>(context, listen: false)
            .emergencylist;
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 10.0,
        child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            height: size.height * 0.3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                          Provider.of<EmergencyTaskProvider>(context,
                                  listen: false)
                              .fetchEmergencyTasks(context, value);
                          duelistval = value;
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
                Expanded(
                    child: emergencylist.length <= 0 ||
                            emergencylist.length == null
                        ? Center(
                            child: SpinKitFadingCube(color: btnColor, size: 15),
                          )
                        : ListView.separated(
                            separatorBuilder: (_, i) => SizedBox(height: 2),
                            itemCount: emergencylist.length,
                            itemBuilder: (_, index) {
                              String? logo =
                                  emergencylist[index].logo.toString();
                              // ignore: undefined_prefixed_name
                              ui.platformViewRegistry.registerViewFactory(
                                logo,
                                (int _) => ImageElement()..src = logo,
                              );
                              return Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
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
                                      emergencylist[index].taskname.toString(),
                                      style: TxtStls.fieldtitlestyle),
                                  subtitle: Text(
                                    emergencylist[index].email.toString(),
                                    style: TxtStls.fieldstyle,
                                  ),
                                  trailing: Icon(Icons.arrow_forward),
                                  onTap: () {},
                                ),
                              );
                            },
                          ))
              ],
            )),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
