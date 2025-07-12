# APITEST.md

# Pruebas y uso de la API Jikan en dataNime

---

## 1. Introducción

Este documento describe los endpoints consumidos de la API Jikan (https://jikan.moe/) para obtener información de anime, así como pruebas realizadas y ejemplos de uso en la aplicación dataNime.

---

## 2. Endpoints utilizados

### 2.1. Listado de animes

- **URL:** `https://api.jikan.moe/v4/anime?page={page}`
- **Método:** GET
- **Descripción:** Obtiene un listado paginado de animes populares.
- **Parámetros:**
  - `page`: número de página (entero)

**Ejemplo de petición:**

```http
GET https://api.jikan.moe/v4/anime?page=1
```

**Respuesta (fragmento):**

```json
{
  "data": [
    {
      "mal_id": 1,
      "title": "Cowboy Bebop",
      "score": 8.9,
      "images": {
        "jpg": {
          "large_image_url": "https://cdn.myanimelist.net/images/anime/4/19644.jpg"
        }
      }
    }
  ]
}
```

---

### 2.2. Top animes

- **URL:** `https://api.jikan.moe/v4/top/anime?page={page}`
- **Método:** GET
- **Descripción:** Obtiene la lista de animes mejor puntuados por página.

**Ejemplo de petición:**

```http
GET https://api.jikan.moe/v4/top/anime?page=1
```

---

### 2.3. Búsqueda de animes por texto

- **URL:** `https://api.jikan.moe/v4/anime?q={query}&page={page}`
- **Método:** GET
- **Descripción:** Busca animes que coincidan con el texto `query`.

**Ejemplo:**

```http
GET https://api.jikan.moe/v4/anime?q=naruto&page=1
```

---

### 2.4. Detalle de un anime

- **URL:** `https://api.jikan.moe/v4/anime/{id}`
- **Método:** GET
- **Descripción:** Obtiene detalles específicos de un anime según su ID.

---

### 2.5. Géneros disponibles

- **URL:** `https://api.jikan.moe/v4/genres/anime`
- **Método:** GET
- **Descripción:** Lista de géneros disponibles para filtrar animes.

---

## 3. Pruebas realizadas

### 3.1. Validación de conexión

- Se valida que la app pueda conectarse a internet antes de hacer solicitudes a la API.
- En caso de no haber conexión, se muestra una pantalla para reintentar.

### 3.2. Consumo de endpoints

- Se probaron exitosamente las peticiones a los endpoints mencionados.
- Se verificó que las respuestas contienen los datos necesarios para el funcionamiento de la app.

### 3.3. Traducción de campos

- Algunos campos (géneros, sinopsis) son traducidos con Google Translator antes de mostrarse en la app.

### 3.4. Filtrado

- Se implementó filtrado por géneros usando el listado oficial de géneros de la API.

### 3.5. Control de contenido adulto

- Se excluyen géneros como "Hentai", "Ecchi" y "Erotica" para evitar contenido explícito.

---

## 4. Código ejemplo para obtener top animes

```dart
Future<List<AnimePreview>> jikanGetTopAnimePreviews(int page) async {
  final response = await http.get(
    Uri.parse('https://api.jikan.moe/v4/top/anime?page=$page'),
  );

  if (response.statusCode != 200) {
    throw Exception("Error al obtener topAnimes");
  }

  final data = jsonDecode(response.body);
  final List<dynamic> topAnimes = data['data'];

  return topAnimes.map<AnimePreview>((anime) {
    return AnimePreview(
      id: anime["mal_id"],
      score: (anime["score"] as num?)?.toDouble() ?? 0.0,
      urlImage: anime["images"]["jpg"]["large_image_url"],
      title: anime["title"],
    );
  }).toList();
}
```

---

## 5. Resultados

- La aplicación muestra correctamente listados de animes, con imágenes y puntuación.
- La búsqueda y filtrado funcionan correctamente.
- La app maneja errores de conexión y ausencia de resultados de manera amigable.

---

## 6. Conclusión

La API Jikan es adecuada para proporcionar la información de anime necesaria para la app dataNime, y permite funcionalidades como búsqueda, filtrado y acceso a datos detallados.

---

**Fin de documento**
