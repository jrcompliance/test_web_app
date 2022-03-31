class CustomerModel {
  final String Customername;
  final String Customeremail;
  final String Customerphone;
  final String? Idocid;

  CustomerModel(
      {required this.Customername,
        required this.Customeremail,
        required this.Customerphone,
        this.Idocid});
}