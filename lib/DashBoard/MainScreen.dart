import 'dart:async';
import 'dart:typed_data';
import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Constants/endDrawer.dart';
import 'package:test_web_app/DashBoard/Comonents/Calendar/Calendar.dart';
import 'package:test_web_app/DashBoard/Comonents/Notifications/NotificationScreen.dart';
import 'package:test_web_app/DashBoard/Comonents/Task%20Preview/TaskPreview.dart';
import 'package:test_web_app/Models/MoveModel.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/Header.dart';
import 'package:test_web_app/Models/tasklength.dart';
import 'package:test_web_app/UserProvider/UserProvider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final globalKey = GlobalKey<ScaffoldState>();
  final ScrollController _controller = ScrollController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Tabs active = Tabs.Calendar;

  @override
  void initState() {
    super.initState();
    userdetails();
    //Future.delayed(Duration(seconds: 3)).then((value) => userTasks());
    Future.delayed(Duration.zero).then((value) {
      Provider.of<AllUSerProvider>(context, listen: false).fetchAllUser();
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
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!Responsive.isSmallScreen(context))
                  Expanded(child: SideDrawer(context)),
                Expanded(flex: 6, child: DashboardBody(context)),
              ],
            ),
            ScaleAnimatedWidget.tween(
              duration: Duration(milliseconds: 450),
              scaleDisabled: 1.5,
              scaleEnabled: 1,
              child: updateProfile(),
            )
          ],
        ),
      ),
    );
  }

  Widget SideDrawer(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      elevation: 1,
      child: Container(
        height: size.height * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrawerHeader(
                child: Image.asset("assets/Logos/Ologo.png",
                    filterQuality: FilterQuality.high)),
            Expanded(
                child: ListView(
              shrinkWrap: true,
              children: [
                DrawerListTile("DashBoard", "assets/Notations/Category.png",
                    Tabs.DashBoard),
                DrawerListTile("TaskPreview", "assets/Notations/Document.png",
                    Tabs.TaskPreview),
                DrawerListTile(
                    "Analytics", "assets/Notations/Chart.png", Tabs.Analytics),
                DrawerListTile(
                    "Finance", "assets/Notations/Ticket.png", Tabs.Finance),
                DrawerListTile(
                    "Calendar", "assets/Notations/Calendar.png", Tabs.Calendar),
                DrawerListTile(
                    "Messages", "assets/Notations/Activity.png", Tabs.Messages),
                DrawerListTile("Notification",
                    "assets/Notations/Notification.png", Tabs.Notification),
                DrawerListTile(
                    "Settings", "assets/Notations/Setting.png", Tabs.Settings),
              ],
            )),
            Card(
              elevation: 10.0,
              child: Builder(
                builder: (context) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        lead = "Profile";
                        Scaffold.of(context).openEndDrawer();
                      });
                    },
                    leading: imageUrl == null || imageUrl == ""
                        ? Icon(
                            Icons.person,
                            color: txtColor,
                            size: 30,
                          )
                        : ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: SizedBox(
                                height: size.height * 0.06,
                                width: size.width * 0.025,
                                child: Image.network(
                                  imageUrl!,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ))),
                    title: username == null
                        ? Text("")
                        : Text(username!, style: TxtStls.fieldstyle),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          color: btnColor,
                        )),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  DashboardBody(BuildContext context) {
    switch (active) {
      case Tabs.DashBoard:
        {
          return Column(
            children: [
              Header(
                title: "DashBoard",
              ),
              //UserDashBoard(),
            ],
          );
        }
      case Tabs.TaskPreview:
        {
          return Column(
            children: [
              Header(title: 'Task Preview'),
              TaskPreview(),
            ],
          );
        }

      case Tabs.Analytics:
        {
          return Column(
            children: [
              Header(title: "Analytics"),
              //Analytics(),
            ],
          );
        }

      case Tabs.Finance:
        {
          return Column(
            children: [
              Header(title: "Finance"),
              //InvoiceScreen(),
            ],
          );
        }

      case Tabs.Calendar:
        {
          return Column(
            children: [
              Header(title: "Calendar"),
              Calendar(),
            ],
          );
        }

      case Tabs.Messages:
        {
          return Header(title: "Messages");
        }

      case Tabs.Notification:
        {
          return Column(
            children: [Header(title: "Notification"), Notifications()],
          );
        }

      default:
        {
          return Header(
            title: "Settings",
          );
        }
    }
  }

  DrawerListTile(title, image, tab) {
    return ListTile(
      title: Responsive.isMediumScreen(context)
          ? Text("")
          : Text(title, style: TxtStls.fieldtitlestyle),
      leading: SizedBox(
        child: Image.asset(image,
            fit: BoxFit.fill, filterQuality: FilterQuality.high),
        height: 22.5,
      ),
      onTap: () => setState(() => active = tab),
      selectedColor: btnColor,
      hoverColor: btnColor.withOpacity(0.5),
    );
  }

  // functions are from here...

  Future<void> userdetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var uid = prefs.getString("uid");
      FirebaseFirestore.instance
          .collection("EmployeeData")
          .where("uid", isEqualTo: uid)
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
    } catch (e) {}
  }

  Future<void> userTasks() async {
    try {
      FirebaseFirestore.instance
          .collection("Tasks")
          .where("cat", isEqualTo: "NEW")
          .where("Attachments", arrayContainsAny: [
            {
              "image": imageUrl,
              "uid": _auth.currentUser!.uid.toString(),
            }
          ])
          .snapshots()
          .listen((value) {
            setState(() {
              newLength = value.docs.length.toDouble();
            });
          });
    } on Exception catch (e) {
      print(e.toString());
    }
    try {
      FirebaseFirestore.instance
          .collection("Tasks")
          .where("cat", isEqualTo: "PROSPECT")
          .where("Attachments", arrayContainsAny: [
            {
              "image": imageUrl,
              "uid": _auth.currentUser!.uid.toString(),
            }
          ])
          .snapshots()
          .listen((value) {
            prospectLength = value.docs.length.toDouble();
            setState(() {});
          });
    } on Exception catch (e) {
      print(e.toString());
    }
    try {
      FirebaseFirestore.instance
          .collection("Tasks")
          .where("Attachments", arrayContainsAny: [
            {
              "image": imageUrl,
              "uid": _auth.currentUser!.uid.toString(),
            }
          ])
          .where("cat", isEqualTo: "IN PROGRESS")
          .snapshots()
          .listen((value) {
            ipLength = value.docs.length.toDouble();
            setState(() {});
          });
    } on Exception catch (e) {
      print(e.toString());
    }
    try {
      FirebaseFirestore.instance
          .collection("Tasks")
          .where("Attachments", arrayContainsAny: [
            {
              "image": imageUrl,
              "uid": _auth.currentUser!.uid.toString(),
            }
          ])
          .where("cat", isEqualTo: "WON")
          .snapshots()
          .listen((value) {
            wonLength = value.docs.length.toDouble();
            setState(() {});
          });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Uint8List? logoBase64;
  String? name;
  chooseProfile() async {
    FilePickerResult? pickedfile = await FilePicker.platform.pickFiles();
    if (pickedfile != null) {
      Uint8List? fileBytes = pickedfile.files.first.bytes;
      String fileName = pickedfile.files.first.name;
      logoBase64 = fileBytes;
      name = fileName;
      setState(() {});
    } else {}
  }

  updateProfile() {
    Future.delayed(Duration(seconds: 10));
    Size size = MediaQuery.of(context).size;
    if (imageUrl == null || imageUrl == "") {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0.0),
        actionsPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(0),
        buttonPadding: EdgeInsets.all(0),
        backgroundColor: bgColor,
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: bgColor),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              width: size.width * 0.175,
              height: size.height * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Update Profile Picture",
                    style: TxtStls.fieldtitlestyle,
                  ),
                  InkWell(
                    child: logoBase64 == null
                        ? CircleAvatar(
                            maxRadius: 40.0,
                            child: Icon(Icons.camera_alt),
                          )
                        : CircleAvatar(
                            maxRadius: 40.0,
                            backgroundImage: MemoryImage(logoBase64!),
                          ),
                    onTap: () {
                      chooseProfile();
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Text(
                        "Name : ",
                        style: TxtStls.fieldstyle,
                      ),
                      username == null
                          ? Text("")
                          : Text(username!, style: TxtStls.fieldstyle)
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Email : ",
                        style: TxtStls.fieldstyle,
                      ),
                      email == null
                          ? Text("")
                          : Text(email!, style: TxtStls.fieldstyle)
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Phone : ",
                        style: TxtStls.fieldstyle,
                      ),
                      phone == null
                          ? Text("")
                          : Text(phone!, style: TxtStls.fieldstyle)
                    ],
                  ),
                  logoBase64 == null
                      ? SizedBox()
                      : Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              elevation: 0.0,
                              onPressed: () {
                                storeUserData();
                              },
                              child: Text(
                                "Update",
                                style: TxtStls.fieldstyle1,
                              ),
                              color: btnColor),
                        )
                ],
              ),
            );
          },
        ),
      );
    }
    return Text("");
  }

  Future<void> storeUserData() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      TaskSnapshot upload =
          await storage.ref('profiles/$name').putData(logoBase64!);
      String myUrl = await upload.ref.getDownloadURL();
      String uid = _auth.currentUser!.uid.toString();
      await fireStore.collection("EmployeeData").doc(uid).update({
        "uimage": myUrl,
      }).then((value) => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => MainScreen()), (route) => false));
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}

enum Tabs {
  DashBoard,
  TaskPreview,
  Analytics,
  Finance,
  Calendar,
  Messages,
  Notification,
  Settings
}
