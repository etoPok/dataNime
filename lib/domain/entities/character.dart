class Character {
  final int _id;
  final String _name;
  final String _urlImage;
  final String _about;
  final Map<String, String> _voices; // key: language, value: person

  Character({
    required int id,
    required String name,
    required String urlImage,
    required String about,
    required Map<String, String> voices
  }) : _id = id,
    _name = name,
    _urlImage = urlImage,
    _about = about,
    _voices = voices;

  int get id { return _id; }
  String get name { return _name; }
  String get urlImage { return _urlImage; }
  String get about { return _about; }
  Map<String, String> get voices { return _voices; }

  Character copyWith({
    int? id,
    String? name,
    String? urlImage,
    String? about,
    Map<String, String>? voices
  }) {
    return Character(
      id: id ?? _id,
      name: name ?? _name,
      urlImage: urlImage ?? _urlImage,
      about: about ?? _about,
      voices: voices ?? _voices
    );
  }
}