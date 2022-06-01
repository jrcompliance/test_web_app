// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test_web_app/PracticeProviders/Providers/FakeProvider.dart';
//
// class FakeScreen extends StatefulWidget {
//   const FakeScreen({Key? key}) : super(key: key);
//
//   @override
//   _FakeScreenState createState() => _FakeScreenState();
// }
//
// class _FakeScreenState extends State<FakeScreen> {
//   @override
//   void initState() {
//     Provider.of<FakeProvider>(context, listen: false).getData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var mylist =
//         Provider.of<FakeProvider>(context, listen: false).fakemodellist;
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: mylist.length,
//         itemBuilder: (BuildContext context, int i) {
//           return ListTile(
//             title: Text(mylist[i].title.toString()),
//             subtitle: Text(mylist[i].body.toString()),
//           );
//         },
//       ),
//     );
//   }
// }
