import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/reusable.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final TextEditingController _endDateController = TextEditingController();
  var pricol;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding,
      ),
      child: Container(
        width: width,
        height: height * 0.895,
        color: secondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  height: height * 0.05,
                  width: Responsive.isMobile(context) ? 100 : 200,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border(
                      top: BorderSide(width: 3.0, color: statClr.todo),
                      bottom: BorderSide(color: Clrs.txtColor),
                      left: BorderSide(color: Clrs.txtColor),
                      right: BorderSide(color: Clrs.txtColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "TO DO",
                      style: TxtStls.stl1,
                    ),
                  ),
                ),
                SizedBox(
                    height: height * 0.84,
                    width: Responsive.isMobile(context) ? 100 : 200,
                    child: StreamBuilder(
                      stream: _fireStore.collection("Tasks").snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.separated(
                                separatorBuilder: (BuildContext context, i) =>
                                    Divider(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, index) {
                                  String res =
                                      snapshot.data!.docs[index]["priority"];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Task name here...
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: Responsive.isMobile(context)
                                              ? width * 0.547
                                              : width * 0.33,
                                          child: Text(
                                            snapshot.data!.docs[index]["task"],
                                            style: TxtStls.stl1,
                                          ),
                                        ),
                                        // Task assignee here...
                                        CircleAvatar(
                                          backgroundColor: Colors.orange,
                                          child: IconButton(
                                            icon: Icon(Icons.person_add_alt_1),
                                            onPressed: () {},
                                            tooltip: "ASSIGNEE TO",
                                          ),
                                        ),
                                        Spacer(
                                            flex: Responsive.isMobile(context)
                                                ? 2
                                                : 1),
                                        //end Date of task here...
                                        snapshot.data!.docs[index]["endDate"] ==
                                                ""
                                            ? InkWell(
                                                onTap: () {
                                                  print(index);
                                                  pickEndDate(context, index);
                                                },
                                                child: Icon(
                                                  Icons.calendar_today_outlined,
                                                ))
                                            : InkWell(
                                                onTap: () {
                                                  print(index);
                                                  pickEndDate(context, index);
                                                },
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.clear,
                                                        size: 10,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          updateEdateTask1(
                                                              index);
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
                                        Spacer(
                                            flex: Responsive.isMobile(context)
                                                ? 2
                                                : 1),
                                        // task priority flag here....
                                        snapshot.data!.docs[index]
                                                    ["priority"] ==
                                                ""
                                            ? PopupMenuButton(
                                                color: Clrs.txtColor,
                                                onSelected: (value) {
                                                  pricol = value;
                                                  updateFlag(index);
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.flag,
                                                  color: pricolorget(res),
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
                                                        value: "H",
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.flag,
                                                              color: Clrs.high,
                                                            ),
                                                            Text(
                                                              "High",
                                                              style:
                                                                  TxtStls.stl2,
                                                            )
                                                          ],
                                                        )),
                                                    PopupMenuItem(
                                                        value: "N",
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.flag,
                                                              color:
                                                                  Clrs.normal,
                                                            ),
                                                            Text(
                                                              "Normal",
                                                              style:
                                                                  TxtStls.stl2,
                                                            )
                                                          ],
                                                        )),
                                                    PopupMenuItem(
                                                        value: "L",
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.flag,
                                                              color: Clrs.low,
                                                            ),
                                                            Text(
                                                              "Low",
                                                              style:
                                                                  TxtStls.stl2,
                                                            )
                                                          ],
                                                        )),
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
                                              )
                                            : PopupMenuButton(
                                                color: Clrs.txtColor,
                                                onSelected: (value) {
                                                  pricol = value;
                                                  updateFlag(index);
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.flag,
                                                  color: pricolorget(res),
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
                                                        value: "H",
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.flag,
                                                              color: Clrs.high,
                                                            ),
                                                            Text(
                                                              "High",
                                                              style:
                                                                  TxtStls.stl2,
                                                            )
                                                          ],
                                                        )),
                                                    PopupMenuItem(
                                                        value: "N",
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.flag,
                                                              color:
                                                                  Clrs.normal,
                                                            ),
                                                            Text(
                                                              "Normal",
                                                              style:
                                                                  TxtStls.stl2,
                                                            )
                                                          ],
                                                        )),
                                                    PopupMenuItem(
                                                        value: "L",
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.flag,
                                                              color: Clrs.low,
                                                            ),
                                                            Text(
                                                              "Low",
                                                              style:
                                                                  TxtStls.stl2,
                                                            )
                                                          ],
                                                        )),
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
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ))
              ],
            ),
            Column(
              children: [
                Container(
                  height: height * 0.05,
                  width: Responsive.isMobile(context) ? 100 : 200,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border(
                      top: BorderSide(width: 3.0, color: statClr.inpro),
                      bottom: BorderSide(color: Clrs.txtColor),
                      left: BorderSide(color: Clrs.txtColor),
                      right: BorderSide(color: Clrs.txtColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "IN PROGRESS",
                      style: TxtStls.stl1,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.84,
                  width: Responsive.isMobile(context) ? 100 : 200,
                  child: ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: height * 0.05,
                  width: Responsive.isMobile(context) ? 100 : 200,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border(
                      top: BorderSide(width: 3.0, color: statClr.ready),
                      bottom: BorderSide(color: Clrs.txtColor),
                      left: BorderSide(color: Clrs.txtColor),
                      right: BorderSide(color: Clrs.txtColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "READY",
                      style: TxtStls.stl1,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.84,
                  width: Responsive.isMobile(context) ? 100 : 200,
                  child: ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: height * 0.05,
                  width: Responsive.isMobile(context) ? 100 : 200,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border(
                      top: BorderSide(width: 3.0, color: statClr.com),
                      bottom: BorderSide(color: Clrs.txtColor),
                      left: BorderSide(color: Clrs.txtColor),
                      right: BorderSide(color: Clrs.txtColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "COMPLETED",
                      style: TxtStls.stl1,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.84,
                  width: Responsive.isMobile(context) ? 100 : 200,
                  child: ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void pickEndDate(BuildContext context, index) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100))
        .then((value) {
      setState(() {
        _endDateController.text = value!.toString().split(" ")[0];
      });
      updateEdateTask(index);
    });
  }

  Future<void> updateEdateTask(int index) async {
    CollectionReference collectionReference = _fireStore.collection("Tasks");
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[index].reference.update({
      "endDate": _endDateController.text.toString(),
    });
  }

  Future<void> updateEdateTask1(int index) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Tasks");
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[index].reference.update({
      "endDate": '',
    });
  }

  Future<void> updateFlag(index) async {
    CollectionReference collectionReference = _fireStore.collection("Tasks");
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[index].reference.update({
      "priority": pricol.toString(),
    });
  }

  Color pricolorget(String res) {
    if (res == "U") {
      return Clrs.urgent;
    }
    if (res == "H") {
      return Clrs.high;
    }
    if (res == "N") {
      return Clrs.normal;
    }
    if (res == "L") {
      return Clrs.low;
    } else {
      return Clrs.txtColor;
    }
  }
}
