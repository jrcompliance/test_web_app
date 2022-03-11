class InvoiceDescriptionModel {
  final String? desc;
  final double? qty;
  final double? ucost;
  final double? amount;

  InvoiceDescriptionModel({this.desc, this.qty, this.ucost, this.amount});

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "qty": qty,
        "ucost": ucost,
        "amount": amount,
      };
}
