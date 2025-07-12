import 'package:flutter/material.dart';
import 'package:data_nime/widget/app_drawer.dart';

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
                'Estudio: NekoCode Studio',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Contacto: josetpffpt@gmail.com, toskareymun@gmail.com',
              ),
              const SizedBox(height: 16),
              const Text(
                'Descripción',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'DataNime es una aplicación intuitiva que le permite explorar, buscar y organizar su colección de animes, marcándolos como favoritos, vistos o pendientes. Con integración a la API de Jikan, ofrece información actualizada, calificaciones, personajes y descripciones de cada anime.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
