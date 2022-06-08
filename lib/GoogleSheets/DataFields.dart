class DataFields {
  static String id = 'id';
  static String name = 'name';
  static String email = 'email';
  static String designation = 'designation';
  static String doj = 'doj';

  static List<String> getfields() => [id, name, designation, doj];
}

class Data {
  // String? id;
  String? name;
  String? email;
  String? designation;
  String? doj;
  Data({/*this.id,*/ this.doj, this.designation, this.name, this.email});

  Map<String, dynamic> toJson() => {
        // DataFields.id: id,
        DataFields.name: name,
        DataFields.email: email,
        DataFields.designation: designation,
        DataFields.doj: doj,
      };
}
