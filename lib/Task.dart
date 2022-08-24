import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Constants/reusable.dart';

class Taskpage extends StatefulWidget {
  const Taskpage({Key? key}) : super(key: key);

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  List<Data> dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataList = Provider.of<SaveDataProvider>(context, listen: false).tlist;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    spacer(),
                    Container(
                      decoration: deco,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.01),
                        child: TextFormField(
                          cursorColor: btnColor,
                          controller: _emailController,
                          style: TxtStls.fieldstyle,
                          decoration: InputDecoration(
                            errorStyle: ClrStls.errorstyle,
                            hintText: "Enter email address",
                            hintStyle: TxtStls.fieldstyle,
                            border: InputBorder.none,
                          ),
                          validator: (email) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(pattern);
                            if (email!.isEmpty) {
                              return "Email can not be empty";
                            } else if (!regExp.hasMatch(email)) {
                              return "Enter a valid email";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    space(),
                    Container(
                      decoration: deco,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.01),
                        child: TextFormField(
                          cursorColor: btnColor,
                          controller: _phoneController,
                          style: TxtStls.fieldstyle,
                          decoration: InputDecoration(
                            errorStyle: ClrStls.errorstyle,
                            hintText: "Enter email address",
                            hintStyle: TxtStls.fieldstyle,
                            border: InputBorder.none,
                          ),
                          validator: (phone) {
                            if (phone!.isEmpty) {
                              return "Phone Number can not be empty";
                            } else if (phone.length < 10 || phone.length > 10) {
                              return "Enter a valid Phone Number";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    space(),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: btnColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Text(
                          "Save".toUpperCase(),
                          style: TextStyle(color: bgColor),
                        ),
                      ),
                      onTap: () {
                        try {
                          if (_formKey.currentState!.validate()) {
                            if (_emailController.text.toString() != null &&
                                _phoneController.text.toString() != null) {
                              Provider.of<SaveDataProvider>(context,
                                      listen: false)
                                  .saveData(_emailController.text.toString(),
                                      _phoneController.text.toString());
                              Fluttertoast.showToast(
                                  gravity: ToastGravity.CENTER,
                                  msg: "Successfully saved your details");
                            } else {
                              Fluttertoast.showToast(
                                  gravity: ToastGravity.CENTER,
                                  msg: "Please check the details");
                            }
                          }
                        } on Exception catch (e) {
                          Fluttertoast.showToast(
                              gravity: ToastGravity.CENTER, msg: e.toString());

                          // TODO
                        }
                        setState(() {
                          dataList = Provider.of<SaveDataProvider>(context,
                                  listen: false)
                              .tlist;

                          // dataList.add(Data(
                          //     email: _emailController.text.toString(),
                          //     phone: _phoneController.text.toString()));
                          print(dataList.toSet().toString());
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            spacer(),
            Container(
                height: size.height * 0.4,
                width: size.width,
                child: ListView.builder(
                    itemCount:
                        Provider.of<SaveDataProvider>(context, listen: false)
                            .tlist
                            .length,
                    itemBuilder: (context, index) {
                      var mail;
                      var ph;
                      var data =
                          Provider.of<SaveDataProvider>(context, listen: false)
                              .tlist;
                      data.map((e) {
                        mail = e.email;
                        ph = e.phone;
                      });
                      return ListTile(
                        title: Text(mail[index].toString()),
                        subtitle: Text(ph[index].toString()),
                      );
                    })),
          ],
        ),
      ),
    );
  }

  Widget space() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.01,
    );
  }

  Widget spacer() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.1,
    );
  }

  // addtodolist({List<String>? list}) async {
  //   isLoading = true;
  //   final addlis = await SharedPreferences.getInstance();
  //   addlis.setStringList('list', list!).then((value) {
  //     _emailController.clear();
  //     _phoneController.clear();
  //     //setlistchek(key:'checkdata',value: true);
  //     showlist = false;
  //     isLoading = false;
  //   });
  // }
  //
  // gettodolist() async {
  //   final prfss = await SharedPreferences.getInstance();
  //   var list = prfss.getStringList('list');
  //   if (list == null) {
  //     todolist.length = 0;
  //   } else {
  //     todolist = list;
  //   }
  // }
  //
  // checkgettodolist({List<String>? list, dataelement}) async {
  //   isLoading = true;
  //   final listval = await SharedPreferences.getInstance();
  //   var listdata = listval.getStringList('list');
  //   if (listdata == null) {
  //     addtodolist(list: list);
  //     isLoading = false;
  //   } else {
  //     var isexists = listdata.where((element) => element.contains(dataelement));
  //     if (isexists.isNotEmpty) {
  //       _emailController.clear();
  //       _phoneController.clear();
  //       showalredyexits = true;
  //       isLoading = false;
  //     } else {
  //       listdata.add(dataelement);
  //       addtodolist(list: listdata);
  //     }
  //   }
  // }
}

// const btnColor = Color(0xFF5551F1);
// const bgColor = Colors.white;
// const clsClr = Color(0xFFF44336);
// const fieldColor = Color(0x8AEEEEEE);
// const txtColor = Colors.black;
// const deco = BoxDecoration(
//   color: fieldColor,
//   borderRadius: BorderRadius.all(Radius.circular(5.0)),
// );
//
// class TxtStls {
//   static TextStyle fieldstyle = GoogleFonts.nunito(
//       textStyle:
//           const TextStyle(color: txtColor, fontSize: 12.5, letterSpacing: 0.2),
//       color: txtColor,
//       letterSpacing: 0.2,
//       fontSize: 12.5);
//   static const btnstyle = TextStyle(color: btnColor, fontSize: 12.5);
//   static TextStyle errorstyle = GoogleFonts.nunito(
//       textStyle: const TextStyle(
//           fontSize: 12, color: clsClr, fontWeight: FontWeight.bold),
//       fontSize: 12,
//       color: clsClr,
//       fontWeight: FontWeight.bold);
// }
class Data {
  String? email;
  String? phone;
  Data({this.phone, this.email});
  factory Data.fromJson(json) {
    return Data(email: json["email"], phone: json["phone"]);
  }
  Map<String, dynamic> toJson() => {"email": email, "phone": phone};
}

class SaveDataProvider extends ChangeNotifier {
  List<Data> _tlist = [];
  List<Data> get tlist {
    return [..._tlist];
  }

  void saveData(email, phone) {
    List<Data> loadedData = [];
    loadedData.add(Data(email: email, phone: phone));
    _tlist = loadedData;
    notifyListeners();
  }
}
