import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_flutter_app/core/utils/image_helper.dart';

/// A widget that displays a movie poster image using a network image.
///
/// [MovieImage] uses the [CachedNetworkImage] package to efficiently load
/// and cache images from the network. It provides a placeholder while the
/// image is loading and an error widget if the image fails to load.
class MovieImage extends StatelessWidget {
  /// The path to the movie poster image.
  final String posterPath;

  /// The height of the image.
  final double? height;

  /// Creates a [MovieImage] widget.
  ///
  /// The [posterPath] parameter is required and must not be null.
  const MovieImage({super.key, required this.posterPath, this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: ImageHelper.getFullImageUrl(posterPath),
      width: double.infinity,
      height: height,
      fit: BoxFit.contain,
      // Provides a placeholder widget while the image is loading.
      placeholder:
          (context, url) => const Center(child: CircularProgressIndicator()),
      // Provides an error widget if the image fails to load.
      errorWidget:
          (context, url, error) => Image.asset(
            "assets/images/no_image.png",
            width: double.infinity,
            height: height,
            fit: BoxFit.contain,
          ),
    );
  }
}
