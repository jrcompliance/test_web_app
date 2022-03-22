import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Models/InvoiceDescriptionModel.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Providers/GstProvider.dart';

import '../../../Providers/CustomerProvider.dart';

class Finance1 extends StatefulWidget {
  Finance1({Key? key}) : super(key: key);

  @override
  _Finance1State createState() => _Finance1State();
}

class _Finance1State extends State<Finance1> {
  @override
  void initState() {
    Provider.of<CustmerProvider>(context,listen: false).getCustomers();
    super.initState();
  }
  final _list = ["Quotation", "Performer Invoice", "Invoice"];
  var activeid = "Quotation";
  bool qto = false;
  double? tbal;
  String bnature = "Active";
  bool visible = false;
  final TextEditingController _searchController1 = TextEditingController();
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
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _ucostController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _selectController = TextEditingController();
  final TextEditingController _qtyController2 = TextEditingController();
  final TextEditingController _discController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: btnColor.withOpacity(0.0001),
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Row(
                  children: _list.map((e) => newMethod(e, () {})).toList(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.025,
          ),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                      height: size.height * 0.845,
                      color: bgColor,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        itemCount: Provider.of<CustmerProvider>(context).customerlist.length,
                        itemBuilder: (BuildContext context, int i) {
                          var snp = Provider.of<CustmerProvider>(context).customerlist[i];
                          String? contactname = snp.Customername;
                          String? cemail = snp.Customeremail;
                          String? cphone = snp.Customerphone;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              color: bgColor,
                              child: ListTile(
                                leading: CircleAvatar(
                                    backgroundColor: btnColor.withOpacity(0.1),
                                    child: Icon(
                                      Icons.person,
                                      color: btnColor,
                                    )),
                                title: Text(
                                  contactname.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.5),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cemail.toString(),
                                      style: TxtStls.fieldstyle,
                                    ),
                                    Text(
                                      cphone.toString(),
                                      style: TxtStls.fieldstyle,
                                    ),
                                  ],
                                ),
                                trailing: CircleAvatar(
                                  backgroundColor: btnColor.withOpacity(0.1),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color: btnColor,
                                      )),
                                ),
                                onTap: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 7.5);
                        },
                      )
                  )),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  flex: 7,
                  child: Container(
                    height: size.height * 0.845,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 8.0, left: 20.0),
                              child: Text(
                                "Create New " + activeid,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: txtColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 16, right: 16),
                              child: Container(
                                width: size.width * 0.25,
                                decoration: BoxDecoration(
                                  // color: fieldColor,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 2),
                                  child: TextField(
                                    controller: _searchController,
                                    style: TxtStls.fieldstyle,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.search,
                                            color: btnColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Provider.of<GstProvider>(context,
                                                  listen: false)
                                                  .fetchGstData(
                                                  _searchController.text)
                                                  .then((value) {
                                                //  getarrayLength();
                                                visible = true;
                                                _invoiceusername.text =
                                                cusname!;
                                                _emailController.text =
                                                cusemail!;
                                                _nameController.text =
                                                    Provider.of<GstProvider>(
                                                        context,
                                                        listen: false)
                                                        .tradename
                                                        .toString();
                                                _dateController.text =
                                                    DateFormat("dd-MM-yyyy")
                                                        .format(DateTime.now());
                                                _addressControoler.text =
                                                    Provider.of<GstProvider>(
                                                        context,
                                                        listen: false)
                                                        .principalplace
                                                        .toString();
                                                _pincodeController.text =
                                                    Provider.of<GstProvider>(
                                                        context,
                                                        listen: false)
                                                        .pincode
                                                        .toString();
                                                _panController.text =
                                                    Provider.of<GstProvider>(
                                                        context,
                                                        listen: false)
                                                        .pan
                                                        .toString();
                                                setState(() {
                                                  _statusController.text =
                                                      Provider.of<GstProvider>(
                                                          context,
                                                          listen: false)
                                                          .gstinstatus
                                                          .toString();
                                                  bnature =
                                                      Provider.of<GstProvider>(
                                                          context,
                                                          listen: false)
                                                          .businessnature![0]
                                                          .toString();
                                                });
                                              });
                                            });
                                          },
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Enter GSTIN Number...",
                                        hintStyle: TxtStls.fieldstyle),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  child: Text("Invoice Description"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 20, right: 250),
                                child: Container(
                                  height: size.height * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: TextFormField(
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Container(
                                  height: size.height * 0.05,
                                  color: Colors.purple,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "ITEM DETAILS",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      VerticalDivider(
                                        thickness: 2,
                                        color: bgColor,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "RATE",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: bgColor,
                                            ),
                                            Expanded(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text("QUANTITY",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ))))
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        thickness: 2,
                                        color: bgColor,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text("DISC(%)",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ))),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: bgColor,
                                            ),
                                            Expanded(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text("PRICE",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        )))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Container(
                                  height: size.height * 0.05,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.5))),
                                            alignment: Alignment.center,
                                            // child: textField(
                                            //     _selectController,
                                            //     "Select Item",
                                            //     errorText(
                                            //         _selectController.text),
                                            //         (value) {
                                            //       setState(() {
                                            //         _selectController.text = value;
                                            //       });
                                            //     }, (value) {
                                            //   Validator(_selectController.text);
                                            // }),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        thickness: 2,
                                        color: bgColor,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                              0.5))),
                                                  alignment: Alignment.center,
                                                  // child: textField(
                                                  //     _discController,
                                                  //     "0 %",
                                                  //     errorText(
                                                  //         _discController.text),
                                                  //         (value) {
                                                  //       setState(() {
                                                  //         _discController.text =
                                                  //             value;
                                                  //       });
                                                  //     }, (value) {
                                                  //   Validator(
                                                  //       _discController.text);
                                                  // }),
                                                ),
                                              ),
                                            ),
                                            //      hintText: "₹ 0",
                                            VerticalDivider(
                                              thickness: 2,
                                              color: bgColor,
                                            ),
                                            Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .withOpacity(0.5))),
                                                    alignment: Alignment.center,
                                                    // child: textField(
                                                    //     _qtyController2,
                                                    //     "1",
                                                    //     errorText(
                                                    //         _qtyController2.text),
                                                    //         (value) {
                                                    //       setState(() {
                                                    //         _qtyController2.text =
                                                    //             value;
                                                    //       });
                                                    //     }, (value) {
                                                    //   Validator(
                                                    //       _qtyController2.text);
                                                    // }),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        thickness: 2,
                                        color: bgColor,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                              0.5))),
                                                  alignment: Alignment.center,
                                                  // child: textField(
                                                  //     _rateController,
                                                  //     "₹ 0",
                                                  //     errorText(
                                                  //         _rateController.text),
                                                  //         (value) {
                                                  //       setState(() {
                                                  //         _rateController.text =
                                                  //             value;
                                                  //       });
                                                  //     }, (value) {
                                                  //   Validator(
                                                  //       _rateController.text);
                                                  // }),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: bgColor,
                                            ),
                                            Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .withOpacity(0.5))),
                                                    alignment: Alignment.center,
                                                    // child: textField(
                                                    //     _priceController,
                                                    //     "₹ 0.00",
                                                    //     errorText(
                                                    //         _priceController.text),
                                                    //         (value) {
                                                    //       setState(() {
                                                    //         _priceController.text =
                                                    //             value;
                                                    //       });
                                                    //     },
                                                    //     Validator(
                                                    //         _priceController.text)),
                                                    //      hintText: "₹ 0.00",
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 10,right: 20,left: 20.0),
                              //   child: Container(
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Expanded(
                              //           flex: 3,
                              //           child: Container(
                              //             height: size.height*0.05,
                              //             color: Colors.purple,
                              //           ),
                              //         ),
                              //         VerticalDivider(
                              //           thickness: 2,
                              //           color: bgColor,
                              //         ),
                              //         Expanded(
                              //           flex: 4,
                              //           child: Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Expanded(
                              //               child: Container(
                              //                 height: size.height*0.05,
                              //
                              //                 color: Colors.grey,
                              //               ),
                              //             ),
                              //             Expanded(
                              //               child: Container(
                              //                 height: size.height*0.05,
                              //
                              //                 color: Colors.yellow,
                              //               ),
                              //             ),
                              //           ],
                              //         ),),
                              //         VerticalDivider(
                              //           thickness: 2,
                              //           color: bgColor,
                              //         ),
                              //         Expanded(
                              //           flex: 4,
                              //           child: Row(
                              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               Expanded(
                              //                 child: Container(
                              //                   height: size.height*0.05,
                              //                   color: Colors.green,
                              //                 ),
                              //               ),
                              //               Expanded(
                              //                 child: Container(
                              //                   height: size.height*0.05,
                              //                   color: Colors.pink,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         VerticalDivider(
                              //           thickness: 2,
                              //           color: bgColor,
                              //         ),
                              //       ],
                              //
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: 30,
                                width: size.width * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Save & Send",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.telegram_rounded,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: 30,
                                width: size.width * 0.1,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.purple),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        child: Text(
                                          "Save  ",
                                          style:
                                          TextStyle(color: Colors.purple),
                                        ),
                                        onTap: () {},
                                      ),
                                      VerticalDivider(
                                        thickness: 0.5,
                                        color: Colors.purple,
                                      ),
                                      InkWell(
                                        child: Text(
                                          "Cancel",
                                          style:
                                          TextStyle(color: Colors.purple),
                                        ),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: 30,
                                width: size.width * 0.1,
                                child: Center(
                                  child: InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.copy_all,
                                          size: 15,
                                          color: Colors.purple,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "Preview  ",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.purple),
                                        ),
                                      ],
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),

      // child:Column(
      //   children: [
      //     Expanded(
      //       flex: 1,
      //       child: Container(child: Text('Create Invoice')),
      //     ),
      //     Divider(),
      //     Container(
      //       height: 15,
      //       width: 30,
      //       decoration: BoxDecoration(
      //         border: Border.all(),
      //         borderRadius: BorderRadiusDirectional.circular(10)
      //       ),
      //     ),
      //   ],
      // )
    );
  }
  // Column(
  //         children: [
  //
  //

  // Expanded(
  //     flex: 7,
  //     child: Container(
  //       height: size.height*0.93,
  //
  //
  //         color: Colors.green,
  //         child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment:
  //                     MainAxisAlignment.spaceBetween,
  //                 children: [
  //
  //                   // IconButton(
  //                   //     onPressed: () {
  //                   //       setState(() {
  //                   //         qto = false;
  //                   //       });
  //                   //     },
  //                   //     icon: Icon(
  //                   //       Icons.cancel,
  //                   //       color: btnColor,
  //                   //     ))
  //
  //               SizedBox(height: size.height * 0.02),
  //
  //               SizedBox(height: size.height * 0.01),

  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 10.0, left: 20.0, right: 20),
  //                 child: Row(
  //                   // mainAxisAlignment:
  //                   //     MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Column(
  //                       children: [
  //                         Container(
  //                           height: size.height * 0.04,
  //                           width: size.width * 0.075,
  //                           decoration: BoxDecoration(
  //                               border: Border.all(
  //                                   color: Colors.grey
  //                                       .withOpacity(0.5)),
  //                               borderRadius:
  //                                   BorderRadius.circular(8),
  //                               color: Colors.white),
  //                           child: ,
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Container(
  //                             height: size.height * 0.04,
  //                             width: size.width * 0.075,
  //                             decoration: BoxDecoration(
  //                                 border: Border.all(
  //                                     color: Colors.grey
  //                                         .withOpacity(0.5)),
  //                                 borderRadius:
  //                                     BorderRadius.circular(8),
  //                                 color: Colors.white),
  //                             child: Center(
  //                               child: TextFormField(
  //                                 textAlign: TextAlign.center,
  //                                 maxLines: 3,
  //                                 decoration: InputDecoration(
  //                                   contentPadding:
  //                                       EdgeInsets.only(
  //                                           bottom: 15, left: 5),
  //                                   hintText: "Item Description",
  //                                   hintStyle:
  //                                       TextStyle(fontSize: 10),
  //                                   focusedBorder:
  //                                       InputBorder.none,
  //                                   enabledBorder:
  //                                       InputBorder.none,
  //                                   errorBorder: InputBorder.none,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Divider(
  //                       height: 10,
  //                       thickness: 2,
  //                       color: Colors.red,
  //                     ),
  //                     Container(
  //                       height: size.height * 0.04,
  //                       width: size.width * 0.04,
  //                       decoration: BoxDecoration(
  //                           border: Border.all(
  //                               color:
  //                                   Colors.grey.withOpacity(0.5)),
  //                           borderRadius:
  //                               BorderRadius.circular(8),
  //                           color: Colors.white),
  //                       child:
  //                     VerticalDivider(
  //                       thickness: 2,
  //                       // color: Colors.grey,
  //                     ),
  //                     Container(
  //                       height: size.height * 0.04,
  //                       width: size.width * 0.04,
  //                       decoration: BoxDecoration(
  //                           border: Border.all(
  //                               color:
  //                                   Colors.grey.withOpacity(0.5)),
  //                           borderRadius:
  //                               BorderRadius.circular(8),
  //                           color: Colors.white),
  //                       child: Center(
  //                         child:
  //                       ),
  //                     ),
  //                     VerticalDivider(
  //                       thickness: 2,
  //                       // color: Colors.grey,
  //                     ),
  //                     Container(
  //                       height: size.height * 0.04,
  //                       width: size.width * 0.04,
  //                       decoration: BoxDecoration(
  //                           border: Border.all(
  //                               color:
  //                                   Colors.grey.withOpacity(0.5)),
  //                           borderRadius:
  //                               BorderRadius.circular(8),
  //                           color: Colors.white),
  //                       child: Center(
  //                         child:
  //                       ),
  //                     ),
  //                     VerticalDivider(
  //                       thickness: 2,
  //                       // color: Colors.grey,
  //                     ),
  //                     Container(
  //                       //  padding: EdgeInsets.all(8),
  //                       height: size.height * 0.04,
  //                       width: size.width * 0.05,
  //                       decoration: BoxDecoration(
  //                           border: Border.all(
  //                               color:
  //                                   Colors.grey.withOpacity(0.5)),
  //                           borderRadius:
  //                               BorderRadius.circular(8),
  //                           color: Colors.white),
  //                       child: Center(
  //                         child:
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(16.0),
  //                 child: Container(
  //                     height: 50,
  //                     width: 50,
  //                     child: InkWell(
  //                         child: Text(
  //                           '+ Add Item',
  //                           style: TextStyle(
  //                               fontSize: 10.0,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.purple),
  //                         ),
  //                         onTap: () {})),
  //               ),
  //               Row(
  //                 mainAxisAlignment:
  //                     MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(16.0),
  //                     child: Container(
  //                       padding: EdgeInsets.all(10),
  //                       height: 60,
  //                       width: 250,
  //                       decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           border: Border.all(
  //                               color:
  //                                   Colors.grey.withOpacity(0.5)),
  //                           borderRadius:
  //                               BorderRadius.circular(8)),
  //                       child: Text("Internal Notes"),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(16.0),
  //                     child: Container(
  //                       width: size.width * 0.1,
  //                       child: Column(
  //                         children: [
  //                           RichText(
  //                               text: TextSpan(
  //                                   text: 'Sub Total ',
  //                                   style: DefaultTextStyle.of(
  //                                           context)
  //                                       .style,
  //                                   children: const <TextSpan>[
  //                                 TextSpan(text: ":"),
  //                                 TextSpan(text: "  "),
  //                                 TextSpan(
  //                                     text: '54454555',
  //                                     style: TextStyle(
  //                                         fontWeight:
  //                                             FontWeight.bold)),
  //                               ])),
  //                           Divider(
  //                             thickness: 0.5,
  //                             color: Colors.grey.withOpacity(0.5),
  //                           ),
  //                           RichText(
  //                               text: TextSpan(
  //                                   text: 'Total ',
  //                                   style: DefaultTextStyle.of(
  //                                           context)
  //                                       .style,
  //                                   children: const <TextSpan>[
  //                                 TextSpan(text: ":"),
  //                                 TextSpan(text: "  "),
  //                                 TextSpan(
  //                                     text: '54454444',
  //                                     style: TextStyle(
  //                                         fontWeight:
  //                                             FontWeight.bold)),
  //                               ])),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //
  //
  //
  //
  //
  //                   ],
  //                 ),
  //               )
  //             ]))),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),

  Widget newMethod(e, callack) {
    return RaisedButton(
      elevation: 0.0,
      color: activeid == e ? btnColor : bgColor,
      hoverColor: Colors.transparent,
      hoverElevation: 0.0,
      onPressed: () {
        setState(() {
          activeid = e;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
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

  List invoicelist = ["SAC No.", "Qty.", "UnitCost.", "Disc(%)", "Amount"];
  List list = [];
  void addingInvoiceData() async {
    double qty = double.parse(_qtyController.text.toString());
    double ucost = double.parse(_ucostController.text.toString());
    list.add(InvoiceDescriptionModel(
      desc: _descController.text,
      qty: qty,
      ucost: ucost,
      amount: qty * ucost,
    ).toJson());
    print(list);
    tbal = list.map((m) => (m["amount"])).reduce((a, b) => a + b);
    print("Data is set");
  }

  Validator(String value) {
    if (value.length == 0) {
      print("");
      return "Please Enter value ";
    } else {
      null;
    }
    ;
  }

  errorText(value) {
    if (value.length == 0) {
      return "enter value";
    } else {
      return;
    }
  }

  Widget textField(controller, hintText, errortext, _onSaved, _validator) {
    return TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errortext,
          focusedErrorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
        onSaved: _onSaved,
        validator: _validator);
  }
}
