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
class InvoiceDescriptionModel2 {
  final String? item;
  final double? rate;
  final int? qty;
  final double? disc;
  final double? price;

  InvoiceDescriptionModel2({this.item, this.rate, this.qty, this.disc,this.price});

  Map<String, dynamic> toJson() => {
    "item": item,
    "rate": rate,
    "qty": qty,
    "disc": disc,
    "price": price,
  };
}

