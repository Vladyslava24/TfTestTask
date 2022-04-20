import 'package:totalfit/analytics/analytic_service.dart';
import 'package:totalfit/analytics/events.dart';

abstract class TrackableAction {
  Event event();

  Map<String, String> parameters() => null;

  Map<String, String> _mapParams = {};

  ///for later modification, like in middleware, when action instance is already created
  void addParameters(Map<String, dynamic> params) {
    _mapParams.addAll(params);
  }

  void logEvent(AnalyticService service) {
    final params = parameters();
    if (params != null) {
      _mapParams.addAll(params);
    }
    service.logEvent(event: event(), parameters: _mapParams);
  }
}
