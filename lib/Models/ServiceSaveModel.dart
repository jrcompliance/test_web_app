import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceSaveModel {
  String? serviceurl;
  int? isiserviceid;
  String? cusname;
  List? Servicelist;
  double? tbal;
  String? actualinid;
  String? gstNo;
  String? docid;
  String? activeid;
  double? gstAmount;
  double? total;
  String? invoicedate;
  String? duedate;
  String? selectedValue;
  String? cxID;
  String? externalNotes;
  String? internalNotes;
  String? referenceID;
  String? LeadId;
  String? eimageurl;
  String? ename;
  String? eemail;
  String? ephone;
  String? edesig;

  ServiceSaveModel(
      {this.isiserviceid,
      this.cusname,
      this.ephone,
      this.edesig,
      this.ename,
      this.eimageurl,
      this.activeid,
      this.selectedValue,
      this.cxID,
      this.total,
      this.tbal,
      this.Servicelist,
      this.docid,
      this.LeadId,
      this.referenceID,
      this.externalNotes,
      this.internalNotes,
      this.duedate,
      this.actualinid,
      this.eemail,
      this.gstAmount,
      this.gstNo,
      this.invoicedate,
      this.serviceurl});

  Map<String, dynamic> toMap() => {
        "isiserviceid": isiserviceid,
        "cusname": cusname,
        "ephone": ephone,
        "edesig": edesig,
        "duedate": duedate,
        "ename": ename,
        "eimageurl": eimageurl,
        "internalNotes": internalNotes,
        "externalNotes": externalNotes,
        "referenceID": referenceID,
        "activeid": activeid,
        "selectedValue": selectedValue,
        "cxID": cxID,
        "total": total,
        "tbal": tbal,
        "Servicelist": Servicelist,
        "docid": docid,
        "actualinid": actualinid,
        "eemail": eemail,
        "gstAmount": gstAmount,
        "gstNo": gstNo,
        "LeadId": LeadId,
        "invoicedate": invoicedate,
        "serviceurl": serviceurl,
      };
}
