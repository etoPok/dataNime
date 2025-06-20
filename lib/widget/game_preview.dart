import 'package:flutter/material.dart';
import 'package:videogame_rating/domain/entities/videogame.dart';
import 'package:videogame_rating/data/services/database_helper.dart';

class GamePreviewWidget extends StatefulWidget {
  final Videojuego juego;
  final VoidCallback? onSaved;

  const GamePreviewWidget({super.key, required this.juego, this.onSaved});

  @override
  State<GamePreviewWidget> createState() => _GamePreviewWidgetState();
}

class _GamePreviewWidgetState extends State<GamePreviewWidget> {
  late bool favorito;
  late bool jugado;
  late bool pendiente;

  @override
  void initState() {
    super.initState();
    favorito = widget.juego.favorito;
    jugado = widget.juego.jugado;
    pendiente = widget.juego.pendiente;
  }

  Future<void> _guardarCambios() async {
    final juegoActualizado = Videojuego(
      id: widget.juego.id,
      nombre: widget.juego.nombre,
      genero: widget.juego.genero,
      calificacion: widget.juego.calificacion,
      plataformas: widget.juego.plataformas,
      anio: widget.juego.anio,
      imagenUrl: widget.juego.imagenUrl,
      favorito: favorito,
      jugado: jugado,
      pendiente: pendiente,
    );
    await DatabaseHelper.instance.updateGame(juegoActualizado);
    if (widget.onSaved != null) {
      widget.onSaved!();
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.juego.imagenUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder:
                (_, __, ___) => Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(child: Text('Imagen no disponible')),
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Género: ${widget.juego.genero}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Año: ${widget.juego.anio}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Plataformas: ${widget.juego.plataformas.join(", ")}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Calificación: ${widget.juego.calificacion.toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 24),
          CheckboxListTile(
            title: const Text('Favorito'),
            value: favorito,
            onChanged: (val) => setState(() => favorito = val ?? false),
          ),
          CheckboxListTile(
            title: const Text('Jugado'),
            value: jugado,
            onChanged: (val) => setState(() => jugado = val ?? false),
          ),
          CheckboxListTile(
            title: const Text('Por jugar'),
            value: pendiente,
            onChanged: (val) => setState(() => pendiente = val ?? false),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _guardarCambios,
              child: const Text('Guardar'),
            ),
          ),
        ],
      ),
    );
  }
}
