class CustomerModel {
  final String Customername;
  final String Customeremail;
  final String Customerphone;
  final String? Idocid;
  final int? CxID;

  CustomerModel(
      {required this.Customername,
      required this.Customeremail,
      required this.Customerphone,
      this.Idocid,
      this.CxID});
}
