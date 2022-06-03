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
import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/ChatWidgets/MyOwnCard.dart';
import 'package:test_web_app/ChatWidgets/ReplyCard.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Models/ChatModel.dart';
import 'package:test_web_app/Models/CustomerModel.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/Models/UserModel2.dart';
import 'package:test_web_app/Models/UserModels.dart';
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
  var imageFile;
  FocusNode _focusNode = new FocusNode();
  bool isLoading = false;
  bool isLogggedIn = false;
  ScrollController _sc = ScrollController();
  String? employee;
  String? currentuid;
  String? lastLoggedIn;
  bool _flagTyping = false;
  var messageList = [];
  late IO.Socket _socket;
  String? id;
  final TextEditingController _messageInputController = TextEditingController();

  String? groupChatId;

  _sendMessage() {
    _socket.emit('message',
        {'message': _chatController.text.trim(), 'sender': currentuid});
    _chatController.clear();
  }

  _connectSocket() {
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    _socket.on(
      'message',
      (data) => addNewMessage(
        Message.fromJson(data),
      ),
    );
  }

  // var currentUser;

  bool filePicked = false;

  var fileName;
  bool show = false;
  // late IO.Socket socket;
  //
  bool sendByMe = false;
  IO.Socket? socket;
  var messgeListener;
  String listenerID = "agam";
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      currentuid = pref.getString("uid");
      lastLoggedIn = pref.getString("lastSeen");
      print("@" + lastLoggedIn.toString());
      Provider.of<UserDataProvider>(context, listen: false)
          .getEmployeesList(currentuid)
          .then((value) {
        allEmployees =
            Provider.of<UserDataProvider>(context, listen: false).employeelist;
      });
    });
    // if (kIsWeb) {
    //   _socket = IO.io(
    //     'http://localhost:8080',
    //     IO.OptionBuilder().setQuery({'username': employeename}).build(),
    //   );
    // } else {
    //   _socket = IO.io(
    //     'http://localhost:8080',
    //     IO.OptionBuilder().setTransports(['websocket']).setQuery(
    //         {'sender': currentuid, 'receiver': peerUid}).build(),
    //   );
    // }

    // _connectSocket();
  }

  @override
  void dispose() {
    _chatController.dispose();
    _sc.dispose();
    //  channel.sink.close();

    super.dispose();
  }

  final TextEditingController _customersearchController =
      TextEditingController();
  final TextEditingController videoCallEditingController =
      TextEditingController();
  final TextEditingController _chatController = TextEditingController();
  var chatContent = "";

  List<EmployeesModel> allEmployees = [];
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.845,
      width: size.width,
      color: AbgColor.withOpacity(0.0001),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
              decoration: BoxDecoration(
                  color: bgColor, borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: fieldColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 2),
                      child: TextField(
                          controller: _customersearchController,
                          style: TxtStls.fieldstyle,
                          decoration: InputDecoration(
                              suffixIcon:
                                  _customersearchController.text.isNotEmpty
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            color: btnColor,
                                          ),
                                          onPressed: () {
                                            _customersearchController.clear();
                                            searchCustomer("");
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          },
                                        )
                                      : Icon(
                                          Icons.search,
                                          color: btnColor,
                                        ),
                              border: InputBorder.none,
                              hintText:
                                  "Enter Customer name or email or phone.....",
                              hintStyle: TxtStls.fieldstyle),
                          onChanged: searchCustomer),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  allEmployees.length <= 0
                      ? Center(
                          child: SpinKitFadingCube(color: btnColor, size: 15),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          itemCount: allEmployees.length,
                          itemBuilder: (BuildContext context, int i) {
                            var snp = allEmployees[i];
                            return Material(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: bgColor,
                              child: ListTile(
                                tileColor: grClr.withOpacity(0.1),
                                hoverColor: btnColor.withOpacity(0.2),
                                selectedColor: btnColor.withOpacity(0.2),
                                selectedTileColor: btnColor.withOpacity(0.2),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: btnColor.withOpacity(0.1),
                                  backgroundImage: snp.uimage.toString() == null
                                      ? NetworkImage(
                                          "https://cdn1.iconfinder.com/data/icons/bokbokstars-121-classic-stock-icons-1/512/person-man.png")
                                      : NetworkImage(snp.uimage.toString()),
                                  // child: Icon(
                                  //   Icons.person,
                                  //   color: btnColor,
                                  // )
                                ),
                                title: Text(
                                  snp.uname.toString(),
                                  style: TxtStls.fieldtitlestyle,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snp.uemail.toString(),
                                      style: TxtStls.fieldstyle,
                                    ),
                                    Text(
                                      snp.uphoneNumber.toString(),
                                      style: TxtStls.fieldstyle,
                                    ),
                                  ],
                                ),
                                trailing: CircleAvatar(
                                  backgroundColor: btnColor.withOpacity(0.1),
                                ),
                                onTap: () {
                                  setState(() {
                                    _isTapped = true;
                                    employeename = snp.uname;
                                    employeeemail = snp.uemail;
                                    employeePhone = snp.uphoneNumber;
                                    employeeImageUrl = snp.uimage;
                                    peerUid = snp.uid;
                                    Provider.of<GetMessagesListProvider>(
                                            context,
                                            listen: false)
                                        .getMessagesList(peerUid);

                                    // _isTapped ? getChatMessage(peerUid!) : null;
                                    // Provider.of<ChatProvider>(context,
                                    //         listen: false)
                                    //     .SaveChatMessage(
                                    //   currentuid.toString(),
                                    //   docID.toString(),
                                    //   _chatController.text,
                                    // );
                                    // var chatdocId = Provider.of<ChatProvider>(
                                    //         context,
                                    //         listen: false)
                                    //     .chatDocID;
                                    // Idocid = snp.uid;
                                    // cusname = snp.Customername;
                                    // cusphone = snp.Customerphone;
                                    // cusemail = snp.Customeremail;
                                    // cusID = snp.CxID;
                                    // cusTask = snp.taskname;
                                    // //startDate = snp.startDate;
                                    // endDate = snp.endDate;
                                    // priority = snp.priority;
                                    // //lastseen = snp.lastseen;
                                    // cat = snp.cat;
                                    // message = snp.message;
                                    // status = snp.status;
                                    // s = snp.s;
                                    // f = snp.f;
                                    // assign = snp.assign;
                                    // print(cusname.toString());
                                    // Provider.of<GetInvoiceListProvider>(context,
                                    //         listen: false)
                                    //     .getInvoiceList(snp.CxID);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(color: grClr.withOpacity(0.5));
                          },
                        )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.all(20),
              height: size.height * 0.93,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: bgColor,
              ),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  _isTapped ? listview() : Expanded(child: SizedBox()),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: SafeArea(
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            autofocus: true,
                            focusNode: _focusNode,
                            controller: _chatController,
                            onFieldSubmitted: (val) {
                              onSendMessage(_chatController.text, 0);
                              submitMsg(val);
                            },
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              color: btnColor,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                            onChanged: (val) {
                              setState(() {
                                if (val.length == 0) {
                                  if (_flagTyping) {
                                    //   socketService.isTyping(false);
                                    _flagTyping = false;
                                  }
                                } else {
                                  if (_flagTyping == false) {
                                    //   socketService.isTyping(true);
                                    _flagTyping = true;
                                  }
                                }
                                chatContent = val.trim();
                              });
                            },
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                bottom: .0,
                                left: 24.0,
                              ),
                              border: InputBorder.none,
                              hintText: "Type a message...",
                              hintStyle: TextStyle(
                                color: btnColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.send),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void searchCustomer(String query) {
    final allEmployees = Provider.of<UserDataProvider>(context, listen: false)
        .employeelist
        .where((element) {
      final customertitle = element.uname!.toLowerCase();
      final customeremail = element.uemail!.toLowerCase();
      final customerphone = element.uphoneNumber!.toLowerCase();
      final input = query.toLowerCase();
      return customertitle.contains(input) ||
          customeremail.contains(input) ||
          customerphone.contains(input);
    }).toList();
    setState(() {
      query = query;
      this.allEmployees = allEmployees;
    });
  }

  Widget chatAvatar(icondata) {
    return CircleAvatar(
      backgroundColor: grClr.withOpacity(0.1),
      child: Icon(
        icondata,
        color: btnColor.withOpacity(0.75),
      ),
    );
  }

  Widget space() {
    return SizedBox(
      width: 10,
    );
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
      //   imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        // uploadImageFile();
      }
    }
  }

  Widget buildMessageInput() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [],
      ),
    );
  }

  Widget listview() {
    return Expanded(
      flex: 5,
      child: Text(currentuid.toString()),
      // child: ChatWidget.widgetChatBuildItem(
      //     context, listMessage, id!, index, document, peerAvatar),
    );
  }

  Stream getChatMessage() {
    return FirebaseFirestore.instance
        .collection("Chats")
        .doc(currentuid)
        .collection("messages")
        .where("isFrom", isEqualTo: currentuid)
        .where("isTo", isEqualTo: peerUid)
        .orderBy("time", descending: true)
        .snapshots();
  }

  createRoom() async {
    String url =
        "https://yalagala.whereby.com/0af4d394-e401-4409-89fa-54ea8aedf4d8";

    var response =
        await Dio().get(url, options: Options(responseType: ResponseType.json));
    print(response.toString());
  }

  void connect() {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://192.168.1.11:4000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect();
    socket?.onConnect((data) {
      print("Connected");
      socket?.on("message", (msg) {
        print(msg);
        // setMessage("destination", msg["message"]);
        _sc.animateTo(_sc.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket?.connected);
  }

  final List<Message> messages = [];

  addNewMessage(Message message) {
    messages.add(message);
  }

  void sendMessage() {
    if (_chatController.text.isNotEmpty) {
      var msg = Message(
          message: _chatController.text,
          senderUsername: currentuid.toString(),
          sentAt: DateTime.now().toString().substring(10, 16),
          sentTo: peerUid.toString());
      // channel.sink.add(msg);
      print(msg.toString());
      //  channel.sink.addStream(_chatController.text)
    }
  }

  submitMsg(msg) {
    if (msg == 'exit') {
    } else if (msg != '') {
      // socketService.sendMessage(msg);
      // socketService.isTyping(false);
    }
    setState(() {
      _chatController.text = '';
      chatContent = '';
      // _flagTyping = false;
    });
    _focusNode.requestFocus();
  }

  readLocal() async {
    id = currentuid ?? "";
    if (id.hashCode <= peerUid.hashCode) {
      groupChatId = '$id-$peerUid';
    } else {
      groupChatId = '$peerUid-$id';
    }

    FirebaseFirestore.instance
        .collection("EmployeeData")
        .doc(id)
        .update({'chattingWith': peerUid});
    setState(() {});
  }

  void onSendMessage(String content, int type) {
    //type:0 = text,
    //type:1 = image,
    //type:2 = sticker,
    if (content.trim() != "") {
      _chatController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection("messages")
          .doc(groupChatId)
          .collection(groupChatId!)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(documentReference, {
          'idFrom': id,
          'idTo': peerUid,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'content': content,
          'type': type,
        });
      });

      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'nothing to send');
    }
  }

  Future<bool> onBackPress() {
    Navigator.pop(context);
    return Future.value(false);
  }
}
