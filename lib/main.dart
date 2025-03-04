import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter_app/core/config/isar_database_service.dart';
import 'package:tmdb_flutter_app/core/routes/router.dart';
import 'package:tmdb_flutter_app/core/theme/theme.dart';
import 'package:tmdb_flutter_app/core/theme/theme_provider.dart';

void main() async {
  // Ensures that Flutter bindings are initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes the Isar database service.
  await IsarDatabaseService().init();

  // Runs the app with Riverpod's ProviderScope, which provides dependency injection.
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the routerProvider to get the app's routing configuration.
    final router = ref.watch(routerProvider);
    // Watches the themeProvider to get the current theme mode (light, dark, or system).
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      // Configures the app's routing using the GoRouter package.
      routerConfig: router,
      // Disables the debug banner in the app.
      debugShowCheckedModeBanner: false,
      // Sets the light theme for the app.
      theme: lightTheme,
      // Sets the dark theme for the app.
      darkTheme: darkTheme,
      // Sets the theme mode based on the user's preference.
      themeMode: themeMode,
    );
  }
}
