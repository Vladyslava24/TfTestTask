class NetworkResponse {
  final Map<String, dynamic> headers;
  final dynamic body;
  final int statusCode;

  NetworkResponse({
    required this.headers,
    required this.body,
    required this.statusCode
  });
}
