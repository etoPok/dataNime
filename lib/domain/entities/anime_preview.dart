class AnimePreview {
  final int _id;
  final double _score;
  final String _urlImage;
  final String _title;

  AnimePreview({
    required int id,
    required double score,
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
}
