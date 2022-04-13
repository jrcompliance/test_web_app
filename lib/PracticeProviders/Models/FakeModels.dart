class FakeModels {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  FakeModels({this.userId, this.id, this.title, this.body});

  factory FakeModels.fromJSON(Map, map) {
    return FakeModels(
      userId: map["userId"],
      id: map["id"],
      title: map["title"],
      body: map["body"],
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
