import 'package:totalfit/redux/actions/trackable_action.dart';
import 'package:redux/redux.dart';
import 'package:device_info/device_info.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'dart:io';
import '../../analytics/analytic_service.dart';

class AnalyticMiddleware<State> extends MiddlewareClass<State> {
  final AnalyticService analyticService;

  AnalyticMiddleware(this.analyticService);

  @override
  call(Store<State> store, action, next) async {
    if (action is TrackableAction) {
      if (action is ErrorReportAction) {
        Map<String, String> deviceParams = {};
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        if (Platform.isAndroid) {
          AndroidDeviceInfo info = await deviceInfo.androidInfo;
          deviceParams.putIfAbsent("model", () => "${info.model}");
          deviceParams.putIfAbsent("product", () => "${info.product}");
          deviceParams.putIfAbsent(
              "manufacturer", () => "${info.manufacturer}");
          deviceParams.putIfAbsent("display", () => "${info.display}");
        } else if (Platform.isIOS) {
          IosDeviceInfo info = await deviceInfo.iosInfo;
          deviceParams.putIfAbsent("model", () => "${info.model}");
          deviceParams.putIfAbsent("system_name", () => "${info.systemName}");
          deviceParams.putIfAbsent(
              "system_version", () => "${info.systemVersion}");
        }
        action.addParameters(deviceParams);
      }

      action.logEvent(analyticService);
    }
    next(action);
  }
}
