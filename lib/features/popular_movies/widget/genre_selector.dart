import 'package:flutter/material.dart';

class GenreSelector extends StatefulWidget {
  final List<String> genres;
  final Function(List<String>) onSelectedGenresChanged;

  const GenreSelector({
    super.key,
    required this.genres,
    required this.onSelectedGenresChanged,
  });

  @override
  _GenreSelectorState createState() => _GenreSelectorState();
}

class _GenreSelectorState extends State<GenreSelector> {
  List<String> selectedGenres = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.genres.map((genre) {
          final isSelected = selectedGenres.contains(genre);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(genre),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedGenres.add(genre);
                  } else {
                    selectedGenres.remove(genre);
                  }
                });
                widget.onSelectedGenresChanged(selectedGenres);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
