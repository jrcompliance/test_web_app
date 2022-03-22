import 'dart:html';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Models/InvoiceDescriptionModel.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Pdf/Models/CustomerModel.dart';
import 'package:test_web_app/Pdf/Models/InvoiceModel.dart';
import 'package:test_web_app/Pdf/Models/SupplierModel.dart';
import 'package:test_web_app/Pdf/PdfApi.dart';
import 'package:test_web_app/Pdf/PdfInvoiceApi.dart';
import 'package:test_web_app/PdfPage.dart';
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
 bool isAdded = false;
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
  final TextEditingController _descripController = TextEditingController();
  final TextEditingController _internalController = TextEditingController();
  List cust =[];
  String? contactname;
  String? cemail;
  String? cphone;

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
                                              contactname = snp.Customername;
                                               cemail = snp.Customeremail;
                                               cphone = snp.Customerphone;
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
                                   EdgeInsets.only(top: 8.0, left: 20.0),
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
                                   EdgeInsets.only(top: 16, right: 16),
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
                                padding: EdgeInsets.only(left: 20.0,),
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
                                padding:  EdgeInsets.only(
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
                              // InvoiceFields(_discController, "DISC")
                             isAdded ==true ?
                             Padding(
                               padding: EdgeInsets.only(left: 20,right: 20),
                               child: ListView.builder(
                                   scrollDirection: Axis.vertical,
                                   shrinkWrap: true,
                                 itemCount: list1.length,
                                   itemBuilder: (context,index){
                                     return Expanded(
                                       child: Row(
                                         mainAxisAlignment:
                                         MainAxisAlignment.spaceBetween,
                                         children: [
                                           Expanded(
                                             flex: 3,
                                             child: Container(
                                                 alignment: Alignment.center,
                                                 child: Text(
                                                   list1[index]["item"].toString(),
                                                   style:TxtStls.fieldtitlestyle2,
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
                                                         list1[index]["rate"].toString(),
                                                         style: TxtStls.fieldtitlestyle2,
                                                       )),
                                                 ),
                                                 VerticalDivider(
                                                   thickness: 2,
                                                   color: bgColor,
                                                 ),
                                                 Expanded(
                                                     child: Container(
                                                         alignment: Alignment.center,
                                                         child: Text(list1[index]["qty"].toString(),
                                                             style: TxtStls.fieldtitlestyle2)))
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
                                                       child: Text(list1[index]["disc"].toString(),
                                                           style: TxtStls.fieldtitlestyle2)),
                                                 ),
                                                 VerticalDivider(
                                                   thickness: 2,
                                                   color: bgColor,
                                                 ),
                                                 Expanded(
                                                     child: Container(
                                                         alignment: Alignment.center,
                                                         child: Text(list1[index]["price"].toString(),
                                                             style: TxtStls.fieldtitlestyle2))),
                                               ],
                                             ),
                                           ),
                                         ],
                                       ),
                                     );
                                   }
                                   ),
                             ) : SizedBox(),
                             Padding(
                                padding:  EdgeInsets.only(
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
                                          padding:  EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.5))),
                                            alignment: Alignment.center,
                                            child:
                                            textField(_selectController, "Select Item"),

                                       //   InvoiceFields(_selectController,"Select Item"),
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
                                                padding:  EdgeInsets.only(
                                                    left: 20, right: 20),
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
                                                  child: textField(_rateController, "₹ 0"),

                                                //  InvoiceFields(_rateController,"₹ 0"),
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
                                              padding:  EdgeInsets.only(
                                                  left: 35, right: 35),
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
                                                child:textField(_qtyController2, "1")
                                                //InvoiceFields(_qtyController2,"1"),
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
                                                padding:  EdgeInsets.only(
                                                    left: 35, right: 35),
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
                                                  child: textField(_discController, "0 %")
                                                  // InvoiceFields(_discController,"0 %"),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: bgColor,
                                            ),
                                            Expanded(
                                                child: SizedBox()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),
                            isAdded ==true? SizedBox(): SizedBox(), Padding(
                                padding:  EdgeInsets.only(
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
                                          padding:  EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.5))),
                                            alignment: Alignment.center,
                                            child:
                                            textField(_descripController, "Item Description"),

                                            //   InvoiceFields(_selectController,"Select Item"),
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
                                                padding:  EdgeInsets.only(
                                                    left: 20, right: 20),
                                              ),
                                            ),
                                            //      hintText: "₹ 0",
                                            VerticalDivider(
                                              thickness: 2,
                                              color: bgColor,
                                            ),
                                            Expanded(
                                                child: Padding(
                                                  padding:  EdgeInsets.only(
                                                      left: 35, right: 35),
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
                                                padding:  EdgeInsets.only(
                                                    left: 35, right: 35),
                                              ),
                                            ),
                                            VerticalDivider(
                                              thickness: 2,
                                              color: bgColor,
                                            ),
                                            Expanded(
                                                child: Padding(
                                                  padding:  EdgeInsets.only(
                                                      left: 20, right: 20),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),

                              Padding(
                                padding:  EdgeInsets.only(left: 75,),
                                child: InkWell(
                                  autofocus: false,
                                    onTap: (){
                                      setState(() {
                                        isAdded = true;
                                        var _customer = Provider.of<CustmerProvider>(context,listen: false);
                                        cust.forEach((element) =>_customer);

                                      });


                                      print('custom cust'+cust.toString());


                                      addingData();
                                      _rateController.clear();
                                      _qtyController2.clear();
                                      _priceController.clear();
                                      _discController.clear();
                                      _selectController.clear();
                                      _descripController.clear();



                                    }, child: Text("+ADD ITEM",style: TxtStls.btnstyle,)),

                              ),
                              SizedBox(height: 20,),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 50),
                                                  child: Container(
                                                    padding: EdgeInsets.all(0),
                                                    height: 50,
                                                    width: 250,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color:
                                                                Colors.grey.withOpacity(0.5)),
                                                        borderRadius:
                                                            BorderRadius.circular(8)),
                                                    child: textField(_internalController, "Internal Notes"),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 20),
                                                  child: Container(
                                                    width: size.width * 0.15,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("Sub Total",style:TxtStls.fieldtitlestyle,),
                                                            Text(tbal==null?"0.00":tbal.toString(),style:TxtStls.fieldtitlestyle,),

                                                          ],
                                                        ),
                                                        Divider(
                                                          thickness: 0.5,
                                                          color: Colors.grey.withOpacity(0.5),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("Total",style:TxtStls.fieldtitlestyle,),
                                                            Text("0.00",style:TxtStls.fieldtitlestyle,),

                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

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
                                    onTap: () async{

                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfPage()));
                                          final date = DateTime.now();
                                          final dueDate = date.add(Duration(days: 7));
                                          print('name'+contactname.toString());
                                          print('email'+cemail.toString());

                                          final invoice = Invoice(
                                            supplier: Supplier(
                                              name: "JR Compliance and Testing Labs",
                                              address: "Regd. Office: 705, 7th Floor,Krishna Apra Tower,Netaji Subhash Place, Pitampura,New Delhi 110034,India",
                                              paymentInfo: 'https://paypal.me/sarahfieldzz',
                                              pan: "PAN: AALFJ0070E",
                                              tan: "TAN: DELJ10631F",
                                              gst: "GST REGN NO: 07AALFJ0070E1ZO",
                                            ),
                                            customer: Customer(

                                              name: "Srinivas",
                                              address: "yalagala@jrcompliance.com",
                                            ),
                                            info: InvoiceInfo(
                                              date: date,
                                              dueDate: dueDate,
                                              description: 'My description...',
                                              number: '${DateTime.now().year}-9999',
                                            ),
                                            items:
                                              [

                                              InvoiceItem(
                                                description: 'Coffee',
                                                date: DateTime.now(),
                                                quantity: list1[0]["qty"],
                                                vat: 0.18,
                                                unitPrice:list1[0]["rate"] ,
                                              ),
                                              InvoiceItem(
                                                description: 'Water',
                                                date: DateTime.now(),
                                                quantity: 8,
                                                vat: 0.19,
                                                unitPrice: 0.99,
                                              ),
                                              InvoiceItem(
                                                description: 'Orange',
                                                date: DateTime.now(),
                                                quantity: 3,
                                                vat: 0.19,
                                                unitPrice: 2.99,
                                              ),
                                              InvoiceItem(
                                                description: 'Apple',
                                                date: DateTime.now(),
                                                quantity: 8,
                                                vat: 0.19,
                                                unitPrice: 3.99,
                                              ),
                                              InvoiceItem(
                                                description: 'Mango',
                                                date: DateTime.now(),
                                                quantity: 1,
                                                vat: 0.19,
                                                unitPrice: 1.59,
                                              ),
                                              InvoiceItem(
                                                description: 'Blue Berries',
                                                date: DateTime.now(),
                                                quantity: 5,
                                                vat: 0.19,
                                                unitPrice: 0.99,
                                              ),
                                              InvoiceItem(
                                                description: 'Lemon',
                                                date: DateTime.now(),
                                                quantity: 4,
                                                vat: 0.19,
                                                unitPrice: 1.29,
                                              ),
                                             ],
                                          );
                                         //  final Uint8List fontData = File();
                                         //  final ttf = pw.Font.ttf(fontData.buffer.asByteData());
                                        //  var data = fontData.buffer.asByteData();

                                          final pdfFile = await PdfInvoiceApi.generate(invoice);

                                          PdfApi.openFile(pdfFile);

                                    },
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

    );
  }





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

  Widget textField(_controller,String hintText) {
    return TextFormField(
      textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: _controller,
        decoration: InputDecoration(
          hintText: hintText,hintStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.normal,color: Colors.black),
          focusedErrorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
        validator:(value){
          if(value!.isEmpty){
            return "value can not be empty";
          }
        });
  }

  List list1 = [];
  void addingData() async {
    double _rate = double.parse(_rateController.text);
    int _qty = int.parse(_qtyController2.text);
    double _disc = double.parse(_discController.text);
    double price = (_rate*_qty)- (((_rate*_qty)/100)*_disc);
    list1.add(InvoiceDescriptionModel2(
      item: _selectController.text,
      qty: _qty,
      rate:_rate,
      disc: _disc,

      price: price,
    ).toJson());
    print('@@@'+list1.toString());

    tbal = list1.map((m) => (m["price"])).reduce((a, b) => a + b);
    print("Data added ");
  }
}
