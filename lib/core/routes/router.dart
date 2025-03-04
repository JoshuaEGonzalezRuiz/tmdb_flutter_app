import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

/// A Riverpod provider for managing the application's routing configuration.
///
/// The [routerProvider] uses the [GoRouter] package to define and manage
/// the app's navigation and routing. It provides the [GoRouter] instance
/// configured with the application's routes defined in [appRoutes].
final routerProvider = Provider<GoRouter>((ref) {
  return appRouter;
});
