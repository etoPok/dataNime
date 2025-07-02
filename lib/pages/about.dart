import 'package:flutter/material.dart';
import 'package:data_nime/widget/app_drawer.dart';
import 'package:data_nime/pages/feedback.dart';

class AboutPage extends StatefulWidget {
  static const routeName = '/about';
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text('Acerca de la App')),
        drawer: const AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Desarrollador: José Peña',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Contacto: josetpffpt@gmail.com'),
              const SizedBox(height: 16),
              const Text(
                'Descripción',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'Game Gauge es una aplicación intuitiva que te permite explorar, buscar y organizar tu colección de videojuegos, marcándolos como favoritos, jugados o pendientes. Con integración a la API de RAWG, ofrece información actualizada, calificaciones y descripciones de cada juego, además de búsqueda por voz para facilitar la experiencia.',
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  child: const Text('Valorar'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FeedbackPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
