import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileServices {
  static choosefile(id) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);
    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      uploadStorage1(fileName, fileBytes, id);
    } else {}
  }

  static uploadStorage1(fileName, fileBytes, id) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    TaskSnapshot upload =
        await storage.ref('Attachments/$fileName').putData(fileBytes);
    String myUrl = await upload.ref.getDownloadURL();
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Tasks");
    collectionReference.doc(id).update({
      "Attachments1": FieldValue.arrayUnion([
        {
          "name": fileName,
          "url": myUrl,
        }
      ]),
    });
  }
}
