class Anime {
  final int _id;

  final String _title;
  final String _titleEnglish;
  final String _titleJapanese;
  final String _titleSpanish;

  final String _synopsis;

  final String _type;
  final String _source;
  final int _episodes;
  final String _status;
  final String _aired;
  final double _score;

  final List<String> _genres;
  final List<String> _explicitGenres;

  final String _urlImage;
  final String _urlTrailer;

  Anime({
    int id = 0,
    required String title,
    required String titleEnglish,
    required String titleJapanese,
    required String titleSpanish,
    required String synopsis,
    required String type,
    required String source,
    required int episodes,
    required String status,
    required String aired,
    required double score,
    required List<String> genres,
    List<String> explicitGenres = const [],
    required String urlImage,
    required String urlTrailer,
  }) : _id = id,
       _title = title,
       _titleEnglish = titleEnglish,
       _titleJapanese = titleJapanese,
       _titleSpanish = titleSpanish,
       _synopsis = synopsis,
       _type = type,
       _source = source,
       _episodes = episodes,
       _status = status,
       _aired = aired,
       _score = score,
       _genres = genres,
       _explicitGenres = explicitGenres,
       _urlImage = urlImage,
       _urlTrailer = urlTrailer;

  int get id {
    return _id;
  }

  String get title {
    return _title;
  }

  String get titleEnglish {
    return _titleEnglish;
  }

  String get titleJapanese {
    return _titleJapanese;
  }

  String get titleSpanish {
    return _titleSpanish;
  }

  String get synopsis {
    return _synopsis;
  }

  String get type {
    return _type;
  }

  String get source {
    return _source;
  }

  int get episodes {
    return _episodes;
  }

  String get status {
    return _status;
  }

  String get aired {
    return _aired;
  }

  double get score {
    return _score;
  }

  List<String> get genres {
    return _genres;
  }

  List<String> get explicitGenres {
    return _explicitGenres;
  }

  String get urlImage {
    return _urlImage;
  }

  String get urlTrailer {
    return _urlTrailer;
  }

  Map<String, dynamic> toMap() {
    return {
      "title": _title,
      "titleEnglish": _titleEnglish,
      "titleJapanese": _titleJapanese,
      "titleSpanish": _titleSpanish,
      "synopsis": _synopsis,
      "type": _type,
      "source": _source,
      "episodes": _episodes,
      "status": _status,
      "aired": _aired,
      "score": _score,
      "genres": _genres.join(","),
      "explicitGenres": _explicitGenres.join(","),
      "urlImage": _urlImage,
      "urlTrailer": _urlTrailer,
    };
  }

  factory Anime.fromMap(Map<String, dynamic> map) {
    return Anime(
      id: map["id"],
      title: map["title"],
      titleEnglish: map["titleEnglish"],
      titleJapanese: map["titleJapanese"],
      titleSpanish: map["titleSpanish"],
      synopsis: map["synopsis"],
      type: map["type"],
      source: map["source"],
      episodes: map["episodes"],
      status: map["status"],
      aired: map["aired"],
      score: map["score"],
      genres: (map["genres"] as String).split(","),
      explicitGenres: (map["explicitGenres"] as String).split(","),
      urlImage: map["urlImage"],
      urlTrailer: map["urlTrailer"],
    );
  }

  Anime copyWith({
    int? id,
    String? title,
    String? titleEnglish,
    String? titleJapanese,
    String? titleSpanish,
    String? synopsis,
    String? type,
    String? source,
    int? episodes,
    String? status,
    String? aired,
    double? score,
    List<String>? genres,
    List<String>? explicitGenres,
    String? urlImage,
    String? urlTrailer,
  }) {
    return Anime(
      id: id ?? _id,
      title: title ?? _title,
      titleEnglish: titleEnglish ?? _titleEnglish,
      titleJapanese: titleJapanese ?? _titleJapanese,
      titleSpanish: titleSpanish ?? _titleSpanish,
      synopsis: synopsis ?? _synopsis,
      type: type ?? _type,
      source: source ?? _source,
      episodes: episodes ?? _episodes,
      status: status ?? _status,
      aired: aired ?? _aired,
      score: score ?? _score,
      genres: genres ?? _genres,
      explicitGenres: explicitGenres ?? _explicitGenres,
      urlImage: urlImage ?? _urlImage,
      urlTrailer: urlTrailer ?? _urlTrailer,
    );
  }
}
