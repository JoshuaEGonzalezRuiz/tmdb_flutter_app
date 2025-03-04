import 'error_messages.dart';

/// A utility class for handling errors and providing user-friendly error messages.
class ErrorHandler {
  /// Returns a user-friendly error message based on the provided [error].
  ///
  /// If the [error] is an [Exception], it delegates to [_handleException] for specific handling.
  /// If the [error] is a [String], it returns the error message directly.
  /// For any other type of error, it returns a generic unknown error message.
  ///
  /// [error]: The error object to be handled.
  /// Returns: A user-friendly error message.
  static String getErrorMessage(dynamic error) {
    if (error is Exception) {
      return _handleException(error);
    } else if (error is String) {
      return error;
    }
    return ErrorMessages.unknownError;
  }

  /// Handles specific [Exception] types and returns corresponding error messages.
  ///
  /// Checks the [error] for known exception types like `SocketException` and `TimeoutException`.
  /// Returns a predefined error message from [ErrorMessages] for recognized exceptions.
  /// If the exception type is not recognized, it returns the exception's string representation.
  ///
  /// [error]: The exception to be handled.
  /// Returns: A user-friendly error message for the exception.
  static String _handleException(Exception error) {
    if (error.toString().contains("SocketException")) {
      return ErrorMessages.networkError;
    } else if (error.toString().contains("TimeoutException")) {
      return ErrorMessages.timeoutError;
    }
    return error.toString();
  }
}
