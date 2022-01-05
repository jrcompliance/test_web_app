import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'dart:ui' as ui;
import 'dart:html';

class LeadScreen extends StatefulWidget {
  const LeadScreen({Key? key}) : super(key: key);
  @override
  _LeadScreenState createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final TextEditingController _taskController = TextEditingController();
  bool istrue = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return role == "Admin"
        ? Padding(
            padding: Responsive.isSmallScreen(context)
                ? const EdgeInsets.all(10.0)
                : const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: Container(
                padding: EdgeInsets.all(10.0),
                width: width * 0.5,
                height: height,
                color: secondaryColor,
                child: StreamBuilder(
                  stream: _fireStore.collection("Tasks").snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: check()),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          String flagres =
                              snapshot.data!.docs[index]["priority"];
                          String date = DateFormat('dd-MMM-yy').format(
                              snapshot.data!.docs[index]["startDate"].toDate());
                          String time = DateFormat('hh:mm a').format(
                              snapshot.data!.docs[index]["startDate"].toDate());
                          var logo = snapshot.data!.docs[index]["logo"];
                          // ignore: undefined_prefixed_name
                          ui.platformViewRegistry.registerViewFactory(
                            logo,
                            (int _) => ImageElement()..src = logo,
                          );
                          List cert = snapshot.data!.docs[index]["Attachments"];

                          String id = snapshot.data!.docs[index]["id"];
                          var snp = snapshot.data!.docs;
                          return Card(
                            elevation: 10.0,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      istrue
                                          ? Flexible(
                                              child: TextFormField(
                                              controller: _taskController,
                                            ))
                                          : Expanded(
                                              child: Text(
                                              snp[index]["task"],
                                              style: TxtStls.stl1,
                                            )),
                                      IconButton(
                                          onPressed: () {
                                            istrue = !istrue;
                                            setState(() {});
                                          },
                                          icon: istrue
                                              ? Icon(Icons.check)
                                              : Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            _showMyDialog(id);
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Flexible(
                                      child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    width: width / 5,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: grClr)),
                                    child: Text(
                                      snapshot.data!.docs[index]["message"],
                                      style: TxtStls.stl1,
                                    ),
                                  )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: "Created : ",
                                            style: TxtStls.stl1,
                                            children: [
                                              TextSpan(text: date),
                                            ]),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text: "At : ",
                                            style: TxtStls.stl1,
                                            children: [
                                              TextSpan(text: time),
                                            ]),
                                      ),
                                      snapshot.data!.docs[index]["priority"] ==
                                              null
                                          ? PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                var pricol = value;
                                                String prcl = pricol.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                FlagService.updateFlag(
                                                    id, prcl);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.flag,
                                                color: FlagService.pricolorget(
                                                    flagres),
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
                                                      value: "E",
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                            )
                                          : PopupMenuButton(
                                              color: Clrs.txtColor,
                                              onSelected: (value) {
                                                var pricol = value;
                                                String prcl = pricol.toString();
                                                String id = snapshot
                                                    .data!.docs[index]["id"];
                                                FlagService.updateFlag(
                                                    id, prcl);
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.flag,
                                                color: FlagService.pricolorget(
                                                    flagres),
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
                                                      value: "E",
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Contact Details  : ",
                                    style: TxtStls.stl1,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.perm_contact_calendar_rounded),
                                      Text(
                                        snapshot.data!.docs[index]
                                                ["CompanyDetails"][0]
                                            ["contactperson"],
                                        style: TxtStls.stl1,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.email_outlined),
                                      Text(
                                        snapshot.data!.docs[index]
                                            ["CompanyDetails"][0]["email"],
                                        style: TxtStls.stl1,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.call),
                                      Text(
                                        snapshot.data!.docs[index]
                                            ["CompanyDetails"][0]["phone"],
                                        style: TxtStls.stl1,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      cert.isEmpty
                                          ? Text("")
                                          : Expanded(
                                              child: Row(
                                                  children: cert
                                                      .map(
                                                        (e) => Stack(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  CachedNetworkImageProvider(
                                                                      e["uid1"]),
                                                            ),
                                                            Positioned(
                                                              top: -15,
                                                              right: -10,
                                                              child: IconButton(
                                                                icon: Icon(Icons
                                                                    .close),
                                                                onPressed: () {
                                                                  AssignServices
                                                                      .remove(
                                                                          id,
                                                                          e);
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                      .toList()),
                                            ),
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("EmployeeData")
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            var snp = snapshot.data!.docs;
                                            String? img;
                                            if (!snapshot.hasData) {
                                              return Container();
                                            }
                                            return PopupMenuButton(
                                              icon: Icon(Icons.person_add),
                                              color: txtColor,
                                              itemBuilder: (context) => snp
                                                  .map((item) => PopupMenuItem(
                                                      onTap: () {
                                                        img =
                                                            item.get("uimage");
                                                        setState(() {});
                                                      },
                                                      value: item.get("uid"),
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    item.get(
                                                                        "uimage")),
                                                          ),
                                                          Text(
                                                            item.get("uname"),
                                                          ),
                                                        ],
                                                      )))
                                                  .toList(),
                                              onSelected: (value) {
                                                print(img);
                                                // AssignServices.assign(
                                                //     id, value, img);
                                              },
                                            );
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                )),
          )
        : Center(
            child: Text(
            "Admins Only",
            style: TxtStls.stl1,
          ));
  }

  check() {
    if (Responsive.isSmallScreen(context)) {
      return 2;
    } else if (Responsive.isMediumScreen(context)) {
      return 3;
    } else {
      return 4;
    }
  }

  Future<void> _showMyDialog(id) async {
    return showDialog<void>(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: txtColor,
          title: const Text('Are you sure to Delete ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Once you delete can not retrive it!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ok'),
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
}
