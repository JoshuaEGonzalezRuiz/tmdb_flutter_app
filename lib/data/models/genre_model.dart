/// A data model class representing a movie genre.
///
/// [GenreModel] is used to encapsulate the details of a movie genre,
/// including its unique identifier and name. It provides methods for
/// JSON serialization and conversion to a map format.
class GenreModel {
  /// The unique identifier for the genre.
  final int id;

  /// The name of the genre.
  final String name;

  /// Creates a [GenreModel] instance with the given attributes.
  ///
  /// [id]: The unique identifier for the genre.
  /// [name]: The name of the genre.
  /// Both parameters are required and must not be null.
  GenreModel({required this.id, required this.name});

  /// Creates a [GenreModel] from a JSON object.
  ///
  /// [json]: The JSON object containing genre data.
  /// Returns: A [GenreModel] instance populated with data from the JSON object.
  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(id: json['id'], name: json['name']);
  }

  /// Converts the [GenreModel] to a map format.
  ///
  /// Returns: A map with the genre ID as the key and the genre name as the value.
  Map<int, String> toMap() {
    return {id: name};
  }
}
