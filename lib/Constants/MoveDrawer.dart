import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:test_web_app/Constants/Calenders.dart';
import 'package:test_web_app/Constants/MoveModel.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/reusable.dart';

class MoveDrawer extends StatefulWidget {
  const MoveDrawer({Key? key}) : super(key: key);

  @override
  _MoveDrawerState createState() => _MoveDrawerState();
}

class _MoveDrawerState extends State<MoveDrawer> {
  @override
  void initState() {
    super.initState();
    this.menu();
  }

  var radioItem;
  var _choosenValue;
  var _selectperson;
  var _image;
  final inbounditems = ["CALL", "EMAIL", "SOCIAL MEDIA"];
  final outbounditems = ["CALL", "EMAIL", "SOCIAL MEDIA", "NO RESPONSE"];
  String? activeid;

  TextEditingController _companyController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  TextEditingController _leadnameController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _clientnameController = TextEditingController();
  TextEditingController _clientphoneController = TextEditingController();
  TextEditingController _clientemailController = TextEditingController();
  TextEditingController _firstmessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: _check(),
    ));
  }

  Widget actions() {
    if (radioItem != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 40),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Choose Action Type',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: radioItem == "InBound"
                ? inbounditems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TxtStls.fieldstyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList()
                : outbounditems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TxtStls.fieldstyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
            value: _choosenValue,
            onChanged: (value) {
              setState(() {
                _choosenValue = value as String;
              });
            },
            iconEnabledColor: txtColor,
            buttonPadding: EdgeInsets.symmetric(horizontal: 15),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            itemPadding: const EdgeInsets.symmetric(horizontal: 15),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: bgColor,
            ),
          ),
        ),
      );
    }
    return Text("");
  }

  final List<Model> _list = [];
  menu() {
    _list.add(Model(name: "NEW", color: neClr));
    _list.add(Model(name: "PROSPECT", color: prosClr));
    _list.add(Model(name: "IN PROGRESS", color: ipClr));
    _list.add(Model(name: "WON", color: wonClr));
    _list.add(Model(name: "CLOSE", color: clsClr));
  }

  Widget _check() {
    if (lead == "Lead") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Create New Lead", style: TxtStls.fieldtitlestyle11),
              CircleAvatar(
                backgroundColor: neClr.withOpacity(0.1),
                child: IconButton(
                    hoverColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: neClr,
                      size: 15,
                    )),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text("Lead Name", style: TxtStls.fieldtitlestyle),
          _field(_leadnameController, true, "Lead Name"),
          SizedBox(height: 10.0),
          Text("End Date", style: TxtStls.fieldtitlestyle),
          InkWell(
            child: _field(_endDateController, false, "End Date"),
            onTap: () {
              MyCalenders.pickEndDate(context, _endDateController);
              setState(() {});
            },
          ),
          SizedBox(height: 10.0),
          Text("Client Name", style: TxtStls.fieldtitlestyle),
          _field(_clientnameController, true, "Client Name"),
          SizedBox(height: 10.0),
          Text("Client Phone Number", style: TxtStls.fieldtitlestyle),
          _field(_clientphoneController, true, "Client Phone Number"),
          SizedBox(height: 10.0),
          Text("Client Email", style: TxtStls.fieldtitlestyle),
          _field(_clientemailController, true, "Client email id"),
          SizedBox(height: 10.0),
          Text("First Message", style: TxtStls.fieldtitlestyle),
          _field(_firstmessageController, true, "Enter First Message"),
          SizedBox(height: 10.0),
          Text("Assignee", style: TxtStls.fieldtitlestyle),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("EmployeeData")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                var snp = snapshot.data!.docs;
                if (snapshot.hasError) {
                  return Container();
                }
                return DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Text(
                      'Choose Action Type',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.5, color: txtColor, letterSpacing: 0.2),
                    ),
                    items: snp
                        .map((item) => DropdownMenuItem<String>(
                              onTap: () {
                                _image = item.get("uimage");
                                setState(() {});
                              },
                              value: item.get('uid'),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    child: Image.network(item.get("uimage")),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  Text(
                                    item.get("uname"),
                                    style: TxtStls.fieldstyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    value: _selectperson,
                    onChanged: (value) {
                      setState(() {
                        _selectperson = value as String;
                      });
                    },
                    iconEnabledColor: txtColor,
                    buttonPadding: EdgeInsets.symmetric(horizontal: 15),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 15),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: bgColor,
                    ),
                  ),
                );
              }),
          SizedBox(height: 10.0),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(12.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Text(
                "Create Lead",
                style: TxtStls.fieldstyle1,
              ),
            ),
            onTap: () {
              CrudOperations.uploadTask(
                _leadnameController,
                _endDateController,
                _clientnameController,
                _clientemailController,
                _clientphoneController,
                _firstmessageController,
                _selectperson,
                _image,
              );

              Navigator.pop(context);
            },
          )
        ],
      );
    }
    if (lead == "update") {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                backgroundColor: neClr.withOpacity(0.1),
                child: IconButton(
                    hoverColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: neClr,
                      size: 15,
                    )),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Progress Update",
              style: TxtStls.fieldtitlestyle11,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  dname!,
                  style: TxtStls.fieldtitlestyle11,
                ),
                SizedBox(width: 5),
                Text(
                  cxID!,
                  style: TxtStls.fieldtitlestyle11,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: btnColor.withOpacity(0.1),
                  child: Icon(Icons.access_time_rounded, color: btnColor),
                ),
                SizedBox(width: 5),
                Column(
                  children: [
                    Text(
                        DateFormat('dd,MMMM,yyyy,hh:mm a')
                            .format(DateTime.now()),
                        style: TxtStls.fieldtitlestyle),
                    Text("${DateTime.now().timeZoneName}",
                        style: TxtStls.fieldstyle),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: btnColor.withOpacity(0.1),
                  child: Icon(
                    Icons.work,
                    color: btnColor,
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  children: [
                    Text(
                      "Type of Activity",
                      style: TxtStls.fieldtitlestyle,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: statClr.inpro,
                  ),
                  child: Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: bgColor),
                        child: Radio(
                          activeColor: btnColor,
                          value: "InBound",
                          groupValue: radioItem,
                          onChanged: (val) {
                            radioItem = val.toString();
                            setState(() {});
                          },
                          toggleable: true,
                        ),
                      ),
                      Text(
                        "INBOUND",
                        style: TxtStls.fieldstyle1,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 120,
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: wonClr,
                  ),
                  child: Row(
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: bgColor),
                        child: Radio(
                          activeColor: btnColor,
                          value: "OutBound",
                          groupValue: radioItem,
                          onChanged: (val) {
                            radioItem = val.toString();
                            setState(() {});
                          },
                          toggleable: true,
                        ),
                      ),
                      Text(
                        "OUTBOUND",
                        style: TxtStls.fieldstyle1,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            actions(),
            Row(
              children: [
                CircleAvatar(
                    backgroundColor: btnColor.withOpacity(0.1),
                    child: Icon(
                      Icons.videogame_asset,
                      color: btnColor,
                    )),
                SizedBox(width: 5),
                Text(
                  "Status Selection",
                  style: TxtStls.fieldtitlestyle,
                )
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                  alignment: WrapAlignment.start,
                  children: _list
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Card(
                                shadowColor: btnColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                elevation: activeid == e.name ? 20 : 0,
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 103,
                                    child: Text(
                                      e.name,
                                      style: TxtStls.fieldstyle1,
                                    ),
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: e.color,
                                        border: Border.all(
                                            color: activeid == e.name
                                                ? btnColor
                                                : bgColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)))),
                              ),
                              onTap: () {
                                activeid = e.name;
                                setState(() {});
                              },
                              onDoubleTap: () {
                                activeid = null;
                                setState(() {});
                              },
                            ),
                          ))
                      .toList()),
            ),
            dcat == "NEW"
                ? _field(_companyController, true, "Enter Company name")
                : SizedBox(),
            SizedBox(height: 5),
            dcat == "NEW"
                ? _field(_websiteController, true, "Enter Company Website")
                : SizedBox(),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: btnColor.withOpacity(0.1),
                  child: Icon(
                    Icons.message,
                    color: btnColor,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "Comments",
                  style: TxtStls.fieldtitlestyle,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, top: 2),
              child: Container(
                decoration: deco,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 0, top: 2),
                  child: TextFormField(
                    controller: noteController,
                    maxLines: 6,
                    style: TxtStls.fieldstyle,
                    decoration: InputDecoration(
                      hintText: "Enter a valid Comment",
                      hintStyle: TxtStls.fieldstyle,
                      border: InputBorder.none,
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
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  hoverColor: Colors.transparent,
                  color: AbgColor.withOpacity(0.001),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Text("Cancel", style: TxtStls.fieldstyle1),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  hoverColor: Colors.transparent,
                  color: btnColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Text("Save", style: TxtStls.fieldstyle1),
                  onPressed: () {
                    dcat == "NEW"
                        ? ComapnyUpdateServices.updateCompany(
                            did, _companyController, _websiteController)
                        : null;
                    ProgressUpdsate.updateCat(did, dcat, activeid,
                        noteController, dendDate, radioItem, _choosenValue);
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      );
    }
    return Text('');
  }

  Widget _field(
    _controller,
    bool enable,
    hint,
  ) {
    return Container(
      decoration: deco,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 2),
        child: TextFormField(
          controller: _controller,
          enabled: enable,
          style: TxtStls.fieldstyle,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TxtStls.fieldstyle,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class Model {
  final String name;
  final Color color;
  Model({required this.name, required this.color});
}
//
// PopupMenuButton(
// icon: Icon(Icons.person_add),
// color: txtColor,
// itemBuilder: (context) => snp
//     .map((item) => PopupMenuItem(
// onTap: () {
// img = item.get("uimage");
// setState(() {});
// },
// value: item.get("uid"),
// child: Row(
// children: [
// CircleAvatar(
// backgroundImage:
// NetworkImage(item.get("uimage")),
// ),
// Text(
// item.get("uname"),
// ),
// ],
// )))
// .toList(),
// onSelected: (value) {},
// );
