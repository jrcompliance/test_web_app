// import 'dart:io';
// import 'dart:typed_data';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
//
// class PdfProvider {
//   static generatePdf() async {
//     final pdf = Document();
//
//     pdf.addPage(pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Center(
//             child: pw.Text("Hello World"),
//           ); // Center
//         }));
//     final file = File("example.pdf");
//     final bytes = pdf.save(); //await file.writeAsBytes(await pdf.save());
//     print(bytes); // Page
//
//     Uint8List fileBytes = Uint8List.fromList(bytes);
//     print(fileBytes);
//     FirebaseStorage storage = FirebaseStorage.instance;
//     TaskSnapshot upload =
//         await storage.ref('Attachments/yalagala').putData(bytes);
//     String myUrl = await upload.ref.getDownloadURL();
//   }
// }
