import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:tmdb_flutter_app/core/config/isar_database_service.dart';

/// A Riverpod provider for managing the [Isar] database instance.
///
/// [isarProvider] is a [FutureProvider] that asynchronously provides an
/// instance of [Isar], the database used in the application. It utilizes
/// the [IsarDatabaseService] to initialize and retrieve the database instance.
/// The provider is marked as `autoDispose` to automatically clean up resources
/// when no longer needed, ensuring efficient memory usage.
///
/// This provider is essential for accessing the Isar database throughout
/// the application, allowing for data persistence and retrieval.
final isarProvider = FutureProvider<Isar>((ref) async {
  // Initializes and retrieves the Isar database instance using the service.
  return await IsarDatabaseService().isar;
});
