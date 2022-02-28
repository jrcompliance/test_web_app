import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

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
                            decoration: new InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: btnColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Provider.of<GstProvider>(context,
                                              listen: false)
                                          .fetchGstData(_searchController.text);
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                                hintText: "Enter GSTIN number...",
                                hintStyle: TxtStls.fieldstyle),
                          ),
                        ),
                      ),

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
                      // formfield("Name", _nameController, icnData()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Provider.of<GstProvider>(context, listen: false)
                              .tradename
                              .toString()),
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
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       flex: 4,
                      //       child: InkWell(
                      //         child: Container(
                      //           padding: EdgeInsets.all(12.0),
                      //           alignment: Alignment.center,
                      //           decoration: BoxDecoration(
                      //               color: bgColor,
                      //               border: Border.all(color: btnColor),
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(10.0))),
                      //           child: Text(
                      //             "Send Invoice",
                      //             style: TxtStls.btnstyle,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(flex: 1, child: Text("")),
                      //     Expanded(
                      //       flex: 4,
                      //       child: InkWell(
                      //         child: Container(
                      //           padding: EdgeInsets.all(12.0),
                      //           alignment: Alignment.center,
                      //           decoration: BoxDecoration(
                      //               color: btnColor,
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(10.0))),
                      //           child: Text(
                      //             "Create Invoice",
                      //             style: TextStyle(color: Colors.white),
                      //           ),
                      //         ),
                      //         onTap: () {},
                      //       ),
                      //     )
                      //   ],
                      // )
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      formfield(
                          "",
                          _invoiceController,
                          Icon(
                            Icons.horizontal_rule,
                            color: fieldColor,
                          )),
                      Text(_dateController.text.toString()),
                      Text(_emailController.text.toString()),
                      Text(_nameController.text.toString()),
                      Text(_addressControoler.text.toString()),
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
}
