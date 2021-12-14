import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_web_app/Constants/reusable.dart';

Widget Chart(BuildContext context, s, f) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Row(
    children: [
      Container(
        height: height * 0.35,
        width: width * 0.445 / 2,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(touchCallback: (clickResponse) {
              if (clickResponse.clickHappened) {}
            }),
            sectionsSpace: 2,
            centerSpaceRadius: 90,
            startDegreeOffset: -90,
            sections: [
              PieChartSectionData(
                color: wonClr,
                value: s,
                showTitle: true,
                radius: 40,
              ),
              PieChartSectionData(
                color: clsClr,
                value: f,
                showTitle: true,
                radius: 40,
              ),
              PieChartSectionData(
                color: statClr.inpro,
                value: 0,
                showTitle: true,
                radius: 40,
              ),
            ],
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.circle,
                color: wonClr,
                size: 15,
              ),
              label: Text("IN TIME :")),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.circle,
                color: clsClr,
                size: 15,
              ),
              label: Text("MISSED UP :")),
          TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.circle,
                color: statClr.inpro,
                size: 15,
              ),
              label: Text("ON DEMAND CLIENTS :")),
        ],
      )
    ],
  );
}

Widget chart2(BuildContext context, ic, ie, im, na, oc, oe, om, date) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  var yearTextStyle;
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        height: height * 0.35,
        width: width * 0.345,
        child: LineChart(
          LineChartData(
            backgroundColor: bgColor.withOpacity(1),
            lineTouchData: LineTouchData(enabled: true),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(date, ic),
                ],
                isCurved: true,
                barWidth: 5,
                colors: [wonClr],
                belowBarData: BarAreaData(show: false),
                aboveBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
              ),
              LineChartBarData(
                spots: [
                  FlSpot(date, ie),
                ],
                isCurved: true,
                barWidth: 5,
                colors: [ipClr],
                belowBarData: BarAreaData(show: false),
                aboveBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
              ),
              LineChartBarData(
                spots: [
                  FlSpot(date, im),
                ],
                isCurved: true,
                barWidth: 5,
                colors: [flwClr],
                belowBarData: BarAreaData(show: false),
                aboveBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
              ),
              LineChartBarData(
                spots: [
                  FlSpot(date, na),
                ],
                isCurved: true,
                barWidth: 5,
                colors: [irrClr],
                belowBarData: BarAreaData(show: false),
                aboveBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
              ),
              LineChartBarData(
                spots: [
                  FlSpot(date, oc),
                ],
                isCurved: true,
                barWidth: 5,
                colors: [Colors.teal],
                belowBarData: BarAreaData(show: false),
                aboveBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
              ),
              LineChartBarData(
                spots: [
                  FlSpot(date, oe),
                ],
                isCurved: true,
                barWidth: 5,
                colors: [Color(0xFF880E4f)],
                belowBarData: BarAreaData(show: false),
                aboveBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
              ),
              LineChartBarData(
                spots: [
                  FlSpot(date, om),
                ],
                isCurved: true,
                barWidth: 5,
                colors: [clsClr],
                belowBarData: BarAreaData(show: false),
                aboveBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true),
              ),
            ],
            minY: 0.0,
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 1,
                  getTextStyles: yearTextStyle,
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 0:
                        return date;

                      default:
                        return '';
                    }
                  }),
              leftTitles: SideTitles(
                showTitles: true,
                getTitles: (value) {
                  return '${value}';
                },
              ),
            ),
            axisTitleData: FlAxisTitleData(
                leftTitle:
                    AxisTitle(showTitle: true, titleText: "Value", margin: 10),
                bottomTitle: AxisTitle(
                    showTitle: true, margin: 10, textAlign: TextAlign.center)),
            gridData: FlGridData(
                show: true, drawHorizontalLine: true, drawVerticalLine: true),
          ),
        ),
      ),
      Container(
        height: height * 0.35,
        width: width * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.circle,
                  color: wonClr,
                  size: 15,
                ),
                label: Text("Call(In Bound)")),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.circle,
                  color: ipClr,
                  size: 15,
                ),
                label: Text("Message(In Bound)")),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.circle,
                  color: flwClr,
                  size: 15,
                ),
                label: Text("Email(In Bound)")),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.circle,
                  color: irrClr,
                  size: 15,
                ),
                label: Text("Call(Out Bound)")),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.circle,
                  color: Colors.teal,
                  size: 15,
                ),
                label: Text("Message(Out Bound)")),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.circle,
                  color: Color(0xFF880E4f),
                  size: 15,
                ),
                label: Text("Email(Out Bound)")),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.circle,
                  color: clsClr,
                  size: 15,
                ),
                label: Text("No Answer")),
          ],
        ),
      )
    ],
  );
}
