class MyModel {
  String? task;
  int? CxID;

  MyModel({this.task, this.CxID});

  factory MyModel.fromJSON(Map map) {
    return MyModel(
      task: map["task"],
      CxID: map["CxID"],
    );
  }
}
