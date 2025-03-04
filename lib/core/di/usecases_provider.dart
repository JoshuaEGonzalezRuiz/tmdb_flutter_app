import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter_app/domain/usecases/get_popular_movies.dart';

import 'repository_provider.dart';

/// A Riverpod provider for managing the [GetPopularMovies] use case.
///
/// [getPopularMoviesProvider] is a [FutureProvider] that asynchronously
/// provides an instance of [GetPopularMovies]. It uses the [movieRepositoryProvider]
/// to obtain the necessary [MovieRepository] dependency required to create
/// the use case. The provider is marked as `autoDispose` to automatically
/// clean up resources when no longer needed.
final getPopularMoviesProvider = FutureProvider.autoDispose<GetPopularMovies>((
  ref,
) async {
  // Watches the movieRepositoryProvider to get the MovieRepository instance.
  final movieRepository = await ref.watch(movieRepositoryProvider.future);
  // Returns a new instance of GetPopularMovies with the retrieved repository.
  return GetPopularMovies(movieRepository);
});
