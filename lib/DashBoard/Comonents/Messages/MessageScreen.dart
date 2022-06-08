import 'dart:convert';
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
import 'package:test_web_app/DashBoard/Comonents/Messages/ChatItem.dart';
import 'package:test_web_app/Models/ChatModel.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/Models/UserModel2.dart';
import 'package:test_web_app/NewModels/ChattingScreen.dart';
import 'package:test_web_app/NewModels/MessageModel.dart';
import 'package:test_web_app/NewModels/RoomModel.dart';
import 'package:test_web_app/Providers/ChatProvider.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:test_web_app/Providers/GetChatProvider.dart';
import 'package:dio/dio.dart';
import 'package:test_web_app/Widgets/FullPhotoPage.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  File? imageFile;
  FocusNode _focusNode = new FocusNode();
  bool isLoading = false;
  List<ChatModel> messages = [];
  bool isLogggedIn = false;
  var _scrollController = ScrollController();
  String? employee;
  String? currentuid;
  String? lastLoggedIn;
  String? lastLoggedOut;
  User? user = FirebaseAuth.instance.currentUser;
  EmployeesModel? logginUserModel;
  late var employeeModal;
  RoomModel roomModel = RoomModel();
  late var roomModal;
  getUserData() {
    FirebaseFirestore.instance
        .collection("EmployeeData")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.logginUserModel = EmployeesModel.fromMap(value.data());
      setState(() {});
    });
  }

  CollectionReference? chatsCollectionReference;

  bool filePicked = false;

  var fileName;
  bool show = false;
  bool sendByMe = false;
  @override
  void initState() {
    super.initState();
    getUserData();
    employeeModal = EmployeesModel();
    roomModal = RoomModel();
    // initializeSocket();
    Future.delayed(Duration(seconds: 2)).then((value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      currentuid = pref.getString("uid");
      lastLoggedIn = pref.getString("lastSeen");
      lastLoggedOut = pref.getString("logoutTime");
      print("@" + lastLoggedIn.toString() + "@" + lastLoggedOut.toString());
    });

    Future.delayed(Duration(seconds: 2)).then((value) {
      Provider.of<UserDataProvider>(context, listen: false)
          .getEmployeesList(currentuid)
          .then((value) {
        allEmployees =
            Provider.of<UserDataProvider>(context, listen: false).employeelist;
      });
    });
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 2), curve: Curves.easeInOut);
    }
  }
  //   if (_scrollController.offset >=
  //           _scrollController.position.maxScrollExtent &&
  //       !_scrollController.position.outOfRange &&
  //       _limit <= listMessage.length) {
  //     setState(() {
  //       _limit += _limitIncrement;
  //     });
  //   }
  // }
  //
  // void onFocusChange() {
  //   if (_focusNode.hasFocus) {
  //     // Hide sticker when keyboard appear
  //     setState(() {
  //       // isShowSticker = false;
  //     });
  //   }
  // }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
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
                      : StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("EmployeeData")
                              .get()
                              .asStream(),
                          builder: (context, snapshot) {
                            return ListView.separated(
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
                                          ? NetworkImage(
                                              "https://cdn1.iconfinder.com/data/icons/bokbokstars-121-classic-stock-icons-1/512/person-man.png")
                                          : NetworkImage(
                                              employeeModel.uimage.toString()),
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
                                          employeeModel.uphoneNumber.toString(),
                                          style: TxtStls.fieldstyle,
                                        ),
                                      ],
                                    ),
                                    trailing: CircleAvatar(
                                      backgroundColor:
                                          btnColor.withOpacity(0.1),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _isTapped = true;
                                        employeeModal = employeeModel;
                                        checkAndCreateNewRoom(
                                            employeeModel, context);
                                      });
                                    },
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
                            );
                          })
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 7,
            child:
                // roomModel.roomId != null
                //     ? chatScreen()
                // roomModel.roomId != null
                //     ? ChattingScreen(
                //         employeesModel: employeeModal,
                //         roomModel: roomModel,
                //       )
                //     :
                Container(),
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
      imageFile = File(pickedFile.path);
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

  createRoom() async {
    String url =
        "https://yalagala.whereby.com/0af4d394-e401-4409-89fa-54ea8aedf4d8";

    var response =
        await Dio().get(url, options: Options(responseType: ResponseType.json));
    print('videocallresponse==' + response.toString());
  }

  String createRoomId(EmployeesModel toChatUserModel) {
    // SmallId_LargeId
    String roomID = "";

    print(
        "createRoomId ${user!.uid.hashCode} >> ${toChatUserModel.uid.hashCode} ");
    print("createRoomId ${user!.uid} >> ${toChatUserModel.uid} ");
    if (user!.uid.hashCode > toChatUserModel.uid.hashCode) {
      roomID = toChatUserModel.uid! + "_" + user!.uid;
    } else if (user!.uid.hashCode < toChatUserModel.uid.hashCode) {
      roomID = user!.uid + "_" + toChatUserModel.uid.toString();
    } else {
      roomID = user!.uid + "_" + toChatUserModel.uid.toString();
    }

    print("createRoomId @$roomID");

    return roomID;
  }

  checkAndCreateNewRoom(
      EmployeesModel toChatUserModel, BuildContext context) async {
    String roomId = createRoomId(toChatUserModel);

    CollectionReference roomCollectionReference =
        FirebaseFirestore.instance.collection("Rooms");

    DocumentSnapshot documentSnapshot =
        await roomCollectionReference.doc(roomId).get();
    if (documentSnapshot.exists) {
      // already created a room
      roomModel =
          RoomModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } else {
      // create a new room
      roomModel.roomId = roomId;
      roomModel.peerId = toChatUserModel.uid;
      roomModel.participantsList = [];
      roomModel.participantsList!.add(toChatUserModel.uid);
      roomModel.participantsList!.add(user!.uid);
      await roomCollectionReference.doc(roomId).set(roomModel.toMap());
    }

    if (roomModel != null) {
      print('room available');

      // setState(() {
      //   roomModal = roomModel;
      // });
      print('roooom' + roomModel.roomId.toString());
      // setState(() {
      //   roomModal = roomModel;
      //   chatScreen(
      //     roomModel: roomModel,
      //     employeesModel: toChatUserModel,
      //   );
      // });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => ChattingScreen(
                    roomModel: roomModel,
                    employeesModel: toChatUserModel,
                  )));
    }
  }

  TextEditingController textEditingController = TextEditingController();
  Widget chatScreen({RoomModel? roomModel, EmployeesModel? employeesModel}) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Text(employeesModel!.uname ?? "Chat"),
        ),
        Expanded(
            flex: 8,
            child: StreamBuilder<QuerySnapshot>(
                stream: chatsCollectionReference!
                    // .where("senderId", isEqualTo: widget.roomModel.senderId)
                    // .where('peerId', isEqualTo: widget.roomModel.peerId)
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
                      hintText: "Enter message", border: OutlineInputBorder()),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          sendMessage();
                        });
                      },
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context).accentColor,
                      )))
            ],
          ),
        )
      ],
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
        .doc(roomModel.roomId)
        .update(roomMap);

    textEditingController.clear();
  }
}
