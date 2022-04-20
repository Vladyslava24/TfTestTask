library mood_api;

import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:mood_data/data.dart';
import 'package:mood_ui/ui.dart';
import 'package:mood_usecase/mood_usecase.dart';
import 'package:mood_usecase/mood_usecase_impl.dart';

export 'package:mood_ui/ui.dart' show MoodRoute;
export 'package:mood_ui/l10n/mood_localizations.dart';

class MoodDependencyResolver {
  static void register() {
    DependencyProvider.registerLazySingleton<MoodLocalizations>(() =>
      MoodLocalizations.of(DependencyProvider.get<BuildContext>()));

    DependencyProvider.registerLazySingleton<MoodRepository>(() =>
      MoodRepositoryImpl(
        networkClient: DependencyProvider.get<NetworkClient>(),
        jwtProvider: DependencyProvider.get<JwtProvider>()
      )
    );

    DependencyProvider.registerLazySingleton<MoodUseCase>(
      () => MoodUseCaseImpl(
        repository: DependencyProvider.get<MoodRepository>()
      ),
    );

    DependencyProvider.get<NavigationGraph>()
      .registerFeature(MoodRouter.getRoutes());
  }
}
