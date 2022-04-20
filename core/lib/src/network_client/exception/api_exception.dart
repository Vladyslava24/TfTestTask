class ApiException implements Exception {
  final int serverErrorCode;
  final String serverErrorMessage;
  final String serverLogMessage;

  ApiException({required this.serverErrorCode, required this.serverErrorMessage, required this.serverLogMessage});

  String get message => serverErrorMessage;

  factory ApiException.fromErrorBody(jsonMap) {
    final serverErrorCode = int.parse(jsonMap["errorCode"] ?? "-111111");
    final serverErrorMessage = jsonMap["message"];
    final serverLogMessage = jsonMap["cause"];
    return ApiException(
        serverErrorCode: serverErrorCode, serverErrorMessage: serverErrorMessage, serverLogMessage: serverLogMessage);
  }

  factory ApiException.unknown({required String log}) {
    const serverErrorCode = -111111;
    const serverErrorMessage = 'unknown';
    final serverLogMessage = log;
    return ApiException(
        serverErrorCode: serverErrorCode, serverErrorMessage: serverErrorMessage, serverLogMessage: serverLogMessage);
  }

  @override
  String toString() {
    return serverErrorMessage;
  }
}
