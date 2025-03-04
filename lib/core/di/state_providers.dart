import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A Riverpod state provider for managing the selected genre in the filter.
///
/// [selectedGenreProvider] is a [StateProvider] that holds the state of the
/// currently selected genre ID for filtering movies. It is initialized with
/// a default value of `0`, which typically represents "All Genres". The provider
/// is marked as `autoDispose` to automatically clean up resources when no longer
/// needed, ensuring efficient memory usage.
final selectedGenreProvider = StateProvider.autoDispose<int>((ref) => 0);
