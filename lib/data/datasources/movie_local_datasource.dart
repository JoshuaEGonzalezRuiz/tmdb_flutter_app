import 'package:isar/isar.dart';
import 'package:tmdb_flutter_app/data/models/movie_model.dart';

/// A data source class for managing local movie data storage using Isar.
///
/// [MovieLocalDataSource] provides methods to cache movie data locally
/// and retrieve cached movies from the Isar database. It facilitates
/// offline access to movie data by storing and querying [MovieModel] objects.
class MovieLocalDataSource {
  /// The Isar database instance used for local data storage.
  final Isar _isar;

  /// Creates a [MovieLocalDataSource] with the given Isar database instance.
  ///
  /// [_isar]: The Isar database instance used for storing and retrieving movie data.
  MovieLocalDataSource(this._isar);

  /// Caches a list of movies in the local database.
  ///
  /// [movies]: The list of [MovieModel] objects to be cached.
  /// This method performs a write transaction to store the movies in the database.
  Future<void> cacheMovies(List<MovieModel> movies) async {
    await _isar.writeTxn(() async {
      await _isar.movieModels.putAll(movies);
    });
  }

  /// Retrieves all cached movies from the local database.
  ///
  /// Returns: A [Future] that resolves to a list of [MovieModel] objects
  /// representing the cached movies.
  Future<List<MovieModel>> getCachedMovies() async {
    return await _isar.movieModels.where().findAll();
  }
}
