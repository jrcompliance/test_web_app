// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_countdown_timer/current_remaining_time.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
// import 'package:intl/intl.dart';
// import 'package:just_the_tooltip/just_the_tooltip.dart';
// import 'package:provider/provider.dart';
// import 'package:test_web_app/Constants/LabelText.dart';
// import 'package:test_web_app/Constants/Services.dart';
// import 'package:test_web_app/Constants/reusable.dart';
// import 'package:test_web_app/Constants/shape.dart';
// import 'package:test_web_app/Models/MoveModel.dart';
// import 'package:test_web_app/UserProvider/ShowLeadProvider.dart';
// import 'package:test_web_app/UserProvider/UserProvider.dart';
// import 'dart:html';
// import 'dart:ui' as ui;
//
// class InvoiceScreen extends StatefulWidget {
//   const InvoiceScreen({Key? key}) : super(key: key);
//
//   @override
//   _InvoiceScreenState createState() => _InvoiceScreenState();
// }
//
// class _InvoiceScreenState extends State<InvoiceScreen> {
//   var img;
//   @override
//   Widget build(BuildContext context) {
//     Provider.of<ShowLeadProvider>(context, listen: false).fetchAllLead();
//     final alluserModellist =
//         Provider.of<AllUSerProvider>(context).alluserModellist;
//     Size size = MediaQuery.of(context).size;
//     final showleadmodellist =
//         Provider.of<ShowLeadProvider>(context).showleadmodellist;
//     return Container(
//       width: size.width,
//       height: size.height * 0.8,
//     );
//   }
//
//   Widget dropdowns(id, cat, newsta, prosta, insta, wonsta, clsta) {
//     Size size = MediaQuery.of(context).size;
//     if (cat == "NEW") {
//       return Container(
//         alignment: Alignment.center,
//         width: size.width * 0.1,
//         decoration: BoxDecoration(
//             color: StatusUpdateServices.statcolorget(newsta),
//             borderRadius: BorderRadius.all(Radius.circular(20.0))),
//         child: PopupMenuButton(
//           tooltip: "UpDate Status",
//           padding: EdgeInsets.zero,
//           shape: TooltipShape(),
//           offset: Offset(0, size.height * 0.035),
//           onSelected: (value) {
//             StatusUpdateServices.updateStatus(id, value.toString());
//             setState(() {});
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   StatusUpdateServices.statusget(newsta),
//                   style: TxtStls.fieldstyle1,
//                 ),
//                 Icon(
//                   Icons.arrow_drop_down_outlined,
//                   color: bgColor,
//                 )
//               ],
//             ),
//           ),
//           itemBuilder: (context) {
//             return [
//               PopupMenuItem(
//                 value: "FRESH",
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     color: wonClr,
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "FRESH",
//                       style: TxtStls.fieldstyle1,
//                     ),
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: "ASSIGNED",
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     color: flwClr,
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "ASSIGNED",
//                       style: TxtStls.fieldstyle1,
//                     ),
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: "CONTACTED",
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     color: conClr,
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "CONTACTED",
//                       style: TxtStls.fieldstyle1,
//                     ),
//                   ),
//                 ),
//               ),
//             ];
//           },
//         ),
//       );
//     } else if (cat == "PROSPECT") {
//       return Container(
//         alignment: Alignment.center,
//         width: size.width * 0.1,
//         decoration: BoxDecoration(
//             color: StatusUpdateServices.statcolorget1(prosta),
//             borderRadius: BorderRadius.all(Radius.circular(20.0))),
//         child: PopupMenuButton(
//           tooltip: "UpDate Status",
//           padding: EdgeInsets.zero,
//           shape: TooltipShape(),
//           offset: Offset(0, size.height * 0.035),
//           onSelected: (value) {
//             StatusUpdateServices.updateStatus1(id, value.toString());
//             setState(() {});
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   StatusUpdateServices.statusget1(prosta),
//                   style: TxtStls.fieldstyle1,
//                 ),
//                 Icon(
//                   Icons.arrow_drop_down_outlined,
//                   color: bgColor,
//                 )
//               ],
//             ),
//           ),
//           itemBuilder: (context) {
//             return [
//               PopupMenuItem(
//                 value: "AVERAGE",
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     color: avgClr,
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "   AVERAGE   ",
//                       style: TxtStls.fieldstyle1,
//                     ),
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: "GOOD",
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     color: goodClr,
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "   GOOD   ",
//                       style: TxtStls.fieldstyle1,
//                     ),
//                   ),
//                 ),
//               ),
//             ];
//           },
//         ),
//       );
//     } else if (cat == "IN PROGRESS") {
//       return Container(
//         alignment: Alignment.center,
//         width: size.width * 0.1,
//         decoration: BoxDecoration(
//             color: StatusUpdateServices.statcolorget2(insta),
//             borderRadius: BorderRadius.all(Radius.circular(20.0))),
//         child: PopupMenuButton(
//           tooltip: "UpDate Status",
//           padding: EdgeInsets.zero,
//           shape: TooltipShape(),
//           offset: Offset(0, size.height * 0.035),
//           onSelected: (value) {
//             StatusUpdateServices.updateStatus2(id, value.toString());
//             setState(() {});
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   StatusUpdateServices.statusget2(insta),
//                   style: TxtStls.fieldstyle1,
//                 ),
//                 Icon(
//                   Icons.arrow_drop_down_outlined,
//                   color: bgColor,
//                 )
//               ],
//             ),
//           ),
//           itemBuilder: (context) {
//             return [
//               PopupMenuItem(
//                 value: "FOLLOWUP",
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     color: flwClr,
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "FOLLOWUP",
//                       style: TxtStls.fieldstyle1,
//                     ),
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: "SPECIFICATION",
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     color: spClr,
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "SPECIFICATION",
//                       style: TxtStls.fieldstyle1,
//                     ),
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: "QUOTATION",
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     color: qtoClr,
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "QUOTATION",
//                       style: TxtStls.fieldstyle1,
//                     ),
//                   ),
//                 ),
//               ),
//             ];
//           },
//         ),
//       );
//     } else if (cat == "WON") {
//       return Container(
//         alignment: Alignment.center,
//         width: size.width * 0.1,
//         decoration: BoxDecoration(
//             color: StatusUpdateServices.statcolorget4(wonsta),
//             borderRadius: BorderRadius.all(Radius.circular(20.0))),
//         child: PopupMenuButton(
//           tooltip: "UpDate Status",
//           padding: EdgeInsets.zero,
//           shape: TooltipShape(),
//           offset: Offset(0, size.height * 0.035),
//           onSelected: (value) {
//             StatusUpdateServices.updateStatus4(id, value.toString());
//             setState(() {});
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   StatusUpdateServices.statusget4(wonsta),
//                   style: TxtStls.fieldstyle1,
//                 ),
//                 Icon(
//                   Icons.arrow_drop_down_outlined,
//                   color: bgColor,
//                 )
//               ],
//             ),
//           ),
//           itemBuilder: (context) {
//             return [
//               PopupMenuItem(
//                 value: "PAYMENT",
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     color: wonClr,
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "PAYMENT",
//                       style: TxtStls.fieldstyle1,
//                     ),
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: "DOCUMENTS",
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     color: flwClr,
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "DOCUMENTS",
//                       style: TxtStls.fieldstyle1,
//                     ),
//                   ),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: "SAMPLES",
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                     color: goodClr,
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       "SAMPLES",
//                       style: TxtStls.fieldstyle1,
//                     ),
//                   ),
//                 ),
//               ),
//             ];
//           },
//         ),
//       );
//     }
//     return Container(
//       alignment: Alignment.center,
//       width: size.width * 0.1,
//       decoration: BoxDecoration(
//           color: StatusUpdateServices.statcolorget5(clsta),
//           borderRadius: BorderRadius.all(Radius.circular(20.0))),
//       child: PopupMenuButton(
//         tooltip: "UpDate Status",
//         padding: EdgeInsets.zero,
//         shape: TooltipShape(),
//         offset: Offset(0, size.height * 0.035),
//         onSelected: (value) {
//           StatusUpdateServices.updateStatus5(id, value.toString());
//           setState(() {});
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text(
//                 StatusUpdateServices.statusget5(clsta),
//                 style: TxtStls.fieldstyle11,
//               ),
//               Icon(
//                 Icons.arrow_drop_down_outlined,
//                 color: bgColor,
//               )
//             ],
//           ),
//         ),
//         itemBuilder: (context) {
//           return [
//             PopupMenuItem(
//               value: "IRRELEVANT",
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                   color: irrClr,
//                 ),
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Text(
//                     "IRRELEVANT",
//                     style: TxtStls.fieldstyle1,
//                   ),
//                 ),
//               ),
//             ),
//             PopupMenuItem(
//               value: "BUDGET ISSUE",
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                   color: clsClr,
//                 ),
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Text(
//                     "BUDGET ISSUE",
//                     style: TxtStls.fieldstyle1,
//                   ),
//                 ),
//               ),
//             ),
//             PopupMenuItem(
//               value: "INFORMATIVE",
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                   color: flwClr,
//                 ),
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Text(
//                     "INFORMATIVE",
//                     style: TxtStls.fieldstyle1,
//                   ),
//                 ),
//               ),
//             ),
//             PopupMenuItem(
//               value: "NO ANSWER",
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                   color: conClr,
//                 ),
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Text(
//                     "NO ANSWER",
//                     style: TxtStls.fieldstyle1,
//                   ),
//                 ),
//               ),
//             )
//           ];
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/UserProvider/ShowLeadProvider.dart';
import 'package:test_web_app/Providers/UserProvider.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AllLeadsProvider>(context, listen: false).fetchAllLead();
  }

  var img;

  @override
  Widget build(BuildContext context) {
    final allledaslist =
        Provider.of<AllLeadsProvider>(context).showleadmodellist;
    final alluserModellist =
        Provider.of<AllUSerProvider>(context).alluserModellist;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
      child: Column(
        children: [
          title(),
          allledaslist.isEmpty
              ? Lottie.asset("assets/Lotties/empty.json")
              : ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  itemCount: allledaslist.length,
                  itemBuilder: (BuildContext context, int i) {
                    var snp = allledaslist[i];
                    String? id = snp.id;
                    String? taskname = snp.task;
                    int? CxID = snp.CxID;
                    Timestamp? startDate = snp.startDate;
                    String? endDate = snp.endDate;
                    String createDate =
                        DateFormat("EEE | MMM").format(startDate.toDate());
                    String careatedate1 =
                        DateFormat("dd, yy").format(startDate.toDate());
                    DateTime dt = DateTime.parse(endDate);
                    String edf = DateFormat("EEE | MMM").format(dt);
                    String edf1 = DateFormat("dd, yy").format(dt);
                    String? message = snp.meesage;
                    List? companydeatails = snp.companyDetails;
                    String? contactname = companydeatails[0]["contactperson"];
                    String? cemail = companydeatails[0]["email"];
                    String? cphone = companydeatails[0]["phone"];
                    var tooltipController;
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: bgColor,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: JustTheTooltip(
                              showWhenUnlinked: true,
                              controller: tooltipController,
                              showDuration: Duration(seconds: 0),
                              offset: -40.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              preferredDirection: AxisDirection.right,
                              child: Container(
                                  width: size.width * 0.115,
                                  alignment: Alignment.centerLeft,
                                  child: Flexible(
                                    child: Text(
                                      taskname,
                                      style: ClrStls.tnClr,
                                    ),
                                  )),
                              content: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setstate) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10.0),
                                    width: size.width * 0.2,
                                    height: size.height * 0.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              maxRadius: 15,
                                              child: Icon(Icons.person,
                                                  color: btnColor, size: 15),
                                              backgroundColor:
                                                  btnColor.withOpacity(0.1),
                                            ),
                                            SizedBox(width: 5),
                                            Text(contactname.toString(),
                                                style: TxtStls.fieldstyle),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              maxRadius: 15,
                                              child: Icon(Icons.email,
                                                  color: btnColor, size: 15),
                                              backgroundColor:
                                                  btnColor.withOpacity(0.1),
                                            ),
                                            SizedBox(width: 5),
                                            Text(cemail.toString(),
                                                style: TxtStls.fieldstyle),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              maxRadius: 15,
                                              child: Icon(
                                                Icons.phone,
                                                color: btnColor,
                                                size: 15,
                                              ),
                                              backgroundColor:
                                                  btnColor.withOpacity(0.1),
                                            ),
                                            SizedBox(width: 5),
                                            Text(cphone.toString(),
                                                style: TxtStls.fieldstyle),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              maxRadius: 15,
                                              child: Icon(
                                                Icons.message_rounded,
                                                color: btnColor,
                                                size: 15,
                                              ),
                                              backgroundColor:
                                                  btnColor.withOpacity(0.1),
                                            ),
                                            SizedBox(width: 5),
                                            Flexible(
                                              child: Text(
                                                message,
                                                style: TxtStls.fieldstyle,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              shadow: Shadow(color: btnColor, blurRadius: 20),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(
                                CxID.toString(),
                                style: TxtStls.fieldstyle,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                createDate.toString() +
                                    " ${careatedate1.toString()}",
                                style: TxtStls.fieldstyle,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(" ${edf}" + " ${edf1}",
                                    style: ClrStls.endClr)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.centerLeft,
                              child: PopupMenuButton(
                                tooltip: "Assignee",
                                icon: Icon(
                                  Icons.add_circle,
                                  color: btnColor,
                                ),
                                color: bgColor,
                                itemBuilder: (context) => alluserModellist
                                    .map((item) => PopupMenuItem(
                                        onTap: () {
                                          img = item.auserimage;
                                          print(img);

                                          setState(() {});
                                        },
                                        value: item.uid,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  item.auserimage.toString()),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              item.ausername.toString(),
                                              style: TxtStls.fieldstyle,
                                            ),
                                          ],
                                        )))
                                    .toList(),
                                onSelected: (value) {
                                  AssignServices.assign(id, value, img);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 7.5);
                  },
                )
        ],
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: titlelist
            .map((e) => Expanded(
                  flex: 2,
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
      ),
    );
  }

  final titlelist = ["Leads", "CxID", "LeadDate", "EndDate", "AssignTo"];
}
