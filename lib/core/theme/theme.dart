import 'package:flutter/material.dart';

/// Defines the light theme for the application.
///
/// The [lightTheme] is configured with a light brightness setting and a teal color scheme.
/// It sets the scaffold background color to white and customizes the app bar and text themes.
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorSchemeSeed: Colors.teal,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
  ),
);

/// Defines the dark theme for the application.
///
/// The [darkTheme] is configured with a dark brightness setting and a blue-grey color scheme.
/// It sets the scaffold background color to black and customizes the app bar and text themes.
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.teal,
  scaffoldBackgroundColor: Colors.black,
  cardTheme: const CardTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
  ),
);
