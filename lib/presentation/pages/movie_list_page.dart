import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter_app/core/theme/theme_provider.dart';
import 'package:tmdb_flutter_app/core/utils/constants.dart';
import 'package:tmdb_flutter_app/presentation/widgets/genre_filter.dart';
import 'package:tmdb_flutter_app/presentation/widgets/movie_grid.dart';
import 'package:tmdb_flutter_app/presentation/widgets/search_field.dart';

/// A page that displays a list of movies with filtering options.
///
/// [MovieListPage] is a [ConsumerWidget] that provides a user interface
/// for browsing movies. It includes a genre filter, a search field, and
/// a grid of movie cards. The page also allows users to toggle between
/// light and dark themes using an icons button in the app bar.
class MovieListPage extends ConsumerWidget {
  /// Creates a [MovieListPage] widget.
  ///
  /// The constructor is marked as `const` to allow for compile-time optimizations.
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Accesses the theme notifier to toggle the theme mode.
    final themeNotifier = ref.read(themeProvider.notifier);
    // Watches the current theme mode to update the UI accordingly.
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        // Sets the title of the app bar using a constant value.
        title: const Text(Constants.appTitle),
        centerTitle: true,
        actions: [
          IconButton(
            // Displays an icon based on the current theme mode.
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
            ),
            // Toggles the theme mode when the icon button is pressed.
            onPressed: () => themeNotifier.toggleTheme(),
          ),
        ],
      ),
      body: Column(
        children: const [
          // Adds a genre filter widget with padding.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: GenreFilter(),
          ),
          // Adds a search field widget with horizontal padding.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchField(),
          ),
          SizedBox(height: 10),
          // Expands the movie grid to fill the remaining space.
          Expanded(child: MovieGrid()),
        ],
      ),
    );
  }
}
