import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter_app/data/datasources/movie_local_datasource.dart';
import 'package:tmdb_flutter_app/data/datasources/movie_remote_datasource.dart';

import 'dio_provider.dart';
import 'isar_provider.dart';

/// A Riverpod provider for managing the [MovieRemoteDataSource] instance.
///
/// [movieRemoteDataSourceProvider] is a [Provider] that supplies an instance
/// of [MovieRemoteDataSource]. It uses the [dioProvider] to obtain the
/// configured Dio HTTP client required for making network requests to fetch
/// movie data from a remote API. The provider is marked as `autoDispose` to
/// automatically clean up resources when no longer needed, ensuring efficient
/// memory usage.
final movieRemoteDataSourceProvider =
    Provider.autoDispose<MovieRemoteDataSource>((ref) {
      return MovieRemoteDataSource(ref.read(dioProvider));
    });

/// A Riverpod provider for managing the [MovieLocalDataSource] instance.
///
/// [movieLocalDataSourceProvider] is a [FutureProvider] that asynchronously
/// provides an instance of [MovieLocalDataSource]. It uses the [isarProvider]
/// to obtain the Isar database instance required for caching movie data locally.
/// The provider is marked as `autoDispose` to automatically clean up resources
/// when no longer needed, ensuring efficient memory usage.
final movieLocalDataSourceProvider =
    FutureProvider.autoDispose<MovieLocalDataSource>((ref) async {
      final isar = await ref.watch(isarProvider.future);
      return MovieLocalDataSource(isar);
    });
