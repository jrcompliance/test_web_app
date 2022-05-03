class FakeModels {
  final String? id;
  final String? title;
  final String? body;

  FakeModels({this.id, this.title, this.body});

  factory FakeModels.fromJSON(Map, map) {
    return FakeModels(
      id: map["id"],
      title: map["title"],
      body: map["body"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
      };
}
