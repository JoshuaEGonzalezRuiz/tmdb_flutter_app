import 'package:go_router/go_router.dart';
import 'package:tmdb_flutter_app/domain/entities/movie.dart';
import 'package:tmdb_flutter_app/presentation/pages/movie_detail_page.dart';
import 'package:tmdb_flutter_app/presentation/pages/movie_list_page.dart';

import 'route_names.dart';

/// Configures the application's routing using the GoRouter package.
///
/// The [appRouter] is an instance of [GoRouter] that defines the initial location
/// and the routes available in the application. It uses [RouteNames] for path constants
/// to ensure consistency and ease of maintenance.
final GoRouter appRouter = GoRouter(
  /// Sets the initial location of the app to the home route.
  initialLocation: RouteNames.home,
  routes: [
    /// Defines the route for the home screen.
    ///
    /// The home route displays the [MovieListPage].
    GoRoute(
      path: RouteNames.home,
      builder: (context, state) => const MovieListPage(),
    ),

    /// Defines the route for the detail screen.
    ///
    /// The detail route displays the [MovieDetailPage] and expects a [Movie] object
    /// passed as extra data in the navigation state.
    GoRoute(
      path: RouteNames.detail,
      builder: (context, state) {
        final movie = state.extra as Movie;
        return MovieDetailPage(movie: movie);
      },
    ),
  ],
);
