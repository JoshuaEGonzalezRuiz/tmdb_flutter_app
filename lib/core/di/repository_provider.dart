import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter_app/data/repositories/movie_repository_impl.dart';
import 'package:tmdb_flutter_app/domain/repositories/movie_repository.dart';

import 'datasources_providers.dart';

/// A Riverpod provider for managing the [MovieRepository] instance.
///
/// [movieRepositoryProvider] is a [FutureProvider] that asynchronously
/// provides an instance of [MovieRepository]. It constructs the repository
/// using both remote and local data sources. The provider is marked as
/// `autoDispose` to automatically clean up resources when no longer needed,
/// ensuring efficient memory usage.
///
/// This provider watches the [movieLocalDataSourceProvider] to obtain the
/// local data source and reads the [movieRemoteDataSourceProvider] for the
/// remote data source. These data sources are then used to create an instance
/// of [MovieRepositoryImpl].
final movieRepositoryProvider = FutureProvider.autoDispose<MovieRepository>((
  ref,
) async {
  // Watches the local data source provider to get the local data source instance.
  final localDataSource = await ref.watch(movieLocalDataSourceProvider.future);
  // Returns a new instance of MovieRepositoryImpl with the remote and local data sources.
  return MovieRepositoryImpl(
    ref.read(movieRemoteDataSourceProvider),
    localDataSource,
  );
});
