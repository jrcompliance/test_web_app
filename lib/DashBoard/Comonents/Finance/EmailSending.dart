// import 'package:flutter/material.dart';
// import 'package:test_web_app/Constants/reusable.dart';
// import 'package:zefyrka/zefyrka.dart';
//
// class EmailSending extends StatefulWidget {
//   const EmailSending({Key? key}) : super(key: key);
//
//   @override
//   _EmailSendingState createState() => _EmailSendingState();
// }
//
// class _EmailSendingState extends State<EmailSending> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Align(
//                 alignment: Alignment.topRight,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: AbgColor.withOpacity(0.1),
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(
//                         12.0) //                 <--- border radius here
//                     ),
//                   ),
//                   child: TextButton(
//                     onPressed: () {},
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Cancel',
//                         style: TextStyle(
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )),
//             Text(
//               'Sending Window',
//               style: TxtStls.fieldtitlestyle11,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30.0, right: 30.0),
//               child: Text(
//                 'Recepient',
//                 style: TxtStls.fieldstyle,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20),
//                   child: Container(
//                     height: 60,
//                     width: 500,
//                     decoration: decoration(),
//                     //BoxDecoration
//                     // child: ListView.builder(
//                     //     scrollDirection: Axis.horizontal,
//                     //     itemCount: emaillist.length,
//                     //     itemBuilder: (context, index) {
//                     //       print('hjshfiuw' + emaillist.length.toString());
//                     //       print('hjshfiuw' + emaillist.toString());
//                     //       return Center(
//                     //         child: Row(
//                     //           children: [
//                     //             emaildeco(emaillist[index], index),
//                     //           ],
//                     //         ),
//                     //       );
//                     //     }),
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: emaillist
//                           .map(
//                             (e) => InkWell(
//                           child: Center(
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: AbgColor.withOpacity(0.2)),
//                                     color: Colors.red,
//                                     borderRadius:
//                                     BorderRadius.circular(12.0)),
//                                 child: Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(e.toString()),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(5.0),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             border: Border.all(
//                                                 color: AbgColor.withOpacity(
//                                                     0.2)),
//                                             borderRadius:
//                                             BorderRadius.circular(
//                                                 16.0)),
//                                         child: const Icon(
//                                           Icons.close,
//                                           size: 16.0,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )),
//                           ),
//                           onTap: () {
//                             emaillist.removeLast();
//                           },
//                         ),
//                       )
//                           .toSet()
//                           .toList(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 InkWell(
//                   child: CircleAvatar(
//                     backgroundColor: Colors.indigo,
//                     radius: 15,
//                     child: Icon(Icons.add),
//                   ),
//                   onTap: () {
//                     _showPopupMenu();
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30.0, right: 30.0),
//               child: Text(
//                 'Subject',
//                 style: TxtStls.fieldstyle,
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20),
//               child: Container(
//                 height: 50,
//                 width: 350,
//                 decoration: decoration(),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Text(
//                     _subjectController.text == null
//                         ? ""
//                         : _subjectController.text.toString(),
//                     style: TxtStls.fieldstyle,
//                   ),
//                 ), //BoxDecoration
//               ),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30.0, right: 30.0),
//               child: Text(
//                 'Standard',
//                 style: TxtStls.fieldstyle,
//               ),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20),
//               child: Material(
//                 color: AbgColor.withOpacity(0.2),
//                 //       // elevation: 1.0,
//                 borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                         height: size.height * 0.2,
//                         child: Material(
//                           color: AbgColor.withOpacity(0.2),
//                           child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ZefyrEditor(
//                                 controller: zefyrExclusionsController,
//                                 embedBuilder: (context, node) {
//                                   return Text(
//                                     exclusions,
//                                     style: TxtStls.fieldstyle,
//                                   );
//                                 },
//                               )),
//                         )),
//                     ZefyrToolbar.basic(controller: zefyrExclusionsController),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   BoxDecoration decoration() {
//     return BoxDecoration(
//       // color: Color(0XFF1485C9),
//       border: Border.all(
//           color: Colors.black,
//           width: 0.1,
//           style: BorderStyle.solid), //Border.all
//
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(10.0),
//         topRight: Radius.circular(10.0),
//         bottomLeft: Radius.circular(10.0),
//         bottomRight: Radius.circular(10.0),
//       ),
//       //BorderRadius.only
//       /************************************/
//       /* The BoxShadow widget  is here */
//       /************************************/
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey,
//           offset: const Offset(
//             1.0,
//             1.0,
//           ),
//           blurRadius: 1.0,
//           spreadRadius: 1.0,
//         ), //BoxShadow
//         BoxShadow(
//           color: Colors.white,
//           offset: const Offset(0.0, 0.0),
//           blurRadius: 1.0,
//           spreadRadius: 1.0,
//         ), //BoxShadow
//       ],
//     );
//   }
// }
