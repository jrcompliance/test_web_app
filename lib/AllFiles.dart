// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController editingController = TextEditingController();
//
//   final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
//   var items = [];
//
//   @override
//   void initState() {
//     items.addAll(duplicateItems);
//     super.initState();
//   }
//
//   void filterSearchResults(String query) {
//     List<String> dummySearchList = [];
//     dummySearchList.addAll(duplicateItems);
//     if (query.isNotEmpty) {
//       List<String> dummyListData = [];
//       dummySearchList.forEach((item) {
//         if (item.contains(query)) {
//           dummyListData.add(item);
//         }
//       });
//       setState(() {
//         items.clear();
//         items.addAll(dummyListData);
//       });
//       return;
//     } else {
//       setState(() {
//         items.clear();
//         items.addAll(duplicateItems);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("widget.title"),
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 onChanged: (value) {
//                   filterSearchResults(value);
//                 },
//                 controller: editingController,
//                 decoration: InputDecoration(
//                     labelText: "Search",
//                     hintText: "Search",
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('${items[index]}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // class APage extends StatefulWidget {
// //   const APage({Key? key}) : super(key: key);
// //
// //   @override
// //   _APageState createState() => _APageState();
// // }
// //
// // class _APageState extends State<APage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("ADMIN SIDE"),
// //       ),
// //       body: Container(
// //         width: MediaQuery.of(context).size.width * 1,
// //         height: MediaQuery.of(context).size.height * 1,
// //         color: txtColor,
// //         child: StreamBuilder(
// //           stream:
// //               FirebaseFirestore.instance.collection("EmployeeData").snapshots(),
// //           builder:
// //               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //             if (!snapshot.hasData) {
// //               return Container();
// //             }
// //             return ListView.builder(
// //               itemCount: snapshot.data!.docs.length,
// //               itemBuilder: (BuildContext context, index) {
// //                 return ListTile(
// //                   leading: ClipRRect(
// //                       borderRadius: BorderRadius.all(Radius.circular(40.0)),
// //                       child: Image.network(
// //                           snapshot.data!.docs[index]["imageUrl"])),
// //                   title: Text(snapshot.data!.docs[index]["username"]),
// //                   onTap: () {
// //                     login(snapshot.data!.docs[index]["email"],
// //                         snapshot.data!.docs[index]["password"]);
// //                   },
// //                 );
// //               },
// //             );
// //           },
// //         ),
// //       ),
// //     );
// // class SearchListExample extends StatefulWidget {
// //   @override
// //   _SearchListExampleState createState() => new _SearchListExampleState();
// // }
// //
// // class _SearchListExampleState extends State<SearchListExample> {
// //   Widget appBarTitle = new Text(
// //     "Search Example",
// //     style: new TextStyle(color: Colors.white),
// //   );
// //   Icon icon = new Icon(
// //     Icons.search,
// //     color: Colors.white,
// //   );
// //   final globalKey = new GlobalKey<ScaffoldState>();
// //   final TextEditingController _controller = new TextEditingController();
// //   List<TaskSearchModel> _searchlistt = [];
// //   bool _isSearching = false;
// //   String _searchText = "";
// //   List searchresult = [];
// //
// //   _SearchListExampleState() {
// //     _controller.addListener(() {
// //       if (_controller.text.isEmpty) {
// //         setState(() {
// //           _isSearching = false;
// //           _searchText = "";
// //         });
// //       } else {
// //         setState(() {
// //           _isSearching = true;
// //           _searchText = _controller.text;
// //         });
// //       }
// //     });
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _isSearching = false;
// //     assignvel();
// //   }
// //
// //   void values() {
// //     _searchlistt;
// //   }
// //
// //   void _handleSearchStart() {
// //     setState(() {
// //       _isSearching = true;
// //     });
// //   }
// //
// //   void _handleSearchEnd() {
// //     setState(() {
// //       this.icon = new Icon(
// //         Icons.search,
// //         color: Colors.white,
// //       );
// //       this.appBarTitle = new Text(
// //         "Search Sample",
// //         style: new TextStyle(color: Colors.white),
// //       );
// //       _isSearching = false;
// //       _controller.clear();
// //     });
// //   }
// //
// //   void searchOperation(String searchText) {
// //     searchresult.clear();
// //     if (_isSearching != null) {
// //       for (int i = 0; i < _searchlistt.length; i++) {
// //         String data = _searchlistt[i].taskname as String;
// //         if (data.toLowerCase().contains(searchText.toLowerCase())) {
// //           searchresult.add(data);
// //         }
// //       }
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return new Scaffold(
// //         key: globalKey,
// //         appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
// //           new IconButton(
// //             icon: icon,
// //             onPressed: () {
// //               setState(() {
// //                 if (this.icon.icon == Icons.search) {
// //                   this.icon = new Icon(
// //                     Icons.close,
// //                     color: Colors.white,
// //                   );
// //                   this.appBarTitle = new TextField(
// //                     controller: _controller,
// //                     style: new TextStyle(
// //                       color: Colors.white,
// //                     ),
// //                     decoration: new InputDecoration(
// //                         prefixIcon: new Icon(Icons.search, color: Colors.white),
// //                         hintText: "Search...",
// //                         hintStyle: new TextStyle(color: Colors.white)),
// //                     onChanged: searchOperation,
// //                   );
// //                   _handleSearchStart();
// //                 } else {
// //                   _handleSearchEnd();
// //                 }
// //               });
// //             },
// //           ),
// //         ]),
// //         body: new Container(
// //           child: new Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.min,
// //             children: <Widget>[
// //               new Flexible(
// //                   child: searchresult.length != 0 || _controller.text.isNotEmpty
// //                       ? new ListView.builder(
// //                           shrinkWrap: true,
// //                           itemCount: searchresult.length,
// //                           itemBuilder: (BuildContext context, int index) {
// //                             String listData = searchresult[index];
// //                             return new ListTile(
// //                               title: new Text(listData.toString()),
// //                             );
// //                           },
// //                         )
// //                       : new ListView.builder(
// //                           shrinkWrap: true,
// //                           itemCount: _searchlistt.length,
// //                           itemBuilder: (BuildContext context, int index) {
// //                             String? listData = _searchlistt[index].taskname;
// //                             return new ListTile(
// //                               title: new Text(listData.toString()),
// //                             );
// //                           },
// //                         ))
// //             ],
// //           ),
// //         ));
// //   }
// //
// //   Future<void> assignvel() async {
// //     final List<TaskSearchModel> loadeddata = [];
// //     FirebaseFirestore.instance.collection("Tasks").snapshots().listen((event) {
// //       event.docs.forEach((element) {
// //         values();
// //         print(element.data());
// //         loadeddata.add(TaskSearchModel(taskname: element.data()["task"]));
// //         setState(() {
// //           _searchlistt = loadeddata;
// //         });
// //       });
// //     });
// //   }
