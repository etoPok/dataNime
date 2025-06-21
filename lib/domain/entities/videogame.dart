class Videojuego {
  final int? id;
  final String nombre;
  final String genero;
  final double calificacion;
  final List<String> plataformas;
  final int anio;
  final String imagenUrl;
  final bool favorito;
  final bool jugado;
  final bool pendiente;

  Videojuego({
    this.id,
    required this.nombre,
    required this.genero,
    required this.calificacion,
    required this.plataformas,
    required this.anio,
    required this.imagenUrl,
    this.favorito = false,
    this.jugado = false,
    this.pendiente = false,
  });

  Videojuego copyWith({
    int? id,
    String? nombre,
    String? genero,
    double? calificacion,
    List<String>? plataformas,
    int? anio,
    String? imagenUrl,
    bool? favorito,
    bool? jugado,
    bool? pendiente,
  }) {
    return Videojuego(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      genero: genero ?? this.genero,
      calificacion: calificacion ?? this.calificacion,
      plataformas: plataformas ?? this.plataformas,
      anio: anio ?? this.anio,
      imagenUrl: imagenUrl ?? this.imagenUrl,
      favorito: favorito ?? this.favorito,
      jugado: jugado ?? this.jugado,
      pendiente: pendiente ?? this.pendiente,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'genero': genero,
      'calificacion': calificacion,
      'plataformas': plataformas.join(','),
      'anio': anio,
      'imagenUrl': imagenUrl,
      'favorito': favorito ? 1 : 0,
      'jugado': jugado ? 1 : 0,
      'pendiente': pendiente ? 1 : 0,
    };
  }

  factory Videojuego.fromMap(Map<String, dynamic> map) {
    return Videojuego(
      id: map['id'],
      nombre: map['nombre'],
      genero: map['genero'],
      calificacion: map['calificacion'],
      plataformas: (map['plataformas'] as String).split(','),
      anio: map['anio'],
      imagenUrl: map['imagenUrl'],
      favorito: map['favorito'] == 1,
      jugado: map['jugado'] == 1,
      pendiente: map['pendiente'] == 1,
    );
  }
}
