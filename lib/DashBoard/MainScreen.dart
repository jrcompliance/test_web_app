import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Auth_Views/GetUserdata.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/Comonents/DashBoard/MyDashBoard.dart';
import 'package:test_web_app/DashBoard/Comonents/Header.dart';
import 'package:test_web_app/Task/TaskScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final ScrollController _mainScrollController = ScrollController();
  Tabs active = Tabs.DashBoard;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(context),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!Responsive.isMobile(context))
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
      floatingActionButton: RaisedButton.icon(
          onPressed: () {
            logout();
          },
          icon: Icon(Icons.add),
          label: Text("Create"),
          color: Colors.pinkAccent,
          elevation: 10),
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
          DrawerListTile("Task", "assets/menu_task.svg", Tabs.Task),
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
        print(active);
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
    if (active == Tabs.Task) {
      return SafeArea(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          children: [
            Header(
              title: "Task",
            ),
            TaskScreen(),
          ],
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
}

enum Tabs { DashBoard, Task, Notification, Profile, Settings }
