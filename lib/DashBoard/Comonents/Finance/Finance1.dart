// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test_web_app/Constants/reusable.dart';
// import 'package:test_web_app/Models/InvoiceDescriptionModel.dart';
//
// import '../../../UserProvider/CustomerProvider.dart';
//
// class Finance1 extends StatefulWidget {
//   const Finance1({Key? key}) : super(key: key);
//
//   @override
//   _Finance1State createState() => _Finance1State();
// }
//
// class _Finance1State extends State<Finance1> {
//   final _list = ["Quotation", "Performer Invoice", "Invoice"];
//   var activeid = "Quotation";
//   bool qto = false;
//   String bnature = "Active";
//   bool visible = false;
//   final TextEditingController _searchController1 = TextEditingController();
//   final TextEditingController _invoiceController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _invoiceusername = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _addressControoler = TextEditingController();
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _pincodeController = TextEditingController();
//   final TextEditingController _panController = TextEditingController();
//   final TextEditingController _statusController = TextEditingController();
//   final TextEditingController _descController = TextEditingController();
//   final TextEditingController _qtyController = TextEditingController();
//   final TextEditingController _ucostController = TextEditingController();
//   final GlobalKey<FormState> _formkey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     final customerlist = Provider.of<CustmerProvider>(context).customerlist;
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: _list.map((e) => newMethod(e, () {})).toList(),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             children: [
//               Expanded(
//                   flex: 3,
//                   child: Container(
//                     height: size.height * 0.86,
//                     color: Colors.grey.withOpacity(0.05),
//                     child: ListView.separated(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       physics: ClampingScrollPhysics(),
//                       itemCount: customerlist.length,
//                       itemBuilder: (BuildContext context, int i) {
//                         var snp = customerlist[i];
//                         String? contactname = snp.Customername;
//                         String? cemail = snp.Customeremail;
//                         String? cphone = snp.Customerphone;
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Material(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)),
//                             color: bgColor,
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                   backgroundColor: btnColor.withOpacity(0.1),
//                                   child: Icon(
//                                     Icons.person,
//                                     color: btnColor,
//                                   )),
//                               title: Text(
//                                 contactname.toString(),
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12.5),
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     cemail.toString(),
//                                     style: TxtStls.fieldstyle,
//                                   ),
//                                   Text(
//                                     cphone.toString(),
//                                     style: TxtStls.fieldstyle,
//                                   ),
//                                 ],
//                               ),
//                               trailing: CircleAvatar(
//                                 backgroundColor: btnColor.withOpacity(0.1),
//                                 child: IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(
//                                       Icons.more_horiz,
//                                       color: btnColor,
//                                     )),
//                               ),
//                               onTap: () {},
//                               shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10.0))),
//                             ),
//                           ),
//                         );
//                       },
//                       separatorBuilder: (BuildContext context, int index) {
//                         return SizedBox(height: 7.5);
//                       },
//                     ),
//                   )),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     // image: DecorationImage(
//                     //     image: AssetImage("assets/Images/invoicebg.jpeg"),
//                     //     fit: BoxFit.cover,
//                     //     filterQuality: FilterQuality.high),
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     color: bgColor,
//                   ),
//                   height: size.height * 0.92,
//                   padding: EdgeInsets.symmetric(
//                       horizontal: size.width * 0.015,
//                       vertical: size.width * 0.015),
//                   child: Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Text(
//                               activeid + " Preview",
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   color: txtColor,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Expanded(child: Text(" ")),
//                             IconButton(
//                                 onPressed: (() {
//                                   setState(() {});
//                                 }),
//                                 icon: Icon(Icons.download, color: btnColor)),
//                             IconButton(
//                                 onPressed: (() {}),
//                                 icon: Icon(Icons.print_sharp, color: btnColor)),
//                           ],
//                         ),
//                         // divider(),
//                         Row(
//                           children: [
//                             SizedBox(
//                               height: size.height * 0.15,
//                               width: size.width * 0.175,
//                               child: Image.asset(
//                                 "assets/Logos/jrlogo.png",
//                                 filterQuality: FilterQuality.high,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Expanded(child: SizedBox()),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text("JR Compliance and Testing Labs",
//                                     style: TxtStls.fieldstyle),
//                                 Text(
//                                     "Regd. Office: 705, 7th Floor,Krishna Apra Tower",
//                                     style: TxtStls.fieldstyle),
//                                 Text(
//                                     "Netaji Subhash Place, Pitampura,New Delhi 110034,India",
//                                     style: TxtStls.fieldstyle),
//                                 Text("JR Compliance and Testing Labs",
//                                     style: TxtStls.fieldstyle),
//                                 Text("PAN: AALFJ0070E",
//                                     style: TxtStls.fieldstyle),
//                                 Text("TAN: DELJ10631F",
//                                     style: TxtStls.fieldstyle),
//                                 Text("GST REGN NO: 07AALFJ0070E1ZO",
//                                     style: TxtStls.fieldstyle),
//                               ],
//                             )
//                           ],
//                         ),
//                         // divider(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("To,", style: TxtStls.fieldtitlestyle),
//                                 Text(
//                                   _nameController.text.toString(),
//                                   style: TxtStls.fieldstyle,
//                                 ),
//                                 Text(_addressControoler.text.toString(),
//                                     style: TxtStls.fieldstyle),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   "Invoice No. " + _invoiceController.text,
//                                   style: TxtStls.fieldtitlestyle,
//                                 ),
//                                 Text(
//                                   "Issued On: " +
//                                       DateFormat("dd MMM,yyyy")
//                                           .format(DateTime.now()),
//                                   style: TxtStls.fieldstyle,
//                                 ),
//                                 Text("Payment Due: Paid",
//                                     style: TxtStls.fieldstyle),
//                               ],
//                             )
//                           ],
//                         ),
//                         Text("GST NO- " + _searchController.text,
//                             style: TxtStls.fieldtitlestyle),
//                         Text("Kind Atten: Mr." + _invoiceusername.text,
//                             style: TxtStls.fieldtitlestyle),
//
//                         // divider(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                                 flex: 3,
//                                 child: Text("# Description",
//                                     style: TxtStls.fieldstyle)),
//                             Expanded(
//                               flex: 7,
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: invoicelist
//                                       .map((e) => Expanded(
//                                             child: Align(
//                                               alignment: Alignment.centerRight,
//                                               child: Text(e,
//                                                   style: TxtStls.fieldstyle),
//                                             ),
//                                           ))
//                                       .toList()),
//                             ),
//                           ],
//                         ),
//                         // divider(),
//                         Expanded(
//                           child: Column(
//                             children: [
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: list.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                             "${index + 1}" +
//                                                 ". " +
//                                                 list[index]["desc"],
//                                             style: TxtStls.fieldstyle),
//                                       ),
//                                       Expanded(
//                                           child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                               alignment: Alignment.centerRight,
//                                               child: Text("9983",
//                                                   style: TxtStls.fieldstyle),
//                                             ),
//                                           ),
//                                           Expanded(
//                                               child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Text(
//                                                 list[index]["qty"].toString(),
//                                                 style: TxtStls.fieldstyle),
//                                           )),
//                                           Expanded(
//                                               child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Text(
//                                                 list[index]["ucost"].toString(),
//                                                 style: TxtStls.fieldstyle),
//                                           )),
//                                           Expanded(
//                                               child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Text("".toString(),
//                                                 style: TxtStls.fieldstyle),
//                                           )),
//                                           Expanded(
//                                             child: Align(
//                                               alignment: Alignment.centerRight,
//                                               child: Text(
//                                                   list[index]["amount"]
//                                                       .toString(),
//                                                   style: TxtStls.fieldstyle),
//                                             ),
//                                           ),
//                                         ],
//                                       ))
//                                     ],
//                                   );
//                                 },
//                               ),
//                               list.length > 0
//                                   ? Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "IGST 18%",
//                                           style: TxtStls.fieldstyle,
//                                         ),
//                                         Text(
//                                           gst.toString(),
//                                           style: TxtStls.fieldstyle,
//                                         )
//                                       ],
//                                     )
//                                   : SizedBox(),
//                               list.length > 0
//                                   ? Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text("Total :",
//                                             style: TxtStls.fieldstyle),
//                                         Text(
//                                             "${tbal == null ? 0 : tbal! + gst}",
//                                             style: TxtStls.fieldstyle),
//                                       ],
//                                     )
//                                   : SizedBox(),
//                               list.length > 0
//                                   ? Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text("Amount Paid :",
//                                             style: TxtStls.fieldstyle),
//                                         Text("85,300",
//                                             style: TxtStls.fieldstyle),
//                                       ],
//                                     )
//                                   : SizedBox(),
//                               isadded
//                                   ? Form(
//                                       key: _formkey,
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                             child: InvoiceFields(
//                                                 _descController,
//                                                 "Enter Service Description"),
//                                           ),
//                                           SizedBox(
//                                             width: 5,
//                                           ),
//                                           Expanded(
//                                               child: InvoiceFields(
//                                                   _qtyController,
//                                                   "Enter Quantity")),
//                                           SizedBox(
//                                             width: 5,
//                                           ),
//                                           Expanded(
//                                               child: InvoiceFields(
//                                                   _ucostController,
//                                                   "Enter UnitCost")),
//                                           SizedBox(
//                                             width: 5,
//                                           ),
//                                           InkWell(
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(7)),
//                                                   color: goodClr),
//                                               child: Icon(
//                                                 Icons.done,
//                                                 color: bgColor,
//                                                 size: 20,
//                                               ),
//                                             ),
//                                             onTap: () {
//                                               if (_formkey.currentState!
//                                                   .validate()) {
//                                                 isadded = !isadded;
//                                                 addingInvoiceData();
//                                                 _descController.clear();
//                                                 _qtyController.clear();
//                                                 _ucostController.clear();
//                                                 setState(() {});
//                                               } else {
//                                                 null;
//                                               }
//                                             },
//                                           )
//                                         ],
//                                       ),
//                                     )
//                                   : SizedBox(),
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: InkWell(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(7)),
//                                         color: btnColor),
//                                     child: isadded
//                                         ? Icon(
//                                             Icons.clear,
//                                             color: bgColor,
//                                             size: 20,
//                                           )
//                                         : Icon(
//                                             Icons.add,
//                                             color: bgColor,
//                                             size: 20,
//                                           ),
//                                   ),
//                                   onTap: () {
//                                     isadded = !isadded;
//                                     setState(() {});
//                                   },
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         divider(),
//                         Text("Bank Details:",
//                             style: GoogleFonts.nunito(
//                                 textStyle: TextStyle(
//                                     fontSize: 13,
//                                     color: txtColor,
//                                     fontWeight: FontWeight.bold,
//                                     decoration: TextDecoration.underline),
//                                 fontSize: 13,
//                                 color: txtColor,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.underline)),
//                         Text("Company Name: JR Compliance And Testing Labs",
//                             style: TxtStls.fieldtitlestyle),
//                         Text("Bank Name: IDFC FIRST BANK",
//                             style: TxtStls.fieldtitlestyle),
//                         Text("Account Number: 10041186185",
//                             style: TxtStls.fieldtitlestyle),
//                         Text("IFSC Code: IDFB0040101",
//                             style: TxtStls.fieldtitlestyle),
//                         Text("SWIFT Code: IDFBINBBMUM",
//                             style: TxtStls.fieldtitlestyle),
//                         Text("Bank Address: Rohini, New Delhi-110085",
//                             style: TxtStls.fieldtitlestyle),
//                         divider(),
//                         Text("Terms And Conditions:",
//                             style: TxtStls.fieldtitlestyle),
//                         InkWell(
//                           child: Text(
//                             "https://www.jrcompliance.com/terms-and-conditions",
//                             style: TxtStls.fieldstyle,
//                           ),
//                           onTap: () {
//                             launches.termsofuse();
//                           },
//                         ),
//                         // InkWell(
//                         //   child: Text(
//                         //     "https://www.jrcompliance.com/privacy-policy",
//                         //     style: ClrStls.tnClr,
//                         //   ),
//                         //   onTap: () {
//                         //     launches.privacy();
//                         //   },
//                         // ),
//                         // InkWell(
//                         //   child: Text(
//                         //     "https://www.jrcompliance.com/purchase-and-billing",
//                         //     style: ClrStls.tnClr,
//                         //   ),
//                         //   onTap: () {
//                         //     launches.privacy();
//                         //   },
//                         // )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                   flex: 5,
//                   child: Container(
//                     height: size.height * 0.86,
//                     color: Colors.green,
//                   )),
//               Expanded(
//                   flex: 2,
//                   child: Container(
//                     height: size.height * 0.86,
//                     color: Colors.grey.withOpacity(0.05),
//                   )),
//             ],
//           )
//         ],
//       ),
//
//       // child:Column(
//       //   children: [
//       //     Expanded(
//       //       flex: 1,
//       //       child: Container(child: Text('Create Invoice')),
//       //     ),
//       //     Divider(),
//       //     Container(
//       //       height: 15,
//       //       width: 30,
//       //       decoration: BoxDecoration(
//       //         border: Border.all(),
//       //         borderRadius: BorderRadiusDirectional.circular(10)
//       //       ),
//       //     ),
//       //   ],
//       // )
//     );
//   }
//
//   Widget newMethod(e, callack) {
//     return RaisedButton(
//       elevation: 0.0,
//       color: activeid == e ? btnColor : bgColor,
//       hoverColor: Colors.transparent,
//       hoverElevation: 0.0,
//       onPressed: () {
//         setState(() {
//           activeid = e;
//         });
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Text(
//           e,
//           style: TextStyle(
//               fontSize: 12.5,
//               color: activeid == e ? bgColor : txtColor,
//               letterSpacing: 0.2),
//         ),
//       ),
//     );
//   }
//
//   List invoicelist = ["SAC No.", "Qty.", "UnitCost.", "Disc(%)", "Amount"];
//   List list = [];
//   void addingInvoiceData() async {
//     double qty = double.parse(_qtyController.text.toString());
//     double ucost = double.parse(_ucostController.text.toString());
//     list.add(InvoiceDescriptionModel(
//       desc: _descController.text,
//       qty: qty,
//       ucost: ucost,
//       amount: qty * ucost,
//     ).toJson());
//     print(list);
//     tbal = list.map((m) => (m["amount"])).reduce((a, b) => a + b);
//     print("Data is set");
//   }
// }
