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
  int chartval = 1;
  int graphval = 1;
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
            children: [
              cover("assets/Logos/1.png", newLength, "NEW"),
              cover("assets/Logos/4.png", prospectLength, "PROSPECT"),
              cover("assets/Logos/2.png", ipLength, "INPROGRESS"),
              cover("assets/Logos/3.png", wonLength, "WON"),
            ],
          ),
          space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      alignment: Alignment.center,
                      height: size.height * 0.4,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(graphval == 1 ? "Reports" : "History",
                                    style: TxtStls.fieldtitlestyle),
                                PopupMenuButton(
                                  offset: Offset(0, 32),
                                  elevation: 10.0,
                                  shape: TooltipShape(),
                                  icon: Icon(
                                    Icons.more_horiz,
                                  ),
                                  onSelected: (int value) {
                                    setState(() {
                                      graphval = value;
                                    });
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        value: 1,
                                        child: Text(
                                          "Reports",
                                          style: TxtStls.fieldstyle,
                                        ),
                                      ),
                                      PopupMenuItem(
                                          value: 2,
                                          child: Text(
                                            "History",
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
                              child: graphval == 1
                                  ? SfCartesianChart(
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
                                              xValueMapper:
                                                  (SalesData sales, _) =>
                                                      sales.year,
                                              yValueMapper:
                                                  (SalesData sales, _) =>
                                                      sales.sales,
                                              // Enable data label
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                      isVisible: true))
                                        ])
                                  : Text("will Update soon"))
                        ],
                      )),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      alignment: Alignment.center,
                      height: size.height * 0.4,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                showtitleofPiechart(chartval),
                                PopupMenuButton(
                                  offset: Offset(0, 32),
                                  elevation: 10.0,
                                  shape: TooltipShape(),
                                  icon: Icon(
                                    Icons.more_horiz,
                                  ),
                                  onSelected: (int value) {
                                    setState(() {
                                      chartval = value;
                                    });
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        value: 1,
                                        child: Text(
                                          "Leads",
                                          style: TxtStls.fieldstyle,
                                        ),
                                      ),
                                      PopupMenuItem(
                                          value: 2,
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
                            child: showbodyofPieChart(chartval),
                          ),
                          showbottomofPieChart(chartval),
                        ],
                      )),
                ),
              ),
            ],
          ),
          space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cover1("PI-Amount"),
              SizedBox(width: 20),
              cover1("Q-Amount"),
              SizedBox(width: 20),
              cover1("Invoice-Amount"),
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

  Widget cover(imageUrl, datalength, title) {
    Size size = MediaQuery.of(context).size;
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                child: Image.asset(
                  imageUrl,
                  filterQuality: FilterQuality.high,
                ),
                backgroundColor: Colors.blueAccent.withOpacity(0.1),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  datalength == null
                      ? Text("0+", style: TxtStls.numstyle)
                      : Row(
                          children: [
                            Countup(
                              end: datalength!.toDouble(),
                              begin: 0,
                              style: TxtStls.numstyle,
                            ),
                            Text(
                              "+",
                              style: TxtStls.numstyle,
                            )
                          ],
                        ),
                  Text(title, style: TxtStls.fieldstyle)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cover1(title) {
    Size size = MediaQuery.of(context).size;
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          alignment: Alignment.center,
          height: size.height * 0.06,
          child: Text(title, style: TxtStls.numstyle),
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
            height: size.height * 0.27,
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
            height: size.height * 0.27,
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

  // Part of Pie Chart Data here

  showtitleofPiechart(chartval) {
    if (chartval == 1) {
      return Text(
        "Leads Analytics",
        style: TxtStls.fieldtitlestyle,
      );
    } else if (chartval == 2) {
      return Text(
        "Transactions",
        style: TxtStls.fieldtitlestyle,
      );
    }
  }

  showbodyofPieChart(chartval) {
    if (chartval == 1) {
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
    } else if (chartval == 2) {
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
              value: 100,
              showTitle: true,
              radius: 25,
            ),
            PieChartSectionData(
              color: Colors.yellowAccent.withOpacity(0.75),
              value: 100,
              showTitle: true,
              radius: 25,
            ),
            PieChartSectionData(
              color: btnColor.withOpacity(0.75),
              value: 100,
              showTitle: true,
              radius: 25,
            ),
          ],
        ),
      );
    }
  }

  showbottomofPieChart(chartval) {
    if (chartval == 1) {
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
    } else if (chartval == 2) {
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
                "PI-Amount",
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
                "Q-Amount",
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
                "Invoice-Amount",
                style: TxtStls.fieldstyle,
              )),
        ],
      );
    }
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
