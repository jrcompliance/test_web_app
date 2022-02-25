import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Constants/reusable.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.9,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (_, i) {
            if (list.isEmpty || list.length == 0) {
              return Text("Loading...");
            }
            return ListTile(
              title: Text(list[i].toString()),
            );
          }),
    );
  }

  List list = [];
  getsharelist() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    list = sharedPreferences.getStringList('timer')!;
    print("yalagala....");
    print(sharedPreferences.getStringList('timer')!.length.toString());
    print(list.length.toString());
    print(list.toString());
    setState(() {});
    //print(list.map((e) => NotificationModel(message: e.toString(),title: e.toString())));
  }
}
