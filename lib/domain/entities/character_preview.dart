class CharacterPreview {
  final int _id;
  final String _urlImage;
  final String _name;

  CharacterPreview({
    required int id,
    required String urlImage,
    required String name
  }) : _id = id,
    _urlImage = urlImage,
    _name = name;

  int get id { return _id; }
  String get urlImage { return _urlImage; }
  String get name { return _name; }
}