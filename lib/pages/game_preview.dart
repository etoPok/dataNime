import 'package:flutter/material.dart';
import 'package:data_nime/domain/entities/videogame.dart';
import 'package:data_nime/data/services/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:data_nime/data/models/preferences_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:translator/translator.dart';

class GamePreviewPage extends StatefulWidget {
  final Videojuego juego;
  final VoidCallback? onSaved;
  final String apiKey = 'eb23da9e656e4b40a1014b96087bfdd6';

  const GamePreviewPage({super.key, required this.juego, this.onSaved});

  @override
  State<GamePreviewPage> createState() => _GamePreviewPageState();
}

class _GamePreviewPageState extends State<GamePreviewPage> {
  late bool favorito;
  late bool jugado;
  late bool pendiente;

  String? description;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    favorito = widget.juego.favorito;
    jugado = widget.juego.jugado;
    pendiente = widget.juego.pendiente;
    _loadDescription();
  }

  Future<String> traducirTexto(String textoOriginal) async {
    final translator = GoogleTranslator();
    final translation = await translator.translate(textoOriginal, to: 'es');
    return translation.text;
  }

  Future<void> _loadDescription() async {
    final desc = await fetchDescriptionByName(
      widget.juego.nombre,
      widget.apiKey,
    );
    final traducida =
        desc != null ? await traducirTexto(desc) : 'Descripción no disponible.';

    if (!mounted) return;
    setState(() {
      description = traducida;
      isLoading = false;
    });
  }

  Future<String?> fetchDescriptionByName(String gameName, String apiKey) async {
    final url = Uri.parse(
      'https://api.rawg.io/api/games?search=${Uri.encodeComponent(gameName)}&key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        // Elige el primer resultado que más se asemeje
        final firstGame = results[0];

        // Si el campo description no está en este endpoint,
        // hay que hacer otra llamada a /games/{id}
        final gameId = firstGame['id'];
        final detailUrl = Uri.parse(
          'https://api.rawg.io/api/games/$gameId?key=$apiKey',
        );
        final detailResponse = await http.get(detailUrl);

        if (detailResponse.statusCode == 200) {
          final detailData = json.decode(detailResponse.body);
          return detailData['description_raw'] ?? 'Descripción no disponible.';
        }
      }
    }
    return null;
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
    if (widget.onSaved != null) widget.onSaved!();
  }

  Widget _buildToggleButton({
    required IconData icon,
    required String label,
    required bool value,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
  }) {
    final colorActive = colorScheme.primary;
    final colorInactive = colorScheme.onSurface;

    return Expanded(
      child: TextButton.icon(
        onPressed: () async {
          onTap();
          await _guardarCambios();
        },
        icon: Icon(icon, color: value ? colorActive : colorInactive),
        label: Text(
          label,
          style: TextStyle(color: value ? colorActive : colorInactive),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showSummary = context.watch<PreferencesModel>().showSummary;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(widget.juego.nombre)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
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
                    color: colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: Text(
                        'Imagen no disponible',
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Género: ${widget.juego.genero}',
              style: TextStyle(fontSize: 18, color: colorScheme.onSurface),
            ),
            Text(
              'Año: ${widget.juego.anio}',
              style: TextStyle(fontSize: 18, color: colorScheme.onSurface),
            ),
            Text(
              'Plataformas: ${widget.juego.plataformas.join(", ")}',
              style: TextStyle(fontSize: 18, color: colorScheme.onSurface),
            ),
            Text(
              'Calificación: ${widget.juego.calificacion.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 18, color: colorScheme.onSurface),
            ),
            if (showSummary)
              Text(
                'Descripción:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            SizedBox(height: 8),
            if (showSummary)
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Text(description ?? 'No hay descripción'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToggleButton(
                  icon: Icons.favorite,
                  label: 'Favorito',
                  value: favorito,
                  onTap: () => setState(() => favorito = !favorito),
                  colorScheme: colorScheme,
                ),
                _buildToggleButton(
                  icon: Icons.check_box,
                  label: 'Jugado',
                  value: jugado,
                  onTap: () => setState(() => jugado = !jugado),
                  colorScheme: colorScheme,
                ),
                _buildToggleButton(
                  icon: Icons.schedule,
                  label: 'Por jugar',
                  value: pendiente,
                  onTap: () => setState(() => pendiente = !pendiente),
                  colorScheme: colorScheme,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
