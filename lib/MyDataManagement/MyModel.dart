class LeadModel {
  String? task;
  int? CxID;
  String? cat;
  LeadModel({this.task, this.CxID, this.cat});

  factory LeadModel.fromMap(Map<String, dynamic> map) {
    return LeadModel(
      task: map['task'],
      CxID: map['CxID'],
      cat: map['cat'],
    );
  }
}
