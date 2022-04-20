import 'package:core/core.dart';
import 'package:collection/collection.dart';
import 'package:workout_ui/l10n/workout_localizations.dart';
import 'package:workout_ui/src/model/workout_settings_item.dart';
import 'package:workout_ui/src/model/workout_status.dart';
import 'package:workout_ui/src/preview/list_item/item_builder.dart';
import 'package:workout_ui/src/preview/workout_preview_state.dart';
import 'package:workout_ui/workout_ui.dart';
import 'package:workout_use_case/use_case.dart';
import 'package:flutter/foundation.dart';

class WorkoutPreviewCubit extends BaseCubit<WorkoutPreviewState> {
  WorkoutLocalizations localization;
  AppNavigator navigator;
  DownloadWorkoutUseCase downloadWorkoutUseCase;
  WorkoutSettingsUseCase workoutSettingsUseCase;
  WorkoutOnBoardingUseCase workoutOnBoardingUseCase;

  WorkoutPreviewCubit(
      {required this.downloadWorkoutUseCase,
      required this.localization,
      required this.navigator,
      required this.workoutSettingsUseCase,
      required this.workoutOnBoardingUseCase})
      : super(WorkoutPreviewState.initial());

  buildItemList(
      WorkoutModel workout, WorkoutStatus status, bool isLocked) async {
    try {
      final items =
          buildWorkoutPreviewListItems(workout, status, isLocked, localization);
      emit(state.copyWith(
          workoutListItems: items, downloadedStatus: DownloadStatus.notLoaded));
    } catch (e) {
      //Log error
    }
  }

  Future<void> getInitialStatus(WorkoutModel workout) async {
    downloadWorkoutUseCase.getInitialStatus(workout);
  }

  void onStartWorkout(
      WorkoutModel workout, String workoutId, int? userWeight) async {
    final result = await navigator.push(WorkoutRoute.exerciseFlow,
        arguments: [workout, workoutId, userWeight]);
    if (result == "Finished") {
      navigator.popUntil("/to_main");
    }
  }

  Future<bool> getOnBoardingStatus() async {
    return workoutOnBoardingUseCase.getOnBoardingStatus();
  }

  void onStartOnBoarding(
      WorkoutModel workout, String workoutId, int? userWeight) {
    navigator.push(WorkoutRoute.workoutOnBoarding,
        arguments: [workout, workoutId, userWeight]);
  }

  ValueNotifier<int> selectDownloadedPercentFor(WorkoutModel workout) =>
      downloadWorkoutUseCase.selectDownloadedPercentFor(workout);

  void downloadExercise(WorkoutModel workout) {
    emit(state.copyWith(
        workoutListItems: state.workoutListItems,
        downloadedStatus: DownloadStatus.loading));
    downloadWorkoutUseCase.download(workout);
  }

  ValueNotifier<WorkoutModel?> downloadableWorkoutNotifier() =>
      downloadWorkoutUseCase.downloadableWorkoutNotifier();

  ValueNotifier<Set<String>> downloadedExercisesNotifier() =>
      downloadWorkoutUseCase.downloadedExercisesNotifier();

  ValueNotifier<String> errorNotifier() =>
      downloadWorkoutUseCase.errorNotifier();

  bool isWorkoutDownloaded(WorkoutModel workout) {
    final result = downloadWorkoutUseCase.isWorkoutDownloaded(workout);
    if (result) {
      emit(state.copyWith(
          workoutListItems: state.workoutListItems,
          downloadedStatus: DownloadStatus.loaded));
    }
    return result;
  }

  void updateListWorkoutSettingItems(List<WorkoutSettingsItem>? config) {
    emit(state.copyWith(
        workoutListItems: state.workoutListItems,
        downloadedStatus: state.downloadedStatus,
        listWorkoutSettingItems: config));
  }

  void setAudioConfig(List<WorkoutSettingsItem> config) {
    final AudioConfigModel audioConfigModel = AudioConfigModel(
        config: List<WorkoutItemModel>.of(config.map((e) => WorkoutItemModel(
            id: e.id.toString(), label: e.label, value: e.value))));
    workoutSettingsUseCase.setAudioConfig(audioConfigModel);
  }

  Future<List<WorkoutSettingsItem>?>? getAudioConfig() async {
    final result = await workoutSettingsUseCase.getAudioConfig();
    final config = result != null
        ? List<WorkoutSettingsItem>.of(result.config.map((e) =>
            WorkoutSettingsItem(
                id: WorkoutSettingsItem.convertToEnum(e.id),
                label: e.label,
                value: e.value)))
        : null;
    return config;
  }

  void setWorkoutConfig(String uid, List<WorkoutSettingsItem> config) {
    final WorkoutConfigModel workoutConfigModel = WorkoutConfigModel(
      uid: uid,
      config: List<WorkoutItemModel>.of(config.map((e) {
        print('__setID');
        print(e.id.toString());
        return WorkoutItemModel(
            id: e.id.toString(), label: e.label, value: e.value);
      })),
    );
    workoutSettingsUseCase.setWorkoutConfig(workoutConfigModel);
  }

  Future<List<WorkoutSettingsItem>?>? getWorkoutConfig(String uid) async {
    final result = await workoutSettingsUseCase.getWorkoutConfig(uid);
    final config = result != null
        ? List<WorkoutSettingsItem>.of(result.config.map((e) {
            print(e.id);
            return WorkoutSettingsItem(
                id: WorkoutSettingsItem.convertToEnum(e.id),
                label: e.label,
                value: e.value);
          }))
        : null;
    return config;
  }

  WorkoutModel convertToWorkoutWithSettings(
      WorkoutModel workout, List<WorkoutItemModel> config) {
    return WorkoutModel(
        id: workout.id,
        theme: workout.theme,
        image: workout.image,
        difficultyLevel: workout.difficultyLevel,
        estimatedTime: workout.estimatedTime,
        plan: workout.plan,
        badge: workout.badge,
        priorityStage: workout.priorityStage,
        equipment: workout.equipment,
        stages: workout.stages.where((e) {
          if (config.isNotEmpty) {
            final turnOffWarmup = config.singleWhereOrNull((e) =>
                e.id == 'WorkoutSettingsIds.turnOffWarmUp' && e.value == true);
            final turnOffCoolDown = config.singleWhereOrNull((e) =>
                e.id == 'WorkoutSettingsIds.turnOffCoolDown' &&
                e.value == true);

            if ((turnOffWarmup != null && e.stageName == WorkoutStage.WARMUP) ||
                (turnOffCoolDown != null &&
                    e.stageName == WorkoutStage.COOLDOWN)) {
              return false;
            }
          }
          return true;
        }).toList());
  }
}
