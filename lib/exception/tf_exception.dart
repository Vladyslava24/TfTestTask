import 'error_codes.dart';

class TfException implements Exception {
  final ErrorCode errorCode;
  final String _logMessage;
  String message;

  TfException(this.errorCode, this._logMessage);

  factory TfException.message(String message, String logMessage) {
    return TfException(ErrorCode.ERROR_UNKNOWN, logMessage)..message = message;
  }

  String getMessage(context) => message != null ? message : errorCode.getStringMessage(context);

  @override
  String toString() {
    return "Error code: $errorCode  "
        "ErrorMessage: ${errorCode.getUnlocalizedStringMessage()}  "
        "LogMessage: ${_logMessage ?? no_log_message}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TfException &&
          runtimeType == other.runtimeType &&
          errorCode == other.errorCode &&
          _logMessage == other._logMessage;

  @override
  int get hashCode => errorCode.hashCode ^ _logMessage.hashCode;
}

const no_log_message = 'No log message';
