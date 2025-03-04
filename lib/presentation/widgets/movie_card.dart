import 'package:flutter/material.dart';
import 'package:tmdb_flutter_app/presentation/widgets/movie_image.dart';

import '../../domain/entities/movie.dart';

/// A widget that displays a movie card with a poster image.
///
/// [MovieCard] is a stateless widget that shows a movie's poster image
/// inside a card with rounded corners and a shadow effect. It triggers
/// the [onTap] callback when tapped.
class MovieCard extends StatelessWidget {
  /// The movie to display in the card.
  final Movie movie;

  /// The callback to trigger when the card is tapped.
  final VoidCallback onTap;

  /// Creates a [MovieCard] widget.
  ///
  /// The [movie] and [onTap] parameters are required.
  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1), // Corrected method
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: MovieImage(posterPath: movie.posterPath, height: 220),
        ),
      ),
    );
  }
}
