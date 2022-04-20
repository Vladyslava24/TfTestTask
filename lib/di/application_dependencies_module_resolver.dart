import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:force_upgrade_service/service.dart';
import 'package:mood_api/mood_api.dart';
import 'package:totalfit/common/flavor/flavor_config.dart';
import 'package:totalfit/ui/widgets/keys.dart';
import 'package:workout_ui/workout_ui.dart';
import 'app_dependency_resolver.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:profile_api/profile_dependency_resolver.dart';

class ApplicationDependenciesModuleResolver {
  static register(FlavorConfig flavorConfig, TFLogger logger) {
    _registerApplication(flavorConfig, logger);
    _registerFeatures();
  }

  static _registerApplication(FlavorConfig flavorConfig, TFLogger logger) {
    DependencyProvider.registerLazySingleton<BuildContext>(
        () => Keys.navigatorKey.currentState.context);
    DependencyProvider.registerLazySingleton<NavigatorState>(
        () => Keys.navigatorKey.currentState);

    DependencyProvider.registerLazySingleton<AppNavigator>(
        () => AppNavigator(DependencyProvider.get<NavigatorState>()));

    DependencyProvider.registerLazySingleton<TFLogger>(() => logger);

    DependencyProvider.registerLazySingleton<AudioService>(
        () => AudioService(DependencyProvider.get<TFLogger>()));

    DependencyProvider
        .registerLazySingleton<List<LocalizationsDelegate<dynamic>>>(() => [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              WorkoutLocalizations.delegate,
              MoodLocalizations.delegate,
              AppLocalizationDelegate(),
            ]);
    CoreModuleInitializer.init('https://${flavorConfig.values.apiUrl}', logger);

    DependencyProvider.registerLazySingleton(() => ForceUpgradeService(
          DependencyProvider.get<AppNavigator>(),
          RemoteConfig.instance,
          DependencyProvider.get<TFLogger>(),
        ));
  }

  static _registerFeatures() {
    AppDependencyResolver.register();
    WorkoutDependencyResolver.register();
    MoodDependencyResolver.register();
    ProfileDependencyResolver.register();
  }
}
