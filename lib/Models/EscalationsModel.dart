class EscalationsModel {
  String? name;
  String? imageUrl;
  String? desig;
  String? phone;
  String? email;

  EscalationsModel(
      {this.imageUrl, this.phone, this.name, this.desig, this.email});

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "desig": desig,
        "phone": phone,
        "email": email,
      };
}
