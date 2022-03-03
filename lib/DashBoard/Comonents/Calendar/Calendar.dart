import 'dart:html';
import 'dart:math';
import 'dart:ui';

import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/UserProvider/GstProvider.dart';

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

  String bnature = "Active";

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: bgColor,
              ),
              height: size.height * 0.92,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Create New Invoice",
                        style: TextStyle(
                            fontSize: 20,
                            color: txtColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Container(
                        decoration: BoxDecoration(
                            color: fieldColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 2),
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
                                      visible = true;
                                      Provider.of<GstProvider>(context,
                                              listen: false)
                                          .fetchGstData(_searchController.text)
                                          .then((value) {
                                        _nameController.text =
                                            Provider.of<GstProvider>(context,
                                                    listen: false)
                                                .tradename
                                                .toString();
                                        _dateController.text =
                                            DateFormat("dd-MM-yyyy")
                                                .format(DateTime.now());
                                        _addressControoler.text =
                                            Provider.of<GstProvider>(context,
                                                    listen: false)
                                                .principalplace
                                                .toString();
                                        _pincodeController.text =
                                            Provider.of<GstProvider>(context,
                                                    listen: false)
                                                .pincode
                                                .toString();
                                        _panController.text =
                                            Provider.of<GstProvider>(context,
                                                    listen: false)
                                                .pan
                                                .toString();
                                        setState(() {
                                          _statusController.text =
                                              Provider.of<GstProvider>(context,
                                                      listen: false)
                                                  .gstinstatus
                                                  .toString();
                                          bnature = Provider.of<GstProvider>(
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
                      SizedBox(height: size.height * 0.05),
                      Visibility(
                        visible: visible,
                        child: ScaleAnimatedWidget.tween(
                          duration: Duration(seconds: 2),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: formfield("Invoice Id",
                                            _invoiceController, icnData())),
                                  ),
                                  Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: formfield(
                                            "Date",
                                            _dateController,
                                            Icon(Icons.calendar_today,
                                                color: btnColor))),
                                  ),
                                ],
                              ),
                              space(),
                              formfield(
                                  "TradeName", _nameController, icnData()),
                              space(),
                              formfield("Name", _invoiceusername, icnData()),
                              space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: formfield(
                                          "Email", _emailController, icnData()),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: formfield(
                                          "Address",
                                          _addressControoler,
                                          Icon(
                                            Icons.location_on_rounded,
                                            color: btnColor,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: formfield("PanNumber",
                                          _panController, icnData()),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: formfield("PinCode",
                                          _pincodeController, icnData()),
                                    ),
                                  ),
                                ],
                              ),
                              space(),
                              Row(
                                children: [
                                  CircleAvatar(
                                      maxRadius: 7,
                                      backgroundColor: Provider.of<GstProvider>(
                                                      context,
                                                      listen: false)
                                                  .gstinstatus
                                                  .toString() ==
                                              "Active"
                                          ? Colors.green
                                          : clsClr),
                                  SizedBox(width: 5),
                                  Text(
                                    _statusController.text.toString(),
                                    style: TxtStls.fieldstyle,
                                  ),
                                  Expanded(child: Text("")),
                                  Text(bnature, style: TxtStls.fieldstyle)
                                ],
                              ),
                              space(),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(12.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: bgColor,
                                            border: Border.all(color: btnColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        child: Text(
                                          "Send Invoice",
                                          style: TxtStls.btnstyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 1, child: Text("")),
                                  Expanded(
                                    flex: 4,
                                    child: InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(12.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: btnColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        child: Text(
                                          "Create Invoice",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: bgColor,
              ),
              height: size.height * 0.92,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Invoice Preview",
                            style: TextStyle(
                                fontSize: 20,
                                color: txtColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Text(" ")),
                          IconButton(
                              onPressed: (() {
                                setState(() {});
                              }),
                              icon: Icon(Icons.download, color: btnColor)),
                          IconButton(
                              onPressed: (() {}),
                              icon: Icon(Icons.print_sharp, color: btnColor)),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.075),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: size.height * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    height: size.height * 0.1,
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/Logos/jrlogo.png",
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: "@",
                                            style: ClrStls.tnClr,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      "support@jrcompliance.com",
                                                  style: TxtStls.fieldstyle),
                                            ]),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text: "m",
                                            style: ClrStls.tnClr,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: "+91 9999807976",
                                                  style: TxtStls.fieldstyle),
                                            ]),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Recipient',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: txtColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Tax Invoice',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: txtColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                        "4-19/1, Tana Bazar,Dondapadu(vi),Chintalapalem(M),Suryapet(Dist),Telangana",
                                        style: TxtStls.fieldstyle),
                                  ),
                                  Expanded(flex: 2, child: SizedBox()),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("INVOICE NO.",
                                          style: TxtStls.fieldtitlestyle),
                                      Text("#000001",
                                          style: TxtStls.fieldstyle),
                                      Text("INVOICE DATE",
                                          style: TxtStls.fieldtitlestyle),
                                      Text("March 03, 2022",
                                          style: TxtStls.fieldstyle)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "@",
                                  style: ClrStls.tnClr,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "yalagalasrinivas@gmail.com",
                                        style: TxtStls.fieldstyle),
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "m",
                                  style: ClrStls.tnClr,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "+91 8247467723",
                                        style: TxtStls.fieldstyle),
                                  ]),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: size.height * 0.4,
                      ),
                      Divider(color: grClr.withOpacity(0.4)),
                      Container(
                        height: size.height * 0.1,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("JR Compliance And Testing Labs",
                                    style: TxtStls.fieldtitlestyle),
                                Text(
                                  "PLOT NO. K - 8, SECTOR NO. 3, BAWANA, BAWANA, DELHI, Delhi",
                                  style: TxtStls.fieldstyle,
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: "@",
                                      style: ClrStls.tnClr,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "support@jrcompliance.com",
                                            style: TxtStls.fieldstyle),
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "m",
                                      style: ClrStls.tnClr,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "+91 9999807976",
                                            style: TxtStls.fieldstyle),
                                      ]),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    "The company is registered in the Service register under ########",
                                    style: TxtStls.fieldstyle,
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

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
}
