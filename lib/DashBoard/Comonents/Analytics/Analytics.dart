import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_web_app/Constants/alluserModel.dart';
import 'package:test_web_app/Constants/reusable.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AbgColor.withOpacity(0.0001),
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.01),
                    child: title(),
                  ),
                  Container(
                    padding: EdgeInsets.all(0.1),
                    height: size.height * 0.9,
                    child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("EmployeeData")
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: Text(
                            "No Data Found",
                            style: TxtStls.fieldtitlestyle,
                          ));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: SpinKitFadingCube(
                            color: btnColor,
                            size: size.height * 0.05,
                          ));
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, int index) {
                              return InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      snapshot.data!.docs[index]
                                                          ["uimage"],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          size.width * 0.005),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ["uname"],
                                                    style: TxtStls.fieldstyle,
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ["uemail"],
                                              style: TxtStls.fieldstyle,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Text(
                                                "+91 " +
                                                    snapshot.data!.docs[index]
                                                        ['uphoneNumber'],
                                                style: TxtStls.fieldstyle),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: snapshot.data!
                                                                    .docs[index]
                                                                ["gender"] ==
                                                            "Male"
                                                        ? Colors.blue
                                                            .withOpacity(0.2)
                                                        : Colors.red
                                                            .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0))),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 20),
                                                child: Text(
                                                  snapshot.data!.docs[index]
                                                      ["gender"],
                                                  style: TxtStls.fieldstyle,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.more_horiz),
                                                onPressed: () {},
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    aimageUrl =
                                        snapshot.data!.docs[index]["uimage"];
                                    ausername =
                                        snapshot.data!.docs[index]["uname"];
                                    aemail =
                                        snapshot.data!.docs[index]["uemail"];
                                    aphone = snapshot.data!.docs[index]
                                        ["uphoneNumber"];
                                    udesignation = snapshot.data!.docs[index]
                                        ["udesignation"];
                                  });
                                },
                              );
                            });
                      },
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: size.height * 0.225,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  aimageUrl == null ? "" : aimageUrl!),
                              maxRadius: 50,
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(ausername == null ? "" : ausername!,
                                style: TxtStls.fieldtitlestyle),
                            Text(
                                udesignation == null
                                    ? ""
                                    : "(${udesignation!})",
                                style: TxtStls.fieldstyle),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2)),
                      SizedBox(height: size.height * 0.01),
                      Text("Contact Info", style: TxtStls.fieldtitlestyle),
                      SizedBox(height: size.height * 0.01),
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.email, color: btnColor, size: 15),
                          backgroundColor: btnColor.withOpacity(0.1),
                        ),
                        title: Text("Email", style: TxtStls.fieldtitlestyle),
                        subtitle: Text(aemail == null ? "" : aemail!,
                            style: TxtStls.fieldstyle),
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2)),
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.phone,
                            color: btnColor,
                            size: 15,
                          ),
                          backgroundColor: btnColor.withOpacity(0.1),
                        ),
                        title: Text("Phone Number",
                            style: TxtStls.fieldtitlestyle),
                        subtitle: Text(aphone == null ? "" : aphone!,
                            style: TxtStls.fieldstyle),
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2)),
                      ListTile(
                        title: Text("Address", style: TxtStls.fieldtitlestyle),
                        leading: CircleAvatar(
                          backgroundColor: btnColor.withOpacity(0.1),
                          child: Icon(
                            Icons.location_on,
                            color: btnColor,
                            size: 15,
                          ),
                        ),
                        subtitle: Text(
                            "4-19/1, Tana Bazar Dondapadu,Mellachervu,Suryapet,TS",
                            style: TxtStls.fieldstyle),
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2)),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: btnColor.withOpacity(0.1),
                          child: Icon(
                            Icons.calendar_today,
                            color: btnColor,
                            size: 15,
                          ),
                        ),
                        title: Text("Date of Joining",
                            style: TxtStls.fieldtitlestyle),
                        subtitle: Text(
                          "Wed | 12 jan 2021",
                          style: TxtStls.fieldstyle,
                        ),
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2)),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red.withOpacity(0.1),
                          child: Icon(
                            Icons.bloodtype_rounded,
                            color: Colors.red,
                            size: 15,
                          ),
                        ),
                        title:
                            Text("Blood Group", style: TxtStls.fieldtitlestyle),
                        subtitle: Text(
                          "B+",
                          style: TxtStls.fieldstyle,
                        ),
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2)),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red.withOpacity(0.1),
                          child: Icon(
                            Icons.call,
                            color: Colors.red,
                            size: 15,
                          ),
                        ),
                        title: Text("Emergency Contact",
                            style: TxtStls.fieldtitlestyle),
                        subtitle: Text(
                          "8978511783",
                          style: TxtStls.fieldstyle,
                        ),
                      ),
                      RaisedButton(
                          onPressed: () {},
                          child:
                              Text("Upload Files", style: TxtStls.fieldstyle1),
                          color: btnColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))))
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget title() {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: titlelist
          .map((e) => Expanded(
                flex: 9,
                child: Row(
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
                ),
              ))
          .toList(),
    );
  }

  Widget userlist() {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 1,
            child: Container(
              color: neClr,
              child: Text("Yalagala Srinivas"),
            )),
        Expanded(
          flex: 1,
          child: Container(
            color: prosClr,
            child: Text("Yalagala Srinivas"),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: ipClr,
            child: Text("Yalagala Srinivas"),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: wonClr,
            child: Text("Yalagala Srinivas"),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: clsClr,
            child: Text("Yalagala Srinivas"),
          ),
        ),
        // Expanded(
        //   flex: 1,
        //   child: Row(
        //     children: [
        //       Text("pdf"),
        //     ],
        //   ),
        // ),
        // Expanded(flex: 1, child: Text("pdf@gmail.com")),
        // Expanded(flex: 1, child: Text("+91 8247467723")),
        // Expanded(flex: 1, child: Text("Male")),
        // IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
      ],
    );
  }

  final titlelist = ["Name", "Email", "Phone Number", "Gender"];
}
