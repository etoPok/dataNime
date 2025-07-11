import 'package:flutter/material.dart';

import 'package:data_nime/widget/app_drawer.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  static const routeName = '/games';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final TextEditingController _searchController = TextEditingController();

  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();

    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            if (!mounted) return;
            setState(() {
              _searchController.text = result.recognizedWords;
            });
          },
          listenFor: const Duration(seconds: 5),
          pauseFor: const Duration(seconds: 3),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explorar animes')),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,

                    decoration: const InputDecoration(
                      labelText: 'Buscar por nombre',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  onPressed: _listen,
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: Row(mainAxisSize: MainAxisSize.min),
                  onTap: () async {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
