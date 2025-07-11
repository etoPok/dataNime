import 'package:flutter/material.dart';
import 'package:data_nime/pages/anime_search.dart';

class GenreFilterSheet extends StatefulWidget {
  final List<Genre> allGenres;
  final Set<int> selectedGenres;

  const GenreFilterSheet({
    super.key,
    required this.allGenres,
    required this.selectedGenres,
  });

  @override
  State<GenreFilterSheet> createState() => _GenreFilterSheetState();
}

class _GenreFilterSheetState extends State<GenreFilterSheet> {
  late Set<int> tempSelectedGenres;

  @override
  void initState() {
    super.initState();
    tempSelectedGenres = Set<int>.from(widget.selectedGenres);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Selecciona géneros',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: widget.allGenres.length,
                itemBuilder: (context, index) {
                  final genre = widget.allGenres[index];
                  final isSelected = tempSelectedGenres.contains(genre.id);
                  return CheckboxListTile(
                    title: Text(genre.name),
                    value: isSelected,
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          tempSelectedGenres.add(genre.id);
                        } else {
                          tempSelectedGenres.remove(genre.id);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.pop(context, null),
                ),
                TextButton(
                  child: const Text('Aplicar'),
                  onPressed: () => Navigator.pop(context, tempSelectedGenres),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
