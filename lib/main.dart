import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthProviders/LogOutProvider.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthProviders/LoginProvider.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthProviders/RegisterProvider.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthProviders/ResetPasswordProvider.dart';
import 'package:test_web_app/CompleteAppAuthentication/AuthProviders/StoreUserDataProvider.dart';
import 'package:test_web_app/CompleteAppAuthentication/Auth_Views/Login_View.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/MainScreen.dart';
import 'package:test_web_app/Providers/AddDocumentsProvider.dart';
import 'package:test_web_app/Providers/AddServicesProvider.dart';
import 'package:test_web_app/Providers/CompleteProfileProvider.dart';
import 'package:test_web_app/Providers/CreateLeadProvider.dart';
import 'package:test_web_app/Providers/DupicatesFinderProvider.dart';
import 'package:test_web_app/Providers/GenerateCxIDProvider.dart';
import 'package:test_web_app/Providers/GetInvoiceProvider.dart';
import 'package:test_web_app/Providers/InvoiceSaveProvider.dart';
import 'package:test_web_app/Providers/InvoiceUpdateProvider.dart';
import 'package:test_web_app/Providers/LeadUpdateProvider.dart';
import 'package:test_web_app/Providers/RemoveServiceProvider.dart';
import 'package:test_web_app/Providers/UpdateCompanyDetailsProvider.dart';
import 'package:test_web_app/Providers/UpdatestatusProvider.dart';
import 'package:test_web_app/Providers/ActivityProvider.dart';
import 'package:test_web_app/Providers/CustomerProvider.dart';
import 'package:test_web_app/Providers/GstProvider.dart';
import 'package:test_web_app/UserProvider/ShowLeadProvider.dart';
import 'package:test_web_app/Providers/UserProvider.dart';
import 'package:test_web_app/Providers/CurrentUserdataProvider.dart';
import 'package:test_web_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => RegisterProvider()),
      ChangeNotifierProvider(create: (ctx) => StoreUserDataProvider()),
      ChangeNotifierProvider(create: (ctx) => LoginProvider()),
      ChangeNotifierProvider(create: (ctx) => PasswordResetProvider()),
      ChangeNotifierProvider(create: (ctx) => LogOutProvider()),
      ChangeNotifierProvider(create: (ctx) => CompleteProfielProvider()),
      ChangeNotifierProvider(create: (ctx) => AllUSerProvider()),
      ChangeNotifierProvider(create: (ctx) => CreateLeadProvider()),
      ChangeNotifierProvider(create: (ctx) => LeadUpdateProvider()),
      ChangeNotifierProvider(create: (ctx) => UpdateCompanyDeatailsProvider()),
      ChangeNotifierProvider(create: (ctx) => UpdateStatusProvider()),
      ChangeNotifierProvider(create: (ctx) => AllLeadsProvider()),
      ChangeNotifierProvider(create: (ctx) => GstProvider()),
      ChangeNotifierProvider(create: (ctx) => RecentFetchCXIDProvider()),
      ChangeNotifierProvider(create: (ctx) => UserDataProvider()),
      ChangeNotifierProvider(create: (ctx) => CustmerProvider()),
      ChangeNotifierProvider(create: (ctx) => ActivityProvider()),
      ChangeNotifierProvider(create: (ctx) => ActivityProvider1()),
      ChangeNotifierProvider(create: (ctx) => AddServiceProvider()),
      ChangeNotifierProvider(create: (ctx) => RemoveServiceProvider()),
      ChangeNotifierProvider(create: (ctx) => AddDocumentsProvider()),
      ChangeNotifierProvider(create: (ctx) => GetInvoiceListProvider()),
      ChangeNotifierProvider(create: (ctx) => InvoiceSaveProvider()),
      ChangeNotifierProvider(create: (ctx) => InvoiceUpdateProvider()),
      ChangeNotifierProvider(create: (ctx) => DuplicatesFinderProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "JR CENTRAL",
      theme: ThemeData.light().copyWith(
        scrollbarTheme:
            ScrollbarThemeData(thumbColor: MaterialStateProperty.all(btnColor)),
        scaffoldBackgroundColor: AbgColor.withOpacity(0.1),
        canvasColor: bgColor.withOpacity(1),
      ),
      home: const LandingScreen(),
    );
  }
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2))
        .then((value) => _checkAuthentication());
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DuplicatesFinderProvider>(context).dupicates();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SpinKitFadingCube(
          size: size.height * 0.075,
          color: btnColor,
        ),
      ),
    );
  }

  _checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString("email") == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MainScreen()));
      }
    } catch (e) {
      return e;
    }
  }
}
//
// // import 'dart:async';
// // import 'dart:convert';
// // import 'dart:developer';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:test_web_app/firebase_options.dart';
// //
// // main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Animation',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: PushNotificationApp(),
// //     );
// //   }
// // }
// //
// // /// Entry point for the example application.
// // class PushNotificationApp extends StatefulWidget {
// //   static const routeName = "/firebase-push";
// //
// //   @override
// //   _PushNotificationAppState createState() => _PushNotificationAppState();
// // }
// //
// // class _PushNotificationAppState extends State<PushNotificationApp> {
// //   @override
// //   void initState() {
// //     getPermission();
// //     messageListener(context);
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder(
// //       // Initialize FlutterFire
// //       future: Firebase.initializeApp(),
// //       builder: (context, snapshot) {
// //         // Check for errors
// //         if (snapshot.hasError) {
// //           return Center(
// //             child: Text("snapshot.error"),
// //           );
// //         }
// //         // Once complete, show your application
// //         if (snapshot.connectionState == ConnectionState.done) {
// //           print('web firebase initiated');
// //           return NotificationPage();
// //         }
// //         // Otherwise, show something whilst waiting for initialization to complete
// //         return Center(
// //           child: CircularProgressIndicator(),
// //         );
// //       },
// //     );
// //   }
// //
// //   Future<void> getPermission() async {
// //     FirebaseMessaging messaging = FirebaseMessaging.instance;
// //
// //     NotificationSettings settings = await messaging.requestPermission(
// //       alert: true,
// //       announcement: false,
// //       badge: true,
// //       carPlay: false,
// //       criticalAlert: false,
// //       provisional: false,
// //       sound: true,
// //     );
// //
// //     print('User granted permission: ${settings.authorizationStatus}');
// //   }
// //
// //   void messageListener(BuildContext context) {
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //       print('Got a message whilst in the foreground!');
// //       print('Message data: ${message.data}');
// //
// //       if (message.notification != null) {
// //         print(
// //             'Message also contained a notification: ${message.notification?.body}');
// //         showDialog(
// //             context: context,
// //             builder: ((BuildContext context) {
// //               return DynamicDialog(
// //                   title: message.notification?.title,
// //                   body: message.notification?.body);
// //             }));
// //       }
// //     });
// //   }
// // }
// //
// // class NotificationPage extends StatefulWidget {
// //   @override
// //   State<StatefulWidget> createState() => _Application();
// // }
// //
// // class _Application extends State<NotificationPage> {
// //   String? _token;
// //   Stream<String>? _tokenStream;
// //   int notificationCount = 0;
// //
// //   void setToken(String token) {
// //     print('FCM TokenToken: $token');
// //     setState(() {
// //       _token = token;
// //     });
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     //get token
// //     FirebaseMessaging.instance.getToken().then((value) => setToken(value!));
// //     _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
// //     _tokenStream?.listen(setToken);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Firebase push notification'),
// //         ),
// //         body: Container(
// //           child: Center(
// //             child: Card(
// //               margin: EdgeInsets.all(10),
// //               elevation: 10,
// //               child: ListTile(
// //                 title: Center(
// //                   child: OutlinedButton.icon(
// //                     label: Text('Push Notification',
// //                         style: TextStyle(
// //                             color: Colors.blueAccent,
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 16)),
// //                     onPressed: () {
// //                       sendPushMessageToWeb();
// //                     },
// //                     icon: Icon(Icons.notifications),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ));
// //   }
// //
// //   //send notification
// //   sendPushMessageToWeb() async {
// //     if (_token == null) {
// //       print('Unable to send FCM message, no token exists.');
// //       return;
// //     }
// //     try {
// //       await http
// //           .post(
// //             Uri.parse('https://fcm.googleapis.com/fcm/send'),
// //             headers: <String, String>{
// //               'Content-Type': 'application/json',
// //               'Authorization':
// //                   'key=AAAAcGYfxNM:APA91bF05cRER6uD0IKxfN1SUeNdP1f0Itc97FVsZ5I9tfDInhy7TAPkTujy_1VONbPD9P_Dstju5lxfocCW64gyr2whu79EsTMfuMwT3Gb6QSLi1bpQxefErXdkEDp7AIZ3u2uwFgXt'
// //             },
// //             body: json.encode({
// //               'to': _token,
// //               'message': {
// //                 'token': _token,
// //               },
// //               "notification": {
// //                 "title": "Push Notification",
// //                 "body": "Firebase  push notification"
// //               }
// //             }),
// //           )
// //           .then((value) => print(value.body));
// //       print('FCM request for web sent!');
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
// // }
// //
// // //push notification dialog for foreground
// // class DynamicDialog extends StatefulWidget {
// //   final title;
// //   final body;
// //   DynamicDialog({this.title, this.body});
// //   @override
// //   _DynamicDialogState createState() => _DynamicDialogState();
// // }
// //
// // class _DynamicDialogState extends State<DynamicDialog> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       title: Text(widget.title),
// //       actions: <Widget>[
// //         OutlinedButton.icon(
// //             label: Text('Close'),
// //             onPressed: () {
// //               Navigator.pop(context);
// //             },
// //             icon: Icon(Icons.close))
// //       ],
// //       content: Text(widget.body),
// //     );
// //   }
// // }
// class Pdfs {
//
// }
// import 'package:flutter/material.dart';
// import 'package:invoiceninja/invoiceninja.dart';
// import 'package:invoiceninja/models/client.dart';
// import 'package:invoiceninja/models/invoice.dart';
// import 'package:invoiceninja/models/product.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Invoice Ninja',
//       theme: ThemeData(
//         brightness: Brightness.dark,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
//   List<Product> _products = [];
//
//   String _email = '';
//   Product? _product;
//   Invoice? _invoice;
//
//   @override
//   initState() {
//     super.initState();
//     WidgetsBinding.instance?.addObserver(this);
//
//     InvoiceNinja.configure(
//       'KEY', // Set your company key or use 'KEY' to test
//       url: 'https://demo.invoiceninja.com', // Set your selfhost app URL
//       debugEnabled: true,
//     );
//
//     InvoiceNinja.products.load().then((products) {
//       setState(() {
//         _products = products;
//       });
//     });
//   }
//
//   void _createInvoice() async {
//     if (_product == null) {
//       return;
//     }
//
//     var client = Client.forContact(email: _email);
//     client = await InvoiceNinja.clients.save(client);
//
//     var invoice = Invoice.forClient(client, products: [_product!]);
//     invoice = await InvoiceNinja.invoices.save(invoice);
//     print(invoice.pdfUrl);
//
//     setState(() {
//       _invoice = invoice;
//     });
//   }
//
//   void _viewPdf() {
//     if (_invoice == null) {
//       return;
//     }
//
//     launch(
//       '${_invoice!.pdfUrl}',
//       forceWebView: true,
//     );
//   }
//
//   void _viewPortal() {
//     if (_invoice == null) {
//       return;
//     }
//
//     final invitation = _invoice!.invitations.first;
//     launch(invitation.url);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     if (_invoice == null || state != AppLifecycleState.resumed) {
//       return;
//     }
//
//     final invoice = await InvoiceNinja.invoices.findByKey(_invoice!.key);
//
//     if (invoice.isPaid) {
//       // ...
//     }
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance?.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Invoice Ninja Example'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       suffixIcon: Icon(Icons.email),
//                     ),
//                     onChanged: (value) => setState(() => _email = value),
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   DropdownButtonFormField<Product>(
//                     decoration: InputDecoration(
//                       labelText: 'Product',
//                     ),
//                     onChanged: (value) => setState(() => _product = value),
//                     items: _products
//                         .map((product) => DropdownMenuItem(
//                               child: Text(product.productKey),
//                               value: product,
//                             ))
//                         .toList(),
//                   ),
//                   SizedBox(height: 16),
//                   OutlineButton(
//                     child: Text('Create Invoice'),
//                     onPressed: (_email.isNotEmpty && _product != null)
//                         ? () => _createInvoice()
//                         : null,
//                   ),
//                   OutlineButton(
//                     child: Text('View PDF'),
//                     onPressed: (_invoice != null) ? () => _viewPdf() : null,
//                   ),
//                   OutlineButton(
//                     child: Text('View Portal'),
//                     onPressed: (_invoice != null) ? () => _viewPortal() : null,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
