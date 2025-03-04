import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmdb_flutter_app/data/models/movie_model.dart';

/// A service class for managing the Isar database instance.
///
/// [IsarDatabaseService] implements a singleton pattern to ensure a single
/// instance of the Isar database is used throughout the application. It
/// provides methods to initialize and access the database, which stores
/// movie data using the [MovieModelSchema].
class IsarDatabaseService {
  // Private instance for the singleton.
  static final IsarDatabaseService _instance = IsarDatabaseService._internal();
  Isar? _isar;

  // Factory constructor returns the singleton instance.
  factory IsarDatabaseService() {
    return _instance;
  }

  // Private named constructor for internal use.
  IsarDatabaseService._internal();

  /// Initializes the Isar database if it isn't already open.
  ///
  /// This method retrieves the application's document directory and opens
  /// the Isar database with the specified schemas. It ensures that the
  /// database is ready for use and returns the [Isar] instance.
  Future<Isar> init() async {
    if (_isar != null && _isar!.isOpen) {
      return _isar!;
    }

    // Retrieve the app's document directory.
    final dir = await getApplicationDocumentsDirectory();

    // Open the Isar database with your schemas.
    _isar = await Isar.open(
      [MovieModelSchema],
      directory: dir.path,
      name: 'tmdb_database',
    );
    return _isar!;
  }

  /// Provides a getter to retrieve the Isar instance,
  /// initializing it if necessary.
  ///
  /// This getter checks if the Isar instance is null or closed, and if so,
  /// it calls [init] to ensure the database is open before returning the
  /// instance.
  Future<Isar> get isar async {
    if (_isar == null || !_isar!.isOpen) {
      return await init();
    }
    return _isar!;
  }
}
