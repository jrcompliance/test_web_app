// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// class LocalNotifications extends StatefulWidget {
//   const LocalNotifications({Key? key}) : super(key: key);
//
//   @override
//   State<LocalNotifications> createState() => _LocalNotificationsState();
// }
//
// class _LocalNotificationsState extends State<LocalNotifications> {
// FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
// var initializationSettingsAndroid = new  AndroidInitializationSettings('jrlogo.png');
// var initializationSettingsIOS = new IOSInitializationSettings();
// var initializationSettingsMacOS = MacOSInitializationSettings();
// var initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open Notification');
// var initializationSettings = InitializationSettings();
//
//
//  @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//      initializationSettingsAndroid;
//      initializationSettingsIOS;
//      initializationSettingsMacOS;
//     initializationSettingsLinux ;
//      initializationSettings;
//
//
//   }
// Future onSelectNotification(String payload) async{
//    return showDialog<void>(
//       context: context,
//       barrierDismissible: true,
//       // false = user must tap button, true = tap outside dialog
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: Text('payload'),
//           content: Text("Payload:$payload"),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('Okay'),
//               onPressed: () {
//                 _showNotificationWithDefaultSound;
//                 Navigator.of(dialogContext).pop(); // Dismiss alert dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: new Center(
//         child: new Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//         new RaisedButton(
//         onPressed: _showNotificationWithDefaultSound,
//         child: new Text('Show Notification With Default Sound'),
//     ),
//
//     ])
//     )
//     );
//   }
//
// Future _showNotificationWithDefaultSound() async {
//   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//       'your channel id', 'your channel name',
//       importance: Importance.max, priority: Priority.high);
//   var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//   var MacOSPlatformChannelSpecifics = new MacOSNotificationDetails();
//   var LinuxPlatformChannelSpecifics = new LinuxNotificationCategory('');
//   var platformChannelSpecifics = new NotificationDetails();
//
//   await _localNotifications.initialize(initializationSettings);
//   await _localNotifications.getNotificationAppLaunchDetails();
//
//
//   _localNotifications.show(
//     0,
//     'New Post',
//     'How to Show Notification in Flutter',
//     platformChannelSpecifics,
//     payload: 'Default_Sound',
//   );
//    print('button Clicked4');
// }
// }
//
