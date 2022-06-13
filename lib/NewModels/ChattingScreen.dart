import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/Comonents/Messages/ChatItem.dart';
import 'package:test_web_app/DashBoard/Comonents/Messages/Signaling.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/NewModels/MessageModel.dart';
import 'package:test_web_app/NewModels/RoomModel.dart';
import 'package:universal_html/html.dart';

class ChattingScreen extends StatefulWidget {
  RoomModel roomModel;
  EmployeesModel employeesModel;
  bool isTapped;
  ChattingScreen(
      {required this.roomModel,
      required this.employeesModel,
      required this.isTapped});

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  FocusNode _focusNode = new FocusNode();
  bool filePicked = false;
  var fileName;
  bool isLoading = false;
  File? imageFile;

  TextEditingController textEditingController = TextEditingController();
  final ScrollController _sc = ScrollController();
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;

  CollectionReference? chatsCollectionReference;
  String? time;
  @override
  void initState() {
    super.initState();
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });
    print('roomid--' + widget.roomModel.roomId.toString());
    chatsCollectionReference = FirebaseFirestore.instance
        .collection("Chats")
        .doc(widget.roomModel.roomId)
        .collection("messages");
    var user = FirebaseAuth.instance.currentUser!.uid;
    Future.delayed(Duration(seconds: 0)).then((value) {
      var data =
          FirebaseFirestore.instance.collection("EmployeeData").doc(user).get();
      data.then((value) {
        time = value.get("timeStamp");
        print('time---' + time.toString());
      });
    });
  }

  _scrollListener() {
    _sc.animateTo(_sc.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _sc.dispose();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AbgColor.withOpacity(0.0001),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(''),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: size.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: bgColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: IconButton(
                                      tooltip: "press to go back",
                                      padding: const EdgeInsets.all(10.0),
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        size: 20,
                                        color: btnColor,
                                      )),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      widget.employeesModel.uimage.toString()),
                                ),
                                sizedBox(),
                                sizedBox(),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        widget.employeesModel.uname ?? "Chat",
                                        style: TxtStls.fieldtitlestyle,
                                      ),
                                    ),
                                    Text(
                                      isloggedIn
                                          ? "Online"
                                          : "lastseen at" +
                                              " " +
                                              time.toString(),
                                      style: isloggedIn
                                          ? TxtStls.fieldstatusstyle
                                          : TxtStls.fieldstyle,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Text(""),
                                ),
                                circleAvatar(Icon(Icons.call), () {}),
                                sizedBox(),
                                circleAvatar(Icon(Icons.videocam_rounded), () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alertDialog();
                                    },
                                  );
                                }),
                                sizedBox(),
                                circleAvatar(Icon(Icons.more_vert), () {})
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 8,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: chatsCollectionReference!
                                  // .where('senderId', isEqualTo: widget.roomModel.senderId)
                                  // .where("peerId", isEqualTo: widget.roomModel.peerId)
                                  .orderBy("timeStamp")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  print(snapshot.error.toString());
                                  return Text(snapshot.error.toString());
                                }

                                if (snapshot.hasData) {
                                  if (snapshot.data!.docs.length == 0) {
                                    return Center(
                                        child: Text("No chats Found"));
                                  }

                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length + 1,
                                      controller: _sc,
                                      itemBuilder: (ctx, index) {
                                        if (index ==
                                            snapshot.data!.docs.length) {
                                          return Container(
                                            height: size.height * 0.1,
                                          );
                                        }
                                        print('' +
                                            snapshot.data!.docs.toString());
                                        MessageModel messageModel =
                                            MessageModel.fromMap(snapshot
                                                    .data!.docs[index]
                                                    .data()
                                                as Map<String, dynamic>);
                                        return ChatItem(messageModel);
                                        ;
                                      });
                                }

                                return Center(
                                    child: CircularProgressIndicator());
                              })),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Container(
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            color: AbgColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                child: Image.asset(
                                  "assets/Logos/attachLogo.png",
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.fill,
                                  color: AbgColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 12.5, bottom: 12.5),
                                    child: VerticalDivider(
                                      thickness: 2.5,
                                      width: 2.5,
                                      color: AbgColor,
                                    )),
                              ),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: TextField(
                                    // autofocus: true,
                                    focusNode: _focusNode,
                                    controller: textEditingController,
                                    decoration: InputDecoration(
                                        hintText: "Enter message",
                                        hintStyle: TxtStls.fieldstyle,
                                        border: InputBorder.none),
                                    onSubmitted: (_) {
                                      _scrollListener();
                                      sendMessage();
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.emoji_emotions,
                                      size: 20,
                                      color: AbgColor,
                                    )),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                      onTap: () {
                                        _scrollListener();
                                        sendMessage();
                                      },
                                      child: Image.asset(
                                        "assets/Images/send.png",
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.contain,
                                        color: btnColor,
                                      ))),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(''),
              ),
            ],
          ),
        ),
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
    FocusScope.of(context).requestFocus(_focusNode);
  }

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      fileName = result.files.first.name;
      setState(() {
        filePicked = true;
      });
    }
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      //  imageFile = File(pickedFile,fileName);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        // uploadImageFile();
      }
    }
  }

  createRoom() async {
    String url =
        "https://yalagala.whereby.com/0af4d394-e401-4409-89fa-54ea8aedf4d8";

    var response =
        await Dio().get(url, options: Options(responseType: ResponseType.json));
    print('videocallresponse==' + response.toString());
  }

  Widget circleAvatar(icon, onpressed) {
    return CircleAvatar(
      backgroundColor: AbgColor.withOpacity(0.2),
      radius: 20,
      child: IconButton(
        onPressed: onpressed,
        icon: icon,
        iconSize: 15,
        color: txtColor.withOpacity(0.4),
      ),
    );
  }

  Widget sizedBox() {
    return SizedBox(
      width: 10,
    );
  }

  Widget alertDialog() {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      titlePadding: EdgeInsets.all(0.0),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Align(
          alignment: Alignment.topCenter,
          child: Text(
            'VideoCall',
            style: TxtStls.fieldstyle,
          )),
      content: Container(
        height: size.height * 0.7,
        width: size.width * 0.6,
        color: bgColor,
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: size.height * 0.3,
                    width: size.width * 0.2,
                    child: RTCVideoView(
                      _localRenderer,
                      mirror: false,
                    ),
                  ),
                  Container(
                    height: size.height * 0.3,
                    width: size.width * 0.2,
                    child: RTCVideoView(_remoteRenderer),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Row(
              children: [
                ElevatedButton(
                  child: Text("Open Camera"),
                  onPressed: () {
                    signaling.openUserMedia(_localRenderer, _remoteRenderer);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: Text("Create Room"),
                  onPressed: () async {
                    roomId = await signaling.createRoom(_remoteRenderer);
                    print('video-roomId---' + roomId.toString());
                    setState(() {});
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add roomId
                    signaling.joinRoom(
                      roomId.toString(),
                      _remoteRenderer,
                    );
                  },
                  child: Text("Join room"),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    signaling.hangUp(_localRenderer);
                  },
                  child: Text("Hangup"),
                )
              ],
            ),
          ],
        ),
      ),
      // Container(
      //   height: size.height * 0.7,
      //   width: size.width * 0.5,
      //   child: Column(
      //     children: [
      //       Container(
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Expanded(
      //               child: RTCVideoView(
      //                 _localRenderer,
      //                 mirror: false,
      //               ),
      //             ),
      //             Expanded(
      //               child: RTCVideoView(_remoteRenderer),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         child: TextButton(
      //           onPressed: () {
      //             signaling.openUserMedia(_localRenderer, _remoteRenderer);
      //           },
      //           child: Text("Open Camera"),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // actions: [
      //   CupertinoDialogAction(
      //     child: Text("Yes"),
      //   ),
      //   CupertinoDialogAction(
      //     child: Text("No"),
      //   ),
      // ],
    );
  }
}
