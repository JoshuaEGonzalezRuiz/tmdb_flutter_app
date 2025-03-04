import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter_app/core/config/api_config.dart';

/// A Riverpod provider for managing the Dio HTTP client instance.
///
/// [dioProvider] is a [Provider] that supplies a configured instance of
/// [Dio], an HTTP client for making network requests. It is configured
/// with base options such as the base URL and authorization headers
/// required for accessing the API. The provider is marked as `autoDispose`
/// to automatically clean up resources when no longer needed, ensuring
/// efficient memory usage.
///
/// This provider is essential for performing network operations throughout
/// the application, allowing for API requests to be made with the necessary
/// authentication and configuration.
final dioProvider = Provider.autoDispose<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {
        'Authorization': ApiConfig.bearerToken,
        'accept': 'application/json',
      },
    ),
  );
});
