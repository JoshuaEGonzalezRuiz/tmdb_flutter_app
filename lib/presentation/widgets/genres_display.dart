import 'package:flutter/material.dart';

/// A widget that displays a list of genres as chips.
///
/// [GenresDisplay] is a stateless widget that shows a list of genre names
/// as [Chip] widgets in a wrap layout. It provides spacing between the chips
/// for better visual separation.
class GenresDisplay extends StatelessWidget {
  /// The list of genre names to display.
  final List<String> genreNames;

  /// Creates a [GenresDisplay] widget.
  ///
  /// The [genreNames] parameter is required and must not be null.
  const GenresDisplay({super.key, required this.genreNames});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: genreNames.map((genre) => Chip(label: Text(genre))).toList(),
    );
  }
}
