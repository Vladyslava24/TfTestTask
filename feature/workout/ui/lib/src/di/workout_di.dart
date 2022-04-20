import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:impl/impl.dart';
import 'package:workout_api/api.dart';
import 'package:workout_data/data.dart';
import 'package:workout_ui/src/flow/workout_flow_cubit.dart';
import 'package:workout_ui/src/onboarding/workout_onboarding_cubit.dart';
import 'package:workout_ui/src/preview/workout_preview_cubit.dart';
import 'package:workout_ui/workout_ui.dart';
import 'package:workout_use_case/use_case.dart';

class WorkoutDependencyResolver {
  static void register() {
    DependencyProvider.registerLazySingleton<WorkoutLocalizations>(
        () => WorkoutLocalizations.of(DependencyProvider.get<BuildContext>()));
    DependencyProvider.registerLazySingleton<WorkoutApi>(() => WorkoutApiImpl(
        DependencyProvider.get<NetworkClient>(),
        DependencyProvider.get<JwtProvider>()));

    DependencyProvider.registerLazySingleton<WorkoutRepository>(() =>
        WorkoutRepositoryImpl(
            DependencyProvider.get<NetworkClient>(),
            DependencyProvider.get<JwtProvider>(),
            DependencyProvider.get<TFLogger>()));
    DependencyProvider.registerLazySingleton<WorkoutListUseCase>(() =>
        WorkoutListUseCaseImpl(DependencyProvider.get<WorkoutRepository>()));

    DependencyProvider.registerLazySingleton<DownloadWorkoutUseCase>(
        () => DownloadWorkoutUseCaseImpl());

    DependencyProvider.registerLazySingleton<WorkoutOnBoardingUseCase>(() =>
        WorkoutOnBoardingUseCaseImpl(DependencyProvider.get<PrefsStorage>()));

    DependencyProvider.registerLazySingleton<WorkoutSettingsUseCase>(() =>
        WorkoutSettingsUseCaseImpl(DependencyProvider.get<PrefsStorage>()));

    DependencyProvider.registerLazySingleton<UpdateProgressUseCase>(() =>
        UpdateProgressUseCaseImpl(DependencyProvider.get<WorkoutRepository>()));

    DependencyProvider.registerLazySingleton<QuoteRepository>(
        () => QuoteRepositoryImpl(DependencyProvider.get<PrefsStorage>()));

    DependencyProvider.registerFactory<WorkoutPreviewCubit>(
      () => WorkoutPreviewCubit(
          workoutOnBoardingUseCase:
              DependencyProvider.get<WorkoutOnBoardingUseCase>(),
          downloadWorkoutUseCase:
              DependencyProvider.get<DownloadWorkoutUseCase>(),
          localization: DependencyProvider.get<WorkoutLocalizations>(),
          navigator: DependencyProvider.get<AppNavigator>(),
          workoutSettingsUseCase:
              DependencyProvider.get<WorkoutSettingsUseCase>()),
    );

    DependencyProvider.registerFactory<WorkoutOnBoardingCubit>(
      () => WorkoutOnBoardingCubit(
          workoutOnBoardingUseCase:
              DependencyProvider.get<WorkoutOnBoardingUseCase>(),
          localization: DependencyProvider.get<WorkoutLocalizations>(),
          navigator: DependencyProvider.get<AppNavigator>()),
    );

    DependencyProvider.registerFactory<WorkoutFlowCubit>(() => WorkoutFlowCubit(
          logger: DependencyProvider.get<TFLogger>(),
          audioService: DependencyProvider.get<AudioService>(),
          localization: DependencyProvider.get<WorkoutLocalizations>(),
          navigator: DependencyProvider.get<AppNavigator>(),
          progressUseCase: DependencyProvider.get<UpdateProgressUseCase>(),
          alwaysOnService: DependencyProvider.get<AlwaysOn>(),
          quoteRepository: DependencyProvider.get<QuoteRepository>(),
        ));

    DependencyProvider.get<NavigationGraph>()
        .registerFeature(WorkoutRouter.getRoutes());
  }
}
