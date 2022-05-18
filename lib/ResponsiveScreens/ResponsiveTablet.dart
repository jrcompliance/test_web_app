// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:test_web_app/Constants/Responsive.dart';
// import 'package:test_web_app/Constants/reusable.dart';
//
// class ResponsiveScreen1 extends StatefulWidget {
//   const ResponsiveScreen1({Key? key}) : super(key: key);
//
//   @override
//   _ResponsiveScreen1State createState() => _ResponsiveScreen1State();
// }
//
// class _ResponsiveScreen1State extends State<ResponsiveScreen1> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     myall();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         child: Responsive(
//             mobile: Container(
//               padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
//               width: size.width * 1,
//               child: mobilechild(),
//             ),
//             tablet: Container(
//               width: size.width * 1,
//               child: tabanddesktopchild(),
//             ),
//             desktop: Container(
//               width: size.width * 1,
//               child: tabanddesktopchild(),
//             )),
//       ),
//     );
//   }
//
// reditNotrr    return ListView.separated(
//       separatorBuilder: (context, index) {
//         return Divider();
//       },
//       itemCount: productdata.length,
//       itemBuilder: (_, i) {
//         return ListTile(
//           tileColor: grClr,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           leading: CircleAvatar(
//               maxRadius: 50,
//               backgroundImage: NetworkImage(productdata[i].image)),
//           title: Text(productdata[i].product),
//           trailing: Text(productdata[i].price.toString()),
//         );
//       },
//     );
//   }
//
//   Widget tabanddesktopchild() {
//     Size size = MediaQuery.of(context).size;
//     return GridView.builder(
//       padding: EdgeInsets.all(10),
//       itemCount: productdata.length,
//       itemBuilder: (_, i) {
//         return Padding(
//           padding: EdgeInsets.all(5),
//           child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: grClr)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CircleAvatar(
//                       maxRadius: 50,
//                       backgroundImage: NetworkImage(productdata[i].image)),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Flexible(
//                         child: Text(
//                           productdata[i].product,
//                           overflow: TextOverflow.clip,
//                           softWrap: true,
//                         ),
//                       ),
//                       Flexible(
//                           child: Text(
//                         productdata[i].price.toString(),
//                         overflow: TextOverflow.clip,
//                         softWrap: true,
//                       ))
//                     ],
//                   ),
//                 ],
//               )),
//         );
//       },
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: Responsive.isLargeScreen(context) ? 6 : 4),
//     );
//   }
//
//   List<ProductModel> productdata = [];
//   myall() {
//     productdata.add(ProductModel(
//         id: "05222301",
//         product: "Flutter",
//         image:
//             "data:image/jpeg;base64,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",
//         qty: 1,
//         price: 100,
//         discount: 0,
//         gst: 18,
//         total: 118));
//     productdata.add(ProductModel(
//         id: "05222302",
//         product: "React Native",
//         image:
//             "data:image/png;base64,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",
//         qty: 1,
//         price: 200,
//         discount: 0,
//         gst: 36,
//         total: 236));
//     productdata.add(ProductModel(
//         id: "05222303",
//         product: "Ionic",
//         image:
//             "data:image/png;base64,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",
//         qty: 1,
//         price: 300,
//         discount: 0,
//         gst: 54,
//         total: 354));
//     productdata.add(ProductModel(
//         id: "05222304",
//         product: "PHP",
//         image:
//             "data:image/png;base64,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",
//         qty: 1,
//         price: 400,
//         discount: 0,
//         gst: 72,
//         total: 472));
//     productdata.add(ProductModel(
//         id: "05222305",
//         product: "Go Lang",
//         image:
//             "data:image/png;base64,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",
//         qty: 1,
//         price: 500,
//         discount: 0,
//         gst: 90,
//         total: 590));
//     productdata.add(ProductModel(
//         id: "05222306",
//         product: "Node.Js",
//         image:
//             "data:image/png;base64,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",
//         qty: 1,
//         price: 600,
//         discount: 0,
//         gst: 108,
//         total: 708));
//   }
// }
//
// class ProductModel {
//   String id;
//   String product;
//   String image;
//   int qty;
//   int price;
//   int discount;
//   int gst;
//   int total;
//   ProductModel(
//       {required this.id,
//       required this.product,
//       required this.image,
//       required this.qty,
//       required this.price,
//       required this.discount,
//       required this.gst,
//       required this.total});
// }
