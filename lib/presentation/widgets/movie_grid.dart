import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_flutter_app/presentation/viewmodels/movie_viewmodel.dart';

import 'movie_card.dart';

/// A widget that displays a grid of movie cards.
///
/// [MovieGrid] uses a [GridView.builder] to efficiently display a scrollable
/// grid of movie cards. It listens for scroll notifications to implement
/// infinite scrolling by fetching the next page of movies when nearing the end.
class MovieGrid extends ConsumerWidget {
  /// Creates a [MovieGrid] widget.
  const MovieGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the movie list state and view model.
    final movieState = ref.watch(movieListProvider);
    final movieViewModel = ref.watch(movieListProvider.notifier);

    // Defines the scroll threshold for fetching the next page.
    const scrollThreshold = 0.9;

    return movieState.when(
      data:
          (movies) => NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              // Checks if the user has scrolled near the bottom of the grid.
              if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent * scrollThreshold) {
                movieViewModel.fetchNextPage();
              }
              return false;
            },
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(
                  movie: movie,
                  onTap: () {
                    // Navigates to the movie detail page when a card is tapped.
                    context.push('/detail', extra: movie);
                  },
                );
              },
            ),
          ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(error.toString())),
    );
  }
}
