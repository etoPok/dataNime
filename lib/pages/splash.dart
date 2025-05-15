import 'package:flutter/material.dart';
import 'package:videogame_rating/pages/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});

  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: "Game Gauge"),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/Logo.png'),
            Text(
              'Game Gauge',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
