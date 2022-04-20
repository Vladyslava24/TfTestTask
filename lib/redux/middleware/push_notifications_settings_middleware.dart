import 'package:core/core.dart';
import 'package:totalfit/data/dto/request/push_notifications_config_request.dart';
import 'package:totalfit/data/dto/request/push_notifications_settings_request.dart';
import 'package:totalfit/data/source/repository/push_notifications_repository.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/push_notifications_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> pushNotificationsSettingsMiddleware(
  PushNotificationsRepository pushNotificationsRepository, TFLogger logger) {
  final setupPushNotificationsSettingsMiddleware =
    _setupPushNotificationsSettingsMiddleware(pushNotificationsRepository, logger);
  final getPushNotificationsConfigMiddleware =
      _getPushNotificationsConfigMiddleware(pushNotificationsRepository, logger);
  return [
    TypedMiddleware<AppState, SetupPushNotificationsSettingsAction>(setupPushNotificationsSettingsMiddleware),
    TypedMiddleware<AppState, GetPushNotificationsConfig>(getPushNotificationsConfigMiddleware),
  ];
}

Middleware<AppState> _getPushNotificationsConfigMiddleware(
    PushNotificationsRepository pushNotificationsRepository, TFLogger logger) {

  return (Store<AppState> store, action, NextDispatcher next) async {

    next(action);

    next(OnChangedLoadingStatus(status: true));

    final deviceToken = await pushNotificationsRepository.getFCMTokenFromStorage();

    if (deviceToken != null) {
      try {
        final response = await pushNotificationsRepository.getPushNotificationsConfig(
          PushNotificationsConfigRequest(deviceToken: deviceToken)
        );

        next(SetupPushNotificationsSettingsAction(
            wod: response.wod,
            dailyReading: response.dailyReading,
            updatesAndNews: response.updatesAndNews
        ));
        next(OnChangedLoadingStatus(status: false));
      } on ApiException catch (e) {
        next(
          ErrorReportAction(
            where: "_onUpdateProgressAction",
            errorMessage: 'Code: ${e.serverErrorCode} - ${e.serverLogMessage}',
            trigger: action.runtimeType
          )
        );
        next(OnChangedLoadingStatus(status: false));
        next(OnSetupPushNotificationsConfigErrorAction(error: 'Code: ${e.serverErrorCode} - ${e.serverLogMessage}'));
      } catch (e) {
        next(
          ErrorReportAction(
            where: "_onUpdateProgressAction",
            errorMessage: e.toString(),
            trigger: action.runtimeType
          )
        );
        next(OnChangedLoadingStatus(status: false));
        next(OnSetupPushNotificationsConfigErrorAction(error: '$e'));
      }

    } else {
      next(OnSetupPushNotificationsConfigErrorAction(error: 'FCM Token is null'));
      next(OnChangedLoadingStatus(status: false));
    }
  };
}


Middleware<AppState> _setupPushNotificationsSettingsMiddleware(
  PushNotificationsRepository pushNotificationsRepository, TFLogger logger) {

  return (Store<AppState> store, action, NextDispatcher next) async {
    final setup = action as SetupPushNotificationsSettingsAction;

    final deviceToken = await pushNotificationsRepository.getFCMTokenFromStorage();

    if (deviceToken != null) {
      try {
        final response = await pushNotificationsRepository.setupPushNotificationsSettings(
          PushNotificationsSettingsRequest(
            deviceToken: deviceToken,
            wod: setup.wod,
            dailyReading: setup.dailyReading,
            updatesAndNews: setup.updatesAndNews
          )
        );
        next(SetupPushNotificationsSettingsAction(
          wod: response.wod,
          dailyReading: response.dailyReading,
          updatesAndNews: response.updatesAndNews
        ));
      } catch (e) {
        if (e is ApiException && e.serverErrorCode != 404) {
          next(OnSetupPushNotificationsConfigErrorAction(error: 'Failed to setup notifications config'));
          next(
            ErrorReportAction(
              where: "_onUpdateProgressAction",
              errorMessage: e.toString(),
              trigger: action.runtimeType
            )
          );
        }
      }
    } else {
      next(OnSetupPushNotificationsConfigErrorAction(error: 'FCM Token is null'));
    }

    logger.logInfo("_PushNotificationsSettingsMiddleware");
    next(action);
  };
}