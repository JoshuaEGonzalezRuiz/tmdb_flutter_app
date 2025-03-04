/// A configuration class for storing API-related constants.
///
/// [ApiConfig] provides static constants used for configuring API requests
/// to The Movie Database (TMDB). It includes the base URL for API endpoints,
/// the bearer token for authentication, and the base URL for fetching images.
class ApiConfig {
  /// The base URL for TMDB API endpoints.
  ///
  /// This URL is used as the root for all API requests to TMDB.
  static const String baseUrl = "https://api.themoviedb.org/3";

  /// The bearer token for authenticating API requests.
  ///
  /// This token is required for accessing TMDB's API and should be kept
  /// secure. Replace the empty string with your actual bearer token.
  static const String bearerToken = "";

  /// The base URL for fetching movie images from TMDB.
  ///
  /// This URL is used to construct full image URLs by appending image paths.
  /// The `/w500` indicates the desired image width.
  static const String imageUrl = "https://image.tmdb.org/t/p/w500";
}
