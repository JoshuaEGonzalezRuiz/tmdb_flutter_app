import 'package:dio/dio.dart';
import 'package:tmdb_flutter_app/core/utils/error_messages.dart';
import 'package:tmdb_flutter_app/data/models/genre_model.dart';
import 'package:tmdb_flutter_app/data/models/movie_model.dart';

/// A data source class for fetching movie data from a remote API.
///
/// [MovieRemoteDataSource] uses the Dio HTTP client to perform network
/// requests to the TMDB API. It provides methods to fetch genres and
/// popular movies, handling errors and mapping JSON responses to model
/// objects.
class MovieRemoteDataSource {
  /// The Dio HTTP client used for making network requests.
  final Dio _dio;

  /// The API endpoint path for fetching the list of movie genres.
  static const String genreListPath = '/genre/movie/list';

  /// The API endpoint path for fetching popular movies.
  static const String popularMoviesPath = '/movie/popular';

  /// Creates a [MovieRemoteDataSource] with the given Dio client.
  ///
  /// [dio]: The Dio client used for making HTTP requests.
  MovieRemoteDataSource(this._dio);

  /// Fetches a map of genre IDs to genre names from the API.
  ///
  /// Returns: A [Future] that resolves to a map of genre IDs to names.
  /// Throws: An [Exception] with an appropriate error message if the request fails.
  Future<Map<int, String>> getGenres() async {
    try {
      final response = await _dio.get(genreListPath);
      if (response.statusCode == 200) {
        return _mapGenres(response.data['genres']);
      } else {
        throw Exception(ErrorMessages.apiError);
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception(ErrorMessages.unknownError);
    }
  }

  /// Fetches a list of popular movies from the API.
  ///
  /// [page]: The page number to fetch. Defaults to 1.
  /// Returns: A [Future] that resolves to a list of [MovieModel] objects.
  /// Throws: An [Exception] with an appropriate error message if the request fails.
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    try {
      final genreMap = await getGenres();
      final response = await _dio.get(
        popularMoviesPath,
        queryParameters: {'page': page},
      );
      if (response.statusCode == 200) {
        return _mapMovies(response.data, genreMap);
      } else {
        throw Exception(ErrorMessages.apiError);
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception(ErrorMessages.unknownError);
    }
  }

  /// Maps a list of genre JSON objects to a map of genre IDs to names.
  ///
  /// [genresJson]: The list of genre JSON objects.
  /// Returns: A map of genre IDs to genre names.
  Map<int, String> _mapGenres(List<dynamic> genresJson) {
    final genres = genresJson.map((json) => GenreModel.fromJson(json)).toList();
    return {for (var genre in genres) genre.id: genre.name};
  }

  /// Maps a JSON response to a list of [MovieModel] objects.
  ///
  /// [responseData]: The JSON response data containing movie information.
  /// [genreMap]: A map of genre IDs to genre names for conversion.
  /// Returns: A list of [MovieModel] objects.
  List<MovieModel> _mapMovies(dynamic responseData, Map<int, String> genreMap) {
    List<dynamic> dataList;
    if (responseData is Map<String, dynamic> &&
        responseData.containsKey('results')) {
      dataList = responseData['results'];
    } else {
      dataList = responseData;
    }
    return dataList.map((item) => MovieModel.fromJson(item, genreMap)).toList();
  }

  /// Handles Dio-specific errors and returns a user-friendly error message.
  ///
  /// [e]: The [DioException] to handle.
  /// Returns: A string containing a user-friendly error message.
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ErrorMessages.timeoutError;
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 401:
            return ErrorMessages.unauthorizedError;
          case 404:
            return ErrorMessages.notFoundError;
          default:
            return ErrorMessages.apiError;
        }
      case DioExceptionType.unknown:
        return ErrorMessages.networkError;
      default:
        return ErrorMessages.unknownError;
    }
  }
}
