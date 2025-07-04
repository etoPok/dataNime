
# Datanime

**Datanime** es una aplicación móvil desarrollada en Flutter que permite a los usuarios explorar información de animes, consultar detalles como personajes, y organizar su progreso mediante listas de favoritos, vistos y pendientes. Utiliza la API Jikan (basada en MyAnimeList) para obtener datos actualizados de manera eficiente. Esta aplicación busca ofrecer una experiencia fluida y centralizada para los fanáticos del anime que desean llevar un control personalizado de lo que ven.

## Indice

- [Datos de los creadores](#datos-de-los-creadores)

- [API Utilizada — Jikan](#api-utilizada---jikan)


## Datos de los creadores

- **Nombre**: Jostin Duval y José Peña.

- **Universidad**: Universidad de Talca.

- **Carrera**: Ingeniera en desarrollo de videojuegos y realidad virtual.

- **Modulo**: Programacion para dispositivos moviles.

- **Profesor**: Manuel Moscoso.


## API Utilizada — Jikan

Se realizaron pruebas para comprobar el funcionamiento de la API antes de integrarla en la app. Las evidencias y endpoints utilizados se detallan a continuación.

### Endpoints probados:
Búsqueda de animes relacionados a naruto: `GET /anime?q=naruto&limit=3`
Detalle de un anime específico (Fullmetal Alchemist): `GET /anime/5114`
Personajes de un anime (Fullmetal Alchemist): `GET /anime/5114/characters`

### Evidencia de pruebas

Las respuestas de la API se obtuvieron usando Postman. A continuación, se incluyen ejemplos en formato `.json`:

- [`respuesta_busqueda_naruto.json`](docs/api-jikan/respuesta_naruto.json)
- [`respuesta_detalle_fullmetal.json`](docs/api-jikan/respuesta_FMA.json)
- [`respuesta_personajes_fullmetal.json`](docs/api-jikan/respuesta_FMA_personajes.json)

La colección de pruebas puede encontrarse aquí:  
[`jikan_api_test_collection.json`](docs/api-jikan/Jikan API.postman_collection.json)


### Referencia oficial de la API

- [https://docs.api.jikan.moe/](https://docs.api.jikan.moe/)



