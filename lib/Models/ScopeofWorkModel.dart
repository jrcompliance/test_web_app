class ScopeofWorkModel {
  String? text;

  ScopeofWorkModel({
    this.text,
  });
  factory ScopeofWorkModel.fromJson(json) {
    return ScopeofWorkModel(
      text: json['text'],
      // price: map['price'],
      // gst: map['gst'],
      // image: map['image'],
      // qty: map['qty'],
      // sacCode: map["sacCode"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      // 'gst': gst,
      // 'price': price,
      // 'name': name,
      // 'qty': qty,
      // 'sacCode': sacCode
    };
  }
}
