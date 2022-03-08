import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/Comonents/Calendar/Calendar.dart';
import 'package:test_web_app/UserProvider/CustomerProvider.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final _list = ["Quotation", "Performer Invoice", "Invoice"];
  var activeid = "Quotation";
  bool qto = false;
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final customerlist = Provider.of<CustmerProvider>(context).customerlist;

    return Container(
      color: AbgColor.withOpacity(0.0001),
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
      child: qto
          ? Calendar()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _list.map((e) => newMethod(e, () {})).toList(),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                          height: size.height * 0.86,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: bgColor,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01,
                                    horizontal: size.width * 0.01),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: fieldColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 2),
                                    child: TextFormField(
                                      controller: _searchController,
                                      style: TxtStls.fieldstyle,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.search,
                                              color: btnColor,
                                            ),
                                            onPressed: () {},
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Enter Customer Name...",
                                          hintStyle: TxtStls.fieldstyle),
                                    ),
                                  ),
                                ),
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                itemCount: customerlist.length,
                                itemBuilder: (BuildContext context, int i) {
                                  var snp = customerlist[i];
                                  String? contactname = snp.Customername;
                                  String? cemail = snp.Customeremail;
                                  String? cphone = snp.Customerphone;
                                  return InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: bgColor,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  maxRadius: 15,
                                                  child: Icon(Icons.person,
                                                      color: btnColor,
                                                      size: 15),
                                                  backgroundColor:
                                                      btnColor.withOpacity(0.1),
                                                ),
                                                SizedBox(width: 5),
                                                Text(contactname.toString(),
                                                    style: TxtStls.fieldstyle),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Row(
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
                                          )),
                                          Expanded(
                                            child: Row(
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
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(height: 7.5);
                                },
                              ),
                            ],
                          )),
                    ),
                    SizedBox(width: 10),
                    infowidget(),
                  ],
                )
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

  Widget infowidget() {
    Size size = MediaQuery.of(context).size;
    return Expanded(
        flex: 5,
        child: Container(
          height: size.height * 0.860,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: bgColor,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  elevation: 0.0,
                  color: btnColor,
                  hoverColor: Colors.transparent,
                  hoverElevation: 0.0,
                  onPressed: () {
                    setState(() {
                      qto = true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Create " + activeid,
                      style: TextStyle(
                          fontSize: 12.5, color: bgColor, letterSpacing: 0.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
