import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/NewModels/MessageModel.dart';
import 'package:test_web_app/NewModels/RoomModel.dart';

class ChattingScreen extends StatefulWidget {
  RoomModel roomModel;
  EmployeesModel employeesModel;
  ChattingScreen({required this.roomModel, required this.employeesModel});

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  TextEditingController textEditingController = TextEditingController();

  CollectionReference? chatsCollectionReference;

  @override
  void initState() {
    super.initState();
    // FirebaseFirestore.instance.collection("Rooms").doc().;
    print('roomid--' + widget.roomModel.roomId.toString());
    chatsCollectionReference = FirebaseFirestore.instance
        .collection("Chats")
        .doc(widget.roomModel.roomId)
        .collection("messages");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employeesModel.uname ?? "Chat"),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 9,
              child: StreamBuilder<QuerySnapshot>(
                  stream: chatsCollectionReference!
                      .orderBy("timeStamp")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.length == 0) {
                        return Center(child: Text("No chats Found"));
                      }

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (ctx, index) {
                            MessageModel messageModel = MessageModel.fromMap(
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>);
                            return ChatItem(messageModel);
                          });
                    }

                    return Center(child: CircularProgressIndicator());
                  })),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        hintText: "Enter message",
                        border: OutlineInputBorder()),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: InkWell(
                        onTap: () {
                          sendMessage();
                        },
                        child: Icon(
                          Icons.send,
                          color: Theme.of(context).accentColor,
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }

  sendMessage() async {
    if (textEditingController.text.length == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter message")));
      return;
    }
    String message = textEditingController.text;

    MessageModel messageModel = MessageModel();
    messageModel.message = message;
    await chatsCollectionReference!.add(messageModel.toMap());

    Map<String, dynamic> roomMap = Map();
    roomMap['lastMessage'] = message;
    roomMap['timeStamp'] = FieldValue.serverTimestamp();

    await FirebaseFirestore.instance
        .collection("Rooms")
        .doc(widget.roomModel.roomId)
        .update(roomMap);

    textEditingController.clear();
  }
}

class ChatItem extends StatelessWidget {
  MessageModel messageModel;
  ChatItem(this.messageModel);
  bool left = false;
  @override
  Widget build(BuildContext context) {
    if (messageModel.senderId == FirebaseAuth.instance.currentUser!.uid) {
      left = false;
    } else {
      left = true;
    }
    return Row(
      mainAxisAlignment: left ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: left ? Colors.red[300] : Colors.green[300]),
            child: Column(
              crossAxisAlignment:
                  left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  messageModel.message ?? "",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(
                  height: 6,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    messageModel.timeStamp != null
                        ? Utilities.displayTimeAgoFromTimestamp(
                            messageModel.timeStamp!.toDate().toString())
                        : "",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Utilities {
  static String displayTimeAgoFromTimestamp(String dateString,
      {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} years ';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 year ' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} months ';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 month ' : 'Last month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} weeks ';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour' : 'An hour';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} min';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 min' : 'min';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} sec ';
    } else {
      return 'Just now';
    }
  }
}
