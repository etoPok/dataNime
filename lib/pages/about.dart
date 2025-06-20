import 'package:flutter/material.dart';
import 'package:videogame_rating/widget/app_drawer.dart';
import 'package:videogame_rating/pages/feedback.dart';

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
                'Esta aplicación permite explorar, calificar y gestionar videojuegos, ofreciendo una experiencia organizada y personalizable.',
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
