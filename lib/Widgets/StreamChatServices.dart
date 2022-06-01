// import 'package:stream_chat_flutter/stream_chat_flutter.dart';
//
// class StreamChatServices {
//   static chatServicces() async {
//     final apiKey = "wtuy4by8fpf2";
//     final userToken =
//         "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic21hbGwtcGFwZXItMSJ9.uVkb5oZBeoDxvzINbb6g4WYxW4EGSc4xCPwnow2XuIs";
//
//     /// Create a new instance of [StreamChatClient] passing the apikey obtained from
//     /// your project dashboard.
//     final client = StreamChatClient(
//       's2dxdhpxd94g',
//       logLevel: Level.INFO,
//     );
//
//     /// Set the current user and connect the websocket.
//     /// In a production scenario, this should be done using a backend to generate
//     /// a user token using our server SDK.
//     /// Please see the following for more information:
//     /// https://getstream.io/chat/docs/ios_user_setup_and_tokens/
//     await client.connectUser(
//       User(id: 'super-band'),
//       userToken,
//     );
//     final channel = client.channel(
//       'messaging',
//       id: 'flutterdevs',
//       extraData: {
//         'name': 'Flutter devs',
//       },
//     );
//
//     await channel.watch();
//
//     final message = Message(
//       text:
//           'I told them I was pesca-pescatarian. Which is one who eats solely fish who eat other fish.',
//       extraData: {
//         'customField': '123',
//       },
//     );
//     await channel.sendMessage(message);
//   }
// }
