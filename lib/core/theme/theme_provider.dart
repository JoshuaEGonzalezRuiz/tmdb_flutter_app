import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A Riverpod provider for managing the application's theme mode.
///
/// This provider uses [ThemeNotifier] to manage the state of the theme mode,
/// allowing the app to toggle between light and dark themes.
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

/// A state notifier for managing theme mode changes and persistence.
///
/// [ThemeNotifier] extends [StateNotifier] to manage the [ThemeMode] state.
/// It initializes with the system theme mode and loads the saved theme mode
/// from shared preferences. It provides functionality to toggle the theme
/// and save the current theme mode.
class ThemeNotifier extends StateNotifier<ThemeMode> {
  /// Initializes the theme notifier with the system theme mode and loads
  /// the saved theme mode from shared preferences.
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  /// Toggles the theme mode between light and dark, and saves the new state.
  ///
  /// This method switches the current theme mode and persists the change
  /// using shared preferences.
  Future<void> toggleTheme() async {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveTheme(state);
  }

  /// Saves the current theme mode to shared preferences.
  ///
  /// [themeMode]: The theme mode to be saved (light or dark).
  Future<void> _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', themeMode == ThemeMode.light ? 'light' : 'dark');
  }

  /// Loads the saved theme mode from shared preferences.
  ///
  /// If no theme mode is saved, it defaults to the system theme mode.
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme');
    if (themeString == 'light') {
      state = ThemeMode.light;
    } else if (themeString == 'dark') {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system; // Default value
    }
  }
}
