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
import 'package:test_web_app/Models/ChatModel.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/Models/UserModel2.dart';
import 'package:test_web_app/NewModels/ChattingScreen.dart';
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
  var messageList = [];
  List<DocumentSnapshot> listMessage = [];
  Socket? socket;

  User? user = FirebaseAuth.instance.currentUser;
  EmployeesModel? logginUserModel;
  late var employeeModal;
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
    print("ggggg" + getChatMessage().toString());
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
    socket!.disconnect();
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
            child: roomModal == null
                ? ChattingScreen(
                    employeesModel: employeeModal,
                    roomModel: roomModal,
                  )
                : Container(),
            // child: Container(
            //   padding: EdgeInsets.all(20),
            //   height: size.height * 0.93,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //     color: bgColor,
            //   ),
            //   child: Column(
            //     children: [
            //       SizedBox(height: size.height * 0.02),
            //       Container(
            //         child: ListTile(
            //           leading: CircleAvatar(
            //             backgroundImage:
            //                 NetworkImage(employeeImageUrl.toString()),
            //             child: Text(""),
            //           ),
            //           title: Text(employeename.toString()),
            //           subtitle: Text(isloggedOut
            //               ? "lastseen at ${lastLoggedIn?.replaceRange(0, 10, "")}"
            //               : "Online"),
            //           trailing: Container(
            //             width: size.width * 0.08,
            //             child: Row(
            //               children: [
            //                 chatAvatar(Icons.call),
            //                 space(),
            //                 InkWell(
            //                   child: chatAvatar(Icons.video_call_sharp),
            //                   onTap: () {
            //                     print("Please Connect");
            //                     createRoom();
            //                     // VideoCallFlutter(
            //                     //   cover_image: "assets/download.png",
            //                     //   controller: videoCallEditingController,
            //                     //   Heading: "Enter your code",
            //                     //   Button1: "Join",
            //                     //   Button2: "Share",
            //                     //   user_email: employeeemail.toString(),
            //                     //   video_Subject: "Video Call",
            //                     //   User_image: "assets/download.png",
            //                     //   User_name: currentUserID.toString(),
            //                     // );
            //                     print("video Connected");
            //                   },
            //                 ),
            //                 space(),
            //                 chatAvatar(Icons.more_vert_outlined),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       // Expanded(
            //       //   child: Container(
            //       //     child: StreamBuilder(
            //       //       stream: channel.stream,
            //       //       builder: (context, snapshot) {
            //       //         print('agagaga' + snapshot.data.toString());
            //       //         return Text(snapshot.hasData
            //       //             ? '${snapshot.data}'
            //       //             : 'no data found');
            //       //       },
            //       //     ),
            //       //   ),
            //       // ),
            //       _isTapped ? listview() : Expanded(flex: 1, child: SizedBox()),
            //       // Container(
            //       //   height: size.height * 0.06,
            //       //   decoration: BoxDecoration(
            //       //       color: fieldColor,
            //       //       // border: Border.all(color: AbgColor.withOpacity(0.5)),
            //       //       borderRadius: BorderRadius.circular(10.0)),
            //       //   child: Row(
            //       //     children: [
            //       //       Padding(
            //       //         padding: EdgeInsets.only(left: 20, right: 20),
            //       //         child: Container(
            //       //             // padding: EdgeInsets.only(left: 10),
            //       //             height: 25,
            //       //             width: 25,
            //       //             child: InkWell(
            //       //               child: Image.asset(
            //       //                 "Logos/attachLogo.png",
            //       //                 filterQuality: FilterQuality.high,
            //       //                 fit: BoxFit.fill,
            //       //                 color: AbgColor,
            //       //               ),
            //       //               onTap: () {
            //       //                 getFile();
            //       //               },
            //       //             )),
            //       //       ),
            //       //       Container(
            //       //         padding:
            //       //             EdgeInsets.only(top: 10, bottom: 10, right: 20),
            //       //         child: VerticalDivider(
            //       //           thickness: 2,
            //       //           color: AbgColor,
            //       //         ),
            //       //       ),
            //       //       Container(
            //       //         height: size.height * 0.4,
            //       //         width: size.width * 0.3,
            //       //         child: Center(
            //       //           child: TextFormField(
            //       //             keyboardType: TextInputType.text,
            //       //             //  autofocus: true,
            //       //             controller: _chatController,
            //       //             //  focusNode: focusNode,
            //       //             textCapitalization: TextCapitalization.sentences,
            //       //             textInputAction: TextInputAction.next,
            //       //             decoration: InputDecoration(
            //       //               border: InputBorder.none,
            //       //               hintText: "Type a message",
            //       //               hintStyle: TxtStls.fieldtitlestyle1,
            //       //             ),
            //       //             onFieldSubmitted: (_) {
            //       //               Provider.of<ChatProvider>(context,
            //       //                       listen: false)
            //       //                   .saveChatMessage(
            //       //                       _chatController.text,
            //       //                       currentuid.toString(),
            //       //                       peerUid.toString(),
            //       //                       DateTime.now()
            //       //                           .toString()
            //       //                           .substring(10, 16),
            //       //                       "source");
            //       //               setState(() {});
            //       //               // messageList.add(ChatModel(
            //       //               //         type: "source",
            //       //               //         content: _chatController.text,
            //       //               //         time: DateTime.now()
            //       //               //             .toString()
            //       //               //             .substring(10, 16),
            //       //               //         isFrom: currentuid,
            //       //               //         isTo: peerUid)
            //       //               //     .toJson());
            //       //               //    print(messageList.toString());
            //       //
            //       //               // if (_chatController.text.trim().isNotEmpty) {
            //       //               //   _chatController.clear();
            //       //               //   focusNode.requestFocus();
            //       //               //   Provider.of<ChatProvider>(context,
            //       //               //           listen: false)
            //       //               //       .saveChatMessage(
            //       //               //           _chatController.text,
            //       //               //           currentuid.toString(),
            //       //               //           peerUid.toString())
            //       //               //       .then((value) {});
            //       //               //
            //       //               //   setState(() {});
            //       //               // }
            //       //             },
            //       //           ),
            //       //         ),
            //       //       ),
            //       //       Expanded(
            //       //         child: SizedBox(),
            //       //       ),
            //       //       Padding(
            //       //         padding: const EdgeInsets.only(left: 20, right: 20),
            //       //         child: Container(
            //       //           child: Text(
            //       //             "😀",
            //       //             style: TextStyle(fontSize: 20),
            //       //           ),
            //       //         ),
            //       //       ),
            //       //       space(),
            //       //       Padding(
            //       //         padding: EdgeInsets.only(right: 20),
            //       //         child: IconButton(
            //       //           color: btnColor,
            //       //           icon: Icon(Icons.send_rounded),
            //       //           onPressed: () {
            //       //             // sendMessage(_chatController.text,
            //       //             //     currentuid.toString(), peerUid.toString());
            //       //             _chatController.clear();
            //       //             // onSendMessage(_chatController.text, true);
            //       //             // focusNode.requestFocus();
            //       //             // _chatController.clear();
            //       //             //    sendMessage(_chatController.text);
            //       //             // setState(() {
            //       //             //   messages.add(ChatModel(
            //       //             //   messages.add(ChatModel(
            //       //             //       isTo: cusname.toString(),
            //       //             //       isFrom: employee.toString(),
            //       //             //       type: useruid.toString() !=
            //       //             //               docID.toString()
            //       //             //           ? "receiver"
            //       //             //           : "sender",
            //       //             //       timestamp:
            //       //             //           DateTime.now().toString(),
            //       //             //       content:
            //       //             //           chatContent.toString(),
            //       //             //       currentUid:
            //       //             //           currentuid.toString(),
            //       //             //       peerid: docID.toString()));
            //       //             //   _chatController.clear();
            //       //             // });
            //       //           },
            //       //         ),
            //       //       ),
            //       //     ],
            //       //   ),
            //       // ),
            //       Container(
            //         height: size.height * 0.06,
            //         decoration: BoxDecoration(
            //             color: fieldColor,
            //             // border: Border.all(color: AbgColor.withOpacity(0.5)),
            //             borderRadius: BorderRadius.circular(10.0)),
            //         child: Row(
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.only(left: 20, right: 20),
            //               child: Container(
            //                   // padding: EdgeInsets.only(left: 10),
            //                   height: 25,
            //                   width: 25,
            //                   child: InkWell(
            //                     child: Image.asset(
            //                       "Logos/attachLogo.png",
            //                       filterQuality: FilterQuality.high,
            //                       fit: BoxFit.fill,
            //                       color: AbgColor,
            //                     ),
            //                     onTap: () {
            //                       getFile();
            //                     },
            //                   )),
            //             ),
            //             Container(
            //               padding:
            //                   EdgeInsets.only(top: 10, bottom: 10, right: 20),
            //               child: VerticalDivider(
            //                 thickness: 2,
            //                 color: AbgColor,
            //               ),
            //             ),
            //             Container(
            //               height: size.height * 0.4,
            //               width: size.width * 0.3,
            //               child: Center(
            //                 child: TextFormField(
            //                   autofocus: true,
            //                   focusNode: _focusNode,
            //                   controller: _chatController,
            //                   onFieldSubmitted: (val) {
            //                     onSendMessage(_chatController.text, "source");
            //                     //   submitMsg(val);
            //                   },
            //                   keyboardType: TextInputType.text,
            //                   style: TextStyle(
            //                     color: btnColor,
            //                     fontSize: 15.0,
            //                     fontWeight: FontWeight.w400,
            //                   ),
            //                   onChanged: (val) {
            //                     setState(() {
            //                       if (val.length == 0) {
            //                         if (_flagTyping) {
            //                           //   socketService.isTyping(false);
            //                           _flagTyping = false;
            //                         }
            //                       } else {
            //                         if (_flagTyping == false) {
            //                           //   socketService.isTyping(true);
            //                           _flagTyping = true;
            //                         }
            //                       }
            //                       chatContent = val.trim();
            //                     });
            //                   },
            //                   textAlign: TextAlign.start,
            //                   decoration: InputDecoration(
            //                     border: InputBorder.none,
            //                     hintText: "Type a message",
            //                     hintStyle: TxtStls.fieldtitlestyle1,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Expanded(
            //               flex: 1,
            //               child: SizedBox(),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(left: 20, right: 20),
            //               child: Container(
            //                 child: Text(
            //                   "😀",
            //                   style: TextStyle(fontSize: 20),
            //                 ),
            //               ),
            //             ),
            //             space(),
            //             Padding(
            //               padding: EdgeInsets.only(right: 20),
            //               child: IconButton(
            //                 color: btnColor,
            //                 icon: Icon(Icons.send_rounded),
            //                 onPressed: () {
            //                   _chatController.clear();
            //                   // });
            //                 },
            //               ),
            //             ),
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
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

  Widget listview() {
    return Expanded(
        flex: 1,
        child: SizedBox(
            child: Container(
                child: Provider.of<GetMessagesListProvider>(context,
                                listen: false)
                            .chatmodellist
                            .length <=
                        0
                    ? Expanded(
                        flex: 1,
                        child: Center(
                            child: Lottie.asset("assets/Lotties/empty.json")))
                    : StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Chats")
                            .doc(currentuid)
                            .collection("messages")
                            .where("isTo", isEqualTo: peerUid)
                            .orderBy("time", descending: false)
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            listMessage = snapshot.data!.docs;
                            print('[[[[' + listMessage.toString());
                            print('[[[[' + listMessage.length.toString());
                            if (listMessage.length > 0) {
                              return ListView.builder(
                                padding: EdgeInsets.all(10),
                                itemBuilder: (context, index) =>
                                    buildItem(index, snapshot.data),
                                itemCount: listMessage.length,
                                reverse: true,
                                controller: _scrollController,
                              );
                            } else {
                              return Center(
                                  child: Text("No message here yet..."));
                            }
                          } else {
                            return Center(
                              child: SpinKitFadingCube(
                                color: btnColor,
                              ),
                            );
                          }
                        },
                      ))));
  }

  // listMessage = snapshot.data.docs;
  // if (listMessage.length > 0) {
  //   return ListView.builder(
  //       controller: _scrollController,
  //       itemCount: snapshot.data.docs.length,
  //       reverse: true,
  //       // Provider.of<GetMessagesListProvider>(context,
  //       //         listen: false)
  //       //     .chatmodellist
  //       //     .length,
  //       scrollDirection: Axis.vertical,
  //       // controller: _scrollController,
  //       itemBuilder: (_, index) {
  //         return buildItem(
  //             index, snapshot.data?.docs[index]);
  //         // var data = Provider.of<GetMessagesListProvider>(
  //         //         context,
  //         //         listen: false)
  //         //     .chatmodellist[index];
  //         // if (data.isFrom == currentuid) {
  //         //   return OwnMessageCard(
  //         //       message: data.content ?? "",
  //         //       time: data.time ?? "");
  //         // } else {
  //         //   return ReplyCard(
  //         //       message: data.content ?? "",
  //         //       time: data.time ?? "");
  //         // }
  //       });
  // }
  //  })
  // :
  // : Container(
  //     child: Center(
  //         child: Text(
  //       "Say Hi....",
  //       style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  //     )),
  //   ),
  //     }

  //   Text(snapshot.data.docs[3]['time'].toString());
  // }),

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
    print('videocallresponse==' + response.toString());
  }

  void setMessage(String type, String message) {
    ChatModel messageModel = ChatModel(
        type: type,
        content: message,
        time: DateTime.now().toString().substring(10, 16),
        isFrom: currentuid,
        isTo: peerUid);
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }

  // void sendMessage(String message, String sourceId, String targetId) {
  //   setMessage("source", message);
  //   socket?.emit("message",
  //       {"message": message, "sourceId": sourceId, "targetId": targetId});
  // }
  void sendMessage(
      String content, String type, String currentUserId, String peerId) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Chats")
        .doc(currentuid)
        .collection("messages")
        .doc();

    ChatModel messageChat = ChatModel(
      isFrom: currentUserId,
      isTo: peerId,
      time: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      type: type,
    );

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }

  void onSendMessage(String content, String type) {
    if (content.trim().isNotEmpty) {
      _chatController.clear();
      sendMessage(content, type, currentuid.toString(), peerUid.toString());
      // _scrollController.animateTo(0,
      //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'NOTHING TO SHOW');
    }
  }

  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {
      ChatModel messageChat = ChatModel.fromDocument(document);
      if (messageChat.isFrom == currentuid) {
        // Right (my message)
        return Row(
          children: <Widget>[
            messageChat.type == TypeMessage.text
                // Text
                ? Container(
                    child: Text(
                      messageChat.content,
                      style: TextStyle(color: primaryColor),
                    ),
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration: BoxDecoration(
                        color: txtColor,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(
                        bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
                  )
                : messageChat.type == TypeMessage.image
                    // Image
                    ? Container(
                        child: OutlinedButton(
                          child: Material(
                            child: Image.network(
                              messageChat.content,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  decoration: BoxDecoration(
                                    color: txtColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: btnColor,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, object, stackTrace) {
                                return Material(
                                  child: Image.asset(
                                    'images/img_not_available.jpeg',
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                );
                              },
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            clipBehavior: Clip.hardEdge,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullPhotoPage(
                                  url: messageChat.content,
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(0))),
                        ),
                        margin: EdgeInsets.only(
                            bottom: isLastMessageRight(index) ? 20 : 10,
                            right: 10),
                      )
                    // Sticker
                    : Container(
                        child: Image.asset(
                          'images/${messageChat.content}.gif',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        margin: EdgeInsets.only(
                            bottom: isLastMessageRight(index) ? 20 : 10,
                            right: 10),
                      ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        );
      } else {
        // Left (peer message)
        return Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Material(
                          child: Image.network(
                            "peerAvatar",
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: btnColor,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, object, stackTrace) {
                              return Icon(
                                Icons.account_circle,
                                size: 35,
                                color: txtColor,
                              );
                            },
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          clipBehavior: Clip.hardEdge,
                        )
                      : Container(width: 35),
                  messageChat.type == TypeMessage.text
                      ? Container(
                          child: Text(
                            messageChat.content,
                            style: TextStyle(color: Colors.white),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          width: 200,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8)),
                          margin: EdgeInsets.only(left: 10),
                        )
                      : messageChat.type == TypeMessage.image
                          ? Container(
                              child: TextButton(
                                child: Material(
                                  child: Image.network(
                                    messageChat.content,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: txtColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        width: 200,
                                        height: 200,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: btnColor,
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, object, stackTrace) =>
                                            Material(
                                      child: Image.asset(
                                        'images/img_not_available.jpeg',
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullPhotoPage(
                                          url: messageChat.content),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(0))),
                              ),
                              margin: EdgeInsets.only(left: 10),
                            )
                          : Container(
                              child: Image.asset(
                                'images/${messageChat.content}.gif',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              margin: EdgeInsets.only(
                                  bottom: isLastMessageRight(index) ? 20 : 10,
                                  right: 10),
                            ),
                ],
              ),

              // Time
              isLastMessageLeft(index)
                  ? Container(
                      child: Text(
                        // messageChat.time,
                        DateFormat('dd MMM kk:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(messageChat.time.toString()))),
                        style: TextStyle(
                            color: txtColor,
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                      ),
                      margin: EdgeInsets.only(left: 50, top: 5, bottom: 5),
                    )
                  : SizedBox.shrink()
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: EdgeInsets.only(bottom: 10),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage[index - 1].get("isFrom") == currentuid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 && listMessage[index - 1].get("isFrom") != currentuid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
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
    RoomModel roomModel = RoomModel();
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
      setState(() {
        roomModal = roomModel;
      });
      // ChattingScreen(
      //   roomModel: roomModel,
      //   employeesModel: toChatUserModel,
      // );

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (ctx) => ChattingScreen(
      //               roomModel: roomModel,
      //               employeesModel: toChatUserModel,
      //             )));
    }
  }
}
