import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/Calenders.dart';
import 'package:test_web_app/Models/MoveModel.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Providers/CreateLeadProvider.dart';
import 'package:test_web_app/Providers/DuplicatesFinderProvider.dart';
import 'package:test_web_app/Providers/GenerateCxIDProvider.dart';
import 'package:test_web_app/Providers/LeadUpdateProvider.dart';
import 'package:test_web_app/Providers/UpdateCompanyDetailsProvider.dart';
import 'package:test_web_app/Providers/UserProvider.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';

class MoveDrawer extends StatefulWidget {
  const MoveDrawer({Key? key}) : super(key: key);

  @override
  _MoveDrawerState createState() => _MoveDrawerState();
}

class _MoveDrawerState extends State<MoveDrawer> {
  List emaillist = [];

  var cusid;

  @override
  void initState() {
    super.initState();
    menu();
  }

  String? radioItem;
  String? _choosenValue;
  String? _selectperson;
  String? _image;
  final List<String> inbounditems = ["CALL", "EMAIL", "SOCIAL MEDIA"];
  final List<String> outbounditems = [
    "CALL",
    "EMAIL",
    "SOCIAL MEDIA",
    "NO RESPONSE"
  ];
  final List<String> _timelist = [
    "1 HR",
    "2 HR",
    "3 HR",
    "4 HR",
    "6 HR",
    "Custom"
  ];
  String? activetime;
  String? activeid;

  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final TextEditingController _leadnameController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _clientnameController = TextEditingController();
  final TextEditingController _clientphoneController = TextEditingController();
  final TextEditingController _clientemailController = TextEditingController();
  final TextEditingController _firstmessageController = TextEditingController();

  final TextEditingController _customtimeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.25,
      child: Drawer(
          child: Padding(
        padding: EdgeInsets.only(right: 15, left: 20),
        child: _checkdrawer(),
      )),
    );
  }

  _checkdrawer() {
    switch (enddrawerkey) {
      case "Lead":
        {
          return createlead();
        }
      case "move":
        {
          return movetask();
        }
      case "update":
        {
          return updatetask();
        }

      default:
        {
          return Profile();
        }
    }
  }

  Widget divider() {
    return Divider(color: Colors.grey.withOpacity(0.2));
  }

  Widget space() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: size.height * 0.01);
  }

  Widget actions() {
    if (radioItem != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 40),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Expanded(
              child: Text(
                'Choose Option',
                overflow: TextOverflow.ellipsis,
              ),
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

  Widget _field(_controller, bool enable, hint) {
    return Container(
      decoration: deco,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 2),
        child: TextFormField(
          validator: (fullname) {
            if (fullname!.isEmpty) {
              return "field can not be empty";
            } else if (fullname.length < 3) {
              return "field should be atleast 3 letters";
            } else {
              return null;
            }
          },
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

  DateTime? addtime;
  val() {
    if (activetime == "1 HR") {
      setState(() {
        addtime = DateTime.now().add(Duration(hours: 1));
      });
    } else if (activetime == "2 HR") {
      setState(() {
        addtime = DateTime.now().add(Duration(hours: 2));
      });
    } else if (activetime == "3 HR") {
      addtime = DateTime.now().add(Duration(hours: 3));
    } else if (activetime == "4 HR") {
      setState(() {
        addtime = DateTime.now().add(Duration(hours: 4));
      });
    } else if (activetime == "6 HR") {
      setState(() {
        addtime = DateTime.now().add(Duration(hours: 6));
      });
    } else if (activetime == "Custom") {
      setState(() {
        print(_customtimeController.text);
      });
    } else {
      setState(() {
        addtime = DateTime.now();
      });
    }
  }

  // timeendnotification() async {
  //   print("delhi");
  //   SharedPreferences _sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   List<String> timerslist = [];
  //   timerslist.add('your schedule time has been ended');
  //   _sharedPreferences.setStringList("timer", timerslist);
  //   print(" to khammam  .......");
  // }

  /// drawerwidgets are here...
  Widget Profile() {
    final userdata = Provider.of<UserDataProvider>(context);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: size.height * 0.225,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userdata.imageUrl.toString()),
                  maxRadius: 50,
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(userdata.username.toString(),
                        style: TxtStls.fieldtitlestyle),
                    Text("(JR-0${userdata.eid.toString()})",
                        style: TxtStls.fieldtitlestyle),
                  ],
                ),
                Text("(${userdata.udesignation.toString()})",
                    style: TxtStls.fieldstyle),
              ],
            ),
          ),
          divider(),
          space(),
          Text("Contact Info", style: TxtStls.fieldtitlestyle),
          space(),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.email, color: btnColor, size: 15),
              backgroundColor: btnColor.withOpacity(0.1),
            ),
            title: Text("Email", style: TxtStls.fieldtitlestyle),
            subtitle:
                Text(userdata.email.toString(), style: TxtStls.fieldstyle),
          ),
          divider(),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.phone,
                color: btnColor,
                size: 15,
              ),
              backgroundColor: btnColor.withOpacity(0.1),
            ),
            title: Text("Phone Number", style: TxtStls.fieldtitlestyle),
            subtitle:
                Text(userdata.phone.toString(), style: TxtStls.fieldstyle),
          ),
          divider(),
          ListTile(
            title: Text("Address", style: TxtStls.fieldtitlestyle),
            leading: CircleAvatar(
              backgroundColor: btnColor.withOpacity(0.1),
              child: Icon(
                Icons.location_on,
                color: btnColor,
                size: 15,
              ),
            ),
            subtitle: Text(userdata.add.toString(), style: TxtStls.fieldstyle),
          ),
          divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: btnColor.withOpacity(0.1),
              child: Icon(
                Icons.calendar_today,
                color: btnColor,
                size: 15,
              ),
            ),
            title: Text("Date of Joining", style: TxtStls.fieldtitlestyle),
            subtitle: Text(
              userdata.doj.toString(),
              style: TxtStls.fieldstyle,
            ),
          ),
          divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red.withOpacity(0.1),
              child: Icon(
                Icons.bloodtype_rounded,
                color: Colors.red,
                size: 15,
              ),
            ),
            title: Text("Blood Group", style: TxtStls.fieldtitlestyle),
            subtitle: Text(
              userdata.bgroup.toString(),
              style: TxtStls.fieldstyle,
            ),
          ),
          divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red.withOpacity(0.1),
              child: Icon(
                Icons.call,
                color: Colors.red,
                size: 15,
              ),
            ),
            title: Text("Emergency Contact", style: TxtStls.fieldtitlestyle),
            subtitle: Text(
              userdata.econtact.toString(),
              style: TxtStls.fieldstyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget movetask() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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
            SizedBox(height: 10),
            Text(
              "Progress Update",
              style: TxtStls.fieldtitlestyle11,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: Text(
                    dname! + "  (${cxID!})",
                    style: TxtStls.fieldtitlestyle11,
                  ),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.orangeAccent,
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
                          toggleable: false,
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
                          toggleable: false,
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
            Wrap(
                children: _list
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            child: Card(
                              shadowColor: btnColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
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
            activeid == "CLOSE"
                ? SizedBox()
                : InkWell(
                    child: _field(_endDateController, false, "End Date"),
                    onTap: () {
                      MyCalenders.pickEndDate(context, _endDateController);
                      setState(() {});
                    },
                  ),
            SizedBox(height: 5),
            dcat == "NEW"
                ? activeid == "CLOSE"
                    ? SizedBox()
                    : _field(_companyController, true, "Enter Company name")
                : SizedBox(),
            SizedBox(height: 5),
            dcat == "NEW"
                ? activeid == "CLOSE"
                    ? SizedBox()
                    : _field(_websiteController, true, "Enter Company Website")
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
                  color: grClr,
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
                    if (_formKey.currentState!.validate() &&
                        radioItem != null &&
                        _choosenValue != null &&
                        activeid != null) {
                      val();
                      var uenddate = _endDateController.text.toString() == ""
                          ? dendDate.toString()
                          : _endDateController.text.toString();
                      var who =
                          Provider.of<UserDataProvider>(context, listen: false)
                              .username;
                      Provider.of<LeadUpdateProvider>(context, listen: false)
                          .updateLead(
                              dcat,
                              who,
                              noteController.text.toString(),
                              dendDate,
                              radioItem,
                              _choosenValue,
                              did,
                              enddrawerkey,
                              activeid,
                              uenddate,
                              addtime!,
                              dstatus)
                          .then((value) {
                        dcat == "NEW"
                            ? Provider.of<UpdateCompanyDeatailsProvider>(
                                    context,
                                    listen: false)
                                .updateCompanyDetails(
                                    did,
                                    _companyController.text.toString(),
                                    _websiteController.text.toString())
                            : null;
                        GraphValueServices.graph(dendDate, did);
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget createlead() {
    final alluserModellist =
        Provider.of<AllUSerProvider>(context).alluserModellist;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
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
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Text(
                  'Select the agent to assignee',
                  overflow: TextOverflow.ellipsis,
                  style: TxtStls.fieldstyle,
                ),
                items: alluserModellist
                    .map((item) => DropdownMenuItem<String>(
                          onTap: () {
                            _image = item.auserimage;
                            setState(() {});
                          },
                          value: item.uid,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  child: SizedBox(
                                      width: 50,
                                      height: 80,
                                      child: Image.network(
                                        item.auserimage.toString(),
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      )),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  item.ausername.toString(),
                                  style: TxtStls.fieldstyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
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
            ),
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
                if (_formKey.currentState!.validate()) {
                  var duplicateprovider = Provider.of<DuplicatesFinderProvider>(
                      context,
                      listen: false);
                  var generatedidprovider =
                      Provider.of<RecentFetchCXIDProvider>(context,
                          listen: false);
                  duplicateprovider
                      .findduplicates(_clientemailController.text.toString())
                      .then((value) {
                    print(duplicateprovider.existingCutomerid);
                    if (duplicateprovider.existingCutomerid == null) {
                      generatedidprovider.fetchLeadId().then((value) {
                        generatedidprovider.fetchRecent().then((value) {
                          Provider.of<CreateLeadProvider>(context,
                                  listen: false)
                              .createTask(
                                  _leadnameController.text.toString(),
                                  _endDateController.text.toString(),
                                  _clientnameController.text.toString(),
                                  _clientemailController.text.toString(),
                                  _clientphoneController.text.toString(),
                                  _firstmessageController.text.toString(),
                                  _selectperson,
                                  _image,
                                  generatedidprovider.CxID,
                                  generatedidprovider.leadId)
                              .then((value) {
                            Navigator.of(context).pop();
                          });
                        });
                      });
                    } else {
                      generatedidprovider.fetchLeadId().then((value) {
                        var existid = Provider.of<DuplicatesFinderProvider>(
                                context,
                                listen: false)
                            .existingCutomerid;
                        Provider.of<CreateLeadProvider>(context, listen: false)
                            .createTask(
                                _leadnameController.text.toString(),
                                _endDateController.text.toString(),
                                _clientnameController.text.toString(),
                                _clientemailController.text.toString(),
                                _clientphoneController.text.toString(),
                                _firstmessageController.text.toString(),
                                _selectperson,
                                _image,
                                existid,
                                generatedidprovider.leadId)
                            .then((value) {
                          Navigator.of(context).pop();
                        });
                      });
                    }
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget updatetask() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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
              "Update",
              style: TxtStls.fieldtitlestyle11,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: Text(
                    dname! + "  (${cxID!})",
                    style: TxtStls.fieldtitlestyle11,
                  ),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.orangeAccent,
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
                          toggleable: false,
                        ),
                      ),
                      Text(
                        "INBOUND",
                        style: TxtStls.fieldstyle1,
                      ),
                    ],
                  ),
                ),
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
                          toggleable: false,
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
                    Icons.calendar_today_sharp,
                    color: btnColor,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "Reschedule",
                  style: TxtStls.fieldtitlestyle,
                )
              ],
            ),
            Wrap(
                children: _timelist
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Material(
                              shadowColor: btnColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              elevation: activetime == e ? 10 : 0,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                width: 60,
                                height: 30,
                                child: Text(
                                  e,
                                  style: TxtStls.fieldstyle,
                                ),
                              ),
                            ),
                            onTap: () {
                              activetime = e;
                              setState(() {});
                            },
                            onDoubleTap: () {
                              activetime = null;
                              setState(() {});
                            },
                          ),
                        ))
                    .toList()),
            SizedBox(height: 10),
            activetime == "Custom"
                ? Container(
                    height: 200,
                    child: Theme(
                      data: ThemeData(
                        colorScheme: ColorScheme.light(primary: btnColor),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: CalendarDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200),
                          onDateChanged: (value) {
                            _customtimeController.text = value.toString();
                            setState(() {});
                          }),
                    ),
                  )
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
                  color: grClr,
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
                  child: Text("Update", style: TxtStls.fieldstyle1),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        radioItem != null &&
                        _choosenValue != null) {
                      var who =
                          Provider.of<UserDataProvider>(context, listen: false)
                              .username;
                      val();
                      var uenddate = _endDateController.text.toString() == ""
                          ? dendDate.toString()
                          : _endDateController.text.toString();
                      Provider.of<LeadUpdateProvider>(context, listen: false)
                          .updateLead(
                              dcat,
                              who,
                              noteController.text.toString(),
                              dendDate,
                              radioItem,
                              _choosenValue,
                              did,
                              enddrawerkey,
                              activeid,
                              uenddate,
                              addtime!,
                              dstatus)
                          .then((value) {
                        Navigator.pop(context);
                      });

                      //GraphValueServices.graph(dendDate, did);
                      //timeendnotification();

                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  findduplicates() async {
    print('clientemail-' + _clientemailController.text.toString());
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("Tasks")
        .where("dupmail", isEqualTo: _clientemailController.text)
        .get()
        .then((value) {
      print(value.docs);
      value.docs.forEach((element) {
        print(element.get("CxID"));
      });
    });

    // print(snapshot);
    //
    // snapshot.docs.forEach((element) {
    //   var email = element["CompanyDetails"]["email"];
    //   var cusid = element["CxID"];
    //   print('####' + cusid + email.toString());
    // });
    // snapshot.docs.forEach((element) {
    //   var dd = element["CompanyDetails"][0]["email"];
    //   emaillist = dd.split(",");
    //   print('2222--' + emaillist.toString());
    // });
  }
}

class Model {
  final String name;
  final Color color;
  Model({required this.name, required this.color});
}
