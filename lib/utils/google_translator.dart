import 'package:translator/translator.dart';
import 'package:data_nime/domain/entities/anime.dart';
import 'package:data_nime/domain/entities/character.dart';

final GoogleTranslator _translator = GoogleTranslator();

Future<String> translateText(
  String text, {
  String to = 'es',
  String from = 'auto',
}) async {
  if (text.trim().isEmpty) return '';

  try {
    final translation = await _translator.translate(text, from: from, to: to);
    return translation.text;
  } catch (e) {
    return text;
  }
}

Future<Anime> translateAnime(Anime anime) async {
  final translatedSynopsis = await translateText(anime.synopsis);
  final translatedStatus = await translateText(anime.status);
  final translatedType = await translateText(anime.type);
  final translatedGenres = await Future.wait(anime.genres.map(translateText));
  final translatedExplicitGenres = await Future.wait(
    anime.explicitGenres.map(translateText),
  );
  final translatedAired = await translateText(anime.aired);
  final translatedSource = await translateText(anime.source);
  return anime.copyWith(
    synopsis: translatedSynopsis,
    status: translatedStatus,
    type: translatedType,
    genres: translatedGenres,
    explicitGenres: translatedExplicitGenres,
    aired: translatedAired,
    source: translatedSource,
  );
}

Future<Character> translateCharacter(Character character) async {
  final translateAbout = await translateText(character.about);
  return character.copyWith(about: translateAbout);
}
