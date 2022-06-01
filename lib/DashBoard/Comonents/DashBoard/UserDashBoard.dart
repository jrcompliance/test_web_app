import 'dart:html' show ImageElement;
import 'dart:io';
import 'dart:ui' as ui;
import 'package:camera_web/camera_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_web_app/Constants/CountUp.dart';
import 'package:test_web_app/Constants/Fileview.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Models/tasklength.dart';
import 'package:test_web_app/Providers/AddDocumentsProvider2.dart';
import 'package:test_web_app/Providers/EmergencyTaskProvider.dart';
import 'package:test_web_app/Widgets/InvoicePopup.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  int chartval = 1;
  int graphval = 1;
  int duelistval = 1;

  TextEditingController _serviceSearchController = TextEditingController();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _taxSlabController = TextEditingController();
  TextEditingController _sacCodeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  var popValue;

  String? docid;

  bool _isClicked = false;

  ScrollController _scrollController = ScrollController();
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

  final _list = [
    "Service",
    "Product",
  ];
  final _titlelist = [
    "SN ",
    "Product Name",
    "SAC Code",
    "Tax Slab",
    "Price",
    "Action",
  ];

  var activeid = "Service";
  @override
  void initState() {
    super.initState();
    getEmployeeId();
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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  child: Row(
                    children: _list.map((e) => newMethod(e, () {})).toList(),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: btnColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.all(12.5),
                    child: Text(
                      "+ Add Product",
                      style: TxtStls.fieldstyle11,
                    ),
                  ),
                )
              ],
            ),
          ),
          activeid == "Product"
              ? Column(
                  children: [
                    space(),
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
                          flex: 1,
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                alignment: Alignment.center,
                                height: size.height * 0.4,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              graphval == 1
                                                  ? "Reports"
                                                  : "History",
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
                                                    text:
                                                        'Half yearly sales analysis',
                                                    textStyle:
                                                        TxtStls.fieldstyle),
                                                // Enable legend
                                                legend: Legend(isVisible: true),
                                                // Enable tooltip

                                                series: <
                                                    LineSeries<SalesData,
                                                        String>>[
                                                    LineSeries<SalesData,
                                                            String>(
                                                        dataSource: <SalesData>[
                                                          SalesData('Jan', 35),
                                                          SalesData('Feb', 28),
                                                          SalesData('Mar', 34),
                                                          SalesData('Apr', 32),
                                                          SalesData('May', 40)
                                                        ],
                                                        xValueMapper:
                                                            (SalesData sales,
                                                                    _) =>
                                                                sales.year,
                                                        yValueMapper:
                                                            (SalesData sales,
                                                                    _) =>
                                                                sales.sales,
                                                        // Enable data label
                                                        dataLabelSettings:
                                                            DataLabelSettings(
                                                                isVisible:
                                                                    true))
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                alignment: Alignment.center,
                                height: size.height * 0.4,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                )
              : Container(
                  child: Column(
                    children: [
                      space(),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 7,
                                child: Container(
                                  height: size.height * 0.85,
                                  decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text(
                                                "Service List",
                                                style:
                                                    TxtStls.fieldtitlestyle11,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Container(
                                                  height: size.width * 0.03,
                                                  width: size.width * 0.2,
                                                  child: field(
                                                      _serviceSearchController,
                                                      "Search",
                                                      1,
                                                      true)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "See More",
                                                style: TxtStls.titlestyle14,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      space(),
                                      Column(
                                        children: [
                                          titleWidget(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: size.height * 0.35,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: 10,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                  ),
                                                  child: Container(
                                                    height: size.width * 0.025,
                                                    padding: EdgeInsets.only(
                                                        left: 50, right: 50),
                                                    color: index % 2 == 0
                                                        ? AbgColor.withOpacity(
                                                            0.1)
                                                        : bgColor,
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                              flex: 1,
                                                              child: Text(
                                                                "${index + 1}",
                                                                style: TxtStls
                                                                    .fieldstyle,
                                                              )),
                                                          Flexible(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 40),
                                                              child:
                                                                  productWidget(
                                                                "assets/Images/pending.png",
                                                                "Product Type",
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                              flex: 1,
                                                              child: SACCode(
                                                                "89445656",
                                                              )),
                                                          Flexible(
                                                              flex: 1,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            50,
                                                                        right:
                                                                            50),
                                                                child: Text(
                                                                  "GST %",
                                                                  style: TxtStls
                                                                      .fieldstyle,
                                                                ),
                                                              )),
                                                          Flexible(
                                                              flex: 1,
                                                              child: Text(
                                                                "\$56468",
                                                                style: TxtStls
                                                                    .fieldstyle,
                                                              )),
                                                          Flexible(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 50,
                                                                      right:
                                                                          50),
                                                              child: popupMenu(
                                                                "EDIT",
                                                                "DELETE",
                                                                _clrslist[0],
                                                                _clrslist[2],
                                                                Icons.edit,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      space(),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Container(
                                          height: size.height * 0.3,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    children: [
                                                      space2(),
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            AbgColor
                                                                .withOpacity(
                                                                    0.1),
                                                        radius: 50,
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          child: IconButton(
                                                            icon: Icon(Icons
                                                                .camera_alt),
                                                            onPressed: () {
                                                              CameraDevice
                                                                  .front;
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      space2(),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Text("Image"),
                                                      ),
                                                    ],
                                                  )),
                                              Expanded(
                                                  flex: 6,
                                                  child: Container(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 2.5),
                                                          child: Text(
                                                            "Product Name",
                                                            style: TxtStls
                                                                .fieldstyle,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Flexible(
                                                              flex: 1,
                                                              child: field(
                                                                  _productNameController,
                                                                  "",
                                                                  1,
                                                                  true),
                                                            ),
                                                            Flexible(
                                                                flex: 1,
                                                                child:
                                                                    Text("")),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          2.5),
                                                              child: Text(
                                                                "SAC Code",
                                                                style: TxtStls
                                                                    .fieldstyle,
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                "Tax Slab",
                                                                style: TxtStls
                                                                    .fieldstyle,
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                "",
                                                                style: TxtStls
                                                                    .fieldstyle,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              flex: 1,
                                                              child: field(
                                                                  _sacCodeController,
                                                                  "",
                                                                  1,
                                                                  true),
                                                            ),
                                                            Flexible(
                                                              flex: 1,
                                                              child: field(
                                                                  _taxSlabController,
                                                                  "",
                                                                  1,
                                                                  true),
                                                            ),
                                                            Flexible(
                                                              flex: 1,
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                width:
                                                                    size.width *
                                                                        0.001,
                                                                child: Text(""),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          7.5),
                                                              child: Text(
                                                                "Price",
                                                                style: TxtStls
                                                                    .fieldstyle,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(""),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Flexible(
                                                                flex: 1,
                                                                child: field(
                                                                    _priceController,
                                                                    "",
                                                                    1,
                                                                    true)),
                                                            Flexible(
                                                                flex: 1,
                                                                child: Text(""))
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Flexible(
                                                              flex: 1,
                                                              child:
                                                                  ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary:
                                                                      bgColor,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0)),
                                                                ),
                                                                child: Text(
                                                                  "Close",
                                                                  style: TextStyle(
                                                                      color: btnColor
                                                                          .withOpacity(
                                                                              0.6)),
                                                                ),
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary:
                                                                    btnColor,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0)),
                                                              ),
                                                              child: Text(
                                                                "Save",
                                                                style: TxtStls
                                                                    .fieldstyle1,
                                                              ),
                                                              onPressed: () {},
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                              Expanded(
                                                flex: 4,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Description",
                                                      style: TxtStls.fieldstyle,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Flexible(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        child: field(
                                                            _descriptionController,
                                                            "",
                                                            3,
                                                            true),
                                                      ),
                                                    ),
                                                    Container(
                                                        alignment: Alignment
                                                            .center,
                                                        decoration: BoxDecoration(
                                                            color: bgColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0)),
                                                        height:
                                                            size.height * 0.15,
                                                        child: StreamBuilder(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "EmployeeData")
                                                                .where("uid",
                                                                    isEqualTo:
                                                                        docid)
                                                                .snapshots(),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        QuerySnapshot>
                                                                    snapshot) {
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return IconButton(
                                                                  icon: Icon(Icons
                                                                      .cloud_upload),
                                                                  onPressed:
                                                                      () {},
                                                                  iconSize: 80,
                                                                  color: btnColor
                                                                      .withOpacity(
                                                                          0.5),
                                                                );
                                                              }
                                                              return ListView
                                                                  .separated(
                                                                separatorBuilder: (_,
                                                                        index) =>
                                                                    SizedBox(
                                                                        height:
                                                                            1),
                                                                shrinkWrap:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                physics:
                                                                    AlwaysScrollableScrollPhysics(),
                                                                itemCount:
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  List attachments1 = snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      "Attachments1"];
                                                                  // print(attachments1
                                                                  //     .toString());
                                                                  // print(docid);
                                                                  return ListView
                                                                      .separated(
                                                                    controller:
                                                                        _scrollController,
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount:
                                                                        attachments1
                                                                            .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            i) {
                                                                      return ListTile(
                                                                        leading:
                                                                            SizedBox(
                                                                          height:
                                                                              30,
                                                                          child: Image.asset(
                                                                              "assets/Images/pdf.png",
                                                                              filterQuality: FilterQuality.high,
                                                                              fit: BoxFit.cover),
                                                                        ),
                                                                        title:
                                                                            Text(
                                                                          attachments1[i]['name']
                                                                              .toString(),
                                                                          style:
                                                                              TxtStls.fieldstyle,
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          fileview1(
                                                                              context,
                                                                              attachments1[i]["name"].toString(),
                                                                              attachments1[i]["url"].toString());
                                                                        },
                                                                      );
                                                                    },
                                                                    separatorBuilder: (BuildContext
                                                                                context,
                                                                            int
                                                                                index) =>
                                                                        Divider(
                                                                            color:
                                                                                grClr),
                                                                  );
                                                                },
                                                              );
                                                            })),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2.5),
                                                      child: Divider(),
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: btnColor,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0)),
                                                            ),
                                                            child: Text(
                                                              "Upload",
                                                              style: TxtStls
                                                                  .fieldstyle1,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                _isClicked =
                                                                    true;
                                                              });
                                                              Provider.of<AddDocumentsProvider2>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .addDocument(
                                                                      docid);
                                                            },
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                flex: 3,
                                child: SizedBox(
                                    child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: bgColor),
                                        height: size.height * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            space2(),
                                            container2("Product Add by Month",
                                                "First Half", "Second Half"),
                                            space2(),
                                            row1(
                                              popValue == "First Half"
                                                  ? "Jan"
                                                  : "Jul",
                                              "23,400",
                                              0.8,
                                            ),
                                            space2(),
                                            row1(
                                              popValue == "First Half"
                                                  ? "Feb"
                                                  : "Aug",
                                              "15,000",
                                              0.4,
                                            ),
                                            space2(),
                                            row1(
                                              popValue == "First Half"
                                                  ? "Mar"
                                                  : "Sep",
                                              "30,000",
                                              0.9,
                                            ),
                                            space2(),
                                            row1(
                                              popValue == "First Half"
                                                  ? "Apr"
                                                  : "Oct",
                                              "22,000",
                                              0.7,
                                            ),
                                            space(),
                                            row1(
                                              popValue == "First Half"
                                                  ? "May"
                                                  : "Nov",
                                              "10,000",
                                              1.0,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            row1(
                                              popValue == "First Half"
                                                  ? "Jun"
                                                  : "Dec",
                                              "23,400",
                                              0.1,
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: bgColor),
                                        height: size.height * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            space(),
                                            container2(
                                                "Product Sales Analytics",
                                                "FirstHalf",
                                                "SecondHalf"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                                height: size.height * 0.3,
                                                child: SfCircularChart(
                                                    annotations: <
                                                        CircularChartAnnotation>[
                                                      CircularChartAnnotation(
                                                          widget: Container(
                                                              child: PhysicalModel(
                                                                  child:
                                                                      Container(),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  elevation: 10,
                                                                  shadowColor:
                                                                      Colors
                                                                          .black,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          230,
                                                                          230,
                                                                          230,
                                                                          1)))),
                                                      CircularChartAnnotation(
                                                          widget: CircleAvatar(
                                                        radius: 120,
                                                        backgroundImage: AssetImage(
                                                            "Images/innerCircle.png"),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        // child: Image.asset(
                                                        //     ),
                                                      ))
                                                    ],
                                                    series: <CircularSeries>[
                                                      // Renders doughnut chart
                                                      DoughnutSeries<ChartData,
                                                          String>(
                                                        dataSource: chartData,
                                                        pointColorMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.color,
                                                        xValueMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.x,
                                                        yValueMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.y,
                                                        innerRadius: "70",
                                                      )
                                                    ])),
                                            showbottomofPieChart3(),
                                          ],
                                        ))
                                  ],
                                ))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  int flexCal(value) {
    if (value < 0.5) {
      return 1;
    } else if (value >= 0.5 && value < 0.75) {
      return 2;
    } else {
      return 3;
    }
  }

  Widget row1(text1, text2, value) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Text(
            text1,
            style: TxtStls.fieldstyle,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          flex: flexCal(value),
          child: Container(
            // height: 15.0,
            // width: size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              child: LinearPercentIndicator(
                lineHeight: 10.0,
                //  width: value < 0.5 ? size.width * 0.03 : size.width * 0.09,
                percent: value,
                backgroundColor: Colors.transparent,
                progressColor: value <= 0.7 ? primaryColor : neClr,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 1,
          child: Text(
            text2,
            style: TxtStls.fieldstyle,
          ),
        ),
      ],
    );
  }

  Widget container2(text, value1, value2) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              text,
              style: TxtStls.fieldtitlestyle11,
            ),
          ),
          Flexible(
            flex: 1,
            child: popupMenu(value1, value2),
          )
        ],
      ),
    );
  }

  Widget space() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * 0.01);
  }

  Widget space2() {
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
            height: size.height * 0.22,
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
            height: size.height * 0.22,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
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

  Widget newMethod(e, callack) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        primary: activeid == e ? btnColor : bgColor,
        // hoverColor: Colors.transparent,
        // hoverElevation: 0.0,
      ),
      onPressed: () {
        setState(() {
          activeid = e;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
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

  Widget field(_controller, hintText, maxlines, bool isenable,
      [icn, icn1, maxlength]) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Container(
        decoration: deco,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.01,
            // vertical: size.width * 0.008,
          ),
          child: TextFormField(
            maxLength: maxlength,
            enabled: isenable,
            cursorColor: btnColor,
            controller: _controller,
            style: TxtStls.fieldstyle,
            decoration: InputDecoration(
              prefixIcon: icn1,
              errorStyle: ClrStls.errorstyle,
              suffixIcon: icn,
              hintText: hintText,
              hintStyle: TxtStls.fieldstyle,
              border: InputBorder.none,
            ),
            maxLines: maxlines,
          ),
        ),
      ),
    );
  }

  Widget titleWidget() {
    Size size = MediaQuery.of(context).size;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _titlelist
            .map((e) => Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      e,
                      style: TxtStls.fieldstyle,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AbgColor,
                    )
                  ],
                )))
            .toList());
  }

  Widget productWidget(assetImage, text) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          child: Image.asset(
            assetImage,
            height: 15,
            width: 15,
            fit: BoxFit.fill,
            filterQuality: ui.FilterQuality.high,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TxtStls.fieldstyle111,
        )
      ],
    );
  }

  Widget SACCode(code) {
    return Text(
      code,
      style: TxtStls.fieldstyle,
    );
  }

  Widget container(width, controller, hintText) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: AbgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0)),
      alignment: Alignment.centerLeft,
      height: size.width * 0.015,
      width: width,
      child: field(controller, hintText, 1, true),
    );
  }

  final List _clrslist = [btnColor, neClr, flwClr];
  Widget dropdecor(String text, [Color? clr, IconData? icon]) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: clr?.withOpacity(0.05),
      ),
      child: Row(
        children: [
          Container(
              child: Icon(
            icon,
            color: clr,
            size: 13,
          )),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              text,
              style: TextStyle(
                  color: clr, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget popupMenu(value1, value2, [Color? clr1, Color? clr2, IconData? icon]) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: PopupMenuButton(
        shape: TooltipShape(),
        offset: Offset(5, 40),
        icon: Icon(
          Icons.more_horiz,
          color: btnColor,
        ),
        onSelected: (value) {
          setState(() {
            popValue = value;
          });
          print(value);
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
                value: value1,
                onTap: () {},
                child: dropdecor(value1, clr1, icon)),
            PopupMenuItem(
              value: value2,
              onTap: () {},
              child: dropdecor(value2, clr2, icon),
            ),
          ];
        },
      ),
    );
  }

  showbodyofPieChart2(chartVal2) {
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
            value: null,
            showTitle: true,
            radius: 25,
          ),
        ],
      ),
    );
  }

  showbottomofPieChart2(chartval, text1, text2, text3) {
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
              text1,
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
              text2,
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
              text3,
              style: TxtStls.fieldstyle,
            )),
      ],
    );
  }

  showbottomofPieChart3() {
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
              "Total Sales",
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
              "Total Order",
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
              "Total Cancel",
              style: TxtStls.fieldstyle,
            )),
      ],
    );
  }

  final List<ChartData> chartData = [
    ChartData('Total Sales', 60, primaryColor),
    ChartData('Total Cancel', 20, neClr),
    ChartData('Total Order', 20, Clrs.yellowClr),
  ];
  getEmployeeId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    docid = pref.getString("uid");
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
