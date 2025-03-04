import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter_app/core/utils/constants.dart';

import '../viewmodels/movie_viewmodel.dart';

/// A widget that provides a search input field for filtering movies.
///
/// [SearchField] is a [ConsumerWidget] that interacts with the [MovieViewModel]
/// to filter the list of movies based on the user's search query. It uses
/// Riverpod's [ConsumerWidget] to access the [movieListProvider] and update
/// the movie list dynamically as the user types.
class SearchField extends ConsumerWidget {
  /// Creates a [SearchField] widget.
  ///
  /// The constructor is marked as `const` to allow for compile-time optimizations.
  const SearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the movieListProvider to get the MovieViewModel instance.
    final movieViewModel = ref.watch(movieListProvider.notifier);

    return TextField(
      // Calls the searchMovies method on the MovieViewModel whenever the input changes.
      onChanged: (query) => movieViewModel.searchMovies(query),
      decoration: InputDecoration(
        // Sets the placeholder text for the search field.
        hintText: Constants.searchPlaceholder,
        // Adds a search icons as a prefix to the input field.
        prefixIcon: const Icon(Icons.search),
        // Configures the border style of the input field with rounded corners.
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
