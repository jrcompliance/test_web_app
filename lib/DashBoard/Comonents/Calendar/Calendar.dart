import 'dart:developer';
import 'dart:ui';
import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';

import '../../../main.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
    // required this.targetUser,
    // required this.chatroom,
    // required this.userModel,
    // required this.firebaseUser
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final TextEditingController _invoiceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _invoiceusername = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _customersearchController =
      TextEditingController();
  List<EmployeesModel> allEmployees = [];
  var user = FirebaseAuth.instance.currentUser;
  StreamChatClient? client;
  Channel? channel;
  String bnature = "Active";

  bool visible = false;
  CollectionReference? chatsCollectionReference;

  var employeeModal;

  bool _isTapped = false;

  EmployeesModel? logginUserModel;

  String? currentuid;
  getUserData() {
    FirebaseFirestore.instance
        .collection("EmployeeData")
        .doc(user!.uid)
        .get()
        .then((value) {
      logginUserModel = EmployeesModel.fromMap(value.data());
      setState(() {});
    });
  }

  var provider;
  var _dataSource;

  @override
  void initState() {
    super.initState();
    //  getUserData();
    Future.delayed(Duration(seconds: 0)).then((value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      currentuid = pref.getString("uid");
    });
    Future.delayed(Duration(seconds: 2)).then((value) {
      Provider.of<UserDataProvider>(context, listen: false)
          .getEmployeesList(currentuid)
          .then((value) {
        allEmployees =
            Provider.of<UserDataProvider>(context, listen: false).employeelist;
      });
    });
    _dataSource = MeetingDataSource(_getDataSource());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.845,
        width: size.width,
        color: AbgColor.withOpacity(0.0001),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
        child: SfCalendar(
          view: CalendarView.schedule,
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          dataSource: _dataSource,
          onTap: (_) {
            print("kjfhjwfhuef");
          },
        ));
  }

  // FirebaseFirestore _firebase = FirebaseFirestore.instance;
  // void getarrayLength() async {
  //   await _firebase
  //       .collection("InvoiceID")
  //       .doc("2dtDd787PkHNjpFag0H5")
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       var list = List.from(value.data()!["id"]);
  //       String lastvalue = list.elementAt(list.length - 1);
  //       //   print("lastvalue is : " + lastvalue);
  //       updatearray(lastvalue);
  //     });
  //   });
  // }
  //
  // updatearray(String lastvalue) async {
  //   var month = DateFormat("MM").format(DateTime.now());
  //   var year = DateFormat("yy").format(DateTime.now());
  //
  //   int mymonth = int.parse(month);
  //   int myyear = int.parse(year);
  //   int acyear = myyear;
  //   int acyear1 = myyear;
  //   if (mymonth <= 3) {
  //     setState(() {
  //       acyear = myyear - 1;
  //     });
  //   } else {
  //     setState(() {
  //       acyear1 = myyear + 1;
  //     });
  //   }
  //   show() {
  //     if (mymonth <= 9) {
  //       return 0;
  //     } else {
  //       return null;
  //     }
  //   }
  //
  //   String val = lastvalue.substring(6);
  //   //  print("pad value is : "+val);
  //   int addval = int.parse(val) + 1;
  //   // print("Added value is : " + addval.toString());
  //   var storeval = show().toString() +
  //       mymonth.toString() +
  //       acyear.toString() +
  //       acyear1.toString() +
  //       addval.toString();
  //   // print(storeval);
  //   setState(() {
  //     _invoiceController.text = "#JR" + storeval;
  //   });
  //   await _firebase.collection("InvoiceID").doc("2dtDd787PkHNjpFag0H5").update({
  //     "id": FieldValue.arrayUnion([storeval]),
  //   });
  // }

  List<Appointment> _getDataSource() {
    final List<Appointment> meetings = <Appointment>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime.now();
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    // meetings.add(Meeting(
    //     'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Appointment(
        endTime: endTime,
        startTime: startTime,
        subject: 'Conference',
        color: btnColor,
        isAllDay: false,
        recurrenceRule: 'FREQ=DAILY,COUNT=5'));

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }

  // @override
  // DateTime getStartTime(int index) {
  //   return _getMeetingData(index).from;
  // }
  //
  // @override
  // DateTime getEndTime(int index) {
  //   return _getMeetingData(index).to;
  // }
  //
  // @override
  // String getSubject(int index) {
  //   return _getMeetingData(index).eventName;
  // }
  //
  // @override
  // Color getColor(int index) {
  //   return _getMeetingData(index).background;
  // }
  //
  // @override
  // bool isAllDay(int index) {
  //   return _getMeetingData(index).isAllDay;
  // }

  // Meeting _getMeetingData(int index) {
  //   final dynamic meeting = appointments![index];
  //   late final Meeting meetingData;
  //   if (meeting is Meeting) {
  //     meetingData = meeting;
  //   }
  //
  //   return meetingData;
  // }
}

// class Meeting {
//   /// Creates a meeting class with required details.
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
//
//   /// Event name which is equivalent to subject property of [Appointment].
//   String eventName;
//
//   /// From which is equivalent to start time property of [Appointment].
//   DateTime from;
//
//   /// To which is equivalent to end time property of [Appointment].
//   DateTime to;
//
//   /// Background which is equivalent to color property of [Appointment].
//   Color background;
//
//   /// IsAllDay which is equivalent to isAllDay property of [Appointment].
//   bool isAllDay;
// }
