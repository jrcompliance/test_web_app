import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/Comonents/Messages/Utilities.dart';
import 'package:test_web_app/NewModels/MessageModel.dart';

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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.15,
            padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: left ? avgClr : goodClr),
            child: Column(
              crossAxisAlignment:
                  left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  messageModel.message ?? "",
                  style: TxtStls.messagestyle,
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
                    style: TxtStls.messagestyle,
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
