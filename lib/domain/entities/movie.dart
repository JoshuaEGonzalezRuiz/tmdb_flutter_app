/// A class representing a movie entity with various attributes.
///
/// [Movie] encapsulates the details of a movie, including its title, poster,
/// overview, release date, genres, and other metadata. This class is used
/// to model movie data retrieved from an external source, such as an API.
class Movie {
  /// The title of the movie.
  final String title;

  /// The path to the movie's poster image.
  final String posterPath;

  /// A brief overview or synopsis of the movie.
  final String overview;

  /// The release date of the movie in YYYY-MM-DD format.
  final String releaseDate;

  /// A list of genre IDs associated with the movie.
  final List<int> genreIds;

  /// A list of genre names associated with the movie.
  final List<String> genreNames;

  /// Indicates whether the movie is intended for adult audiences.
  final bool adult;

  /// The path to the movie's backdrop image.
  final String backdropPath;

  /// The unique identifier for the movie.
  final int id;

  /// The original language of the movie.
  final String originalLanguage;

  /// The original title of the movie.
  final String originalTitle;

  /// The popularity score of the movie.
  final double popularity;

  /// Indicates whether the movie has a video associated with it.
  final bool video;

  /// The average vote rating of the movie.
  final double voteAverage;

  /// The total number of votes the movie has received.
  final int voteCount;

  /// Creates a [Movie] instance with the given attributes.
  ///
  /// All parameters are required and must not be null.
  Movie({
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.genreNames,
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
}
