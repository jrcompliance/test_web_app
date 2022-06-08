import 'dart:developer';
import 'dart:ui';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/Comonents/Messages/ChatItem.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/NewModels/ChattingScreen.dart';
import 'package:test_web_app/NewModels/MessageModel.dart';
import 'package:test_web_app/NewModels/RoomModel.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';
import 'package:test_web_app/Providers/GetChatProvider.dart';
import 'package:test_web_app/Providers/GstProvider.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthReuses/Url_launchers.dart';
import 'package:test_web_app/main.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

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

  var roomModal;
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
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.845,
      width: size.width,
      color: AbgColor.withOpacity(0.0001),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
              decoration: BoxDecoration(
                  color: bgColor, borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: fieldColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 2),
                      child: TextField(
                          controller: _customersearchController,
                          style: TxtStls.fieldstyle,
                          decoration: InputDecoration(
                              suffixIcon:
                                  _customersearchController.text.isNotEmpty
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: btnColor,
                                          ),
                                          onPressed: () {
                                            _customersearchController.clear();
                                            searchCustomer("");
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          },
                                        )
                                      : Icon(
                                          Icons.search,
                                          color: btnColor,
                                        ),
                              border: InputBorder.none,
                              hintText:
                                  "Enter Customer name or email or phone.....",
                              hintStyle: TxtStls.fieldstyle),
                          onChanged: searchCustomer),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  allEmployees.length <= 0
                      ? Center(
                          child: SpinKitFadingCube(color: btnColor, size: 15),
                        )
                      : StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("EmployeeData")
                              .get()
                              .asStream(),
                          builder: (context, snapshot) {
                            return ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ClampingScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int i) {
                                EmployeesModel employeeModel =
                                    EmployeesModel.fromMap(
                                        snapshot.data!.docs[i].data());
                                if (employeeModel.uid ==
                                    FirebaseAuth.instance.currentUser!.uid) {
                                  return Container();
                                }

                                //  var snp = allEmployees[i];
                                return Material(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: bgColor,
                                  child: ListTile(
                                    tileColor: grClr.withOpacity(0.1),
                                    hoverColor: btnColor.withOpacity(0.2),
                                    selectedColor: btnColor.withOpacity(0.2),
                                    selectedTileColor:
                                        btnColor.withOpacity(0.2),
                                    leading: CircleAvatar(
                                      backgroundColor:
                                          btnColor.withOpacity(0.1),
                                      backgroundImage: employeeModel.uimage
                                                  .toString() ==
                                              null
                                          ? NetworkImage(
                                              "https://cdn1.iconfinder.com/data/icons/bokbokstars-121-classic-stock-icons-1/512/person-man.png")
                                          : NetworkImage(
                                              employeeModel.uimage.toString()),
                                      // child: Icon(
                                      //   Icons.person,
                                      //   color: btnColor,
                                      // )
                                    ),
                                    title: Text(
                                      employeeModel.uname.toString(),
                                      style: TxtStls.fieldtitlestyle,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          employeeModel.uemail.toString(),
                                          style: TxtStls.fieldstyle,
                                        ),
                                        Text(
                                          employeeModel.uphoneNumber.toString(),
                                          style: TxtStls.fieldstyle,
                                        ),
                                      ],
                                    ),
                                    trailing: CircleAvatar(
                                      backgroundColor:
                                          btnColor.withOpacity(0.1),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _isTapped = true;

                                        employeeModal = employeeModel;
                                        getChatRoomModel(employeeModel);
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(color: grClr.withOpacity(0.5));
                              },
                            );
                          })
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 7,
            child:
                // roomModel.roomId != null
                //     ? chatScreen()
                // roomModel.roomId != null
                //     ? ChattingScreen(
                //         employeesModel: employeeModal,
                //         roomModel: roomModel,
                //       )
                //     :
                // _isTapped
                //     ? Container(
                //         child: chatScreen(
                //             roomModel: roomModal,
                //             employeesModel: employeeModal)):
                Container(),
          ),
        ],
      ),
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

  TextEditingController textEditingController = TextEditingController();
  sendMessage() async {
    RoomModel roomModel = RoomModel();
    if (textEditingController.text.length == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter message")));
      return;
    }
    String message = textEditingController.text;

    MessageModel messageModel = MessageModel();
    messageModel.message = message;
    await chatsCollectionReference!.add(messageModel.toMap());

    Map<String, dynamic> roomMap = Map();
    roomMap['lastMessage'] = message;
    roomMap['timeStamp'] = FieldValue.serverTimestamp();

    await FirebaseFirestore.instance
        .collection("Rooms")
        .doc(roomModel.roomId)
        .update(roomMap);

    textEditingController.clear();
  }

  Widget chatScreen({RoomModel? roomModel, EmployeesModel? employeesModel}) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Text(employeesModel!.uname ?? "Chat"),
        ),
        Expanded(
            flex: 8,
            child: StreamBuilder<QuerySnapshot>(
                stream: chatsCollectionReference!
                    // .where("senderId", isEqualTo: widget.roomModel.senderId)
                    // .where('peerId', isEqualTo: widget.roomModel.peerId)
                    .orderBy("timeStamp")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length == 0) {
                      return Center(child: Text("No chats Found"));
                    }

                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, index) {
                          MessageModel messageModel = MessageModel.fromMap(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);
                          return ChatItem(messageModel);
                        });
                  }

                  return Center(child: CircularProgressIndicator());
                })),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      hintText: "Enter message", border: OutlineInputBorder()),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          sendMessage();
                        });
                      },
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context).accentColor,
                      )))
            ],
          ),
        )
      ],
    );
  }

  void searchCustomer(String query) {
    final allEmployees = Provider.of<UserDataProvider>(context, listen: false)
        .employeelist
        .where((element) {
      final customertitle = element.uname!.toLowerCase();
      final customeremail = element.uemail!.toLowerCase();
      final customerphone = element.uphoneNumber!.toLowerCase();
      final input = query.toLowerCase();
      return customertitle.contains(input) ||
          customeremail.contains(input) ||
          customerphone.contains(input);
    }).toList();
    setState(() {
      query = query;
      this.allEmployees = allEmployees;
    });
  }

  Future<RoomModel?> getChatRoomModel(EmployeesModel targetUser) async {
    RoomModel newRoomModel = RoomModel();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("ChatRooms")
        .where("senderId", isEqualTo: newRoomModel.senderId)
        .where('peerId', isEqualTo: newRoomModel.peerId)
        .get();

    if (snapshot.docs.length > 0) {
      log("room already exists");
    } else {
      newRoomModel = RoomModel(
          roomId: uuid.v1(), participantsList: [currentuid, targetUser]);
      await FirebaseFirestore.instance
          .collection("ChatRooms")
          .doc(newRoomModel.roomId)
          .set(newRoomModel.toMap());
      log('room created');
    }
  }
}
