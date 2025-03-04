import 'package:flutter/material.dart';
import 'package:tmdb_flutter_app/domain/entities/movie.dart';
import 'package:tmdb_flutter_app/presentation/widgets/genres_display.dart';
import 'package:tmdb_flutter_app/presentation/widgets/movie_image.dart';
import 'package:tmdb_flutter_app/presentation/widgets/movie_title_rating.dart';
import 'package:tmdb_flutter_app/presentation/widgets/sinopsis_display.dart';

/// A page that displays detailed information about a movie.
///
/// [MovieDetailPage] shows the movie's poster, title, rating, release date,
/// genres, and synopsis in a scrollable layout.
class MovieDetailPage extends StatelessWidget {
  /// The movie to display details for.
  final Movie movie;

  /// Creates a [MovieDetailPage] widget.
  ///
  /// The [movie] parameter is required and must not be null.
  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieImage(posterPath: movie.posterPath, height: 400),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieTitleRating(
                    title: movie.title,
                    voteAverage: movie.voteAverage,
                    releaseDate: movie.releaseDate,
                  ),
                  const SizedBox(height: 12),
                  GenresDisplay(genreNames: movie.genreNames),
                  const SizedBox(height: 12),
                  SynopsisDisplay(overview: movie.overview),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
