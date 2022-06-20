class ProductModel {
  String? name;
  String? image;
  String? sacCode;
  String? gst;
  String? price;

  ProductModel({this.name, this.price, this.gst, this.image, this.sacCode});
  factory ProductModel.fromJson(json) {
    return ProductModel(
        name: json['name'],
        price: json['price'],
        gst: json['gst'],
        image: json['image'],
        sacCode: json["sacCode"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'gst': gst,
      'price': price,
      'name': name,
      'sacCode': sacCode
    };
  }
}
