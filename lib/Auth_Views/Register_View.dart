import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/Auth_Views/Login_View.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/MainScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isSecured = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (BuildContext context, constraints) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Lotties/loginbackground.png"),
                fit: BoxFit.fill),
          ),
          child: Card(
            color: Colors.white,
            elevation: 20,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Container(
              constraints: BoxConstraints(maxWidth: 350, maxHeight: 800),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: logoBase64 == null
                                ? CircleAvatar(
                                    backgroundColor: Colors.blue,
                                  )
                                : ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    child: Image.memory(logoBase64!),
                                  ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt),
                              color: bgColor,
                              onPressed: () {
                                chooseProfile();
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Material(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Employee name';
                            }
                            return null;
                          },
                          controller: usernameController,
                          style: TextStyle(color: Colors.white),
                          obscureText: false,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintText: "Employee Name",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      SizedBox(height: 20),
                      Material(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter employee phone Number';
                            }
                            return null;
                          },
                          controller: phonenumberController,
                          style: TextStyle(color: Colors.white),
                          obscureText: false,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintText: "Employee Phone Number",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      SizedBox(height: 20),
                      Material(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Employee email';
                            }
                            return null;
                          },
                          controller: emailController,
                          style: TextStyle(color: Colors.white),
                          obscureText: false,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintText: "Employee Email id",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      SizedBox(height: 30),
                      Material(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter the Password";
                            }
                            return null;
                          },
                          controller: passwordController,
                          style: TextStyle(color: Colors.white),
                          obscureText: _isSecured,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_isSecured
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isSecured = !_isSecured;
                                    });
                                  },
                                  color: Colors.white),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()));
                          },
                          child: Text(
                            "Already have an Account?Login",
                            style: TextStyle(color: Colors.indigo),
                          )),
                      RaisedButton(
                        onPressed: () {
                          getRegister();
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ));
  }

  Future<void> getRegister() async {
    await _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((cred) async {
      storeUserData();
      if (cred.user == null) {
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("email", emailController.text.toString());
        prefs.setString("password", passwordController.text.toString());
        prefs.setString("username", usernameController.text.toString());
        prefs.setString("phone", phonenumberController.text.toString());
      }
    });
  }

  Future<void> storeUserData() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    TaskSnapshot upload =
        await storage.ref('Profiles/$name').putData(logoBase64!);
    String myUrl = await upload.ref.getDownloadURL();
    String uid = _auth.currentUser!.uid.toString();
    await fireStore.collection("EmployeeData").doc(uid).set({
      "email": emailController.text.toString(),
      "password": passwordController.text.toString(),
      "username": usernameController.text.toString(),
      "phone": phonenumberController.text.toString(),
      "imageUrl": myUrl,
      'uid': uid,
    }).then((value) => Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => MainScreen()), (route) => false));
  }

  Uint8List? logoBase64;
  String? name;
  chooseProfile() async {
    FilePickerResult? pickedfile = await FilePicker.platform.pickFiles();
    if (pickedfile != null) {
      Uint8List? fileBytes = pickedfile.files.first.bytes;
      String fileName = pickedfile.files.first.name;
      logoBase64 = fileBytes;
      name = fileName;
      setState(() {});
    } else {}
  }
}
