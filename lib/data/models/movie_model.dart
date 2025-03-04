import 'package:isar/isar.dart';
import 'package:tmdb_flutter_app/core/utils/constants.dart';
import 'package:tmdb_flutter_app/domain/entities/movie.dart';

part 'movie_model.g.dart';

/// A data model class representing a movie, used for database storage.
///
/// [MovieModel] is an Isar collection that stores movie details such as title,
/// poster path, overview, release date, genres, and other metadata. It provides
/// methods for JSON serialization and conversion to the [Movie] entity.
@collection
class MovieModel {
  /// The unique identifier for the movie, automatically incremented by Isar.
  Id id = Isar.autoIncrement;

  /// The title of the movie.
  late String title;

  /// The path to the movie's poster image.
  late String posterPath;

  /// A brief overview or synopsis of the movie.
  late String overview;

  /// The release date of the movie in YYYY-MM-DD format.
  late String releaseDate;

  /// A list of genre IDs associated with the movie.
  final List<int> genreIds;

  /// A list of genre names associated with the movie.
  final List<String> genreNames;

  /// Indicates whether the movie is intended for adult audiences.
  late bool adult;

  /// The path to the movie's backdrop image.
  late String backdropPath;

  /// The original language of the movie.
  late String originalLanguage;

  /// The original title of the movie.
  late String originalTitle;

  /// The popularity score of the movie.
  late double popularity;

  /// Indicates whether the movie has a video associated with it.
  late bool video;

  /// The average vote rating of the movie.
  late double voteAverage;

  /// The total number of votes the movie has received.
  late int voteCount;

  /// Creates a [MovieModel] instance with the given attributes.
  ///
  /// All parameters are required and must not be null.
  MovieModel({
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.genreNames,
    required this.adult,
    required this.backdropPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  /// Creates a [MovieModel] from a JSON object and a genre map.
  ///
  /// [json]: The JSON object containing movie data.
  /// [genreMap]: A map of genre IDs to genre names for conversion.
  /// Returns: A [MovieModel] instance populated with data from the JSON object.
  factory MovieModel.fromJson(
    Map<String, dynamic> json,
    Map<int, String> genreMap,
  ) => MovieModel(
    title: json['title'],
    posterPath: json['poster_path'] ?? '',
    overview: json['overview'],
    releaseDate: json['release_date'] ?? '',
    genreIds: List<int>.from(json['genre_ids']),
    genreNames:
        List<int>.from(
          json['genre_ids'],
        ).map((id) => genreMap[id] ?? Constants.unknown).toList(),
    adult: json['adult'] ?? false,
    backdropPath: json['backdrop_path'] ?? '',
    originalLanguage: json['original_language'] ?? '',
    originalTitle: json['original_title'] ?? '',
    popularity: (json['popularity'] ?? 0).toDouble(),
    video: json['video'] ?? false,
    voteAverage: (json['vote_average'] ?? 0).toDouble(),
    voteCount: json['vote_count'] ?? 0,
  );

  /// Converts the [MovieModel] to a [Movie] entity.
  ///
  /// [genreMap]: A map of genre IDs to genre names for conversion.
  /// Returns: A [Movie] entity with the same attributes as the model.
  Movie toEntity(Map<int, String> genreMap) => Movie(
    title: title,
    posterPath: posterPath,
    overview: overview,
    releaseDate: releaseDate,
    genreIds: genreIds,
    genreNames:
        genreIds.map((id) => genreMap[id] ?? Constants.unknown).toList(),
    adult: adult,
    backdropPath: backdropPath,
    id: id,
    originalLanguage: originalLanguage,
    originalTitle: originalTitle,
    popularity: popularity,
    video: video,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );
}
