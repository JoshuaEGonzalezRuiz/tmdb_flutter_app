import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter_app/core/di/genre_provider.dart';
import 'package:tmdb_flutter_app/core/di/state_providers.dart';
import 'package:tmdb_flutter_app/core/utils/constants.dart';

import '../viewmodels/movie_viewmodel.dart';

/// A widget that provides a dropdown menu for filtering movies by genre.
///
/// [GenreFilter] is a [ConsumerWidget] that interacts with the [genreProvider]
/// to display a list of genres and allows the user to select a genre to filter
/// the movie list. It updates the selected genre state and triggers the
/// [MovieViewModel] to apply the genre filter.
class GenreFilter extends ConsumerWidget {
  /// Creates a [GenreFilter] widget.
  const GenreFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the selected genre and genre state.
    final selectedGenre = ref.watch(selectedGenreProvider);
    final genreState = ref.watch(genreProvider);
    final movieViewModel = ref.watch(movieListProvider.notifier);

    return genreState.when(
      data: (genres) {
        return DropdownButtonFormField<int>(
          value: selectedGenre,
          decoration: InputDecoration(
            labelText: Constants.genreFilter,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onChanged: (genreId) {
            ref.read(selectedGenreProvider.notifier).state = genreId!;
            movieViewModel.filterByGenre(genreId);
          },
          items: [
            const DropdownMenuItem(value: 0, child: Text(Constants.all)),
            ...genres.entries.map(
              (entry) =>
                  DropdownMenuItem(value: entry.key, child: Text(entry.value)),
            ),
          ],
        );
      },
      loading: () => SizedBox.shrink(),
      error: (error, _) => SizedBox.shrink(),
    );
  }
}
