import '../config/api_config.dart';
import 'constants.dart';

/// A helper class for handling image URLs.
class ImageHelper {
  /// Returns the full image URL for a given image path.
  ///
  /// If the [path] is null or empty, it returns the default poster image URL.
  /// Otherwise, it concatenates the base image URL from [ApiConfig] with the provided [path].
  ///
  /// [path]: The relative path of the image.
  /// Returns: The full URL of the image.
  static String getFullImageUrl(String? path) {
    if (path == null || path.isEmpty) {
      return Constants.defaultPoster;
    }
    return "${ApiConfig.imageUrl}$path";
  }
}
