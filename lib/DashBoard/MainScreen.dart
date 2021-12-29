import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/UserModels.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/Header.dart';
import 'package:test_web_app/Constants/MoveDrawer.dart';
import 'package:test_web_app/DashBoard/Comonents/Task%20Preview/TaskPreview.dart';
import 'package:test_web_app/DashBoard/Comonents/DashBoard/UserDashBoard.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Tabs active = Tabs.TaskPreview;

  @override
  void initState() {
    super.initState();
    this.userdetails();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      drawerEnableOpenDragGesture: false,
      drawer: SideDrawer(context),
      endDrawer: MoveDrawer(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!Responsive.isSmallScreen(context))
              Expanded(child: SideDrawer(context)),
            Expanded(flex: 6, child: DashboardBody(context)),
          ],
        ),
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
              "TaskPreview", "assets/Notations/Document.png", Tabs.TaskPreview),
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
    } else if (active == Tabs.TaskPreview) {
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
          title: Text(
            'Are you sure to LogOut?',
            style: TxtStls.fieldtitlestyle,
          ),
          actions: <Widget>[
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: grClr,
              child: Text(
                'Cancel',
                style: TxtStls.fieldstyle1,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: clsClr,
              child: Text('Ok', style: TxtStls.fieldstyle1),
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
  TaskPreview,
  Analytics,
  Invoice,
  Calendar,
  Messages,
  Notification,
  Settings
}
