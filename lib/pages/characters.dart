import 'package:data_nime/pages/character_info.dart';
import 'package:flutter/material.dart';
import 'package:data_nime/data/services/jikan_service.dart';
import 'package:data_nime/domain/entities/character_preview.dart';
import 'package:data_nime/widget/card_preview_character.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});
  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  int _currentPage = 1;
  List<CharacterPreview> characters = [];
  bool requestInProgress = false;

  @override
  void initState() {
    super.initState();
    _loadAnimes();
  }

  void _loadAnimes() async {
    characters = await jikanGetTopCharacterPreviews(_currentPage);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personajes")),
      body: !requestInProgress ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 0.6,
        ),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          return PreviewCharacterCard(
            imageUrl: characters[index].urlImage,
            characterName: characters[index].name,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CharacterInfoPage(characterId: characters[index].id)
                ),
              );
            },
          );
        },
      ) : Center(child: CircularProgressIndicator()),
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () async {
                if (requestInProgress || _currentPage <= 1) return;
                setState(() {
                  _currentPage--;
                  requestInProgress = true;
                });
                characters = await jikanGetTopCharacterPreviews(_currentPage);
                setState(() {
                  requestInProgress = false;
                });
              },
            ),
            Text("$_currentPage"),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if (requestInProgress) return;
                setState(() {
                  _currentPage++;
                  requestInProgress = true;
                });
                characters = await jikanGetTopCharacterPreviews(_currentPage);
                setState(() {
                  requestInProgress = false;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
