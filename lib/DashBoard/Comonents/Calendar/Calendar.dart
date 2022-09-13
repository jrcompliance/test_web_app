import 'dart:developer';
import 'dart:math';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Container(
                height: size.height * 0.845,
                width: size.width * 0.200,
                // color: Colors.grey.withOpacity(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: InkWell(
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: btnColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            'Create',
                            style: TxtStls.fieldstyle11,
                          )),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    content: SizedBox(
                                        height: size.height * 0.4,
                                        width: size.width * 0.22,
                                        child: AppointmentEditor(_startDate)),
                                  ));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        height: 250,
                        width: 250,
                        child: SfCalendar(
                          view: CalendarView.month,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'People',
                        style: TxtStls.fieldstyle22bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: size.height * 0.3,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("EmployeeData")
                              .get()
                              .asStream(),
                          builder: (context, snapshot) {
                            return SizedBox(
                              height: size.height * 0.8,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int i) {
                                  EmployeesModel employeeModel =
                                      EmployeesModel.fromMap(
                                          snapshot.data!.docs[i].data());
                                  if (employeeModel.uid ==
                                      FirebaseAuth.instance.currentUser!.uid) {
                                    return Container();
                                  }

                                  //  var snp = allEmployees[i];
                                  return Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: bgColor,
                                    child: ListTile(
                                      tileColor: grClr.withOpacity(0.1),
                                      hoverColor: btnColor.withOpacity(0.2),
                                      selectedColor: btnColor.withOpacity(0.2),
                                      selectedTileColor:
                                          btnColor.withOpacity(0.2),
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            btnColor.withOpacity(0.1),
                                        backgroundImage: employeeModel.uimage
                                                    .toString() ==
                                                null
                                            ? const NetworkImage(
                                                "https://cdn1.iconfinder.com/data/icons/bokbokstars-121-classic-stock-icons-1/512/person-man.png")
                                            : NetworkImage(employeeModel.uimage
                                                .toString()),
                                        // child: Icon(
                                        //   Icons.person,
                                        //   color: btnColor,
                                        // )
                                      ),
                                      title: Text(
                                        employeeModel.uname.toString(),
                                        style: TxtStls.fieldtitlestyle,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            employeeModel.uemail.toString(),
                                            style: TxtStls.fieldstyle,
                                          ),
                                          Text(
                                            employeeModel.uphoneNumber
                                                .toString(),
                                            style: TxtStls.fieldstyle,
                                          ),
                                        ],
                                      ),
                                      trailing: CircleAvatar(
                                        backgroundColor:
                                            btnColor.withOpacity(0.1),
                                      ),
                                      onTap: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider(color: grClr.withOpacity(0.5));
                                },
                              ),
                            );
                          }),
                    )
                  ],
                )),
            Container(
              height: size.height * 0.845,
              width: size.width * 0.620,
              // color: AbgColor.withOpacity(0.0001),
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
              child: EventCalendar(),
            )
          ],
        )
      ],
    );
  }
}

class EventCalendar extends StatefulWidget {
  const EventCalendar({Key? key}) : super(key: key);

  @override
  EventCalendarState createState() => EventCalendarState();
}

List<Color> _colorCollection = <Color>[];
List<String> _colorNames = <String>[];
int _selectedColorIndex = 0;
int _selectedTimeZoneIndex = 0;
List<String> _timeZoneCollection = <String>[];
late DataSource _events;
Meeting? _selectedAppointment;
late DateTime _startDate;
late TimeOfDay _startTime;
late DateTime _endDate;
late TimeOfDay _endTime;
bool _isAllDay = false;
String _subject = '';
String _notes = '';

class EventCalendarState extends State<EventCalendar> {
  EventCalendarState();

  CalendarView _calendarView = CalendarView.month;
  late List<String> eventNameCollection;
  late List<Meeting> appointments;

  @override
  void initState() {
    _calendarView = CalendarView.month;
    appointments = getMeetingDetails();
    _events = DataSource(appointments);
    _selectedAppointment = null;
    _selectedColorIndex = 0;
    _selectedTimeZoneIndex = 0;
    _subject = '';
    _notes = '';
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(hours: 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: getEventCalendar(_calendarView, _events, onCalendarTapped)));
  }

  SfCalendar getEventCalendar(
      CalendarView _calendarView,
      CalendarDataSource _calendarDataSource,
      CalendarTapCallback calendarTapCallback) {
    return SfCalendar(
        view: _calendarView,
        dataSource: _calendarDataSource,
        onTap: calendarTapCallback,
        initialDisplayDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0, 0, 0),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        timeSlotViewSettings: TimeSlotViewSettings(
            minimumAppointmentDuration: const Duration(minutes: 60)));
  }

  void onCalendarViewChange(String value) {
    if (value == 'Day') {
      _calendarView = CalendarView.day;
    } else if (value == 'Week') {
      _calendarView = CalendarView.week;
    } else if (value == 'Work week') {
      _calendarView = CalendarView.workWeek;
    } else if (value == 'Month') {
      _calendarView = CalendarView.month;
    } else if (value == 'Timeline day') {
      _calendarView = CalendarView.timelineDay;
    } else if (value == 'Timeline week') {
      _calendarView = CalendarView.timelineWeek;
    } else if (value == 'Timeline work week') {
      _calendarView = CalendarView.timelineWorkWeek;
    }

    setState(() {});
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    Size size = MediaQuery.of(context).size;
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    setState(() {
      _selectedAppointment = null;
      _isAllDay = false;
      _selectedColorIndex = 0;
      _selectedTimeZoneIndex = 0;
      _subject = '';
      _notes = '';
      if (_calendarView == CalendarView.month) {
        _calendarView = CalendarView.day;
      } else {
        if (calendarTapDetails.appointments != null &&
            calendarTapDetails.appointments!.length == 1) {
          final Meeting meetingDetails = calendarTapDetails.appointments![0];
          _startDate = meetingDetails.from;
          _endDate = meetingDetails.to;
          _isAllDay = meetingDetails.isAllDay;
          _selectedColorIndex =
              _colorCollection.indexOf(meetingDetails.background);
          _selectedTimeZoneIndex = meetingDetails.startTimeZone == ''
              ? 0
              : _timeZoneCollection.indexOf(meetingDetails.startTimeZone);
          _subject = meetingDetails.eventName == '(No title)'
              ? ''
              : meetingDetails.eventName;
          _notes = meetingDetails.deion;
          _selectedAppointment = meetingDetails;
        } else {
          final DateTime date = calendarTapDetails.date!;
          _startDate = date;
          _endDate = date.add(const Duration(hours: 1));
        }
        _startTime =
            TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
        _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);

        // showDialog(context: context, builder: (context)=>AlertDialog(
        //   insetPadding: EdgeInsets.only(top: 150,bottom: 150),
        //   content: AppointmentEditor(_startDate),));

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: SizedBox(
                      height: size.height * 0.4,
                      width: size.width * 0.22,
                      child: AppointmentEditor(_startDate)),
                ));

        // Navigator.push<Widget>(
        //   context,
        //   MaterialPageRoute(
        //       builder: (BuildContext context) => AppointmentEditor()),
        // );
      }
    });
  }

  List<Meeting> getMeetingDetails() {
    final List<Meeting> meetingCollection = <Meeting>[];
    eventNameCollection = <String>[];
    eventNameCollection.add('General Meeting');
    eventNameCollection.add('Plan Execution');
    eventNameCollection.add('Project Plan');
    eventNameCollection.add('Consulting');
    eventNameCollection.add('Support');
    eventNameCollection.add('Development Meeting');
    eventNameCollection.add('Scrum');
    eventNameCollection.add('Project Completion');
    eventNameCollection.add('Release updates');
    eventNameCollection.add('Performance Check');

    _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF85461E));
    _colorCollection.add(const Color(0xFFFF00FF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));

    _colorNames = <String>[];
    _colorNames.add('Green');
    _colorNames.add('Purple');
    _colorNames.add('Red');
    _colorNames.add('Orange');
    _colorNames.add('Caramel');
    _colorNames.add('Magenta');
    _colorNames.add('Blue');
    _colorNames.add('Peach');
    _colorNames.add('Gray');

    _timeZoneCollection = <String>[];
    _timeZoneCollection.add('Default Time');
    _timeZoneCollection.add('AUS Central Standard Time');
    _timeZoneCollection.add('AUS Eastern Standard Time');
    _timeZoneCollection.add('Afghanistan Standard Time');
    _timeZoneCollection.add('Alaskan Standard Time');
    _timeZoneCollection.add('Arab Standard Time');
    _timeZoneCollection.add('Arabian Standard Time');
    _timeZoneCollection.add('Arabic Standard Time');
    _timeZoneCollection.add('Argentina Standard Time');
    _timeZoneCollection.add('Atlantic Standard Time');
    _timeZoneCollection.add('Azerbaijan Standard Time');
    _timeZoneCollection.add('Azores Standard Time');
    _timeZoneCollection.add('Bahia Standard Time');
    _timeZoneCollection.add('Bangladesh Standard Time');
    _timeZoneCollection.add('Belarus Standard Time');
    _timeZoneCollection.add('Canada Central Standard Time');
    _timeZoneCollection.add('Cape Verde Standard Time');
    _timeZoneCollection.add('Caucasus Standard Time');
    _timeZoneCollection.add('Cen. Australia Standard Time');
    _timeZoneCollection.add('Central America Standard Time');
    _timeZoneCollection.add('Central Asia Standard Time');
    _timeZoneCollection.add('Central Brazilian Standard Time');
    _timeZoneCollection.add('Central Europe Standard Time');
    _timeZoneCollection.add('Central European Standard Time');
    _timeZoneCollection.add('Central Pacific Standard Time');
    _timeZoneCollection.add('Central Standard Time');
    _timeZoneCollection.add('China Standard Time');
    _timeZoneCollection.add('Dateline Standard Time');
    _timeZoneCollection.add('E. Africa Standard Time');
    _timeZoneCollection.add('E. Australia Standard Time');
    _timeZoneCollection.add('E. South America Standard Time');
    _timeZoneCollection.add('Eastern Standard Time');
    _timeZoneCollection.add('Egypt Standard Time');
    _timeZoneCollection.add('Ekaterinburg Standard Time');
    _timeZoneCollection.add('FLE Standard Time');
    _timeZoneCollection.add('Fiji Standard Time');
    _timeZoneCollection.add('GMT Standard Time');
    _timeZoneCollection.add('GTB Standard Time');
    _timeZoneCollection.add('Georgian Standard Time');
    _timeZoneCollection.add('Greenland Standard Time');
    _timeZoneCollection.add('Greenwich Standard Time');
    _timeZoneCollection.add('Hawaiian Standard Time');
    _timeZoneCollection.add('India Standard Time');
    _timeZoneCollection.add('Iran Standard Time');
    _timeZoneCollection.add('Israel Standard Time');
    _timeZoneCollection.add('Jordan Standard Time');
    _timeZoneCollection.add('Kaliningrad Standard Time');
    _timeZoneCollection.add('Korea Standard Time');
    _timeZoneCollection.add('Libya Standard Time');
    _timeZoneCollection.add('Line Islands Standard Time');
    _timeZoneCollection.add('Magadan Standard Time');
    _timeZoneCollection.add('Mauritius Standard Time');
    _timeZoneCollection.add('Middle East Standard Time');
    _timeZoneCollection.add('Montevideo Standard Time');
    _timeZoneCollection.add('Morocco Standard Time');
    _timeZoneCollection.add('Mountain Standard Time');
    _timeZoneCollection.add('Mountain Standard Time (Mexico)');
    _timeZoneCollection.add('Myanmar Standard Time');
    _timeZoneCollection.add('N. Central Asia Standard Time');
    _timeZoneCollection.add('Namibia Standard Time');
    _timeZoneCollection.add('Nepal Standard Time');
    _timeZoneCollection.add('New Zealand Standard Time');
    _timeZoneCollection.add('Newfoundland Standard Time');
    _timeZoneCollection.add('North Asia East Standard Time');
    _timeZoneCollection.add('North Asia Standard Time');
    _timeZoneCollection.add('Pacific SA Standard Time');
    _timeZoneCollection.add('Pacific Standard Time');
    _timeZoneCollection.add('Pacific Standard Time (Mexico)');
    _timeZoneCollection.add('Pakistan Standard Time');
    _timeZoneCollection.add('Paraguay Standard Time');
    _timeZoneCollection.add('Romance Standard Time');
    _timeZoneCollection.add('Russia Time Zone 10');
    _timeZoneCollection.add('Russia Time Zone 11');
    _timeZoneCollection.add('Russia Time Zone 3');
    _timeZoneCollection.add('Russian Standard Time');
    _timeZoneCollection.add('SA Eastern Standard Time');
    _timeZoneCollection.add('SA Pacific Standard Time');
    _timeZoneCollection.add('SA Western Standard Time');
    _timeZoneCollection.add('SE Asia Standard Time');
    _timeZoneCollection.add('Samoa Standard Time');
    _timeZoneCollection.add('Singapore Standard Time');
    _timeZoneCollection.add('South Africa Standard Time');
    _timeZoneCollection.add('Sri Lanka Standard Time');
    _timeZoneCollection.add('Syria Standard Time');
    _timeZoneCollection.add('Taipei Standard Time');
    _timeZoneCollection.add('Tasmania Standard Time');
    _timeZoneCollection.add('Tokyo Standard Time');
    _timeZoneCollection.add('Tonga Standard Time');
    _timeZoneCollection.add('Turkey Standard Time');
    _timeZoneCollection.add('US Eastern Standard Time');
    _timeZoneCollection.add('US Mountain Standard Time');
    _timeZoneCollection.add('UTC');
    _timeZoneCollection.add('UTC+12');
    _timeZoneCollection.add('UTC-02');
    _timeZoneCollection.add('UTC-11');
    _timeZoneCollection.add('Ulaanbaatar Standard Time');
    _timeZoneCollection.add('Venezuela Standard Time');
    _timeZoneCollection.add('Vladivostok Standard Time');
    _timeZoneCollection.add('W. Australia Standard Time');
    _timeZoneCollection.add('W. Central Africa Standard Time');
    _timeZoneCollection.add('W. Europe Standard Time');
    _timeZoneCollection.add('West Asia Standard Time');
    _timeZoneCollection.add('West Pacific Standard Time');
    _timeZoneCollection.add('Yakutsk Standard Time');

    final DateTime today = DateTime.now();
    final Random random = Random();
    for (int month = -1; month < 2; month++) {
      for (int day = -5; day < 5; day++) {
        for (int hour = 9; hour < 18; hour += 5) {
          meetingCollection.add(Meeting(
            from: today
                .add(Duration(days: (month * 30) + day))
                .add(Duration(hours: hour)),
            to: today
                .add(Duration(days: (month * 30) + day))
                .add(Duration(hours: hour + 2)),
            background: _colorCollection[random.nextInt(9)],
            startTimeZone: '',
            endTimeZone: '',
            deion: '',
            isAllDay: false,
            eventName: eventNameCollection[random.nextInt(7)],
          ));
        }
      }
    }

    return meetingCollection;
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;

  @override
  String getSubject(int index) => appointments![index].eventName;

  @override
  String getStartTimeZone(int index) => appointments![index].startTimeZone;

  @override
  String getNotes(int index) => appointments![index].deion;

  @override
  String getEndTimeZone(int index) => appointments![index].endTimeZone;

  @override
  Color getColor(int index) => appointments![index].background;

  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;
}

class Meeting {
  Meeting(
      {required this.from,
      required this.to,
      this.background = Colors.green,
      this.isAllDay = false,
      this.eventName = '',
      this.startTimeZone = '',
      this.endTimeZone = '',
      this.deion = ''});

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String deion;
}

class AppointmentEditor extends StatefulWidget {
  AppointmentEditor(DateTime startDate);

  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  Widget _getAppointmentEditor(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: Colors.white,
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(
                width: size.width * 0.1,
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  leading: const Text(''),
                  title: TextField(
                    controller: TextEditingController(text: _subject),
                    onChanged: (String value) {
                      _subject = value;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TxtStls.fieldstyle22bold,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add title',
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1.0,
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.access_time,
                            size: 20,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'All-day',
                            style: TxtStls.fieldstyle22bold,
                          ),
                        ],
                      ),
                    ),
                    Transform.scale(
                      scale: 0.9,
                      child: Switch(
                        value: _isAllDay,
                        onChanged: (bool value) {
                          setState(() {
                            _isAllDay = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: GestureDetector(
                          child: Text(
                              DateFormat('EEE, MMM dd yyyy').format(_startDate),
                              textAlign: TextAlign.left,
                              style: TxtStls.fieldstyle22bold),
                          onTap: () async {
                            final DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: _startDate,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );

                            if (date != null && date != _startDate) {
                              setState(() {
                                final Duration difference =
                                    _endDate.difference(_startDate);
                                _startDate = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    _startTime.hour,
                                    _startTime.minute,
                                    0);
                                _endDate = _startDate.add(difference);
                                _endTime = TimeOfDay(
                                    hour: _endDate.hour,
                                    minute: _endDate.minute);
                              });
                            }
                          }),
                    ),
                    Container(
                        child: _isAllDay
                            ? const Text('')
                            : GestureDetector(
                                child: Text(
                                  DateFormat('hh:mm a').format(_startDate),
                                  textAlign: TextAlign.right,
                                  style: TxtStls.fieldstyle22bold,
                                ),
                                onTap: () async {
                                  final TimeOfDay? time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: _startTime.hour,
                                          minute: _startTime.minute));

                                  if (time != null && time != _startTime) {
                                    setState(() {
                                      _startTime = time;
                                      final Duration difference =
                                          _endDate.difference(_startDate);
                                      _startDate = DateTime(
                                          _startDate.year,
                                          _startDate.month,
                                          _startDate.day,
                                          _startTime.hour,
                                          _startTime.minute,
                                          0);
                                      _endDate = _startDate.add(difference);
                                      _endTime = TimeOfDay(
                                          hour: _endDate.hour,
                                          minute: _endDate.minute);
                                    });
                                  }
                                })),
                  ],
                ),
              ),

              // ListTile(
              //     contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              //     leading: const Text(''),
              //     title: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: <Widget>[
              //           Expanded(
              //             flex: 7,
              //             child: GestureDetector(
              //                 child: Text(
              //                     DateFormat('EEE, MMM dd yyyy')
              //                         .format(_startDate),
              //                     textAlign: TextAlign.left, style: TxtStls.fieldstyle),
              //                 onTap: () async {
              //                   final DateTime? date = await showDatePicker(
              //                     context: context,
              //                     initialDate: _startDate,
              //                     firstDate: DateTime(1900),
              //                     lastDate: DateTime(2100),
              //                   );
              //
              //                   if (date != null && date != _startDate) {
              //                     setState(() {
              //                       final Duration difference =
              //                       _endDate.difference(_startDate);
              //                       _startDate = DateTime(
              //                           date.year,
              //                           date.month,
              //                           date.day,
              //                           _startTime.hour,
              //                           _startTime.minute,
              //                           0);
              //                       _endDate = _startDate.add(difference);
              //                       _endTime = TimeOfDay(
              //                           hour: _endDate.hour,
              //                           minute: _endDate.minute);
              //                     });
              //                   }
              //                 }),
              //           ),
              //           Expanded(
              //               flex: 3,
              //               child: _isAllDay
              //                   ? const Text('')
              //                   : GestureDetector(
              //                   child: Text(
              //                     DateFormat('hh:mm a').format(_startDate),
              //                     textAlign: TextAlign.right,  style: TxtStls.fieldstyle22bold,
              //                   ),
              //                   onTap: () async {
              //                     final TimeOfDay? time =
              //                     await showTimePicker(
              //                         context: context,
              //                         initialTime: TimeOfDay(
              //                             hour: _startTime.hour,
              //                             minute: _startTime.minute));
              //
              //                     if (time != null && time != _startTime) {
              //                       setState(() {
              //                         _startTime = time;
              //                         final Duration difference =
              //                         _endDate.difference(_startDate);
              //                         _startDate = DateTime(
              //                             _startDate.year,
              //                             _startDate.month,
              //                             _startDate.day,
              //                             _startTime.hour,
              //                             _startTime.minute,
              //                             0);
              //                         _endDate = _startDate.add(difference);
              //                         _endTime = TimeOfDay(
              //                             hour: _endDate.hour,
              //                             minute: _endDate.minute);
              //                       });
              //                     }
              //                   })
              //           ),
              //         ])),

              SizedBox(
                height: 10,
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        child: Text(
                            DateFormat('EEE, MMM dd yyyy').format(_endDate),
                            textAlign: TextAlign.left,
                            style: TxtStls.fieldstyle22bold),
                        onTap: () async {
                          final DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: _endDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (date != null && date != _endDate) {
                            setState(() {
                              final Duration difference =
                                  _endDate.difference(_startDate);
                              _endDate = DateTime(date.year, date.month,
                                  date.day, _endTime.hour, _endTime.minute, 0);
                              if (_endDate.isBefore(_startDate)) {
                                _startDate = _endDate.subtract(difference);
                                _startTime = TimeOfDay(
                                    hour: _startDate.hour,
                                    minute: _startDate.minute);
                              }
                            });
                          }
                        }),
                    Container(
                        child: _isAllDay
                            ? const Text('')
                            : GestureDetector(
                                child: Text(
                                  DateFormat('hh:mm a').format(_endDate),
                                  textAlign: TextAlign.right,
                                  style: TxtStls.fieldstyle22bold,
                                ),
                                onTap: () async {
                                  final TimeOfDay? time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: _endTime.hour,
                                          minute: _endTime.minute));

                                  if (time != null && time != _endTime) {
                                    setState(() {
                                      _endTime = time;
                                      final Duration difference =
                                          _endDate.difference(_startDate);
                                      _endDate = DateTime(
                                          _endDate.year,
                                          _endDate.month,
                                          _endDate.day,
                                          _endTime.hour,
                                          _endTime.minute,
                                          0);
                                      if (_endDate.isBefore(_startDate)) {
                                        _startDate =
                                            _endDate.subtract(difference);
                                        _startTime = TimeOfDay(
                                            hour: _startDate.hour,
                                            minute: _startDate.minute);
                                      }
                                    });
                                  }
                                }))
                  ],
                ),
              ),

              // ListTile(
              //     contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              //     leading: const Text(''),
              //     title: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: <Widget>[
              //           // Expanded(
              //           //   flex: 7,
              //           //   child: GestureDetector(
              //           //       child: Text(
              //           //         DateFormat('EEE, MMM dd yyyy').format(_endDate),
              //           //         textAlign: TextAlign.left,  style: TxtStls.fieldstyle22bold,
              //           //       ),
              //           //       onTap: () async {
              //           //         final DateTime? date = await showDatePicker(
              //           //           context: context,
              //           //           initialDate: _endDate,
              //           //           firstDate: DateTime(1900),
              //           //           lastDate: DateTime(2100),
              //           //         );
              //           //
              //           //         if (date != null && date != _endDate) {
              //           //           setState(() {
              //           //             final Duration difference =
              //           //             _endDate.difference(_startDate);
              //           //             _endDate = DateTime(
              //           //                 date.year,
              //           //                 date.month,
              //           //                 date.day,
              //           //                 _endTime.hour,
              //           //                 _endTime.minute,
              //           //                 0);
              //           //             if (_endDate.isBefore(_startDate)) {
              //           //               _startDate = _endDate.subtract(difference);
              //           //               _startTime = TimeOfDay(
              //           //                   hour: _startDate.hour,
              //           //                   minute: _startDate.minute);
              //           //             }
              //           //           });
              //           //         }
              //           //       }
              //           //       ),
              //           // ),
              //           Expanded(
              //               flex: 3,
              //               child: _isAllDay
              //                   ? const Text('')
              //                   : GestureDetector(
              //                   child: Text(
              //                     DateFormat('hh:mm a').format(_endDate),
              //                     textAlign: TextAlign.right,  style: TxtStls.fieldstyle22bold,
              //                   ),
              //                   onTap: () async {
              //                     final TimeOfDay? time =
              //                     await showTimePicker(
              //                         context: context,
              //                         initialTime: TimeOfDay(
              //                             hour: _endTime.hour,
              //                             minute: _endTime.minute));
              //
              //                     if (time != null && time != _endTime) {
              //                       setState(() {
              //                         _endTime = time;
              //                         final Duration difference =
              //                         _endDate.difference(_startDate);
              //                         _endDate = DateTime(
              //                             _endDate.year,
              //                             _endDate.month,
              //                             _endDate.day,
              //                             _endTime.hour,
              //                             _endTime.minute,
              //                             0);
              //                         if (_endDate.isBefore(_startDate)) {
              //                           _startDate =
              //                               _endDate.subtract(difference);
              //                           _startTime = TimeOfDay(
              //                               hour: _startDate.hour,
              //                               minute: _startDate.minute);
              //                         }
              //                       });
              //                     }
              //                   })
              //           ),
              //         ])),

              SizedBox(
                height: 10,
              ),

              GestureDetector(
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        Icons.public,
                        size: 20,
                        color: Colors.black87,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        _timeZoneCollection[_selectedTimeZoneIndex],
                        style: TxtStls.fieldstyle22bold,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showDialog<Widget>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return _TimeZonePicker();
                    },
                  ).then((dynamic value) => setState(() {}));
                },
              ),

              SizedBox(
                height: 10,
              ),

              // ListTile(
              //   contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              //   leading: Icon(
              //     Icons.public,
              //     color: Colors.black87,
              //   ),
              //   title: Text(_timeZoneCollection[_selectedTimeZoneIndex], style: TxtStls.fieldstyle22bold,),
              //   onTap: () {
              //     showDialog<Widget>(
              //       context: context,
              //       barrierDismissible: true,
              //       builder: (BuildContext context) {
              //         return _TimeZonePicker();
              //       },
              //     ).then((dynamic value) => setState(() {}));
              //   },
              // ),

              const Divider(
                height: 1.0,
                thickness: 1,
              ),
              // ListTile(
              //   contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              //   leading: Icon(Icons.lens,
              //       color: _colorCollection[_selectedColorIndex]),
              //   title: Text(
              //     _colorNames[_selectedColorIndex],
              //   ),
              //   onTap: () {
              //     showDialog<Widget>(
              //       context: context,
              //       barrierDismissible: true,
              //       builder: (BuildContext context) {
              //         return _ColorPicker();
              //       },
              //     ).then((dynamic value) => setState(() {}));
              //   },
              // ),

              const Divider(
                height: 1.0,
                thickness: 1,
              ),

              //
              // Container(
              //   child: Row(
              //   children: [
              //     Icon(
              //       Icons.subject,
              //       color: Colors.black87,
              //     ),
              //     TextField(
              //       controller: TextEditingController(text: _notes),
              //       onChanged: (String value) {
              //         _notes = value;
              //       },
              //       keyboardType: TextInputType.multiline,
              //       maxLines: null,
              //       style: TxtStls.fieldstyle22bold,
              //       // style: TextStyle(
              //       //     fontSize: 18,
              //       //     color: Colors.black87,
              //       //     fontWeight: FontWeight.w400),
              //       decoration: InputDecoration(
              //         border: InputBorder.none,
              //         hintText: 'Add deion',
              //       ),
              //     ),
              //   ],
              //   ),
              // ),

              ListTile(
                contentPadding: const EdgeInsets.all(5),
                leading: Icon(
                  Icons.subject,
                  color: Colors.black87,
                ),
                title: TextField(
                  controller: TextEditingController(text: _notes),
                  onChanged: (String value) {
                    _notes = value;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TxtStls.fieldstyle22bold,
                  // style: TextStyle(
                  //     fontSize: 18,
                  //     color: Colors.black87,
                  //     fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add deion',
                  ),
                ),
              ),
              const Divider(
                height: 1.0,
                thickness: 1,
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: AppBar(
                title: Text(
                  getTile(),
                ),
                backgroundColor: _colorCollection[_selectedColorIndex],
                leading: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: <Widget>[
                  IconButton(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      icon: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        final List<Meeting> meetings = <Meeting>[];
                        if (_selectedAppointment != null) {
                          _events.appointments!.removeAt(_events.appointments!
                              .indexOf(_selectedAppointment));
                          _events.notifyListeners(
                              CalendarDataSourceAction.remove,
                              <Meeting>[]..add(_selectedAppointment!));
                        }
                        meetings.add(Meeting(
                          from: _startDate,
                          to: _endDate,
                          background: _colorCollection[_selectedColorIndex],
                          startTimeZone: _selectedTimeZoneIndex == 0
                              ? ''
                              : _timeZoneCollection[_selectedTimeZoneIndex],
                          endTimeZone: _selectedTimeZoneIndex == 0
                              ? ''
                              : _timeZoneCollection[_selectedTimeZoneIndex],
                          deion: _notes,
                          isAllDay: _isAllDay,
                          eventName: _subject == '' ? '(No title)' : _subject,
                        ));

                        _events.appointments!.add(meetings[0]);

                        _events.notifyListeners(
                            CalendarDataSourceAction.add, meetings);
                        _selectedAppointment = null;

                        FirebaseFirestore.instance.collection('Events').add({
                          "startDate": _startDate,
                          "endDate": _endDate,
                          // "background": _colorCollection[_selectedColorIndex],
                          "startTimeZone": _selectedTimeZoneIndex == 0
                              ? ''
                              : _timeZoneCollection[_selectedTimeZoneIndex],
                          "endTimeZone": _selectedTimeZoneIndex == 0
                              ? ''
                              : _timeZoneCollection[_selectedTimeZoneIndex],
                          "deion": _notes,
                          "isAllDay": _isAllDay,
                          "eventName": _subject == '' ? '(No title)' : _subject,
                        });

                        Navigator.pop(context);
                      })
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Stack(
                children: <Widget>[_getAppointmentEditor(context)],
              ),
            ),
            floatingActionButton: _selectedAppointment == null
                ? const Text('')
                : FloatingActionButton(
                    onPressed: () {
                      if (_selectedAppointment != null) {
                        _events.appointments!.removeAt(_events.appointments!
                            .indexOf(_selectedAppointment));
                        _events.notifyListeners(CalendarDataSourceAction.remove,
                            <Meeting>[]..add(_selectedAppointment!));
                        _selectedAppointment = null;
                        Navigator.pop(context);
                      }
                    },
                    child:
                        const Icon(Icons.delete_outline, color: Colors.white),
                    backgroundColor: Colors.red,
                  )));
  }

  String getTile() {
    return _subject.isEmpty ? 'New event' : 'Event details';
  }
}

class _TimeZonePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TimeZonePickerState();
  }
}

class _TimeZonePickerState extends State<_TimeZonePicker> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: _timeZoneCollection.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Icon(
                  index == _selectedTimeZoneIndex
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                ),
                title: Text(_timeZoneCollection[index]),
                onTap: () {
                  setState(() {
                    _selectedTimeZoneIndex = index;
                  });

                  // ignore: always_specify_types
                  Future.delayed(Duration(milliseconds: 200), () {
                    // When task is over, close the dialog
                    Navigator.pop(context);
                  });
                },
              );
            },
          )),
    );
  }
}

class _ColorPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ColorPickerState();
  }
}

class _ColorPickerState extends State<_ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          // width: double.maxFinite,
          child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: _colorCollection.length - 1,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Icon(
                index == _selectedColorIndex ? Icons.lens : Icons.trip_origin,
                color: _colorCollection[index]),
            title: Text(_colorNames[index]),
            onTap: () {
              setState(() {
                _selectedColorIndex = index;
              });

              // ignore: always_specify_types
              Future.delayed(const Duration(milliseconds: 200), () {
                // When task is over, close the dialog
                Navigator.pop(context);
              });
            },
          );
        },
      )),
    );
  }
}
