import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter_app/core/di/usecases_provider.dart';
import 'package:tmdb_flutter_app/core/utils/error_handler.dart';
import 'package:tmdb_flutter_app/domain/entities/movie.dart';
import 'package:tmdb_flutter_app/domain/repositories/movie_repository.dart';
import 'package:tmdb_flutter_app/domain/usecases/get_popular_movies.dart';

/// A dummy implementation of [GetPopularMovies] for testing purposes.
///
/// [_DummyGetPopularMovies] allows for injecting a custom handler function
/// to simulate fetching popular movies without relying on the actual repository.
class _DummyGetPopularMovies implements GetPopularMovies {
  /// A function that simulates fetching a list of movies for a given page.
  final Future<List<Movie>> Function(int page) handler;

  /// Creates a [_DummyGetPopularMovies] with the provided [handler] function.
  _DummyGetPopularMovies(this.handler);

  @override
  Future<List<Movie>> call({int page = 1}) => handler(page);

  @override
  MovieRepository get repository => throw UnimplementedError();
}

/// A state notifier for managing the state of a list of movies.
///
/// [MovieViewModel] extends [StateNotifier] to manage the state of a list of
/// movies, providing functionality to fetch popular movies, search movies,
/// and filter movies by genre.
class MovieViewModel extends StateNotifier<AsyncValue<List<Movie>>> {
  /// The use case for fetching popular movies.
  final GetPopularMovies _getPopularMovies;

  /// A list of all movies fetched from the API.
  List<Movie> _allMovies = [];

  /// A list of movies filtered based on search query and genre.
  List<Movie> _filteredMovies = [];

  /// The current page number for pagination.
  int _currentPage = 1;

  /// A flag indicating whether more movies are being loaded.
  bool _isLoadingMore = false;

  /// The current search query for filtering movies.
  String _searchQuery = "";

  /// The currently selected genre for filtering movies.
  int _selectedGenre = 0;

  /// Creates a [MovieViewModel] with the provided [GetPopularMovies] use case.
  ///
  /// Initializes the state with a loading state and fetches the initial list
  /// of popular movies.
  MovieViewModel(this._getPopularMovies) : super(const AsyncValue.loading()) {
    _fetchPopularMovies();
  }

  /// Fetches the next page of popular movies and updates the state.
  ///
  /// If a fetch operation is already in progress, this method returns early.
  Future<void> fetchNextPage() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    final nextPage = _currentPage + 1;

    try {
      final movies = await _getPopularMovies(page: nextPage);
      _allMovies.addAll(movies);
      _currentPage = nextPage;
      _applyFilters();
    } catch (error, stackTrace) {
      state = AsyncValue.error(ErrorHandler.getErrorMessage(error), stackTrace);
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Updates the search query and applies filters to the movie list.
  ///
  /// [query]: The new search query to apply.
  void searchMovies(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  /// Updates the selected genre and applies filters to the movie list.
  ///
  /// [genreId]: The ID of the genre to filter by.
  void filterByGenre(int genreId) {
    _selectedGenre = genreId;
    _applyFilters();
  }

  /// Fetches the initial or specified page of popular movies and updates the state.
  ///
  /// [page]: The page number to fetch. Defaults to 1.
  Future<void> _fetchPopularMovies({int page = 1}) async {
    try {
      final movies = await _getPopularMovies(page: page);
      if (page == 1) {
        _allMovies = movies;
      } else {
        _allMovies.addAll(movies);
      }
      _currentPage = page;
      _applyFilters();
    } catch (error, stackTrace) {
      state = AsyncValue.error(ErrorHandler.getErrorMessage(error), stackTrace);
    }
  }

  /// Applies the current search query and genre filters to the movie list.
  ///
  /// Updates the state with the filtered list of movies.
  void _applyFilters() {
    final movies =
        _allMovies.where((movie) {
          final matchesQuery =
              _searchQuery.isEmpty ||
              movie.title.toLowerCase().contains(_searchQuery.toLowerCase());
          final matchesGenre =
              _selectedGenre == 0 || movie.genreIds.contains(_selectedGenre);
          return matchesQuery && matchesGenre;
        }).toList();

    _filteredMovies = movies;
    state = AsyncValue.data(_filteredMovies);
  }
}

/// A Riverpod provider for managing the state of the movie list.
///
/// [movieListProvider] uses [StateNotifierProvider] to provide an instance
/// of [MovieViewModel] and manage the state of the movie list asynchronously.
final movieListProvider = StateNotifierProvider.autoDispose<
  MovieViewModel,
  AsyncValue<List<Movie>>
>((ref) {
  final asyncGetPopularMovies = ref.watch(getPopularMoviesProvider);

  return asyncGetPopularMovies.when(
    data: (getPopularMovies) => MovieViewModel(getPopularMovies),
    loading:
        () => MovieViewModel(_DummyGetPopularMovies((_) async => <Movie>[])),
    error:
        (error, stackTrace) => MovieViewModel(
          _DummyGetPopularMovies((_) async => Future.error(error)),
        ),
  );
});
