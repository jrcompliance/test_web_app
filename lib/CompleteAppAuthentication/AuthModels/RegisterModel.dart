class RegisterModel {
  String? fcmtoken;
  bool? TCPB;
  String? add;
  String? bgroup;
  String? doj;
  String? econtact;
  String? gender;
  String? password;
  String? udesignation;
  String? uemail;
  String? uid;
  String? uimage;
  String? uname;
  String? uphoneNumber;
  String? urole;

  RegisterModel(
      {this.fcmtoken,
      this.TCPB,
      this.add,
      this.bgroup,
      this.doj,
      this.econtact,
      this.gender,
      this.password,
      this.udesignation,
      this.uemail,
      this.uid,
      this.uimage,
      this.uname,
      this.uphoneNumber,
      this.urole});

  toMap() {
    return {
      "fcmtoken": fcmtoken,
      "TCPB": TCPB,
      "add": add,
      "bgroup": bgroup,
      "doj": doj,
      "econtact": econtact,
      "gender": gender,
      "password": password,
      "udesignation": udesignation,
      "uemail": uemail,
      "uid": uid,
      "uimage": uimage,
      "uname": uname,
      "uphoneNumber": uphoneNumber,
      "urole": urole
    };
  }
}
