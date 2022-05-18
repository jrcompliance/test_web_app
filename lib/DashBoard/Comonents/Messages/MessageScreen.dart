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
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
import 'package:video_call_flutter/video_call_flutter.dart';
import 'package:http/http.dart' as http;

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  File? imageFile;
  late FocusNode focusNode;
  bool isLoading = false;
  List<ChatModel> messages = [];
  bool isLogggedIn = false;
  ScrollController _scrollController = ScrollController();
  String? employee;
  String? currentuid;
  String? lastLoggedIn;

  // var currentUser;

  bool filePicked = false;

  var fileName;
  String? currentUserID;
  String? peerId;
  var chatDocID;

  late IO.Socket socket;

  bool sendByMe = false;

  bool sendButton = false;

  @override
  void initState() {
    super.initState();
    focusNode = new FocusNode();
    focusNode.addListener(
        () => print('focusNode updated: hasFocus: ${focusNode.hasFocus}'));
    Future.delayed(Duration(seconds: 2)).then((value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      currentuid = pref.getString("uid");
      lastLoggedIn = pref.getString("lastSeen");
      print("@" + lastLoggedIn.toString());
    });

    Future.delayed(Duration(seconds: 2)).then((value) {
      Provider.of<UserDataProvider>(context, listen: false)
          .getEmployeesList(currentuid)
          .then((value) {
        allEmployees =
            Provider.of<UserDataProvider>(context, listen: false).employeelist;
      });
    });
    // socket = IO.io(
    //     'http://localhost:4000',
    //     IO.OptionBuilder()
    //         .setTransports(['websocket']) // for Flutter or Dart VM
    //         .disableAutoConnect() // disable auto-connection
    //         .setExtraHeaders({'foo': 'bar'}) // optional
    //         .build());
    // socket.connect();
    // connect();
  }

  @override
  void dispose() {
    focusNode.dispose();
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
                  Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(employeeImageUrl.toString()),
                        child: Text(""),
                      ),
                      title: Text(employeename.toString()),
                      subtitle: Text(
                          "lastseen at ${lastLoggedIn?.replaceRange(0, 10, "")}"),
                      trailing: Container(
                        width: size.width * 0.08,
                        child: Row(
                          children: [
                            chatAvatar(Icons.call),
                            space(),
                            InkWell(
                              child: chatAvatar(Icons.video_call_sharp),
                              onTap: () {
                                print("Please Connect");
                                createRoom();
                                // VideoCallFlutter(
                                //   cover_image: "assets/download.png",
                                //   controller: videoCallEditingController,
                                //   Heading: "Enter your code",
                                //   Button1: "Join",
                                //   Button2: "Share",
                                //   user_email: employeeemail.toString(),
                                //   video_Subject: "Video Call",
                                //   User_image: "assets/download.png",
                                //   User_name: currentUserID.toString(),
                                // );
                                print("video Connected");
                              },
                            ),
                            space(),
                            chatAvatar(Icons.more_vert_outlined),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  _isTapped ? listview() : Expanded(child: SizedBox()),
                  Container(
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                        color: fieldColor,
                        // border: Border.all(color: AbgColor.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                              // padding: EdgeInsets.only(left: 10),
                              height: 25,
                              width: 25,
                              child: InkWell(
                                child: Image.asset(
                                  "Logos/attachLogo.png",
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.fill,
                                  color: AbgColor,
                                ),
                                onTap: () {
                                  getFile();
                                },
                              )),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 10, right: 20),
                          child: VerticalDivider(
                            thickness: 2,
                            color: AbgColor,
                          ),
                        ),
                        Container(
                          height: size.height * 0.4,
                          width: size.width * 0.3,
                          child: Center(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              //  autofocus: true,
                              controller: _chatController,
                              focusNode: focusNode,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.send,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message",
                                hintStyle: TxtStls.fieldtitlestyle1,
                              ),
                              // onChanged: (value) {
                              //   setState(() {
                              //     _chatController.text = value;
                              //   });
                              // },
                              onSubmitted: (_) {
                                focusNode.requestFocus();
                                if (_chatController.text.trim().isNotEmpty) {
                                  Provider.of<ChatProvider>(context,
                                          listen: false)
                                      .saveChatMessage(
                                          _chatController.text,
                                          currentuid.toString(),
                                          peerUid.toString());
                                  _chatController.clear();
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            child: Text(
                              "😀",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        space(),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: IconButton(
                            color: btnColor,
                            icon: Icon(Icons.send_rounded),
                            onPressed: () {
                              // onSendMessage(_chatController.text, true);
                              // focusNode.requestFocus();
                              // _chatController.clear();
                              //    sendMessage(_chatController.text);
                              // setState(() {
                              //   messages.add(ChatModel(
                              //       isTo: cusname.toString(),
                              //       isFrom: employee.toString(),
                              //       type: useruid.toString() !=
                              //               docID.toString()
                              //           ? "receiver"
                              //           : "sender",
                              //       timestamp:
                              //           DateTime.now().toString(),
                              //       content:
                              //           chatContent.toString(),
                              //       currentUid:
                              //           currentuid.toString(),
                              //       peerid: docID.toString()));
                              //   _chatController.clear();
                              // });
                            },
                          ),
                        ),
                      ],
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

  // onSendMessage(String content,String type) {
  //     if (content.trim().isNotEmpty) {
  //       ChatProvider chatProvider = ChatProvider();
  //       _chatController.clear();
  //       chatProvider.sendChatMessage(
  //           content, type, groupChatId, currentUserId, peerId);
  //       scrollController.animateTo(0,
  //           duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  //     } else {
  //       toastmessage.warningmessage(context, 'Nothing to send');
  //     }
  //   }

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

// checking if sent message
//   bool isMessageSent(int index) {
//     if ((index > 0 && listMessages[index - 1].get("isFrom") != currentUserId) ||
//         index == 0) {
//       return true;
//     } else {
//       return false;
//     }
//   }

  // checking if received message
  // bool isMessageReceived(int index) {
  //   if ((index > 0 && listMessages[index - 1].get("isFrom") == currentUserId) ||
  //       index == 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  void onSendMessage(String content, bool sendButtton) {
    if (content.trim().isNotEmpty) {
      Provider.of<ChatProvider>(context, listen: false).saveChatMessage(
          _chatController.text, currentuid.toString(), peerUid.toString());
      _chatController.clear();
      if (currentuid != peerUid) {
        setState(() {
          sendByMe = true;
        });
      } else {
        setState(() {
          sendByMe = false;
        });
      }
    }
  }
  // ChatProvider.sendChatMessage(
  // scrollController.animateTo(0,
  //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

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

  // void uploadImageFile() async {
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   UploadTask uploadTask = ChatProvider.uploadImageFile(imageFile!, fileName);
  //   try {
  //     TaskSnapshot snapshot = await uploadTask;
  //     imageUrl = await snapshot.ref.getDownloadURL();
  //     setState(() {
  //       isLoading = false;
  //       onSendMessage(imageUrl, MessageType.image);
  //     });
  //   } on FirebaseException catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(msg: e.message ?? e.toString());
  //   }
  // }

  Widget buildMessageInput() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          // Container(
          //   margin: const EdgeInsets.only(right: Sizes.dimen_4),
          //   decoration: BoxDecoration(
          //     color: AppColors.burgundy,
          //     borderRadius: BorderRadius.circular(Sizes.dimen_30),
          //   ),
          //   child: IconButton(
          //     onPressed: getImage,
          //     icon: const Icon(
          //       Icons.camera_alt,
          //       size: Sizes.dimen_28,
          //     ),
          //     color: AppColors.white,
          //   ),
          // ),
          // Flexible(
          //     child: TextField(
          //   focusNode: focusNode,
          //   textInputAction: TextInputAction.send,
          //   keyboardType: TextInputType.text,
          //   textCapitalization: TextCapitalization.sentences,
          //   controller: textEditingController,
          //   decoration:
          //       kTextInputDecoration.copyWith(hintText: 'write here...'),
          //   onSubmitted: (value) {
          //     onSendMessage(_chatController.text, MessageType.text);
          //   },
          // )),
          // Container(
          //   margin: const EdgeInsets.only(left: Sizes.dimen_4),
          //   decoration: BoxDecoration(
          //     color: AppColors.burgundy,
          //     borderRadius: BorderRadius.circular(Sizes.dimen_30),
          //   ),
          //   child: IconButton(
          //     onPressed: () {
          //       onSendMessage(textEditingController.text, MessageType.text);
          //     },
          //     icon: const Icon(Icons.send_rounded),
          //     color: AppColors.white,
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget buildItem(int index, DocumentSnapshot? documentSnapshot) {
  //   if (documentSnapshot != null) {
  //     ChatModel chatMessages = ChatModel.fromDocument(documentSnapshot);
  //     if (chatMessages.isFrom == currentUserId) {
  //       // right side (my message)
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.end,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               chatMessages.type == MessageType.text
  //                   ? messageBubble(
  //                       chatContent: chatMessages.content,
  //                       color: AppColors.spaceLight,
  //                       textColor: AppColors.white,
  //                       margin: EdgeInsets.only(right: Sizes.dimen_10),
  //                     )
  //                   : chatMessages.type == MessageType.image
  //                       ? Container(
  //                           margin: const EdgeInsets.only(
  //                               right: Sizes.dimen_10, top: Sizes.dimen_10),
  //                           child: chatImage(
  //                               imageSrc: chatMessages.content, onTap: () {}),
  //                         )
  //                       : const SizedBox.shrink(),
  //               isMessageSent(index)
  //                   ? Container(
  //                       clipBehavior: Clip.hardEdge,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(Sizes.dimen_20),
  //                       ),
  //                       child: Image.network(
  //                         widget.userAvatar,
  //                         width: Sizes.dimen_40,
  //                         height: Sizes.dimen_40,
  //                         fit: BoxFit.cover,
  //                         loadingBuilder: (BuildContext ctx, Widget child,
  //                             ImageChunkEvent? loadingProgress) {
  //                           if (loadingProgress == null) return child;
  //                           return Center(
  //                             child: CircularProgressIndicator(
  //                               color: AppColors.burgundy,
  //                               value: loadingProgress.expectedTotalBytes !=
  //                                           null &&
  //                                       loadingProgress.expectedTotalBytes !=
  //                                           null
  //                                   ? loadingProgress.cumulativeBytesLoaded /
  //                                       loadingProgress.expectedTotalBytes!
  //                                   : null,
  //                             ),
  //                           );
  //                         },
  //                         errorBuilder: (context, object, stackTrace) {
  //                           return const Icon(
  //                             Icons.account_circle,
  //                             size: 35,
  //                             color: AppColors.greyColor,
  //                           );
  //                         },
  //                       ),
  //                     )
  //                   : Container(
  //                       width: 35,
  //                     ),
  //             ],
  //           ),
  //           isMessageSent(index)
  //               ? Container(
  //                   margin: const EdgeInsets.only(
  //                       right: Sizes.dimen_50,
  //                       top: Sizes.dimen_6,
  //                       bottom: Sizes.dimen_8),
  //                   child: Text(
  //                     DateFormat('dd MMM yyyy, hh:mm a').format(
  //                       DateTime.fromMillisecondsSinceEpoch(
  //                         int.parse(chatMessages.timestamp),
  //                       ),
  //                     ),
  //                     style: const TextStyle(
  //                         color: AppColors.lightGrey,
  //                         fontSize: Sizes.dimen_12,
  //                         fontStyle: FontStyle.italic),
  //                   ),
  //                 )
  //               : const SizedBox.shrink(),
  //         ],
  //       );
  //     } else {
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               isMessageReceived(index)
  //                   // left side (received message)
  //                   ? Container(
  //                       clipBehavior: Clip.hardEdge,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(Sizes.dimen_20),
  //                       ),
  //                       child: Image.network(
  //                         widget.peerAvatar,
  //                         width: Sizes.dimen_40,
  //                         height: Sizes.dimen_40,
  //                         fit: BoxFit.cover,
  //                         loadingBuilder: (BuildContext ctx, Widget child,
  //                             ImageChunkEvent? loadingProgress) {
  //                           if (loadingProgress == null) return child;
  //                           return Center(
  //                             child: CircularProgressIndicator(
  //                               color: AppColors.burgundy,
  //                               value: loadingProgress.expectedTotalBytes !=
  //                                           null &&
  //                                       loadingProgress.expectedTotalBytes !=
  //                                           null
  //                                   ? loadingProgress.cumulativeBytesLoaded /
  //                                       loadingProgress.expectedTotalBytes!
  //                                   : null,
  //                             ),
  //                           );
  //                         },
  //                         errorBuilder: (context, object, stackTrace) {
  //                           return const Icon(
  //                             Icons.account_circle,
  //                             size: 35,
  //                             color: AppColors.greyColor,
  //                           );
  //                         },
  //                       ),
  //                     )
  //                   : Container(
  //                       width: 35,
  //                     ),
  //               chatMessages.type == MessageType.text
  //                   ? messageBubble(
  //                       color: AppColors.burgundy,
  //                       textColor: AppColors.white,
  //                       chatContent: chatMessages.content,
  //                       margin: const EdgeInsets.only(left: Sizes.dimen_10),
  //                     )
  //                   : chatMessages.type == MessageType.image
  //                       ? Container(
  //                           margin: const EdgeInsets.only(
  //                               left: Sizes.dimen_10, top: Sizes.dimen_10),
  //                           child: chatImage(
  //                               imageSrc: chatMessages.content, onTap: () {}),
  //                         )
  //                       : const SizedBox.shrink(),
  //             ],
  //           ),
  //           isMessageReceived(index)
  //               ? Container(
  //                   margin: const EdgeInsets.only(
  //                       left: Sizes.dimen_50,
  //                       top: Sizes.dimen_6,
  //                       bottom: Sizes.dimen_8),
  //                   child: Text(
  //                     DateFormat('dd MMM yyyy, hh:mm a').format(
  //                       DateTime.fromMillisecondsSinceEpoch(
  //                         int.parse(chatMessages.timestamp),
  //                       ),
  //                     ),
  //                     style: const TextStyle(
  //                         color: AppColors.lightGrey,
  //                         fontSize: Sizes.dimen_12,
  //                         fontStyle: FontStyle.italic),
  //                   ),
  //                 )
  //               : const SizedBox.shrink(),
  //         ],
  //       );
  //     }
  //   } else {
  //     return const SizedBox.shrink();
  //   }
  // }

  // Widget buildListMessage() {
  //   return Flexible(
  //     child: groupChatId.isNotEmpty
  //         ? StreamBuilder<QuerySnapshot>(
  //             stream: ChatProvider.getChatMessage(groupChatId, _limit),
  //             builder: (BuildContext context,
  //                 AsyncSnapshot<QuerySnapshot> snapshot) {
  //               if (snapshot.hasData) {
  //                 listMessages = snapshot.data!.docs;
  //                 if (listMessages.isNotEmpty) {
  //                   return ListView.builder(
  //                       padding: const EdgeInsets.all(10),
  //                       itemCount: snapshot.data?.docs.length,
  //                       reverse: true,
  //                       controller: scrollController,
  //                       itemBuilder: (context, index) =>
  //                           buildItem(index, snapshot.data?.docs[index]));
  //                 } else {
  //                   return const Center(
  //                     child: Text('No messages...'),
  //                   );
  //                 }
  //               } else {
  //                 return const Center(
  //                   child: CircularProgressIndicator(
  //                     color: AppColors.burgundy,
  //                   ),
  //                 );
  //               }
  //             })
  //         : const Center(
  //             child: CircularProgressIndicator(
  //               color: AppColors.burgundy,
  //             ),
  //           ),
  //   );
  // }
  Widget listview() {
    print("njjkasdjna");
    return Expanded(
      child: SizedBox(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: getChatMessage(),
              builder: (context, AsyncSnapshot snapshot) {
                var data = snapshot.data!.docs;
                print("deedfwe");
                print('qqqqqq' + data.toString());
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    itemBuilder: (_, index) {
                      var data1 = snapshot.data!.docs[index];
                      if (!snapshot.hasData) {
                        return Center(child: SpinKitFadingCube());
                      }
                      if (snapshot.data!.docs.length == 0) {
                        return Center(
                          child: Text("No data found"),
                        );
                      }
                      if (currentuid != peerUid) {
                        return OwnMessageCard(
                            message: data1["message"] ?? "",
                            time: data1["time"] ?? "");
                      } else {
                        return ReplyCard(
                            message: data1["message"] ?? "",
                            time: data1["time"] ?? "");
                      }
                    });
              }),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getChatMessage() {
    return FirebaseFirestore.instance
        .collection("Chats")
        .where("isTo", isEqualTo: peerUid)
        .where("isFrom", isEqualTo: currentuid)
        // .orderBy("time", descending: true)
        .snapshots();
  }

  void setFocus() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  createRoom() {
    String url =
        "https://yalagala.whereby.com/0af4d394-e401-4409-89fa-54ea8aedf4d8";

    var response = http.get(Uri.parse(url));
    print(response.toString());
  }
  // Stream<QuerySnapshot<Object?>> qry(cat) {
  //   final userdata = Provider.of<UserDataProvider>(context);
  //   if (newfilter != null) {
  //     return FirebaseFirestore.instance
  //         .collection("Tasks")
  //         .where("Attachments", arrayContainsAny: [
  //       {
  //         "image": userdata.imageUrl,
  //         "uid": _auth.currentUser!.uid.toString(),
  //       }
  //     ])
  //         .where("cat", isEqualTo: cat)
  //         .where("status", isEqualTo: newfilter)
  //         .snapshots();
  //   }
  //   return FirebaseFirestore.instance
  //       .collection("Tasks")
  //       .where("Attachments", arrayContainsAny: [
  //     {
  //       "image": userdata.imageUrl,
  //       "uid": _auth.currentUser!.uid.toString(),
  //     }
  //   ])
  //       .where("cat", isEqualTo: cat)
  //       .snapshots();
  // }
}
