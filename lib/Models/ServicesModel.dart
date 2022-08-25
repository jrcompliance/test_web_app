class ServicesModel {
  String? name;
  String? image;
  String? sacCode;
  String? gst;
  String? price;
  int? qty;

  ServicesModel({
    this.name,
    this.price,
    this.gst,
    this.image,
    this.sacCode,
    this.qty,
  });
  factory ServicesModel.fromMap(map) {
    return ServicesModel(
        name: map['name'],
        price: map['price'],
        gst: map['gst'],
        image: map['image'],
        qty: map['qty'],
        sacCode: map["sacCode"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'gst': gst,
      'price': price,
      'name': name,
      'qty': qty,
      'sacCode': sacCode
    };
  }
}
