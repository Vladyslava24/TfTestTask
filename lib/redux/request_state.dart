import 'package:totalfit/exception/tf_exception.dart';

class RequestState {
  static const RequestState IDLE = RequestState._("IDLE", null, null, null);
  static const RequestState COMPLETED = RequestState._("COMPLETED", null, null, null);

  final String _name;
  final TfException _error;
  final Function _request;
  final bool _showLoader;

  factory RequestState.error(TfException error, Function request, bool showLoader) {
    return RequestState._("ERROR", request, error, showLoader);
  }

  factory RequestState.running(Function request, bool showLoader) {
    return RequestState._("RUNNING", request, null, showLoader);
  }

  bool isError() => _name == "ERROR";

  bool isRunning() => _name == "RUNNING";

  bool showLoader() => _showLoader;

  TfException getError() => _error;

  Function lastRequest() => _request;

  const RequestState._(this._name, this._request, this._error, this._showLoader);

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestState &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _error == other._error &&
          _showLoader == other._showLoader;

  @override
  int get hashCode => _name.hashCode ^ _error.hashCode ^ _showLoader.hashCode;

  @override
  String toString() => _name;
}
