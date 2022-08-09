import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_web_app/Models/ServiceSaveModel.dart';
import 'package:test_web_app/Models/ServicesModel.dart';

class ServiceSaveProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future ServiceData({
    required int isiserviceid,
    required List Servicelist,
    required String cusname,
    required double tbal,
    required String actualinid,
    required String gstNo,
    required String docid,
    required String activeid,
    required double gstAmount,
    required double total,
    required String invoicedate,
    required String duedate,
    required String selectedValue,
    required String cxID,
    required String externalNotes,
    required String internalNotes,
    required String referenceID,
    required String LeadId,
    required String eimageurl,
    required String ename,
    required String eemail,
    required String ephone,
    required String edesig,
    required String serviceurl,
  }) async {
    try {
      CollectionReference reference = await _firestore.collection("Services");
      // String docID = reference.doc().id;
      ServiceSaveModel model = ServiceSaveModel();
      model.invoicedate = invoicedate;
      model.activeid = activeid;
      model.isiserviceid = isiserviceid;
      model.Servicelist = Servicelist;
      model.cusname = cusname;
      model.tbal = tbal;
      model.actualinid = actualinid;
      model.internalNotes = internalNotes;
      model.externalNotes = externalNotes;
      model.referenceID = referenceID;
      model.gstNo = gstNo;
      model.docid = docid;
      model.gstAmount = gstAmount;
      model.total = total;
      model.duedate = duedate;
      model.selectedValue = selectedValue;
      model.cxID = cxID;
      model.LeadId = LeadId;
      model.eimageurl = eimageurl;
      model.ename = ename;
      model.eemail = eemail;
      model.ephone = ephone;
      model.edesig = edesig;
      model.serviceurl = serviceurl;
      reference.doc(docid).set(model.toMap());
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
