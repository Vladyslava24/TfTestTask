import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/model/workout_settings_item.dart';
import 'package:workout_ui/src/model/workout_status.dart';
import 'package:workout_ui/src/navigation/workout_route.dart';
import 'package:workout_ui/src/preview/widget/workout_actions_widget.dart';
import 'package:workout_ui/src/preview/widget/workout_modal_bottom_sheet.dart';
import 'package:workout_ui/src/preview/widget/workout_preview_custom_scroll.dart';
import 'package:workout_ui/src/preview/widget/workout_settings_widget.dart';
import 'package:workout_ui/src/preview/workout_preview_cubit.dart';
import 'package:workout_ui/src/preview/workout_preview_state.dart';
import 'package:workout_use_case/use_case.dart';

class WorkoutPreviewScreenV2
  extends BasePage<WorkoutPreviewState, WorkoutPreviewCubit> {
  final WorkoutModel workout;
  final String workoutId;
  final bool isUserPremium;
  final int? userWeight;

  const WorkoutPreviewScreenV2({
    required this.workout,
    required this.isUserPremium,
    required this.workoutId,
    this.userWeight,
    Key? key
  }) : super(key: key);

  @override
  initBloc(WorkoutPreviewCubit bloc) async {
    bloc.buildItemList(workout, WorkoutStatus.idle, true);
    bloc.getInitialStatus(workout);
    final List<WorkoutSettingsItem>? listWorkoutSettingItems = await bloc.getWorkoutConfig(workout.id);
    bloc.updateListWorkoutSettingItems(listWorkoutSettingItems);
  }

  @override
  createBloc() => DependencyProvider.get<WorkoutPreviewCubit>();

  @override
  Widget buildPage(BuildContext context, bloc, state) {
    return Scaffold(
      backgroundColor: AppColorScheme.colorBlack,
      body: Stack(
        children: [
          state.getHeader() != null
            ? WorkoutPreviewCustomScroll(
                listWorkoutSettingItems: state.listWorkoutSettingItems,
                bodyItemList: state.workoutListItems,
                onStartPressed: () {},
                headerItem: state.getHeader()!,
                detailsTitle: [
                  bloc.localization.preview_workout_details,
                  bloc.localization.preview_workout_equipment
                ],
                fixedActions: WorkoutFixedActionsWidget(
                  onAudioSettingsCall: () async {
                    final _settings = await bloc.getAudioConfig();
                    final settings = _settings ??
                      [
                        WorkoutSettingsItem(
                          id: WorkoutSettingsIds.voiceAndSound,
                          label: bloc.localization
                            .preview_audio_settings_item_title1,
                          value: true
                        ),
                        WorkoutSettingsItem(
                          id: WorkoutSettingsIds.voiceAndMusic,
                          label: bloc.localization
                            .preview_audio_settings_item_title2,
                          value: false
                        ),
                        WorkoutSettingsItem(
                          id: WorkoutSettingsIds.onlyMusic,
                          label: bloc.localization
                            .preview_audio_settings_item_title3,
                          value: false
                        )
                      ];

                    final result = await workoutModalBottomSheet(
                      context: context,
                      title: bloc.localization.preview_audio_settings_title,
                      textActionButton: bloc
                        .localization.preview_audio_settings_button_title,
                      mode: WorkoutSettingsMode.audio,
                      settings: settings
                    );

                    if (result != null) {
                      bloc.setAudioConfig(result);
                    }
                  },
                  onWorkoutSettingsCall: () async {
                    final _settings = await bloc.getWorkoutConfig(workout.id);
                    final settings = _settings ?? [
                      WorkoutSettingsItem(
                        id: WorkoutSettingsIds.turnOffWarmUp,
                        label: bloc.localization
                          .preview_workout_settings_item_title1,
                        value: false
                      ),
                      WorkoutSettingsItem(
                        id: WorkoutSettingsIds.turnOffCoolDown,
                        label: bloc.localization
                          .preview_workout_settings_item_title2,
                        value: false),
                      ];

                    final result = await workoutModalBottomSheet(
                      context: context,
                      title:
                        bloc.localization.preview_workout_settings_title,
                      textActionButton: bloc
                        .localization.preview_audio_settings_button_title,
                      mode: WorkoutSettingsMode.workout,
                      settings: settings);

                    if (result != null) {
                      bloc.updateListWorkoutSettingItems(result);
                      bloc.setWorkoutConfig(workout.id, result);
                    }
                  },
                ))
            : const SizedBox.shrink(),
          _buildButton(bloc),
        ],
      ),
    );
  }

  _buildButton(WorkoutPreviewCubit bloc) {
    return ValueListenableBuilder<int>(
      valueListenable: bloc.selectDownloadedPercentFor(workout),
      builder: (context, value, child) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: !isUserPremium && workout.plan == 'PREMIUM' ?
            BaseElevatedButton(
              padding:
                const EdgeInsets.only(bottom: 20.0, left: 16.0, right: 16.0),
              text: bloc.localization.preview_unlock_workout,
              image: lockIcon,
              backgroundColor: AppColorScheme.colorPrimaryWhite,
              onPressed: () =>
                Navigator.of(context)
                  .pushNamed(WorkoutRoute.paywallFromWorkoutPreview)
            ) :
            BaseDownloadButton(
              value: value.toDouble() / 100,
              backgroundColor:
                !bloc.isWorkoutDownloaded(workout) &&
                bloc.state.downloadedStatus == DownloadStatus.loading ?
                AppColorScheme.colorBlack4 : AppColorScheme.colorPrimaryWhite,
              animationColor: AppColorScheme.colorYellow,
              text: !bloc.isWorkoutDownloaded(workout) &&
                bloc.state.downloadedStatus == DownloadStatus.loading ?
                  bloc.localization.preview_workout_button_loading :
                  bloc.isWorkoutDownloaded(workout) &&
                bloc.state.downloadedStatus == DownloadStatus.loaded  ?
                  bloc.localization.preview_workout_button_start :
                  bloc.localization.preview_workout_button_download,
              textColor:
                !bloc.isWorkoutDownloaded(workout) &&
                bloc.state.downloadedStatus == DownloadStatus.loading &&
                value < 40 ?
                  AppColorScheme.colorPrimaryWhite :
                  AppColorScheme.colorPrimaryBlack,
              isDownloaded: bloc.isWorkoutDownloaded(workout),
              margin: const EdgeInsets.only(
                top: 16, bottom: 24, left: 16, right: 16),
              onPressed: () async {
                if (bloc.isWorkoutDownloaded(workout)) {
                  final isOnBoardingShown = await bloc.getOnBoardingStatus();
                  final settings = await bloc
                    .workoutSettingsUseCase
                    .getWorkoutConfig(workout.id);
                  final config = settings?.config ?? [];
                  final workoutAccordingSettings =
                    bloc.convertToWorkoutWithSettings(workout, config);

                  if (!isOnBoardingShown) {
                    bloc.onStartOnBoarding(
                      workoutAccordingSettings,
                      workoutId,
                      userWeight
                    );
                    return;
                  }
                  bloc.onStartWorkout(
                    workoutAccordingSettings,
                    workoutId,
                    userWeight
                  );
                } else {
                  bloc.downloadExercise(workout);
                }
              },
            ),
        );
      }
    );
  }
}
