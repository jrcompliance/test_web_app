import 'dart:async';
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
import 'package:test_web_app/Constants/Calenders.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/UserModels.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:test_web_app/Constants/tasklength.dart';
import 'package:test_web_app/DashBoard/Comonents/DashBoard/MyDashBoard.dart';
import 'package:test_web_app/DashBoard/Comonents/Header.dart';
import 'package:test_web_app/DashBoard/TaskPreview.dart';
import 'package:test_web_app/DashBoard/UserDashBoard.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
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
    this.userdetails();
    this.userTasks();
  }

  Future<void> userdetails() async {
    fireStore
        .collection("EmployeeData")
        .where("uid", isEqualTo: _auth.currentUser!.uid.toString())
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        setState(() {
          String uname = element.data()["uname"].toString();
          String uemail = element.data()["uemail"].toString();
          String uphoneNumber = element.data()["uphoneNumber"].toString();
          String uimage = element.data()["uimage"].toString();
          String urole = element.data()["urole"].toString();
          String uuid = element.data()["uid"].toString();
          username = uname;
          email = uemail;
          phone = uphoneNumber;
          imageUrl = uimage;
          role = urole;
          uid = uuid;
        });
      });
    });
  }

  Future<void> userTasks() async {
    FirebaseFirestore.instance
        .collection("Tasks")
        .where("Attachments",
            arrayContains: {"uid": _auth.currentUser!.uid.toString()})
        .where("cat", isEqualTo: "PROSPECT")
        .snapshots()
        .listen((value) {
          prospectLength = value.docs.length.toDouble();
          setState(() {});
        });
    FirebaseFirestore.instance
        .collection("Tasks")
        .where("Attachments",
            arrayContains: {"uid": _auth.currentUser!.uid.toString()})
        .where("cat", isEqualTo: "NEW")
        .snapshots()
        .listen((value) {
          newLength = value.docs.length.toDouble();
          setState(() {});
        });
    FirebaseFirestore.instance
        .collection("Tasks")
        .where("Attachments",
            arrayContains: {"uid": _auth.currentUser!.uid.toString()})
        .where("cat", isEqualTo: "INPROGRESS")
        .snapshots()
        .listen((value) {
          ipLength = value.docs.length.toDouble();
          setState(() {});
        });
    FirebaseFirestore.instance
        .collection("Tasks")
        .where("Attachments",
            arrayContains: {"uid": _auth.currentUser!.uid.toString()})
        .where("cat", isEqualTo: "WON")
        .snapshots()
        .listen((value) {
          wonLength = value.docs.length.toDouble();
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      extendBodyBehindAppBar: true,
      drawer: SideDrawer(context),
      endDrawer: Drawer(
        child: Column(
          children: [
            DrawerListTile(
                "Yalagala", "assets/Notations/Category.png", Tabs.Notification)
          ],
        ),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!Responsive.isSmallScreen(context))
              Expanded(
                child: SideDrawer(context),
              ),
            Expanded(
              flex: 6,
              child: DashboardBody(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskBox(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget SideDrawer(BuildContext context) {
    return Drawer(
      elevation: 0.9,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            alignment: Alignment.center,
            height: 130,
            child: SizedBox(
                height: 100, child: Image.asset("assets/Logos/Ologo.png")),
          ),
          DrawerListTile(
              "DashBoard", "assets/Notations/Category.png", Tabs.DashBoard),
          DrawerListTile(
              "Schedule", "assets/Notations/Document.png", Tabs.Schedule),
          DrawerListTile(
              "Anylytics", "assets/Notations/Chart.png", Tabs.Analytics),
          DrawerListTile(
              "Invoice", "assets/Notations/Ticket.png", Tabs.Invoice),
          DrawerListTile(
              "Calendar", "assets/Notations/Calendar.png", Tabs.Calendar),
          DrawerListTile(
              "Messages", "assets/Notations/Activity.png", Tabs.Messages),
          DrawerListTile("Notification", "assets/Notations/Notification.png",
              Tabs.Notification),
          DrawerListTile(
              "Settings", "assets/Notations/Setting.png", Tabs.Settings),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 260,
              width: 50,
              child: Image.asset(
                "assets/Logos/lamp.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Card(
            elevation: 10.0,
            child: ListTile(
              leading: imageUrl == null || imageUrl == ""
                  ? Icon(
                      Icons.person,
                      color: txtColor,
                      size: 30,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(imageUrl!)),
              title: username == null
                  ? Text("")
                  : Text(username!, style: TxtStls.fieldstyle),
              trailing: IconButton(
                  onPressed: () async {
                    await _showMyDialog();
                  },
                  icon: Icon(Icons.exit_to_app_outlined)),
            ),
          )
        ],
      ),
    );
  }

  Widget DashboardBody(BuildContext context) {
    if (active == Tabs.DashBoard) {
      return Column(
        children: [
          Header(
            title: "DashBoard",
          ),
          UserDashBoard(),
        ],
      );
    } else if (active == Tabs.Schedule) {
      return Column(
        children: [
          Header(title: 'Task Preview'),
          TaskPreview(),
        ],
      );
    } else if (active == Tabs.Analytics) {
      return Column(
        children: [
          Header(title: "Analytics"),
          //DashBoardBodyScreen(),
        ],
      );
    } else if (active == Tabs.Invoice) {
      return Header(title: "Invoice");
    } else if (active == Tabs.Calendar) {
      return Header(title: "Calendar");
    } else if (active == Tabs.Messages) {
      return Header(title: "Messages");
    } else if (active == Tabs.Notification) {
      return Header(title: "Notification");
    }
    return Header(
      title: "Settings",
    );
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

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await _auth.signOut().then((value) => Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: const Text(
            'Are you sure to LogOut?',
            style: TxtStls.fieldtitlestyle,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TxtStls.fieldstyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Ok',
                style: TxtStls.fieldstyle,
              ),
              onPressed: () {
                logout();
              },
            ),
          ],
        );
      },
    );
  }

  DrawerListTile(title, imageUrl, tab) {
    return ListTile(
      hoverColor: btnColor.withOpacity(0.25),
      title: Responsive.isMediumScreen(context)
          ? Text("")
          : Text(title, style: TxtStls.fieldtitlestyle),
      leading: SizedBox(
        child: Image.asset(imageUrl,
            fit: BoxFit.fill, filterQuality: FilterQuality.high),
        height: 22.5,
      ),
      onTap: () {
        setState(() {
          active = tab;
        });
      },
    );
  }
}

enum Tabs {
  DashBoard,
  Schedule,
  Analytics,
  Invoice,
  Calendar,
  Messages,
  Notification,
  Settings
}
