import 'package:tmdb_flutter_app/domain/entities/movie.dart';
import 'package:tmdb_flutter_app/domain/repositories/movie_repository.dart';

/// A use case class for fetching popular movies from a repository.
///
/// [GetPopularMovies] encapsulates the logic for retrieving a list of popular
/// movies from a [MovieRepository]. It provides a method to fetch movies
/// asynchronously, allowing for pagination by specifying a page number.
class GetPopularMovies {
  /// The repository used to fetch popular movies.
  final MovieRepository repository;

  /// Creates a [GetPopularMovies] use case with the given [repository].
  ///
  /// The [repository] parameter must not be null and is required to perform
  /// the movie fetching operations.
  GetPopularMovies(this.repository);

  /// Fetches a list of popular movies from the repository.
  ///
  /// [page]: The page number to fetch. Defaults to 1.
  /// Returns: A [Future] that resolves to a list of [Movie] objects.
  Future<List<Movie>> call({int page = 1}) async {
    return await repository.getPopularMovies(page: page);
  }
}
