class GetServiceModel {
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

  GetServiceModel(
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
}
