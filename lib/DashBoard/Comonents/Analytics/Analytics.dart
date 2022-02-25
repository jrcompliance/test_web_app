import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/alluserModel.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/UserProvider/UserProvider.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    final alluserModellist =
        Provider.of<AllUSerProvider>(context).alluserModellist;
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
                      child: alluserModellist.length <= 0
                          ? Center(
                              child: SpinKitFadingCube(
                                color: btnColor,
                                size: size.height * 0.01,
                              ),
                            )
                          : ListView.builder(
                              itemCount: alluserModellist.length,
                              itemBuilder: (context, int index) {
                                var snp = alluserModellist[index];
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
                                                          NetworkImage(snp
                                                              .auserimage
                                                              .toString()),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            size.width * 0.005),
                                                    Text(
                                                      snp.ausername.toString(),
                                                      style: TxtStls.fieldstyle,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Text(
                                                snp.auseremail.toString(),
                                                style: TxtStls.fieldstyle,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Text(
                                                  "+91 " +
                                                      snp.auserphone.toString(),
                                                  style: TxtStls.fieldstyle),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: snp.ausergender ==
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
                                                    snp.ausergender.toString(),
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
                                      aimageUrl = snp.auserimage;
                                      ausername = snp.ausername;
                                      aemail = snp.auseremail;
                                      aphone = snp.auserphone;
                                      adesignation = snp.auserdesignation;
                                      abgroup = snp.auserbgroup;
                                      aecontact = snp.auserecontact;
                                      audoj = snp.adoj;
                                      auadd = snp.aadd;
                                    });
                                  },
                                );
                              })),
                ],
              )),
          Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: aimageUrl == null
                    ? Lottie.asset("assets/Lotties/userdata.json",
                        reverse: true)
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                      adesignation == null
                                          ? ""
                                          : "(${adesignation!})",
                                      style: TxtStls.fieldstyle),
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey.withOpacity(0.2)),
                            SizedBox(height: size.height * 0.01),
                            Text("Contact Info",
                                style: TxtStls.fieldtitlestyle),
                            SizedBox(height: size.height * 0.01),
                            ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.email,
                                    color: btnColor, size: 15),
                                backgroundColor: btnColor.withOpacity(0.1),
                              ),
                              title:
                                  Text("Email", style: TxtStls.fieldtitlestyle),
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
                              title: Text("Address",
                                  style: TxtStls.fieldtitlestyle),
                              leading: CircleAvatar(
                                backgroundColor: btnColor.withOpacity(0.1),
                                child: Icon(
                                  Icons.location_on,
                                  color: btnColor,
                                  size: 15,
                                ),
                              ),
                              subtitle: Text(auadd == null ? "" : auadd!,
                                  style: TxtStls.fieldstyle),
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
                                aecontact == null ? "" : aecontact!,
                                style: TxtStls.fieldstyle,
                              ),
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
                                audoj == null ? "" : audoj!,
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
                              title: Text("Blood Group",
                                  style: TxtStls.fieldtitlestyle),
                              subtitle: Text(
                                abgroup == null ? "" : abgroup!,
                                style: TxtStls.fieldstyle,
                              ),
                            ),
                            Divider(color: Colors.grey.withOpacity(0.2)),
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
