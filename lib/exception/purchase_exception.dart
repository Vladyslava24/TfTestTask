import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';

class PurchaseException extends TfException {
  String _logMessage;

  PurchaseException(this._logMessage) : super(ErrorCode.ERROR_PURCHASE, _logMessage);

  @override
  String getMessage(context) => _logMessage;
}
