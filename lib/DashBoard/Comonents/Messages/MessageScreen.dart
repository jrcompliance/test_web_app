import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie%202.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Models/ChatModel.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/Models/UserModel2.dart';
import 'package:test_web_app/NewModels/ChattingScreen.dart';
import 'package:test_web_app/NewModels/MessageModel.dart';
import 'package:test_web_app/NewModels/RoomModel.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<ChatModel> messages = [];
  String? employee;
  String? currentuid;
  String? lastLoggedIn;
  String? lastLoggedOut;
  User? user = FirebaseAuth.instance.currentUser;
  EmployeesModel? logginUserModel;
  late var employeeModal;
  RoomModel roomModel = RoomModel();
  late var roomModal;

  String? peerid;
  getUserData() {
    FirebaseFirestore.instance
        .collection("EmployeeData")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.logginUserModel = EmployeesModel.fromMap(value.data());
    });
  }

  CollectionReference? chatsCollectionReference;
  @override
  void initState() {
    super.initState();
    getUserData();
    employeeModal = EmployeesModel();
    roomModal = RoomModel();
    // initializeSocket();

    Future.delayed(Duration(seconds: 2)).then((value) {
      Provider.of<UserDataProvider>(context, listen: false)
          .getEmployeesList(currentuid)
          .then((value) {
        allEmployees =
            Provider.of<UserDataProvider>(context, listen: false).employeelist;
      });
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  final TextEditingController _customersearchController =
      TextEditingController();
  final TextEditingController videoCallEditingController =
      TextEditingController();
  final TextEditingController _chatController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  List<EmployeesModel> allEmployees = [];
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.93,
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
                                          icon: const Icon(
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
                                      : const Icon(
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
                  const SizedBox(
                    height: 10,
                  ),
                  allEmployees.isEmpty
                      ? const Center(
                          child: SpinKitFadingCube(color: btnColor, size: 15),
                        )
                      : StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("EmployeeData")
                              .get()
                              .asStream(),
                          builder: (context, snapshot) {
                            return SizedBox(
                              height: size.height * 0.8,
                              child: ListView.separated(
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
                                            ? const NetworkImage(
                                                "https://cdn1.iconfinder.com/data/icons/bokbokstars-121-classic-stock-icons-1/512/person-man.png")
                                            : NetworkImage(employeeModel.uimage
                                                .toString()),
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
                                            employeeModel.uphoneNumber
                                                .toString(),
                                            style: TxtStls.fieldstyle,
                                          ),
                                        ],
                                      ),
                                      trailing: CircleAvatar(
                                        backgroundColor:
                                            btnColor.withOpacity(0.1),
                                      ),
                                      onTap: () {
                                        checkAndCreateNewRoom(employeeModel);
                                        setState(() {
                                          isTapped = true;
                                          peerid = employeeModel.uid;
                                          print('peerid==' + peerid.toString());
                                          employeeModal = employeeModel;
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
                              ),
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
            child: isTapped
                ? const SizedBox()
                : SizedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Lottie.asset("assets/Lotties/empty.json")),
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Select any Employee from list to Start Conversation ',
                                style: TxtStls.fieldBtnStyle,
                              )),
                        ],
                      ),
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

  String createRoomId(toChatUserModel) {
    // SmallId_LargeId
    String roomID = "";

    // print(
    //     "createRoomId ${user!.uid.hashCode} >> ${toChatUserModel.uid.hashCode} ");
    // print("createRoomId ${user!.uid} >> ${toChatUserModel.uid} ");
    if (user!.uid.hashCode > toChatUserModel.uid.hashCode) {
      roomID = toChatUserModel.uid! + "_" + user!.uid;
    } else if (user!.uid.hashCode < toChatUserModel.uid.hashCode) {
      roomID = user!.uid + "_" + toChatUserModel.uid.toString();
    } else {
      roomID = user!.uid + "_" + toChatUserModel.uid.toString();
    }

    print("createdRoomId @$roomID");

    return roomID;
  }

  Widget chatWidget(BuildContext context) {
    return ChattingScreen(
        roomModel: roomModel, employeesModel: employeeModal, isTapped: true);
  }

  checkAndCreateNewRoom(toChatUserModel) async {
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
    if (roomModel.roomId != null) {
      print('room available');

      //   return ChattingScree
      //       roomModel: roomModel, employeesModel: toChatUserModel);

      // setState(() {
      //   roomModal = roomModel;
      // });
      // print('roooom' + roomModel.roomId.toString());
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       Size size = MediaQuery.of(context).size;
      //       return AlertDialog(
      //         content: Container(
      //           height: size.height * 0.2,
      //           width: size.width * 0.2,
      //           child: Column(
      //             children: [
      //               Text('Do you want to proceed'),
      //               SizedBox(
      //                 height: 10,
      //               ),
      //               Row(
      //                 children: [
      //                   Row(
      //                     children: [
      //                       ElevatedButton(
      //                         child: Text("Yes"),
      //                         onPressed: () {
      //                           Future.delayed(Duration(seconds: 1))
      //                               .then((value) {
      //                             Navigator.pop(context);
      //                           }).then((value) => ChattingScreen(
      //                                     roomModel: roomModel,
      //                                     employeesModel: toChatUserModel,
      //                                   ));
      //                         },
      //                       ),
      //                       SizedBox(
      //                         width: 10,
      //                       ),
      //                       ElevatedButton(
      //                         child: Text("No"),
      //                         onPressed: () {
      //                           Navigator.pop(context);
      //                         },
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               )
      //             ],
      //           ),
      //         ),
      //       );
      //     });

      var value = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => ChattingScreen(
                    roomModel: roomModel,
                    employeesModel: toChatUserModel,
                    isTapped: true,
                  )));

      setState(() {
        isTapped = value;
      });
      // return ChattingScreen(
      //     roomModel: roomModel, employeesModel: toChatUserModel);
      // } else {
      //   print('room not available');
      //   return Container();
    }
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
  // Widget dialogAction(text,roomModel,employeesModel,tru){
  //   return  ElevatedButton(
  //     child: Text(text),
  //     onPressed: ()  {
  //       if(text == "yes"){
  //         return ChattingScreen(roomModel: roomModel, employeesModel: employeesModel, isTapped: tru,);
  //       } else return null;
  //     },
  //   );
  // }
}
