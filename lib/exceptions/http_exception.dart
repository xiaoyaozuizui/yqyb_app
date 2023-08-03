import 'dart:convert';

class AppHttpException implements Exception {
  Map<String, dynamic>? errors;

  /// Custom http exception.
  /// Expects the response body of the REST call and will try to parse it to
  /// JSON. Will use the response as-is if it fails.
  AppHttpException(dynamic responseBody) {
    if (responseBody == null) {
      errors = {
        'unknown_error':
            'An unknown error occurred, no further information available'
      };
    } else {
      try {
        errors = json.decode(responseBody);
      } catch (e) {
        errors = responseBody;
      }
    }
    errors = errors;
  }

  @override
  String toString() {
    return errors!.values.toList().join(', ');
  }
}
