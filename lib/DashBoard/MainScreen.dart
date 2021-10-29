import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
import 'package:test_web_app/Constants/Calenders.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/UserModels.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/Comonents/DashBoard/MyDashBoard.dart';
import 'package:test_web_app/DashBoard/Comonents/Header.dart';
import 'package:test_web_app/DashBoard/Comonents/Leads/Leads_View.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final ScrollController _mainScrollController = ScrollController();
  Tabs active = Tabs.DashBoard;
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(context),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!Responsive.isSmallScreen(context))
              Expanded(
                child: SideDrawer(context),
              ),
            Expanded(
              flex: 5,
              child: DashboardBody(context),
            ),
          ],
        ),
      ),
      floatingActionButton: role == "Admin"
          ? RaisedButton.icon(
              onPressed: () {
                taskBox(context);
              },
              icon: Icon(Icons.add),
              label: Text("Create"),
              color: Colors.pinkAccent,
              elevation: 10)
          : null,
    );
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await _auth.signOut().then((value) => Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false));
  }

  Widget SideDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: ExactAssetImage('assets/Logos/jrlogo.jpeg'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          DrawerListTile(
              "DashBoard", "assets/menu_dashbord.svg", Tabs.DashBoard),
          DrawerListTile("Leads", "assets/menu_task.svg", Tabs.Leads),
          DrawerListTile("Notification", "assets/menu_notification.svg",
              Tabs.Notification),
          DrawerListTile("Profile", "assets/menu_profile.svg", Tabs.Profile),
          DrawerListTile("Settings", "assets/menu_setting.svg", Tabs.Settings),
        ],
      ),
    );
  }

  DrawerListTile(title, svgPicture, tab) {
    return ListTile(
      title: Text(title, style: TextStyle(color: txtColor)),
      leading: SvgPicture.asset(
        svgPicture,
        color: txtColor,
      ),
      onTap: () {
        active = tab;
        setState(() {});
      },
    );
  }

  Widget DashboardBody(BuildContext context) {
    if (active == Tabs.DashBoard) {
      return SafeArea(
        child: Scrollbar(
          controller: _mainScrollController,
          isAlwaysShown: true,
          showTrackOnHover: true,
          hoverThickness: 10.0,
          child: ListView(
            controller: _mainScrollController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            children: [
              Header(
                title: "DashBoard",
              ),
              DashBoardBodyScreen(),
            ],
          ),
        ),
      );
    }
    if (active == Tabs.Leads) {
      return Scrollbar(
        controller: _mainScrollController,
        isAlwaysShown: true,
        showTrackOnHover: true,
        hoverThickness: 10.0,
        child: SafeArea(
          child: ListView(
            controller: _mainScrollController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            children: [
              Header(
                title: "Leads",
              ),
              LeadScreen(),
            ],
          ),
        ),
      );
    }
    if (active == Tabs.Notification) {
      return SafeArea(
        child: Column(
          children: [
            Header(
              title: "Notification",
            ),
            Text(
              "Notification",
              style: TextStyle(color: txtColor),
            )
          ],
        ),
      );
    }
    if (active == Tabs.Profile) {
      return SafeArea(
        child: Column(
          children: [
            Header(
              title: "Profile",
            ),
            Text(
              "Profile",
              style: TextStyle(color: txtColor),
            )
          ],
        ),
      );
    }
    return SafeArea(
      child: Column(
        children: [
          Header(
            title: "Settings",
          ),
          Text(
            "Settings",
            style: TextStyle(color: txtColor),
          )
        ],
      ),
    );
  }

  userdetails() async {
    await fireStore
        .collection("EmployeeData")
        .where("uid", isEqualTo: _auth.currentUser!.uid.toString())
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        username = element.data()["username"].toString();
        email = element.data()["email"].toString();
        phone = element.data()["phone"].toString();
        imageUrl = element.data()["imageUrl"].toString();
        role = element.data()["role"].toString();
        uid = element.data()["uid"].toString();
        setState(() {});
      });
    });
  }

  void taskBox(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var alertDialog = AlertDialog(
      backgroundColor: txtColor,
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            width:
                Responsive.isSmallScreen(context) ? width * 0.16 : width * 0.16,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Create New Task"),
                      SizedBox(width: 50),
                      IconButton(
                        color: Colors.red,
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  SizedBox(
                    height: height * 0.05,
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: grClr,
                      child: TextFormField(
                        cursorColor: neClr,
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Task Name' : null;
                        },
                        controller: _taskController,
                        decoration: const InputDecoration(
                            hintText: "TO DO NAME",
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: bgColor)),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      MyCalenders.pickEndDate(context, _endDateController);
                      setState(() {});
                    },
                    child: SizedBox(
                      height: height * 0.05,
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: grClr,
                        child: TextFormField(
                          enabled: false,
                          cursorColor: neClr,
                          controller: _endDateController,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today_outlined),
                                onPressed: () {},
                              ),
                              hintText: "18-07-2000",
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: bgColor)),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: height * 0.05,
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: grClr,
                      child: TextFormField(
                        cursorColor: neClr,
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Name' : null;
                        },
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: "Person NAME",
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: bgColor)),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: height * 0.05,
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: grClr,
                      child: TextFormField(
                        cursorColor: neClr,
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Email' : null;
                        },
                        controller: _emailController,
                        decoration: const InputDecoration(
                            hintText: "Email",
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: bgColor)),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: height * 0.05,
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: grClr,
                      child: TextFormField(
                        cursorColor: neClr,
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Phone Number' : null;
                        },
                        controller: _phoneController,
                        decoration: const InputDecoration(
                            hintText: "Phone Number",
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: bgColor)),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: height * 0.05,
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: grClr,
                      child: TextFormField(
                        cursorColor: neClr,
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Message' : null;
                        },
                        controller: _messageController,
                        decoration: const InputDecoration(
                            hintText: "message",
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: bgColor)),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    elevation: 0.0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    color: Colors.green,
                    child: const Text(
                      "Create",
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        CrudOperations.uploadTask(
                            _taskController,
                            _endDateController,
                            _nameController,
                            _emailController,
                            _phoneController,
                            _messageController);
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return alertDialog;
        });
  }
}

enum Tabs { DashBoard, Leads, Notification, Profile, Settings }
