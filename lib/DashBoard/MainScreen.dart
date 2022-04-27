import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/endDrawer.dart';
import 'package:test_web_app/DashBoard/Comonents/Analytics/Analytics.dart';
import 'package:test_web_app/DashBoard/Comonents/Calendar/Calendar.dart';
import 'package:test_web_app/DashBoard/Comonents/DashBoard/UserDashBoard.dart';
import 'package:test_web_app/DashBoard/Comonents/Finance/Finance.dart';
import 'package:test_web_app/DashBoard/Comonents/Leads/Leads_View.dart';
import 'package:test_web_app/DashBoard/Comonents/Notifications/NotificationScreen.dart';
import 'package:test_web_app/DashBoard/Comonents/Settings/Settings.dart';
import 'package:test_web_app/DashBoard/Comonents/Task%20Preview/TaskPreview.dart';
import 'package:test_web_app/Models/MoveModel.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/Header.dart';
import 'package:test_web_app/Models/tasklength.dart';
import 'package:test_web_app/Providers/CompleteProfileProvider.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';
import 'package:test_web_app/Providers/CustomerProvider.dart';
import 'package:test_web_app/Providers/DuplicatesFinderProvider.dart';
import 'package:test_web_app/Providers/EmergencyTaskProvider.dart';
import 'package:test_web_app/Providers/UserProvider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final globalKey = GlobalKey<ScaffoldState>();
  final ScrollController _controller = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Tabs active = Tabs.Finance;
  var radioItem;

  @override
  void initState() {
    super.initState();
    Provider.of<UserDataProvider>(context, listen: false).getUserData();
    Provider.of<AllUSerProvider>(context, listen: false).fetchAllUser();
    Provider.of<DuplicatesFinderProvider>(context, listen: false).dupicates();
    Future.delayed(Duration(seconds: 5)).then((value) {
      userTasks();
      Provider.of<CustmerProvider>(context, listen: false)
          .getCustomers(context);
      Provider.of<EmergencyTaskProvider>(context, listen: false)
          .fetchEmergencyTasks(
              context, DateTime.now().toString().split(" ")[0].toString());
    });

    Future.delayed(Duration(seconds: 10), () {
      Provider.of<UserDataProvider>(context, listen: false).imageUrl == null
          ? completeProfile()
          : null;
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

  // Widget scaleAnimation(child) {
  //   final AnimationController _controller = AnimationController(
  //     duration: const Duration(seconds: 2),
  //     vsync: this,
  //   )..repeat(reverse: true);
  //   final Animation<double> _animation =
  //       CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut);
  //   return ScaleTransition(
  //       scale: _animation,
  //       child: const Padding(
  //         padding: EdgeInsets.all(8.0),
  //         child: FlutterLogo(size: 150.0),
  //       ));
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget SideDrawer(BuildContext context) {
    final userdata = Provider.of<UserDataProvider>(context);
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
                        enddrawerkey = "Profile";
                        Scaffold.of(context).openEndDrawer();
                      });
                    },
                    leading: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.025,
                            child: userdata.imageUrl == null
                                ? Icon(
                                    Icons.person,
                                    color: txtColor,
                                    size: 30,
                                  )
                                : Image.network(
                                    userdata.imageUrl!,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ))),
                    title: Text(
                        userdata.username == null
                            ? ""
                            : userdata.username.toString(),
                        style: TxtStls.fieldstyle),
                    trailing: Icon(
                      Icons.settings,
                      color: btnColor,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget shortcut(title, child) {
    return Column(
      children: [Header(title: title), child],
    );
  }

  DashboardBody(BuildContext context) {
    switch (active) {
      case Tabs.DashBoard:
        {
          return shortcut("DashBoard", UserDashBoard());
        }
      case Tabs.TaskPreview:
        {
          return shortcut("Task Preview", TaskPreview());
        }
      case Tabs.Analytics:
        {
          return shortcut("Analytics", Analytics());
        }
      case Tabs.Finance:
        {
          return shortcut("Finance", Finance());
        }
      case Tabs.Calendar:
        {
          return shortcut("Calendar", Calendar());
        }
      case Tabs.Messages:
        {
          return shortcut("Messages", LeadScreen());
        }
      case Tabs.Notification:
        {
          return shortcut("Notification", Notifications());
        }

      default:
        {
          return shortcut("Settings", SettingsScreen());
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

  Future<void> userTasks() async {
    final userdata = Provider.of<UserDataProvider>(context, listen: false);
    try {
      FirebaseFirestore.instance
          .collection("Tasks")
          .where("cat", isEqualTo: "NEW")
          .where("Attachments", arrayContainsAny: [
            {
              "image": userdata.imageUrl,
              "uid": _auth.currentUser!.uid.toString(),
            }
          ])
          .snapshots()
          .listen((value) {
            setState(() {
              newLength = value.docs.length.toDouble();
              // print(newLength);
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
              "image": userdata.imageUrl,
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
              "image": userdata.imageUrl,
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
              "image": userdata.imageUrl,
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

  void completeProfile() {
    Size size = MediaQuery.of(context).size;
    Uint8List? logoBase64;
    String? name;
    showDialog<AlertDialog>(
        barrierDismissible: false,
        barrierColor: txtColor.withOpacity(0.75),
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  "Complete Your Profile",
                  style: TxtStls.fieldtitlestyle,
                ),
              ),
            ),
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
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: bgColor),
                  padding: EdgeInsets.all(10),
                  width: size.width * 0.22,
                  height: size.height * 0.5,
                  child: Provider.of<CompleteProfielProvider>(context).isLoading
                      ? Center(
                          child: SpinKitFadingCube(color: btnColor, size: 30),
                        )
                      : SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: logoBase64 == null
                                      ? CircleAvatar(
                                          maxRadius: 40.0,
                                          child: Icon(Icons.camera_alt),
                                        )
                                      : CircleAvatar(
                                          maxRadius: 40.0,
                                          backgroundImage:
                                              MemoryImage(logoBase64!),
                                        ),
                                  onTap: () async {
                                    FilePickerResult? pickedfile =
                                        await FilePicker.platform.pickFiles();
                                    if (pickedfile != null) {
                                      Uint8List? fileBytes =
                                          pickedfile.files.first.bytes;
                                      String fileName =
                                          pickedfile.files.first.name;
                                      logoBase64 = fileBytes;
                                      name = fileName;
                                      setState(() {});
                                    } else {}
                                  },
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                _field(
                                    _roleController, true, "Enter Your Role"),
                                _field(_econtactController, true,
                                    "Enter Emergency Contact"),
                                Row(
                                  children: [
                                    Expanded(
                                        child: _field(_bgroupController, true,
                                            "Enter Blood Group")),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: _field(_dojController, true,
                                            "Select Date of Joining")),
                                  ],
                                ),
                                _field(
                                    _addressController, true, "Enter address"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2.0, horizontal: 3.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        color: Colors.orangeAccent,
                                      ),
                                      child: Row(
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor: bgColor),
                                            child: Radio(
                                              activeColor: btnColor,
                                              value: "Male",
                                              groupValue: radioItem,
                                              onChanged: (val) {
                                                radioItem = val.toString();
                                                setState(() {});
                                              },
                                              toggleable: false,
                                            ),
                                          ),
                                          Text(
                                            "Male",
                                            style: TxtStls.fieldstyle1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2.0, horizontal: 3.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        color: wonClr,
                                      ),
                                      child: Row(
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor: bgColor),
                                            child: Radio(
                                              activeColor: btnColor,
                                              value: "Female",
                                              groupValue: radioItem,
                                              onChanged: (val) {
                                                radioItem = val.toString();
                                                setState(() {});
                                              },
                                              toggleable: false,
                                            ),
                                          ),
                                          Text(
                                            "Female",
                                            style: TxtStls.fieldstyle1,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                logoBase64 == null
                                    ? SizedBox()
                                    : Align(
                                        alignment: Alignment.centerRight,
                                        child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            elevation: 0.0,
                                            onPressed: () {
                                              completeprofile(name, logoBase64);
                                            },
                                            child: Text(
                                              "Update",
                                              style: TxtStls.fieldstyle1,
                                            ),
                                            color: btnColor),
                                      )
                              ],
                            ),
                          ),
                        ),
                );
              },
            ),
          );
        });
  }

  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bgroupController = TextEditingController();
  final TextEditingController _econtactController = TextEditingController();
  final TextEditingController _dojController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Widget _field(_controller, bool enable, hint) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
      decoration: deco,
      child: TextFormField(
        cursorColor: btnColor,
        validator: (fullname) {
          if (fullname!.isEmpty) {
            return "field can not be empty";
          } else {
            return null;
          }
        },
        controller: _controller,
        enabled: enable,
        style: TxtStls.fieldstyle,
        decoration: InputDecoration(
          errorStyle: ClrStls.errorstyle,
          hintText: hint,
          hintStyle: ClrStls.tnClr,
          border: InputBorder.none,
        ),
      ),
    );
  }

  completeprofile(name, logoBase64) {
    if (_formKey.currentState!.validate()) {
      var providerdata =
          Provider.of<CompleteProfielProvider>(context, listen: false);
      providerdata
          .completProfile(
              name,
              logoBase64,
              _roleController.text.toString(),
              _econtactController.text.toString(),
              _bgroupController.text.toString(),
              _addressController.text.toString(),
              radioItem.toString(),
              _dojController.text.toString())
          .then((value) {
        if (providerdata.error == null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => MainScreen()));
          toastmessage.sucesstoast(context, "Profile Updated Successfully");
        } else {
          toastmessage.warningmessage(context, providerdata.error);
        }
      });
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
