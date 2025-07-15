class AnimePreview {
  final int _id;
  final double _score;
  final String _urlImage;
  final String _title;

  AnimePreview({
    required int id,
    double score = 0.0,
    required String urlImage,
    required String title,
  }) : _id = id,
       _score = score,
       _urlImage = urlImage,
       _title = title;

  int get id => _id;
  double get score => _score;
  String get urlImage => _urlImage;
  String get title => _title;

  Map<String, dynamic> toMap() {
    return { "id": _id, "title": _title, "score": _score, "urlImage": urlImage };
  }

  factory AnimePreview.fromMap(Map<String, dynamic> map) {
    return AnimePreview(
      id: map["id"],
      score: (map["score"] as num?)?.toDouble() ?? 0.0,
      urlImage: map["urlImage"] ?? "",
      title: map["title"] ?? ""
    );
  }
}
