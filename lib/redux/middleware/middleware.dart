import 'dart:core';

import 'package:core/core.dart';
import 'package:totalfit/redux/middleware/workout_feature_bridge_middleware.dart';
import 'package:workout_api/api.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalfit/data/source/local/local_storage.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/source/repository/push_notifications_repository.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/analytics/analytic_service.dart';
import 'package:totalfit/domain/ab_test/ab_test_service.dart';
import 'package:totalfit/domain/log_writer.dart';
import 'package:totalfit/redux/epics/epic.dart';
import 'package:totalfit/redux/middleware/analytic_middleware.dart';
import 'package:totalfit/redux/middleware/deep_link_middleware.dart';
import 'package:totalfit/redux/middleware/logging_middleware.dart';
import 'package:totalfit/redux/middleware/progress_middleware.dart';
import 'package:totalfit/redux/middleware/push_notifications_settings_middleware.dart';
import 'package:totalfit/redux/middleware/storage_middleware.dart';
import 'package:totalfit/redux/middleware/validation_middleware.dart';
import 'package:totalfit/redux/middleware/workout_middleware.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/storage/string_storage.dart';
import 'package:totalfit/redux/reducers/profile_middleware.dart';
import 'package:totalfit/redux/middleware/settings_middleware.dart';
import 'package:totalfit/redux/middleware/profile_share_workout_results_middleware.dart';
import 'package:totalfit/redux/middleware/profile_workout_summary_middleware.dart';
import 'package:totalfit/redux/middleware/program_full_schedule_middleware.dart';
import 'package:totalfit/redux/middleware/program_progress_middleware.dart';
import 'package:totalfit/redux/middleware/choose_program_middleware.dart';
import 'package:totalfit/redux/middleware/program_setup_middleware.dart';
import 'package:totalfit/redux/middleware/splash_screen_middleware.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:workout_data/data.dart';
import 'package:workout_use_case/use_case.dart';
import 'navigation_middleware.dart';
import 'preference_middleware.dart';
import 'session_middleware.dart';

List<Middleware<AppState>> createAppMiddleware(
    TFLogger logger,
    WorkoutRepository workoutRepository,
    WorkoutApi workoutApi,
    WorkoutListUseCase workoutListUseCase,
    UserRepository userRepository,
    PushNotificationsRepository pushNotificationsRepository,
    LocalStorage localStorage,
    RemoteStorage remoteStorage,
    StringStorage stringStorage,
    SharedPreferences prefs,
    LogWriter logWriter,
    AnalyticService analyticService,
    ABTestService abTestService
    ) {

  final List<Middleware<AppState>> appMiddleware = [];
  appMiddleware.addAll(sessionMiddleware(remoteStorage, logger));
  appMiddleware.add(ValidationMiddleware());
  appMiddleware.addAll(splashScreenMiddleware(userRepository, remoteStorage, logger));

  /*KEEP THE SEQUENCE*/
  appMiddleware.addAll(updateProgressMiddleWare(workoutRepository, logger));
  appMiddleware.addAll(progressMiddleware(localStorage, remoteStorage, workoutApi, logger));
  /*******************/
  appMiddleware.addAll(storageMiddleware(userRepository, pushNotificationsRepository, remoteStorage, logger));
  appMiddleware.addAll(settingsMiddleware(prefs, logger));
  appMiddleware.addAll(workoutMiddleware(localStorage, logger));
  appMiddleware.addAll(profileWorkoutSummaryMiddleware(remoteStorage, logger));
  appMiddleware.addAll(profileShareResultsMiddleware(remoteStorage, logger));
  appMiddleware.addAll(profileMiddleware(remoteStorage, workoutApi, logger));
  appMiddleware.addAll(preferenceMiddleware(prefs, logger));
  appMiddleware.addAll(programSetupMiddleware(remoteStorage, logger));
  appMiddleware.addAll(chooseProgramMiddleware(stringStorage, remoteStorage, logger));
  appMiddleware.addAll(programProgressMiddleware(stringStorage, remoteStorage, logger));
  appMiddleware.addAll(programFullScheduleMiddleware(stringStorage, remoteStorage, logger));
  appMiddleware.addAll(pushNotificationsSettingsMiddleware(pushNotificationsRepository, logger));
  appMiddleware.addAll(deepLinkMiddleware(remoteStorage, logger));

  appMiddleware.add(EpicMiddleware<AppState>(createEpics(abTestService)));
  appMiddleware.addAll(navigationMiddleware(workoutListUseCase, stringStorage, logger));
  appMiddleware.add(AnalyticMiddleware(analyticService));
  appMiddleware.add(TfLoggingMiddleware.writer(logger: logger));
  return appMiddleware;
}
