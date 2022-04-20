import 'package:workout_api/api.dart';
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalfit/analytics/analytic_service.dart';
import 'package:totalfit/common/flavor/flavor_config.dart';
import 'package:totalfit/data/source/local/local_storage.dart';
import 'package:totalfit/data/source/local/local_storage_impl.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/source/remote/remote_storage_impl.dart';
import 'package:totalfit/data/source/repository/explore_repository.dart';
import 'package:totalfit/data/source/repository/explore_repository_impl.dart';
import 'package:totalfit/data/source/repository/push_notifications_repository.dart';
import 'package:totalfit/data/source/repository/push_notifications_repository_impl.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/data/source/repository/user_repository_impl.dart';
import 'package:totalfit/domain/ab_test/ab_test_service.dart';
import 'package:totalfit/domain/log_writer.dart';
import 'package:totalfit/redux/reducers/app_reducers.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/storage/string_storage.dart';
import 'package:totalfit/ui/widgets/keys.dart';
import 'package:totalfit/utils/locales_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workout_data/data.dart';
import 'package:workout_use_case/use_case.dart';

import 'middleware/middleware.dart';

Future<Store<AppState>> createStore({AppState initial, FlavorConfig flavorConfig, TFLogger logger}) async {
  final secureStorage = FlutterSecureStorage();
  final prefs = await SharedPreferences.getInstance();
  final logWriter = await LogWriter.getInstance();
  final analyticService = AnalyticService.getInstance();
  final stringStorage = const StringStorage();

  await Firebase.initializeApp();
  String configString;
  try {
    configString = await rootBundle.loadString('config/app_config.json');
  } catch (e, s) {
    print(s);
  }

  DependencyProvider.registerSingleton<RemoteStorage>(
      RemoteStorageImpl(secureStorage, DependencyProvider.get<NetworkClient>(), flavorConfig));
  DependencyProvider.registerSingleton<LocalStorage>(LocalStorageImpl());
  // DependencyProvider.registerSingleton(DownloadVideoService());
  DependencyProvider.registerSingleton<UserRepository>(UserRepositoryImpl(DependencyProvider.get<RemoteStorage>(), DependencyProvider.get<LocalStorage>()));
  DependencyProvider.registerSingleton<PushNotificationsRepository>(
       PushNotificationsRepositoryImpl(remoteStorage: DependencyProvider.get<RemoteStorage>(), localStorage: secureStorage));
  DependencyProvider.registerLazySingleton<LocalesService>(() => LocalesService(Keys.navigatorKey));
  DependencyProvider.registerLazySingleton<ABTestService>(() => ABTestService(config: RemoteConfig.instance));
  DependencyProvider.registerSingleton<ExploreRepository>(
      ExploreRepositoryImpl(workoutApi: DependencyProvider.get<WorkoutApi>()));

  // DependencyProvider.get<WorkoutRepository>()

  return Store<AppState>(
    appReducer,
    initialState: initial ?? AppState.initial(prefs, configString),
    middleware: createAppMiddleware(
      logger,
      DependencyProvider.get<WorkoutRepository>(),
      DependencyProvider.get<WorkoutApi>(),
      DependencyProvider.get<WorkoutListUseCase>(),
      DependencyProvider.get<UserRepository>(),
      DependencyProvider.get<PushNotificationsRepository>(),
      DependencyProvider.get<LocalStorage>(),
      DependencyProvider.get<RemoteStorage>(),
      stringStorage,
      prefs,
      logWriter,
      analyticService,
      DependencyProvider.get<ABTestService>()
    ),
  );
}
