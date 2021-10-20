// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class UserDatas {
//   static FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   static String uid = FirebaseAuth.instance.currentUser!.uid.toString();
//
//   static var email;
//   static var imageUrl;
//   static var usersname;
//   static var phone;
//
//   static Future<void> userdetails() async {
//     await _firestore
//         .collection("EmployeeData")
//         .where("uid", isEqualTo: uid)
//         .snapshots()
//         .listen((event) {
//       event.docs.forEach((element) {
//         //print(element.data());
//         usersname = element.data()["username"].toString();
//         email = element.data()["email"].toString();
//         phone = element.data()["phone"].toString();
//         imageUrl = element.data()["imageUrl"].toString();
//       });
//     });
//   }
// }
