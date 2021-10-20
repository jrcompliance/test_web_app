import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/reusable.dart';

class Header extends StatefulWidget {
  final String title;
  Header({Key? key, required this.title}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String? email;
  String? imageUrl;
  String? usersname;
  String? phone;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (Responsive.isMobile(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        if (Responsive.isMobile(context))
          Text(
            widget.title,
            style: GoogleFonts.oswald(
                color: txtColor, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        if (Responsive.isMobile(context))
          Spacer(flex: Responsive.isMobile(context) ? 2 : 1),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: bgColor),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: TextFormField(
            style: TextStyle(color: txtColor),
            decoration: InputDecoration(
              hintText: "Search",
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              suffixIcon: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(defaultPadding * 1.25),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    border: Border.all(
                      color: bgColor,
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: SvgPicture.asset("assets/Search.svg"),
                ),
              ),
            ),
          ),
        )),
        Container(
          margin: EdgeInsets.only(left: defaultPadding),
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: txtColor, width: 2),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: imageUrl == ""
                    ? Container()
                    : ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: Image.network(
                          "$imageUrl".toString(),
                        ),
                      ),
              ),
              if (!Responsive.isMobile(context))
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  child: Text(
                    "$usersname".toString(),
                    style: TextStyle(color: txtColor),
                  ),
                ),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> userdetails() async {
    await fireStore
        .collection("EmployeeData")
        .where("uid", isEqualTo: _auth.currentUser!.uid.toString())
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        //print(element.data());
        usersname = element.data()["username"].toString();
        email = element.data()["email"].toString();
        phone = element.data()["phone"].toString();
        imageUrl = element.data()["imageUrl"].toString();
        setState(() {});
      });
    });
  }
}
