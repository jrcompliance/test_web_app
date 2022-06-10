import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';

import '../../../main.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    // required this.targetUser,
    // required this.chatroom,
    // required this.userModel,
    // required this.firebaseUser
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final TextEditingController _invoiceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _invoiceusername = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _customersearchController =
      TextEditingController();
  List<EmployeesModel> allEmployees = [];
  User? user = FirebaseAuth.instance.currentUser;

  String bnature = "Active";

  bool visible = false;
  CollectionReference? chatsCollectionReference;

  var employeeModal;

  bool _isTapped = false;

  EmployeesModel? logginUserModel;

  String? currentuid;
  getUserData() {
    FirebaseFirestore.instance
        .collection("EmployeeData")
        .doc(user!.uid)
        .get()
        .then((value) {
      logginUserModel = EmployeesModel.fromMap(value.data());
      setState(() {});
    });
  }

  var provider;

  @override
  void initState() {
    //  getUserData();
    Future.delayed(Duration(seconds: 0)).then((value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      currentuid = pref.getString("uid");
    });
    Future.delayed(Duration(seconds: 2)).then((value) {
      Provider.of<UserDataProvider>(context, listen: false)
          .getEmployeesList(currentuid)
          .then((value) {
        allEmployees =
            Provider.of<UserDataProvider>(context, listen: false).employeelist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.845,
      width: size.width,
      color: AbgColor.withOpacity(0.0001),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
    );
  }

  //TranslationAnimatedWidget.tween(
  //       duration: Duration(milliseconds: 250),
  //       translationDisabled: Offset(400, 0),
  //       translationEnabled: Offset(0, 0),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //                 color: bgColor,
  //               ),
  //               height: size.height * 0.92,
  //               padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
  //               child: Expanded(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(20),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             "Create New Invoice",
  //                             style: TextStyle(
  //                                 fontSize: 20,
  //                                 color: txtColor,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                           Icon(Icons.cancel, color: btnColor),
  //                         ],
  //                       ),
  //                       SizedBox(height: size.height * 0.05),
  //                       Container(
  //                         decoration: BoxDecoration(
  //                             color: fieldColor,
  //                             borderRadius:
  //                                 BorderRadius.all(Radius.circular(10.0))),
  //                         child: Padding(
  //                           padding: EdgeInsets.only(left: 15, right: 15, top: 2),
  //                           child: TextField(
  //                             controller: _searchController,
  //                             style: TxtStls.fieldstyle,
  //                             decoration: InputDecoration(
  //                                 suffixIcon: IconButton(
  //                                   icon: Icon(
  //                                     Icons.search,
  //                                     color: btnColor,
  //                                   ),
  //                                   onPressed: () {
  //                                     setState(() {
  //                                       Provider.of<GstProvider>(context,
  //                                               listen: false)
  //                                           .fetchGstData(_searchController.text)
  //                                           .then((value) {
  //                                         getarrayLength();
  //                                         visible = true;
  //                                         _invoiceusername.text = cusname!;
  //                                         _emailController.text = cusemail!;
  //                                         _nameController.text =
  //                                             Provider.of<GstProvider>(context,
  //                                                     listen: false)
  //                                                 .tradename
  //                                                 .toString();
  //                                         _dateController.text =
  //                                             DateFormat("dd-MM-yyyy")
  //                                                 .format(DateTime.now());
  //                                         _addressControoler.text =
  //                                             Provider.of<GstProvider>(context,
  //                                                     listen: false)
  //                                                 .principalplace
  //                                                 .toString();
  //                                         _pincodeController.text =
  //                                             Provider.of<GstProvider>(context,
  //                                                     listen: false)
  //                                                 .pincode
  //                                                 .toString();
  //                                         _panController.text =
  //                                             Provider.of<GstProvider>(context,
  //                                                     listen: false)
  //                                                 .pan
  //                                                 .toString();
  //                                         setState(() {
  //                                           _statusController.text =
  //                                               Provider.of<GstProvider>(context,
  //                                                       listen: false)
  //                                                   .gstinstatus
  //                                                   .toString();
  //                                           bnature = Provider.of<GstProvider>(
  //                                                   context,
  //                                                   listen: false)
  //                                               .businessnature![0]
  //                                               .toString();
  //                                         });
  //                                       });
  //                                     });
  //                                   },
  //                                 ),
  //                                 border: InputBorder.none,
  //                                 hintText: "Enter GSTIN Number...",
  //                                 hintStyle: TxtStls.fieldstyle),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(height: size.height * 0.05),
  //                       Visibility(
  //                         visible: visible,
  //                         child: ScaleAnimatedWidget.tween(
  //                           duration: Duration(milliseconds: 500),
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   CircleAvatar(
  //                                       maxRadius: 7,
  //                                       backgroundColor: Provider.of<GstProvider>(
  //                                                       context,
  //                                                       listen: false)
  //                                                   .gstinstatus
  //                                                   .toString() ==
  //                                               "Active"
  //                                           ? Colors.green
  //                                           : clsClr),
  //                                   SizedBox(width: 5),
  //                                   Text(
  //                                     _statusController.text.toString(),
  //                                     style: TxtStls.fieldstyle,
  //                                   ),
  //                                   Expanded(child: Text("")),
  //                                   Text(bnature, style: TxtStls.fieldstyle)
  //                                 ],
  //                               ),
  //                               space(),
  //                               Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Expanded(
  //                                     child: Padding(
  //                                         padding: EdgeInsets.only(right: 20),
  //                                         child: formfield("Invoice Id",
  //                                             _invoiceController, icnData())),
  //                                   ),
  //                                   Expanded(
  //                                     child: Padding(
  //                                         padding: EdgeInsets.only(left: 20),
  //                                         child: formfield(
  //                                             "Date",
  //                                             _dateController,
  //                                             Icon(Icons.calendar_today,
  //                                                 color: btnColor))),
  //                                   ),
  //                                 ],
  //                               ),
  //                               space(),
  //                               formfield(
  //                                   "TradeName", _nameController, icnData()),
  //                               space(),
  //                               formfield("Name", _invoiceusername, icnData()),
  //                               space(),
  //                               Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Expanded(
  //                                     child: Padding(
  //                                       padding: EdgeInsets.only(right: 20),
  //                                       child: formfield(
  //                                           "Email", _emailController, icnData()),
  //                                     ),
  //                                   ),
  //                                   Expanded(
  //                                     child: Padding(
  //                                       padding: EdgeInsets.only(left: 20),
  //                                       child: formfield(
  //                                           "Address",
  //                                           _addressControoler,
  //                                           Icon(
  //                                             Icons.location_on_rounded,
  //                                             color: btnColor,
  //                                           )),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               space(),
  //                               Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Expanded(
  //                                     child: Padding(
  //                                       padding: EdgeInsets.only(right: 20),
  //                                       child: formfield("PanNumber",
  //                                           _panController, icnData()),
  //                                     ),
  //                                   ),
  //                                   Expanded(
  //                                     child: Padding(
  //                                       padding: EdgeInsets.only(left: 20),
  //                                       child: formfield("PinCode",
  //                                           _pincodeController, icnData()),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               space(),
  //                               Row(
  //                                 children: [
  //                                   Expanded(
  //                                     flex: 4,
  //                                     child: InkWell(
  //                                       child: Container(
  //                                         padding: EdgeInsets.all(12.0),
  //                                         alignment: Alignment.center,
  //                                         decoration: BoxDecoration(
  //                                             color: bgColor,
  //                                             border: Border.all(color: btnColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10.0))),
  //                                         child: Text(
  //                                           "Send Invoice",
  //                                           style: TxtStls.btnstyle,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Expanded(flex: 1, child: Text("")),
  //                                   Expanded(
  //                                     flex: 4,
  //                                     child: InkWell(
  //                                       child: Container(
  //                                         padding: EdgeInsets.all(12.0),
  //                                         alignment: Alignment.center,
  //                                         decoration: BoxDecoration(
  //                                             color: btnColor,
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(10.0))),
  //                                         child: Text(
  //                                           "Create Invoice",
  //                                           style: TextStyle(color: Colors.white),
  //                                         ),
  //                                       ),
  //                                       onTap: () {},
  //                                     ),
  //                                   )
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(width: 10),
  //           Expanded(
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //                 color: bgColor,
  //               ),
  //               height: size.height * 0.92,
  //               padding: EdgeInsets.symmetric(
  //                   horizontal: size.width * 0.015, vertical: size.width * 0.015),
  //               child: Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         Text(
  //                           "Invoice Preview",
  //                           style: TextStyle(
  //                               fontSize: 20,
  //                               color: txtColor,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                         Expanded(child: Text(" ")),
  //                         IconButton(
  //                             onPressed: (() {
  //                               setState(() {});
  //                             }),
  //                             icon: Icon(Icons.download, color: btnColor)),
  //                         IconButton(
  //                             onPressed: (() {}),
  //                             icon: Icon(Icons.print_sharp, color: btnColor)),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: grClr,
  //                     ),
  //                     Row(
  //                       children: [
  //                         SizedBox(
  //                           height: size.height * 0.15,
  //                           width: size.width * 0.175,
  //                           child: Image.asset(
  //                             "assets/Logos/jrlogo.png",
  //                             filterQuality: FilterQuality.high,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                         Expanded(child: SizedBox()),
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.end,
  //                           children: [
  //                             Text("JR Compliance and Testing Labs",
  //                                 style: TxtStls.fieldstyle),
  //                             Text(
  //                                 "Regd. Office: 705, 7th Floor,Krishna Apra Tower",
  //                                 style: TxtStls.fieldstyle),
  //                             Text(
  //                                 "Netaji Subhash Place, Pitampura,New Delhi 110034,India",
  //                                 style: TxtStls.fieldstyle),
  //                             Text("JR Compliance and Testing Labs",
  //                                 style: TxtStls.fieldstyle),
  //                             Text("PAN: AALFJ0070E", style: TxtStls.fieldstyle),
  //                             Text("TAN: DELJ10631F", style: TxtStls.fieldstyle),
  //                             Text("GST REGN NO: 07AALFJ0070E1ZO",
  //                                 style: TxtStls.fieldstyle),
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: grClr,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text("To,", style: TxtStls.fieldtitlestyle),
  //                         Text(
  //                           "Invoice No.",
  //                           style: TxtStls.fieldtitlestyle,
  //                         )
  //                       ],
  //                     ),
  //                     Text(""),
  //                     Text("GST NO- ", style: TxtStls.fieldtitlestyle),
  //                     Text("Kind Atten: Mr.", style: TxtStls.fieldtitlestyle),
  //                     Align(
  //                       alignment: Alignment.centerRight,
  //                       child: Text(
  //                         "Issued On: " +
  //                             DateFormat("dd MMM,yyyy").format(DateTime.now()),
  //                         style: TxtStls.fieldstyle,
  //                       ),
  //                     ),
  //                     Align(
  //                         alignment: Alignment.centerRight,
  //                         child: Text("Payment Due: Paid",
  //                             style: TxtStls.fieldstyle)),
  //                     Divider(
  //                       color: grClr,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Expanded(
  //                             child: Text("# Description",
  //                                 style: TxtStls.fieldstyle)),
  //                         Expanded(
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text("SAC No", style: TxtStls.fieldstyle),
  //                               Text("Qty", style: TxtStls.fieldstyle),
  //                               Text("Unit Cost", style: TxtStls.fieldstyle),
  //                               Text("Amount(Rs)", style: TxtStls.fieldstyle),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: grClr,
  //                     ),
  //                     Expanded(child: SizedBox()),
  //                     Divider(
  //                       color: grClr,
  //                     ),
  //                     Text("Bank Details:",
  //                         style: GoogleFonts.nunito(
  //                             textStyle: TextStyle(
  //                                 fontSize: 13,
  //                                 color: txtColor,
  //                                 fontWeight: FontWeight.bold,
  //                                 decoration: TextDecoration.underline),
  //                             fontSize: 13,
  //                             color: txtColor,
  //                             fontWeight: FontWeight.bold,
  //                             decoration: TextDecoration.underline)),
  //                     Text("Company Name: JR Compliance And Testing Labs",
  //                         style: TxtStls.fieldtitlestyle),
  //                     Text("Bank Name: IDFC FIRST BANK",
  //                         style: TxtStls.fieldtitlestyle),
  //                     Text("Account Number: 10041186185",
  //                         style: TxtStls.fieldtitlestyle),
  //                     Text("IFSC Code: IDFB0040101",
  //                         style: TxtStls.fieldtitlestyle),
  //                     Text("SWIFT Code: IDFBINBBMUM",
  //                         style: TxtStls.fieldtitlestyle),
  //                     Text("Bank Address: Rohini, New Delhi-110085",
  //                         style: TxtStls.fieldtitlestyle),
  //                     Divider(
  //                       color: grClr,
  //                     ),
  //                     Text("Terms And Conditions:",
  //                         style: TxtStls.fieldtitlestyle),
  //                     InkWell(
  //                       child: Text(
  //                         "https://www.jrcompliance.com/terms-and-conditions",
  //                         style: TxtStls.fieldstyle,
  //                       ),
  //                       onTap: () {
  //                         launches.termsofuse();
  //                       },
  //                     ),
  //                     // InkWell(
  //                     //   child: Text(
  //                     //     "https://www.jrcompliance.com/privacy-policy",
  //                     //     style: ClrStls.tnClr,
  //                     //   ),
  //                     //   onTap: () {
  //                     //     launches.privacy();
  //                     //   },
  //                     // ),
  //                     // InkWell(
  //                     //   child: Text(
  //                     //     "https://www.jrcompliance.com/purchase-and-billing",
  //                     //     style: ClrStls.tnClr,
  //                     //   ),
  //                     //   onTap: () {
  //                     //     launches.privacy();
  //                     //   },
  //                     // )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  Widget formfield(title, _controller, icn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TxtStls.fieldtitlestyle),
        Container(
          decoration: deco,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 2),
            child: TextFormField(
              controller: _controller,
              style: TxtStls.fieldstyle,
              decoration: InputDecoration(
                hintText: title,
                hintStyle: TxtStls.fieldstyle,
                border: InputBorder.none,
                suffixIcon: icn,
              ),
              validator: (fullname) {
                if (fullname!.isEmpty) {
                  return "Name can not be empty";
                } else if (fullname.length < 3) {
                  return "Name should be atleast 3 letters";
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget icnData() {
    return Icon(
      Icons.horizontal_rule,
      color: fieldColor,
    );
  }

  Widget space() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * 0.025);
  }

  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  void getarrayLength() async {
    await _firebase
        .collection("InvoiceID")
        .doc("2dtDd787PkHNjpFag0H5")
        .get()
        .then((value) {
      setState(() {
        var list = List.from(value.data()!["id"]);
        String lastvalue = list.elementAt(list.length - 1);
        //   print("lastvalue is : " + lastvalue);
        updatearray(lastvalue);
      });
    });
  }

  updatearray(String lastvalue) async {
    var month = DateFormat("MM").format(DateTime.now());
    var year = DateFormat("yy").format(DateTime.now());

    int mymonth = int.parse(month);
    int myyear = int.parse(year);
    int acyear = myyear;
    int acyear1 = myyear;
    if (mymonth <= 3) {
      setState(() {
        acyear = myyear - 1;
      });
    } else {
      setState(() {
        acyear1 = myyear + 1;
      });
    }
    show() {
      if (mymonth <= 9) {
        return 0;
      } else {
        return null;
      }
    }

    String val = lastvalue.substring(6);
    //  print("pad value is : "+val);
    int addval = int.parse(val) + 1;
    // print("Added value is : " + addval.toString());
    var storeval = show().toString() +
        mymonth.toString() +
        acyear.toString() +
        acyear1.toString() +
        addval.toString();
    // print(storeval);
    setState(() {
      _invoiceController.text = "#JR" + storeval;
    });
    await _firebase.collection("InvoiceID").doc("2dtDd787PkHNjpFag0H5").update({
      "id": FieldValue.arrayUnion([storeval]),
    });
  }
}
