import 'package:tmdb_flutter_app/domain/entities/movie.dart';

/// An abstract class that defines the contract for a movie repository.
///
/// [MovieRepository] provides an interface for fetching movie data,
/// specifically popular movies, from a data source. Implementations of
/// this interface are responsible for providing the actual data retrieval
/// logic, which could involve network requests, database queries, or other
/// data access methods.
abstract class MovieRepository {
  /// Fetches a list of popular movies.
  ///
  /// [page]: The page number to fetch. Defaults to 1.
  /// Returns: A [Future] that resolves to a list of [Movie] objects.
  Future<List<Movie>> getPopularMovies({int page = 1});
}
