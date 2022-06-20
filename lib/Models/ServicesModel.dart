class ServicesModel {
  String? name;
  String? image;
  String? sacCode;
  String? gst;
  String? price;

  ServicesModel({this.name, this.price, this.gst, this.image, this.sacCode});
  factory ServicesModel.fromMap(map) {
    return ServicesModel(
        name: map['name'],
        price: map['price'],
        gst: map['gst'],
        image: map['image'],
        sacCode: map["sacCode"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'gst': gst,
      'price': price,
      'name': name,
      'sacCode': sacCode
    };
  }
}
