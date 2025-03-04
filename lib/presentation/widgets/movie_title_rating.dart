import 'package:flutter/material.dart';

/// A widget that displays the movie title, rating, and release date.
///
/// [MovieTitleRating] is a stateless widget that shows the movie's title,
/// average vote rating, and release date in a structured format.
class MovieTitleRating extends StatelessWidget {
  /// The title of the movie.
  final String title;

  /// The average vote rating of the movie.
  final double voteAverage;

  /// The release date of the movie.
  final String releaseDate;

  /// Creates a [MovieTitleRating] widget.
  ///
  /// The [title], [voteAverage], and [releaseDate] parameters are required.
  const MovieTitleRating({
    super.key,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    // Define a common text style for headlines.
    final headlineStyle = Theme.of(
      context,
    ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: headlineStyle),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 24),
            const SizedBox(width: 4),
            Text(voteAverage.toStringAsFixed(1), style: headlineStyle),
            const Spacer(),
            const Icon(Icons.date_range, color: Colors.blueGrey, size: 24),
            const SizedBox(width: 4),
            Text(releaseDate, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
