/// Parse string date to DateTime object
DateTime dateTimeFromJson(String date) =>
    date != null && date.isNotEmpty ? DateTime.parse(date) : null;

/// Parse DateTime object to String
String dateTimeToJson(DateTime date) =>
    date != null ? date.toUtc().toIso8601String() : null;