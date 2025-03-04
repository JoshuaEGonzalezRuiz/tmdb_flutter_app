import 'package:tmdb_flutter_app/data/datasources/movie_local_datasource.dart';
import 'package:tmdb_flutter_app/data/datasources/movie_remote_datasource.dart';
import 'package:tmdb_flutter_app/data/models/movie_model.dart';
import 'package:tmdb_flutter_app/domain/entities/movie.dart';
import 'package:tmdb_flutter_app/domain/repositories/movie_repository.dart';

/// An implementation of the [MovieRepository] interface for managing movie data.
///
/// [MovieRepositoryImpl] provides the logic for fetching popular movies from
/// a remote data source and caching them locally. It handles data retrieval
/// and conversion from [MovieModel] to [Movie] entities, ensuring that the
/// application can access movie data even when offline.
class MovieRepositoryImpl implements MovieRepository {
  /// The remote data source for fetching movie data from an API.
  final MovieRemoteDataSource remoteDataSource;

  /// The local data source for caching movie data in a local database.
  final MovieLocalDataSource localDataSource;

  /// Creates a [MovieRepositoryImpl] with the given remote and local data sources.
  ///
  /// [remoteDataSource]: The data source for fetching movies from an API.
  /// [localDataSource]: The data source for caching movies locally.
  MovieRepositoryImpl(this.remoteDataSource, this.localDataSource);

  /// Fetches a list of popular movies, either from the remote data source or cache.
  ///
  /// [page]: The page number to fetch. Defaults to 1.
  /// Returns: A [Future] that resolves to a list of [Movie] objects.
  /// If the remote fetch fails, it attempts to return cached movies for the first page.
  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      // Fetches popular movies from the remote data source.
      final List<MovieModel> movieModels = await remoteDataSource
          .getPopularMovies(page: page);
      // Converts the fetched movie models to movie entities.
      final List<Movie> movies = movieModels.map(_convertToMovie).toList();
      // Caches the movies locally if fetching the first page.
      if (page == 1) {
        await localDataSource.cacheMovies(movieModels);
      }
      return movies;
    } catch (e) {
      // Fetches cached movies if the remote fetch fails and it's the first page.
      final List<MovieModel> cachedMovieModels =
          page == 1 ? await localDataSource.getCachedMovies() : [];
      return cachedMovieModels.map(_convertToMovie).toList();
    }
  }

  /// Converts a [MovieModel] to a [Movie] entity.
  ///
  /// [model]: The movie model to convert.
  /// Returns: A [Movie] entity with the same attributes as the model.
  Movie _convertToMovie(MovieModel model) {
    return Movie(
      title: model.title,
      posterPath: model.posterPath,
      overview: model.overview,
      releaseDate: model.releaseDate,
      genreIds: model.genreIds,
      genreNames: model.genreNames,
      adult: model.adult,
      backdropPath: model.backdropPath,
      id: model.id,
      originalLanguage: model.originalLanguage,
      originalTitle: model.originalTitle,
      popularity: model.popularity,
      video: model.video,
      voteAverage: model.voteAverage,
      voteCount: model.voteCount,
    );
  }
}
