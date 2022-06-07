import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeesModel {
  String? fcmtoken;
  String? add;
  String? bgroup;
  String? doj;
  String? econtact;
  String? gender;
  String? udesignation;
  String? uname;
  String? uemail;
  String? uphoneNumber;
  String? uimage;
  String? urole;
  String? uid;
  int? eid;
  var timeStamp;
  EmployeesModel(
      {this.add,
      this.uid,
      this.uname,
      this.uemail,
      this.uimage,
      this.eid,
      this.uphoneNumber,
      this.udesignation,
      this.econtact,
      this.bgroup,
      this.fcmtoken,
      this.gender,
      this.doj,
      this.urole,
      this.timeStamp});

  factory EmployeesModel.fromMap(map) {
    return EmployeesModel(
      add: map['add'],
      uid: map['uid'],
      uname: map['uname'],
      uemail: map['uemail'],
      uimage: map['uimage'],
      eid: map['eid'],
      uphoneNumber: map['uphoneNumber'],
      udesignation: map['udesignation'],
      econtact: map['econtact'],
      bgroup: map['bgroup'],
      fcmtoken: map['fcmtoken'],
      gender: map['gender'],
      doj: map['doj'],
      urole: map['urole'],
      // timeStamp: map['timeStamp']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'add': add,
      'uid': uid,
      'uname': uname,
      'uemail': uemail,
      'uimage': uimage,
      'eid': eid,
      'uphoneNumber': uphoneNumber,
      'udesignation': udesignation,
      'econtact': econtact,
      'bgroup': bgroup,
      'fcmtoken': fcmtoken,
      'gender': gender,
      'doj': doj,
      'urole': urole,
      'timeStamp': FieldValue.serverTimestamp()
    };
  }
}
