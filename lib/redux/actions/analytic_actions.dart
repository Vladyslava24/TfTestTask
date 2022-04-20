import 'package:flutter/foundation.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';

class ErrorReportAction extends TrackableAction {
  final String where;
  final String errorMessage;
  final Type trigger;

  ErrorReportAction({@required this.where, this.errorMessage, this.trigger});

  @override
  Event event() => Event.APP_ERROR;

  @override
  Map<String, String> parameters() => {"where": where, "errorMessage": errorMessage, "trigger": trigger.toString()};

  @override
  String toString() => 'ErrorReportAction. errorMessage: $errorMessage, where: $where, trigger: $trigger';
}
