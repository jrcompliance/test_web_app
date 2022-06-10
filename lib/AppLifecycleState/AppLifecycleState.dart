import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_web_app/Constants/reusable.dart';

class AppLifeCycleManager extends StatefulWidget {
  AppLifeCycleManager({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _AppLifeCycleManagerState createState() => _AppLifeCycleManagerState();
}

class _AppLifeCycleManagerState extends State<AppLifeCycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      var userid = FirebaseAuth.instance.currentUser!.uid;
      setState(() {
        isloggedIn = false;
      });

      logoutTime = FirebaseFirestore.instance
          .collection("EmployeeData")
          .doc(userid)
          .update({
        "timeStamp":
            DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()).toString()
      });
    }
    print('AppLifecycleState $state');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}
