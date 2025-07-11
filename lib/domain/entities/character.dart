class Character {
  final int _id;
  final String _name;
  final String _kanjiName;
  final String _urlImage;
  final String _about;
  final int _favorites;
  final List<String> _nicknames;
  final List<String> _animes;
  final Map<String, String> _voices; // key: language, value: person

  Character({
    required int id,
    required String name,
    required String kanjiName,
    required String urlImage,
    required String about,
    required int favorites,
    required List<String> nicknames,
    required List<String> animes,
    required Map<String, String> voices
  }) : _id = id,
    _name = name,
    _kanjiName = kanjiName,
    _urlImage = urlImage,
    _about = about,
    _favorites = favorites,
    _nicknames = nicknames,
    _animes = animes,
    _voices = voices;

  int get id { return _id; }
  String get name { return _name; }
  String get kanjiName { return _kanjiName; }
  String get urlImage { return _urlImage; }
  String get about { return _about; }
  int get favorites { return _favorites; }
  List<String> get nicknames { return _nicknames; }
  List<String> get animeTitle { return _animes; }
  Map<String, String> get voices { return _voices; }

  Character copyWith({
    int? id,
    String? name,
    String? kanjiName,
    String? urlImage,
    String? about,
    int? favoites,
    List<String>? nicknames,
    List<String>? animeTitle,
    Map<String, String>? voices
  }) {
    return Character(
      id: id ?? _id,
      name: name ?? _name,
      kanjiName: kanjiName ?? _kanjiName,
      urlImage: urlImage ?? _urlImage,
      about: about ?? _about,
      favorites: favoites ?? _favorites,
      nicknames: nicknames ?? _nicknames,
      animes: animeTitle ?? _animes,
      voices: voices ?? _voices
    );
  }
}