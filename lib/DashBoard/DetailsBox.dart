import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:test_web_app/Constants/Fileview.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/slectionfiles.dart';

detailspopBox(
    context, id, taskname, startDate, endDate, priority, lastseen, cat) {
  Size size = MediaQuery.of(context).size;
  TextEditingController _certificateConroller = TextEditingController();
  String createDate = DateFormat('dd-MMM-yy').format(startDate.toDate());
  DateTime dt = DateTime.parse(endDate);
  String deadline = DateFormat('dd-MMM-yy').format(dt);
  String lastview = DateFormat('dd-MMM-yy').format(lastseen.toDate());
  String lastviewTime = DateFormat('hh:mm a').format(lastseen.toDate());
  var alertDialog = AlertDialog(
    contentPadding: EdgeInsets.all(0.0),
    actionsPadding: EdgeInsets.all(0),
    titlePadding: EdgeInsets.all(0),
    insetPadding: EdgeInsets.all(0),
    buttonPadding: EdgeInsets.all(0),
    backgroundColor: Colors.white.withOpacity(0.9),
    title: Container(
      width: size.width * 0.85,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: 150,
            child: Image.asset("assets/Logos/Controlifylogo.png",
                filterQuality: FilterQuality.high, fit: BoxFit.fill),
          ),
          Expanded(
            child: Text(
              taskname,
              style: TxtStls.fieldtitlestyle,
            ),
          ),
          CircleAvatar(
            backgroundColor: neClr.withOpacity(0.1),
            child: IconButton(
              hoverColor: Colors.transparent,
              tooltip: "Close Window",
              icon: Icon(Icons.close),
              color: neClr,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    ),
    content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        int _currentStep = 0;
        return Container(
          width: size.width * 0.85,
          height: size.height * 0.85,
          decoration: BoxDecoration(
            color: AbgColor.withOpacity(0.0001),
          ),
          child: Row(
            children: [
              Container(
                width: size.width * 0.85 / 2,
                height: size.height * 0.85,
                color: AbgColor.withOpacity(0.0001),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.85 / 2,
                          decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                  child: Tooltip(
                                    message: "Agent",
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                btnColor.withOpacity(0.1),
                                            child: Icon(Icons.calendar_today,
                                                color: btnColor),
                                          ),
                                          Text(createDate,
                                              style: TxtStls.fieldstyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onHover: (value) {
                                    setState(() {});
                                  },
                                  onTap: () {}),
                              Container(
                                color: Color(0xFFE0E0E0),
                                height: 40,
                                width: 1,
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: Tooltip(
                                    message: "Filters",
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                btnColor.withOpacity(0.1),
                                            child: Icon(
                                              Icons.date_range,
                                              color: btnColor,
                                            ),
                                          ),
                                          Text(deadline,
                                              style: TxtStls.fieldstyle)
                                        ],
                                      ),
                                    ),
                                  ),
                                  onHover: (value) {
                                    setState(() {});
                                  }),
                              Container(
                                color: Color(0xFFE0E0E0),
                                height: 40,
                                width: 1,
                              ),
                              Tooltip(
                                message: "Priority",
                                child: Container(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          FlagService.pricolorget(priority)
                                              .withOpacity(0.1),
                                      child: Icon(
                                        Icons.flag,
                                        color:
                                            FlagService.pricolorget(priority),
                                      ),
                                    )),
                              ),
                              Container(
                                color: Color(0xFFE0E0E0),
                                height: 40,
                                width: 1,
                              ),
                              InkWell(
                                child: Tooltip(
                                  message: "Last Seen",
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              btnColor.withOpacity(0.1),
                                          child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: Lottie.asset(
                                                  "assets/Lotties/lastseen.json",
                                                  fit: BoxFit.fill)),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(lastview,
                                                style: TxtStls.fieldstyle),
                                            Text(
                                              lastviewTime,
                                              style: TxtStls.fieldstyle,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.85 / 2,
                          decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                      backgroundColor:
                                          btnColor.withOpacity(0.1),
                                      child: Icon(Icons.work, color: btnColor)),
                                  Text("Organisation",
                                      style: TxtStls.fieldstyle)
                                ],
                              ),
                              Container(
                                color: Color(0xFFE0E0E0),
                                height: 40,
                                width: 1,
                              ),
                              Container(
                                  width: size.width * 0.85 / 3.3,
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("Tasks")
                                        .where("id", isEqualTo: id)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }
                                      return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (_, index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  btnColor.withOpacity(0.2),
                                              child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: HtmlElementView(
                                                    viewType: snapshot.data!
                                                        .docs[index]["logo"]),
                                              ),
                                            ),
                                            title: Text(
                                                snapshot.data!.docs[index]
                                                    ["companyname"],
                                                style: TxtStls.fieldstyle),
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
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          width: size.width * 0.85 / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: btnColor.withOpacity(0.1),
                                    child: Lottie.asset(
                                        "assets/Lotties/check.json",
                                        fit: BoxFit.fitHeight),
                                  ),
                                  Text("Manage Contacts",
                                      style: TxtStls.fieldstyle),
                                ],
                              ),
                              Container(
                                width: size.width * 0.85 / 3.1,
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add_box_rounded,
                                      color: btnColor,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          width: size.width * 0.85 / 2,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
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
                                physics: ClampingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, index) {
                                  List<dynamic> contactlist = snapshot
                                      .data!.docs[index]["CompanyDetails"];
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: contactlist.length,
                                      itemBuilder: (_, i) {
                                        return Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Card(
                                            elevation: 10,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              height: 50,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                        contactlist[i]
                                                            ["contactperson"],
                                                        style:
                                                            TxtStls.fieldstyle),
                                                  ),
                                                  Expanded(
                                                      flex: 3,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                Icons.mail,
                                                                color: Colors
                                                                    .green,
                                                                size: 15,
                                                              ),
                                                            ),
                                                            WidgetSpan(
                                                              child: SizedBox(
                                                                width: 5,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                                text:
                                                                    contactlist[
                                                                            i][
                                                                        "email"],
                                                                style: TxtStls
                                                                    .fieldstyle),
                                                          ],
                                                        ),
                                                      )),
                                                  Expanded(
                                                    flex: 3,
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          WidgetSpan(
                                                            child: Icon(
                                                              Icons.call,
                                                              color: AbgColor,
                                                              size: 15,
                                                            ),
                                                          ),
                                                          WidgetSpan(
                                                            child: SizedBox(
                                                              width: 5,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                              text:
                                                                  contactlist[i]
                                                                      ["phone"],
                                                              style: TxtStls
                                                                  .fieldstyle),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.more_horiz,
                                                          color: btnColor,
                                                        ),
                                                        onPressed: () {},
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Attachments :",
                                        style: TxtStls.fieldtitlestyle),
                                    Container(
                                      width: size.width * 0.20,
                                      height: size.height * 0.12,
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
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
                                              top: BorderSide(
                                                  color: txtColor
                                                      .withOpacity(0.5)))),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        color: btnColor,
                                        child: Text("Upload",
                                            style: TxtStls.fieldstyle1),
                                        onPressed: () {
                                          FileServices.choosefile(id);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Services Obtained :",
                                        style: TxtStls.fieldtitlestyle),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            elevation: 5.0,
                                            color: bgColor,
                                            shadowColor: bgColor,
                                            child: TextFormField(
                                              style: TxtStls.fieldtitlestyle,
                                              controller: _certificateConroller,
                                              decoration: InputDecoration(
                                                hintText: "TYPE...",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_box,
                                            color: btnColor,
                                          ),
                                          onPressed: () {
                                            CrudOperations.certificateUpdate(
                                              id,
                                              _certificateConroller,
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      flex: 1,
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
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: bgColor,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Payments Terms",
                                      style: TxtStls.fieldstyle),
                                  Text("Comments", style: TxtStls.fieldstyle)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    color: Color(0xFFE0E0E0),
                                    height: 50,
                                    width: 1,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Advance Required",
                                          style: TxtStls.fieldstyle,
                                        ),
                                        Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                        Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Color(0xFFE0E0E0),
                                    height: 50,
                                    width: 1,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "TDS Applicable",
                                          style: TxtStls.fieldstyle,
                                        ),
                                        Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                        Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Color(0xFFE0E0E0),
                                    height: 50,
                                    width: 1,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "GST Applicable",
                                          style: TxtStls.fieldstyle,
                                        ),
                                        Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                        Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Color(0xFFE0E0E0),
                                    height: 50,
                                    width: 1,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Clients Location",
                                          style: TxtStls.fieldstyle,
                                        ),
                                        Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                        Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Color(0xFFE0E0E0),
                                    height: 50,
                                    width: 1,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Simple Required",
                                          style: TxtStls.fieldstyle,
                                        ),
                                        Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                        Checkbox(
                                            value: false,
                                            onChanged: (value) {}),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Color(0xFFE0E0E0),
                                    height: 50,
                                    width: 1,
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: size.height * 0.001,
                                  color: Color(0xFFE0E0E0),
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   children: [
                              //     Container(
                              //       color: Color(0xFFE0E0E0),
                              //       height: 50,
                              //       width: 1,
                              //     ),
                              //     Container(
                              //       child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text(
                              //             "Slab Percentage",
                              //             style: TxtStls.fieldstyle,
                              //           ),
                              //           Checkbox(
                              //               value: false,
                              //               onChanged: (value) {}),
                              //           Checkbox(
                              //               value: false,
                              //               onChanged: (value) {}),
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //       color: Color(0xFFE0E0E0),
                              //       height: 50,
                              //       width: 1,
                              //     ),
                              //     Container(
                              //       child: Column(
                              //         children: [
                              //           Text(
                              //             "Advance Required",
                              //             style: TxtStls.fieldstyle,
                              //           ),
                              //           Checkbox(
                              //               value: true, onChanged: (value) {}),
                              //           Checkbox(
                              //               value: true, onChanged: (value) {}),
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //       child: Column(
                              //         children: [
                              //           Text(
                              //             "Advance Required",
                              //             style: TxtStls.fieldstyle,
                              //           ),
                              //           Checkbox(
                              //               value: true, onChanged: (value) {}),
                              //           Checkbox(
                              //               value: true, onChanged: (value) {}),
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //       child: Column(
                              //         children: [
                              //           Text(
                              //             "Advance Required",
                              //             style: TxtStls.fieldstyle,
                              //           ),
                              //           Checkbox(
                              //               value: true, onChanged: (value) {}),
                              //           Checkbox(
                              //               value: true, onChanged: (value) {}),
                              //         ],
                              //       ),
                              //     ),
                              //     Container(
                              //       child: Column(
                              //         children: [
                              //           Text(
                              //             "Advance Required",
                              //             style: TxtStls.fieldstyle,
                              //           ),
                              //           Checkbox(
                              //               value: true, onChanged: (value) {}),
                              //           Checkbox(
                              //               value: true, onChanged: (value) {}),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width * 0.85 / 2,
                height: size.height * 0.85,
                color: AbgColor.withOpacity(0.0001),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.85 / 2,
                          decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                  child: Tooltip(
                                    message: "Agent",
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                btnColor.withOpacity(0.1),
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
                                    setState(() {});
                                  },
                                  onTap: () {}),
                              Container(
                                color: Color(0xFFE0E0E0),
                                height: 40,
                                width: 1,
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: Tooltip(
                                    message: "Filters",
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                btnColor.withOpacity(0.1),
                                            child: Lottie.asset(
                                                "assets/Lotties/filter.json"),
                                          ),
                                          Text("Await",
                                              style: TxtStls.fieldstyle)
                                        ],
                                      ),
                                    ),
                                  ),
                                  onHover: (value) {
                                    setState(() {});
                                  }),
                              Container(
                                color: Color(0xFFE0E0E0),
                                height: 40,
                                width: 1,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Tooltip(
                                  message: "Current Status",
                                  child: CircleAvatar(
                                    backgroundColor: btnColor.withOpacity(0.1),
                                    child: Container(
                                      child: Lottie.asset(
                                          "assets/Lotties/live.json",
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                onHover: (value) {
                                  setState(() {});
                                },
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    decoration: BoxDecoration(
                                        color:
                                            StatusUpdateServices.CatColor(cat),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    alignment: Alignment.center,
                                    child: Text(
                                      cat,
                                      style: TxtStls.fieldstyle1,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: spClr,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Specification",
                                      style: TxtStls.fieldstyle1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                color: Color(0xFFE0E0E0),
                                height: 40,
                                width: 1,
                              ),
                              InkWell(
                                child: Tooltip(
                                  message: "Statistics",
                                  child: CircleAvatar(
                                    backgroundColor: btnColor.withOpacity(0.1),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Lottie.asset(
                                          "assets/Lotties/stats.json"),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.25),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          width: size.width * 0.85 / 2,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Tasks")
                              .where("id", isEqualTo: id)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            return ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (_, i) => Divider(
                                      height: 10,
                                      color: Color(0xFFE0E0E0),
                                    ),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  List lr =
                                      snapshot.data!.docs[index]["Activity"];
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: lr.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String statecolor = lr[index]["From"];
                                      String statecolor1 = lr[index]["To"];
                                      String date = DateFormat('dd-MMM-yy')
                                          .format(lr[index]["When"].toDate());
                                      String time = DateFormat('hh:mm a')
                                          .format(lr[index]["When"].toDate());
                                      DateTime dt1 =
                                          DateTime.parse(lr[index]["LatDate"]);
                                      String lastDate =
                                          DateFormat('dd-MMM-yy').format(dt1);

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              color: bgColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            btnColor
                                                                .withOpacity(
                                                                    0.1),
                                                        child: Icon(
                                                            Icons.fast_forward,
                                                            color: btnColor),
                                                      ),
                                                      Text(
                                                        date,
                                                        style:
                                                            TxtStls.fieldstyle,
                                                      ),
                                                    ],
                                                  )),
                                                  Container(
                                                    color: Color(0xFFE0E0E0),
                                                    height: 40,
                                                    width: 1,
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                btnColor
                                                                    .withOpacity(
                                                                        0.1),
                                                            child: Icon(
                                                                Icons.timer,
                                                                color:
                                                                    btnColor),
                                                          ),
                                                          Text(time,
                                                              style: TxtStls
                                                                  .fieldstyle),
                                                        ],
                                                      )),
                                                  Container(
                                                    color: Color(0xFFE0E0E0),
                                                    height: 40,
                                                    width: 1,
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                btnColor
                                                                    .withOpacity(
                                                                        0.1),
                                                            child: Icon(
                                                                Icons
                                                                    .date_range,
                                                                color:
                                                                    btnColor),
                                                          ),
                                                          Text(lastDate,
                                                              style: TxtStls
                                                                  .fieldstyle),
                                                        ],
                                                      )),
                                                  Container(
                                                    color: Color(0xFFE0E0E0),
                                                    height: 40,
                                                    width: 1,
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 50,
                                                      child: lr[index]["Yes"] ==
                                                              true
                                                          ? Lottie.asset(
                                                              "assets/Lotties/success.json")
                                                          : Lottie.asset(
                                                              "assets/Lotties/fail.json"))
                                                ],
                                              ),
                                              Container(
                                                height: size.height * 0.001,
                                                color: Color(0xFFE0E0E0),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text("From",
                                                            style: TxtStls
                                                                .fieldstyle),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 120,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                            color: FlagService
                                                                .stateClr(
                                                                    statecolor),
                                                          ),
                                                          child: Text(
                                                              lr[index]["From"],
                                                              style: TxtStls
                                                                  .fieldstyle1),
                                                        ),
                                                        Text("TO",
                                                            style: TxtStls
                                                                .fieldstyle),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          width: 120,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                            color: FlagService
                                                                .stateClr1(
                                                                    statecolor1),
                                                          ),
                                                          child: Text(
                                                              lr[index]["To"],
                                                              style: TxtStls
                                                                  .fieldstyle1),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Color(0xFFE0E0E0),
                                                    height: 40,
                                                    width: 1,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                btnColor
                                                                    .withOpacity(
                                                                        0.1),
                                                            child: Icon(
                                                                Icons
                                                                    .videogame_asset,
                                                                color:
                                                                    btnColor),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.0),
                                                            alignment: Alignment
                                                                .center,
                                                            width: 150,
                                                            decoration: BoxDecoration(
                                                                color: lr[index]
                                                                            [
                                                                            "Bound"] ==
                                                                        "InBound"
                                                                    ? goodClr
                                                                    : avgClr,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.0))),
                                                            child: Text(
                                                              lr[index]
                                                                  ["Bound"],
                                                              style: TxtStls
                                                                  .fieldstyle1,
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.0),
                                                            alignment: Alignment
                                                                .center,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                                color: avgClr,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.0))),
                                                            child: Text(
                                                                lr[index]
                                                                    ["Action"],
                                                                style: TxtStls
                                                                    .fieldstyle1),
                                                          ),
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(8.0),
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Text("Notes : ",
                                                              style: TxtStls
                                                                  .fieldstyle),
                                                          Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              lr[index]["Who"],
                                                              style: TxtStls
                                                                  .fieldstyle,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                    ),
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                      ),
                                                      elevation: 10,
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 100,
                                                          width:
                                                              size.width * 0.35,
                                                          child: Text(
                                                              lr[index]["Note"],
                                                              style: TxtStls
                                                                  .notestyle)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                          }),
                    ),
                  ],
                ),
              )
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

Widget service(e, id) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Container(
      padding: const EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: neClr),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            e,
            style: TxtStls.fieldstyle1,
          ),
          IconButton(
            icon: const Icon(
              Icons.cancel,
              color: bgColor,
              size: 15,
            ),
            onPressed: () {
              CrudOperations.deleteCertifcate(id, e);
            },
          )
        ],
      ),
    ),
  );
}
