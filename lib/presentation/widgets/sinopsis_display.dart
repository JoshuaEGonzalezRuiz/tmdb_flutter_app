import 'package:flutter/material.dart';
import 'package:tmdb_flutter_app/core/utils/constants.dart';

/// A widget that displays a movie synopsis.
///
/// [SynopsisDisplay] is a stateless widget that shows the title "Synopsis"
/// followed by the movie's overview text. If the overview is empty, it displays
/// a default message indicating that no synopsis is available.
class SynopsisDisplay extends StatelessWidget {
  /// The overview text of the movie.
  ///
  /// This is a required parameter that provides the synopsis content to be displayed.
  final String overview;

  /// Creates a [SynopsisDisplay] widget.
  ///
  /// The [overview] parameter must not be null and is required to construct
  /// the widget.
  const SynopsisDisplay({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Displays the title "Overview" with a bold font style.
        Text(
          Constants.overview,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),

        /// Displays the movie's overview text or a default message if the overview is empty.
        Text(
          overview.isNotEmpty ? overview : Constants.noOverviewAvailable,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
