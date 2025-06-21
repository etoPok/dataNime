const Map<String, String> genreTranslations = {
  'Action': 'Acción',
  'Adventure': 'Aventura',
  'Arcade': 'Arcade',
  'Board Games': 'Juegos de mesa',
  'Card': 'Cartas',
  'Educational': 'Educacional',
  'Family': 'Familiar',
  'Fighting': 'Peleas',
  'Massively Multiplayer': 'Multijugador masivo',
  'Platformer': 'Plataformas',
  'Puzzle': 'Rompecabezas',
  'Racing': 'Carreras',
  'RPG': 'Rol',
  'Shooter': 'Disparos',
  'Simulation': 'Simulación',
  'Sports': 'Deportes',
  'Strategy': 'Estrategia',
};

List<String> translateGenres(List<String> originalGenres) {
  return originalGenres.map((g) => genreTranslations[g] ?? g).toList();
}
