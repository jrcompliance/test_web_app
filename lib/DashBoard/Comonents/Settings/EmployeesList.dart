import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/Comonents/Settings/ChatsList.dart';
import 'package:test_web_app/Models/EmployeesModel.dart';
import 'package:test_web_app/NewModels/ChattingScreen.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';

import '../../../NewModels/RoomModel.dart';

class EmployeesList extends StatefulWidget {
  const EmployeesList({Key? key}) : super(key: key);

  @override
  _EmployeesListState createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  String? employee;
  String? peerid;
  String? currentuid;
  bool isTapped = false;
  List<EmployeesModel> allEmployees = [];
  User? user = FirebaseAuth.instance.currentUser;
  RoomModel roomModel = RoomModel();

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child:
          // allEmployees.length <= 0
          //     ? Center(
          //         child: SpinKitFadingCube(color: btnColor, size: 15),
          //       )
          //     :
          StreamBuilder<QuerySnapshot>(
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
                          EmployeesModel.fromMap(snapshot.data!.docs[i].data());
                      if (employeeModel.uid ==
                          FirebaseAuth.instance.currentUser!.uid) {
                        return Container();
                      }

                      //  var snp = allEmployees[i];
                      return Material(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: bgColor,
                        child: ListTile(
                          tileColor: grClr.withOpacity(0.1),
                          hoverColor: btnColor.withOpacity(0.2),
                          selectedColor: btnColor.withOpacity(0.2),
                          selectedTileColor: btnColor.withOpacity(0.2),
                          leading: CircleAvatar(
                            backgroundColor: btnColor.withOpacity(0.1),
                            backgroundImage: employeeModel.uimage.toString() ==
                                    null
                                ? NetworkImage(
                                    "https://cdn1.iconfinder.com/data/icons/bokbokstars-121-classic-stock-icons-1/512/person-man.png")
                                : NetworkImage(employeeModel.uimage.toString()),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            backgroundColor: btnColor.withOpacity(0.1),
                          ),
                          onTap: () {
                            //  checkAndCreateNewRoom(employeeModel);
                            setState(() {
                              isTapped = true;
                              peerid = employeeModel.uid;
                              print('peerid==' + peerid.toString());
                              // employeeModal = employeeModel;
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: grClr.withOpacity(0.5));
                    },
                  ),
                );
              }),
    );
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
              builder: (ctx) => ChatsList(
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
}
