
# Game Gauge

## Indice

- [Datos del creador](#datos-del-creador)

- [Descripción del proyecto](#descripción-del-proyecto)

- [Lista de características](#lista-de-características)
- [Lista de funcionalidades más relevantes](#lista-de-funcionalidades-más-relevantes)
- [Capturas de pantalla](#capturas-de-pantalla)
- [Descargar la app](#descargar-la-app)
- [Recursos generados](#recursos-generados)

## Datos del creador

- **Nombre**: José Peña.

- **Universidad**: Universidad de Talca.

- **Carrera**: Ingeniera en desarrollo de videojuegos y realidad virtual.

- **Modulo**: Programacion para dispositivos moviles.

- **Profesor**: Manuel Moscoso.


## Descripción del proyecto 
Game Gauge es una aplicación móvil desarrollada en Flutter que permite a los usuarios explorar información sobre videojuegos. La aplicación ofrece una interfaz intuitiva para buscar, descubrir y gestionar una biblioteca personal de videojuegos. 
## Lista de características 
- **Splash Screen**: Pantalla de inicio que muestra el logo y nombre de la aplicación. 
- **Home Screen**: Pantalla principal con una lista de los últimos éxitos y los juegos más esperados. 
- **Navegación**: Menú lateral para navegar entre las diferentes secciones de la aplicación (Perfil, Explorar juegos, Mi biblioteca). 
- **Perfil de Usuario**: Pantalla que muestra la información del usuario, incluyendo juegos gustados, por jugar y jugados. 
- **Explorar Juegos**: Pantalla para buscar videojuegos con filtrado y ordenamiento por calificación. 
- **Biblioteca**: Sección para gestionar los juegos favoritos, guardados y completados del usuario. 
- **Detalle del Videojuego**: Visualización de información detallada de cada juego (nombre, género, calificación, plataformas, año). 
- **Tarjeta de Videojuego**: Widget reutilizable para mostrar información resumida de un videojuego (imagen, nombre, calificación). 
## Lista de funcionalidades más relevantes 
- **Búsqueda y filtrado de videojuegos**: Los usuarios pueden buscar videojuegos por nombre y ordenar los resultados por calificación. 
- **Gestión de la biblioteca personal**: La aplicación permite a los usuarios marcar juegos como favoritos, guardados o completados. 
- **Visualización de detalles del videojuego**: Los usuarios pueden ver información detallada sobre cada videojuego. 
- **Navegación intuitiva**: La aplicación ofrece una navegación fácil de usar a través de un menú lateral y una estructura de pestañas en la biblioteca. 
- **Interfaz de usuario atractiva**: Diseño moderno y atractivo con uso de imágenes, íconos y tarjetas informativas. 
## Capturas de pantalla 

<p align="center">
<img src="assets/Capturas/portada.jpg" alt="Portada" width="200"/>
<img src="assets/Capturas/home.jpg" alt="Home" width="200"/>
<img src="assets/Capturas/ruleta.jpg" alt="Ruleta" width="200"/>
</p>
<p align="center">
<img src="assets/Capturas/drawer.jpg" alt="Drawer" width="200"/>
<img src="assets/Capturas/explorar.jpg" alt="Explorar" width="200"/>
<img src="assets/Capturas/busqueda.jpg" alt="Busqueda" width="200"/>
</p>
<p align="center">
<img src="assets/Capturas/biblioteca.jpg" alt="Biblioteca" width="200"/>
<img src="assets/Capturas/juego.jpg" alt="Juego" width="200"/>
<img src="assets/Capturas/preferencias.jpg" alt="Preferencias" width="200"/>
</p>
<p align="center">
<img src="assets/Capturas/acerca.jpg" alt="Acerca de" width="200"/>
</p>

## Descargar la app

Puedes probar la aplicación descargando el APK:

[ Descargar APK (v1.0.0)](https://github.com/xWTomasWx/VideogameRating/releases/download/v1.0.0/game_gauge.apk)
## Recursos generados 
- [Enlace del proyecto en github](https://github.com/xWTomasWx/VideogameRating)
- [Enlace presentación](https://drive.google.com/file/d/1X0jYLj_HepNChIGcx9ltIi3TE5Sxsyjs/view?usp=sharing)


**Diagrama de clases:**
``` mermaid 
classDiagram
class PreferencesModel {
  _keyThemeMode
  _keyShowSummary
  _keyPlatform
  _keySelectedGenre
  ThemeMode _themeMode
  bool _showSummary
  String? _platformFilter
  String? _selectedGenre
  get themeMode
  get showSummary
  get platformFilter
  get selectedGenre
  prefs
  prefs
  stored
  prefs
  String value
  prefs
  void setThemeMode(ThemeMode mode)
  void setShowSummary(bool value)
  Future<void> setSelectedGenre(String? genre) async
  if (_selectedGenre == null)
  set platformFilter(String? platform)
  if (stored != null)
  switch (stored)
  if (_selectedGenre != null && _selectedGenre!.trim().isEmpty)
  if (platform == null)
}
class DatabaseHelper {
  DatabaseHelper instance
  Database? _database
  dbPath
  path
  db
  db
  result
  db
  db
  result
  Future<void> insertGame(Videojuego juego) async
  Future<List<Videojuego>> getAllGames() async
  Future<void> updateGame(Videojuego juego) async
  Future<void> deleteGame(int id) async
  Future<List<String>> getAllGenres() async
}

class RawgService {
  String _apiKey
  int total
  List<Videojuego> allGames
  int pageSize
  int totalPages
  int page
  url
  response
  data
  List<dynamic> games
  List<String> generos
  return allGames
  Future<List<Videojuego>> fetchPopularGames(
  for (int page = 1; page <= totalPages; page++)
  if (response.statusCode == 200)
  if (json['genres'] != null)
}
class Pregunta {
  String titulo
  String min
  String max
  double valor
}
class Videojuego {
  int? id
  String nombre
  List<String> genero
  double calificacion
  List<String> plataformas
  int anio
  String imagenUrl
  bool favorito
  bool jugado
  bool pendiente
  toMap()
}
class AboutPage {
  routeName
  createState()
}
class FeedbackPage {
  routeName
  createState()
}
class GamePreviewPage {
  Videojuego juego
  VoidCallback? onSaved
  String apiKey
  createState()
}
class GamePage {
  routeName
  createState()
}
class MyHomePage {
  routeName
  String title
  createState()
}
class LibraryPage {
  routeName
  createState()
}
class PreferencesPage {
  routeName
  createState()
}
class ProfilePage {
  routeName
  String title
  createState()
}
class SplashScreen {
  routeName
  String title
  createState()
}
class AppDrawer {
  currentRoute
  Widget build(BuildContext context)
  if (currentRoute != MyHomePage.routeName)
  if (currentRoute != ProfilePage.routeName)
  if (currentRoute != GamePage.routeName)
  if (currentRoute != LibraryPage.routeName)
  if (currentRoute != PreferencesPage.routeName)
  if (currentRoute != AboutPage.routeName)
}
class GameCard {
  String imageUrl
  String gameName
  double rating
  Widget build(BuildContext context)
}
class GameListView {
  List<Widget> games
  Widget build(BuildContext context)
}
Videojuego <-- DatabaseHelper : uses
RawgService --> Videojuego : creates
ImportGames --> RawgService : uses
ImportGames --> DatabaseHelper : uses
GamePreviewPage --> Videojuego : uses
GamePreviewPage --> DatabaseHelper : uses
GamePreviewPage --> PreferencesModel : uses
GamePage --> Videojuego : uses
GamePage --> DatabaseHelper : uses
GamePage --> PreferencesModel : uses
GamePage --> AppDrawer : uses
GamePage --> GamePreviewPage : uses
MyHomePage --> Videojuego : uses
MyHomePage --> DatabaseHelper : uses
MyHomePage --> GameCard : uses
MyHomePage --> AppDrawer : uses
LibraryPage --> Videojuego : uses
LibraryPage --> DatabaseHelper : uses
LibraryPage --> GameCard : uses
LibraryPage --> AppDrawer : uses
LibraryPage --> GamePreviewPage : uses
PreferencesPage --> PreferencesModel : uses
PreferencesPage --> DatabaseHelper : uses
PreferencesPage --> AppDrawer : uses
ProfilePage --> AppDrawer : uses
SplashScreen --> ImportGames : uses
SplashScreen --> MyHomePage : uses
AppDrawer --> MyHomePage : navigates
AppDrawer --> PreferencesPage : navigates
AppDrawer --> ProfilePage : navigates
AppDrawer --> GamePage : navigates
AppDrawer --> LibraryPage : navigates
AppDrawer --> AboutPage : navigates
GameCard <-- MyHomePage : creates
GameCard <-- LibraryPage : creates
FeedbackPage --> Pregunta : uses
AboutPage --> FeedbackPage : navigates


```