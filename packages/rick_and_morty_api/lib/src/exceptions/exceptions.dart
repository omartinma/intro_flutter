/// Exception for non-200 responses
class HttpErrorResponse implements Exception {
  /// Default constructor
  const HttpErrorResponse({
    required this.url,
    required this.statusCode,
    this.message,
  });

  /// URL of the request
  final Uri url;

  /// Status code of the response
  final int statusCode;

  /// Error message
  final String? message;
}

/// Exception thrown when there is a parsing issue in the response
class HttpMalformedResponse implements Exception {}
