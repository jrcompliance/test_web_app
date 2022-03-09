class InvoiceDescriptionModel {
  final String? desc;
  final String? qty;
  final String? ucost;

  InvoiceDescriptionModel({this.desc, this.qty, this.ucost});

  InvoiceDescriptionModel.fromJson(Map<String, dynamic> jsonData)
      : desc = jsonData["desc"],
        qty = jsonData["qty"],
        ucost = jsonData["ucost"];

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "qty": qty,
        "ucost": ucost,
      };
}
