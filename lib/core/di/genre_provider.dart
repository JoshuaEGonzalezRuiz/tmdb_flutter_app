import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'datasources_providers.dart';

/// A Riverpod provider for fetching and managing the genres of movies.
///
/// [genreProvider] is a [FutureProvider] that asynchronously provides a
/// map of genre IDs to genre names. It utilizes the [movieRemoteDataSourceProvider]
/// to access the remote data source and fetch the genres from an external API.
/// The provider is marked as `autoDispose` to automatically clean up resources
/// when no longer needed, ensuring efficient memory usage.
///
/// This provider is essential for accessing the list of movie genres throughout
/// the application, allowing for genre-based filtering and display.
final genreProvider = FutureProvider<Map<int, String>>((ref) async {
  // Reads the remote data source provider to get the MovieRemoteDataSource instance.
  final movieRemoteDataSource = ref.read(movieRemoteDataSourceProvider);
  // Fetches and returns the map of genre IDs to genre names.
  return await movieRemoteDataSource.getGenres();
});
