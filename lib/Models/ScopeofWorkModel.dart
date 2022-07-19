class ScopeofWorkModel {
  String? text;

  ScopeofWorkModel({
    this.text,
  });
  factory ScopeofWorkModel.fromMap(map) {
    return ScopeofWorkModel(
      text: map['text'],
      // price: map['price'],
      // gst: map['gst'],
      // image: map['image'],
      // qty: map['qty'],
      // sacCode: map["sacCode"]
    );
  }

  Map<String, dynamic> toMap() {
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
