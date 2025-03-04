import 'package:intl/intl.dart';
import 'package:tmdb_flutter_app/core/utils/constants.dart';

/// A utility class for formatting dates according to a specified format.
class DateFormatter {
  /// Formats a date string from the API into a user-friendly format.
  ///
  /// If the [date] is null or empty, it returns "Fecha desconocida".
  /// Otherwise, it parses the [date] string into a [DateTime] object and formats it
  /// using the date format specified in [Constants.displayDateFormat].
  ///
  /// [date]: The date string to be formatted.
  /// Returns: A formatted date string or "Fecha desconocida" if the input is invalid.
  static String formatApiDate(String? date) {
    if (date == null || date.isEmpty) return Constants.unknownDate;
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat(Constants.displayDateFormat).format(parsedDate);
  }
}
