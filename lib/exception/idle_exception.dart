import 'package:totalfit/exception/tf_exception.dart';

import 'error_codes.dart';

class IdleException extends TfException {
  IdleException() : super(ErrorCode.ERROR_IDLE, "Empty");
}
