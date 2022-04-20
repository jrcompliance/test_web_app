import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class AddDocumentsProvider with ChangeNotifier {
  FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addDocument(id) async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);
      if (result != null) {
        Uint8List? fileBytes = result.files.first.bytes;
        String fileName = result.files.first.name;
        notifyListeners();
        TaskSnapshot upload =
            await storage.ref('Attachments/$fileName').putData(fileBytes!);
        String myUrl = await upload.ref.getDownloadURL();
        CollectionReference collectionReference =
            _firestore.collection("Tasks");
        collectionReference.doc(id).update({
          "Attachments1": FieldValue.arrayUnion([
            {
              "name": fileName,
              "url": myUrl,
            }
          ]),
        });
        notifyListeners();
      } else {}
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
