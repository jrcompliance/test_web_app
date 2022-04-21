// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class ToastMessage extends StatelessWidget {
//   const ToastMessage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
//
//   _showToast() {
//     Widget toast = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25.0),
//         color: Colors.greenAccent,
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.check),
//           SizedBox(
//             width: 12.0,
//           ),
//           Text("This is a Custom Toast"),
//         ],
//       ),
//     );
//
//     fToast.showToast(
//       child: toast,
//       gravity: ToastGravity.BOTTOM,
//       toastDuration: Duration(seconds: 2),
//     );
//
//     // Custom Toast Position
//     fToast.showToast(
//         child: toast,
//         toastDuration: Duration(seconds: 2),
//         positionedToastBuilder: (context, child) {
//           return Positioned(
//             child: child,
//             top: 16.0,
//             left: 16.0,
//           );
//         });
//   }
// }
