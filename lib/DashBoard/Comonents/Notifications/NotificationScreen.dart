// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:test_web_app/Constants/reusable.dart';
//
// class Notifications extends StatefulWidget {
//   const Notifications({Key? key}) : super(key: key);
//
//   @override
//   _NotificationsState createState() => _NotificationsState();
// }
//
// class _NotificationsState extends State<Notifications> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * 0.9,
//       child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: list.length,
//           itemBuilder: (_, i) {
//             if (list.isEmpty || list.length == 0) {
//               return Text("Loading...");
//             }
//             return ListTile(
//               title: Text(list[i].toString()),
//             );
//           }),
//     );
//   }
//
//   List list = [];
//   getsharelist() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     list = sharedPreferences.getStringList('timer')!;
//     print("yalagala....");
//     print(sharedPreferences.getStringList('timer')!.length.toString());
//     print(list.length.toString());
//     print(list.toString());
//     setState(() {});
//     //print(list.map((e) => NotificationModel(message: e.toString(),title: e.toString())));
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/ChatWidgets/MyOwnCard.dart';
import 'package:test_web_app/ChatWidgets/ReplyCard.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/Comonents/Messages/Chats.dart';
import 'package:test_web_app/Models/ChatModel.dart';
import 'package:test_web_app/Models/CustomerModel.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/Models/UserModel2.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/NewModels/MessageModel.dart';
import 'package:test_web_app/NewModels/RoomModel.dart';
import 'package:test_web_app/Providers/ChatProvider.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:test_web_app/Providers/GetChatProvider.dart';
import 'package:test_web_app/Widgets/Message.dart';
import 'package:test_web_app/Widgets/Utils.dart';
import 'package:video_call_flutter/video_call_flutter.dart';
import 'package:dio/dio.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String chatName = '';
  final ScrollController scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  CollectionReference? chatsCollectionReference;

  Map<String, String> names = {
    '02m': 'Rishabh',
    '10m': 'Shobhit',
    '12m': 'Ankit',
    '08m': 'Kartik',
    '11m': 'Parth',
    '13m': 'Siddhart',
    '26m': 'Arastoo',
    '27m': 'Kshitij',
    '28m': 'Yash',
    '31m': 'Vedant',
    '34m': 'Aman',
    '45m': 'Aryan',
    '06w': 'Raghvi',
  };
  List images = [
    'https://www.freepnglogos.com/uploads/youtube-logo-hd-8.png',
    'https://www.freepnglogos.com/uploads/youtube-logo-hd-8.png',
    'https://www.freepnglogos.com/uploads/youtube-logo-hd-8.png'
  ];
  int selected = -1;

  String? currentuid;

  List<EmployeesModel> allEmployees = [];

  @override
  void initState() {
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
        print(allEmployees.toList().toString());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String url =
        "https://firebasestorage.googleapis.com/v0/b/jrcrm-4f580.appspot.com/o/Services%2FISIServices%2F1?alt=media&token=d9d16bdd-c7b4-4685-a7f1-fa35f8e36ee6";
    return Container(
      height: size.height * 0.93,
      child: Column(
        children: [
          FlatButton(
            onPressed: () async {
              downloadUrl();
            },
            child: Text("downloads"),
          ),
          Text(downloadUrl().toString()),
        ],
      ),
      // child: Row(
      //   children: [
      //     Expanded(
      //       flex: 3,
      //       child: Container(
      //         color: bgColor,
      //         child: Column(
      //           children: [
      //             const SizedBox(
      //               height: 30,
      //             ),
      //             Container(
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   color: bgColor),
      //               width: size.width * 0.2,
      //               height: 50,
      //               padding: const EdgeInsets.only(left: 15, top: 15),
      //               child: Center(
      //                 child: TextField(
      //                   style: TextStyle(
      //                       fontSize: 14, color: Colors.white.withOpacity(0.6)),
      //                   decoration: InputDecoration(
      //                     border: InputBorder.none,
      //                     focusedBorder: InputBorder.none,
      //                     enabledBorder: InputBorder.none,
      //                     errorBorder: InputBorder.none,
      //                     disabledBorder: InputBorder.none,
      //                     hintText: 'Search',
      //                     hintStyle: TextStyle(
      //                         fontSize: 14,
      //                         color: Colors.white.withOpacity(0.6)),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             Container(
      //               height: size.height * 0.7,
      //               color: bgColor,
      //               child: chatRoomsList(),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     const SizedBox(
      //       width: 30,
      //     ),
      //     Expanded(
      //         flex: 7,
      //         child: Chat(
      //           chatRoomId: 'id',
      //           chatUsername: chatName,
      //         ))
      //   ],
      // ),
    );
  }

  downloadUrl() async {
    String url =
        "https://firebasestorage.googleapis.com/v0/b/jrcrm-4f580.appspot.com/o/Services%2FISIServices%2F1?alt=media&token=d9d16bdd-c7b4-4685-a7f1-fa35f8e36ee6";
    final response = await Dio().get(
      url,
      onReceiveProgress: showDownloadProgress,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
  }

// var progress;
  showDownloadProgress(received, total) {
    if (total != -1) {
      // setState(() {
      //  var progress = (received / total * 100).toStringAsFixed(0);
      print((received / total * 100).toStringAsFixed(0) + "%");
      // });
    }
  }

  Widget chatRoomsList() {
    return Expanded(
      child: ListView.separated(
        itemCount: allEmployees.length,
        scrollDirection: Axis.vertical,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return chatRoomTile(
              allEmployees[index].uname.toString(),
              allEmployees[index].uimage.toString(),
              // names.values.elementAt(index),
              // names.keys.elementAt(index),
              selected != index ? AbgColor.withOpacity(0.1) : btnColor,
              index);
        },
        separatorBuilder: (context, int) {
          return SizedBox(
            height: 5,
          );
        },
      ),
    );
  }

  chatRoomTile(String userName, String userDp, Color color, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          chatName = userName;
          selected = index;
        });
      },
      child: Container(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(30)),
                child: Image.network(allEmployees[index].uimage.toString()),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName,
                    textAlign: TextAlign.start, style: TxtStls.fieldstyle),
                Text(
                    chats[userName] == null
                        ? ""
                        : chats[userName]!.messages.last['text'].toString(),
                    style: TxtStls.fieldstyle)
              ],
            )
          ],
        ),
      ),
    );
  }
}
