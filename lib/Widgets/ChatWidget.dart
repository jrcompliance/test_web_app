// import 'package:flutter/material.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';
// import 'package:test_web_app/Models/UserModel2.dart';
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   late final StreamChatClient client;
//
//   /// The channel we'd like to observe and participate.
//   late final Channel channel;
//   @override
//   void initState() async {
//     super.initState();
//   //  chatAuth();
//     client = StreamChatClient(
//       'b67pax5b2wdq',
//       logLevel: Level.INFO,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final themeData = ThemeData(primarySwatch: Colors.green);
//     final defaultTheme = StreamChatThemeData.fromTheme(themeData);
//     final colorTheme = defaultTheme.colorTheme;
//     final customTheme = defaultTheme.merge(StreamChatThemeData(
//       channelPreviewTheme: StreamChannelPreviewThemeData(
//         avatarTheme: StreamAvatarThemeData(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       otherMessageTheme: StreamMessageThemeData(
//         messageBackgroundColor: colorTheme.textHighEmphasis,
//         messageTextStyle: TextStyle(
//           color: colorTheme.barsBg,
//         ),
//         avatarTheme: StreamAvatarThemeData(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     ));
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: themeData,
//       builder: (context, child) => StreamChat(
//         client: client,
//         streamChatThemeData: customTheme,
//         child: child,
//       ),
//       home: StreamChannel(
//         channel: channel,
//         child: Container(
//           height: size.height * 0.6,
//           child: Scaffold(
//             appBar: StreamChannelHeader(
//               title: Text(employeename.toString()),
//               subtitle: Text("lastseen at"),
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                   child: StreamMessageListView(
//                     messageBuilder: _messageBuilder,
//                   ),
//                 ),
//                 Container(child: StreamMessageInput()),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _messageBuilder(
//     BuildContext context,
//     MessageDetails details,
//     List<Message> messages,
//     StreamMessageWidget defaultMessageWidget,
//   ) {
//     final message = details.message;
//     final isCurrentUser =
//         StreamChat.of(context).currentUser!.id == message.user!.id;
//     final textAlign = isCurrentUser ? TextAlign.right : TextAlign.left;
//     final color = isCurrentUser ? Colors.blueGrey : Colors.blue;
//
//     return Padding(
//       padding: EdgeInsets.all(5),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: color,
//           ),
//           borderRadius: const BorderRadius.all(
//             Radius.circular(5),
//           ),
//         ),
//         child: ListTile(
//           title: Text(
//             message.text!,
//             textAlign: textAlign,
//           ),
//           subtitle: Text(
//             message.user!.name,
//             textAlign: textAlign,
//           ),
//         ),
//       ),
//     );
//   }
//
// //   chatAuth() async {
// //     final  client = StreamChat.getInstance("dz5f4d5kzrue");
// //     await client.connectUSer({
// //       id: "rapid-poetry-2",
// //       name: "rapid",
// //       image: "https://bit.ly/2u9Vc0r",
// //     }, "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoicmFwaWQtcG9ldHJ5LTIiLCJleHAiOjE2NTMzMTExOTF9.qmZLG7rzkX4Xa1SYkXVcw5l_R55GjBZYz0ayAAFS4jQ"); // token generated server side
// //     return client;
// // }
