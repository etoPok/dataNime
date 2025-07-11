import 'package:flutter/material.dart';
import 'package:data_nime/pages/home.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});
  static const routeName = '/splash';
  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _checkingConnection = true;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    setState(() {
      _checkingConnection = true;
    });

    final hasConnection = await _hasRealInternet();

    if (!mounted) return;

    if (hasConnection) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: "dataNime"),
        ),
      );
    } else {
      setState(() {
        _checkingConnection = false;
      });
    }
  }

  Future<bool> _hasRealInternet() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) return false;

    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(2, 2, 2, 1),
      body: Center(
        child:
            _checkingConnection
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/anime_icon.png', height: 300),
                    const SizedBox(height: 12),
                    Text(
                      'dataNime',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const CircularProgressIndicator(),
                  ],
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'Sin conexión a internet',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _checkConnection,
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
      ),
    );
  }
}
