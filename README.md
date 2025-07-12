
# dataNime

**dataNime** es una aplicación móvil desarrollada en Flutter que permite a los usuarios explorar información de animes, consultar detalles como personajes, y organizar su progreso mediante listas de favoritos, vistos y pendientes. Utiliza la API Jikan (basada en MyAnimeList) para obtener datos actualizados de manera eficiente. Esta aplicación busca ofrecer una experiencia fluida y centralizada para los fanáticos del anime que desean llevar un control personalizado de lo que ven.

## Indice

- [Datos de los creadores](#datos-de-los-creadores)

- [API Utilizada - Jikan](#api-utilizada---jikan)

- [Estructura del Proyecto](#estructura-del-proyecto)

- [Lista de actividades](#lista-de-actividades)

- [Funcionalidades principales](#funcionalidades-principales)


## Datos de los creadores

- **Nombre**: Jostin Duval y José Peña.

- **Universidad**: Universidad de Talca.

- **Carrera**: Ingeniera en desarrollo de videojuegos y realidad virtual.

- **Modulo**: Programacion para dispositivos moviles.

- **Profesor**: Manuel Moscoso.


## API Utilizada — Jikan

Se realizaron pruebas para comprobar el funcionamiento de la API antes de integrarla en la app. Las evidencias y endpoints utilizados se detallan a continuación.

### Endpoints probados:
- Búsqueda de animes relacionados a naruto: `GET /anime?q=naruto&limit=3`
- Detalle de un anime específico (Fullmetal Alchemist): `GET /anime/5114`
- Personajes de un anime (Fullmetal Alchemist): `GET /anime/5114/characters`

### Evidencia de pruebas

Las respuestas de la API se obtuvieron usando Postman. A continuación, se incluyen ejemplos en formato `.json`:

- [`respuesta_busqueda_naruto.json`](docs/api-jikan/respuesta_naruto.json)
- [`respuesta_detalle_fullmetal.json`](docs/api-jikan/respuesta_FMA.json)
- [`respuesta_personajes_fullmetal.json`](docs/api-jikan/respuesta_FMA_personajes.json)

La colección de pruebas puede encontrarse aquí:  
[`jikan_api_test_collection.json`](docs/api-jikan/Jikan%20API.postman_collection.json)


### Referencia oficial de la API

- [https://docs.api.jikan.moe/](https://docs.api.jikan.moe/)

## Estructura del Proyecto

El proyecto está organizado en capas siguiendo una arquitectura limpia y modular. A continuación, se describe el propósito de cada carpeta:
```
lib/
├── data/ # Datos crudos: modelos y servicios externos
│ ├── models/ # Modelos de datos o archivos base
│ └── services/ # Servicios de conexión a la API Jikan
│
├── domain/ # Lógica central: entidades y casos de uso
│ └── entities/ # Entidades de dominio (compartidas)
│
├── pages/ # Pantallas principales de la app (UI de cada vista)
│ # Ej: HomePage, LibraryPage, PreferencesPage, etc.
│
├── theme/ # Configuración del tema visual: colores, estilos
│
├── widget/ # Widgets reutilizables (tarjetas, botones, listas)
│
└── main.dart # Punto de entrada de la aplicación
```

## Lista de actividades

### José Peña
- [x] Desarrollar un widget para mostrar los animes en forma de tarjeta.
- [x] Crear una pantalla para visualizar la información de un anime.
- [x] Diseñar el logo de la aplicación.
- [ ] Implementar las preferencias del usuario.
- [x] Implementar sección de busqueda de animes, con filtro de generos.

### Jostin Duval
- [x] Implementar la lógica para ver los mejores animes mediante una pantalla de exploración.
- [x] Crear una pantalla para visualizar la información de los personajes de un anime.
- [x] Implementar la lógica de favoritos utilizando una base de datos local.
- [ ] Agregar filtros por género, estado o año.
- [ ] Crear una pantalla de "Acerca de la app" con créditos.

## Funcionalidades principales

- **Buscar animes por nombre**
- **Explorar los animes mejor puntuados**
- **Filtrar por género**
- **Ver detalles completos de un anime**
- **Reproducir trailers**
- **Ver personajes principales**
- **Recomendaciones basadas en animes**
- **Soporte para modo oscuro**
- **Interacción con apps externas**