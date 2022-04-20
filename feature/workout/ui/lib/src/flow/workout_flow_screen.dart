import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:workout_ui/src/flow/utils/extensions.dart';
import 'package:workout_ui/src/flow/widget/icon/tutorial_icon_widget.dart';
import 'package:workout_ui/src/flow/widget/indicator/exercise_quantity_indicator.dart';
import 'package:workout_ui/src/flow/widget/page/countdown_page.dart';
import 'package:workout_ui/src/flow/widget/page/exercise_page.dart';
import 'package:workout_ui/src/flow/widget/indicator/flow_indicator.dart';
import 'package:workout_ui/src/flow/widget/common/pause_modal_widget.dart';
import 'package:workout_ui/src/flow/widget/page/exercise_time_edit_page.dart';
import 'package:workout_ui/src/flow/widget/page/rest_page.dart';
import 'package:workout_ui/src/flow/widget/page/round_number_input_page.dart';
import 'package:workout_ui/src/flow/widget/page/share/share_result_screen.dart';
import 'package:workout_ui/src/flow/widget/page/summary/summary_screen.dart';
import 'package:workout_ui/src/flow/workout_flow_cubit.dart';
import 'package:workout_ui/src/model/countdown_model.dart';
import 'package:workout_ui/src/model/exercise_data.dart';
import 'package:workout_ui/src/model/rest_data.dart';
import 'package:workout_ui/src/model/tutorial_model.dart';
import 'package:workout_use_case/use_case.dart';
import 'package:page_transition/page_transition.dart';

import 'package:workout_ui/src/flow/flow_item.dart';
import 'package:workout_ui/src/flow/workout_flow_state.dart';

import '../../workout_ui.dart';
import 'widget/page/congratulation_page.dart';

const exercisePageTransitionDurationMillis = 200;

class WorkoutFlowScreen extends BasePage<WorkoutFlowState, WorkoutFlowCubit> {
  final WorkoutModel workout;
  final String workoutId;
  final int? userWeight;
  final WorkoutSummaryPayload? workoutSummaryPayload;
  final _navigatorKey = GlobalKey<NavigatorState>();

  WorkoutFlowScreen(
      {required this.workout,
      required this.workoutId,
      this.userWeight,
      this.workoutSummaryPayload,
      Key? key})
      : super(key: key);

  @override
  WorkoutFlowCubit createBloc() => DependencyProvider.get<WorkoutFlowCubit>();

  @override
  initBloc(WorkoutFlowCubit bloc) {
    bloc.buildFlowList(workout, workoutId, userWeight, workoutSummaryPayload);
  }

  @override
  bool buildWhen(WorkoutFlowState previous, WorkoutFlowState current,
      BuildContext context) {
    if (previous.isLoading == true &&
        current.isLoading == false &&
        current.error != "") {
      // show dialog to retry
      final result = TfDialog.show(
          context,
          TfDialogAttributes(
            title: "Network failed. Try again?",
            positiveText: S.of(context).all__retry,
            negativeText: S.of(context).all__cancel,
          ));
      result.then((data) {
        if (data is Confirm) {
          // try call api again
          getBloc(context).moveForward();
        }
      });
    }
    if (previous.currentItem != current.currentItem) {
      // moveNext
      if (current.currentItem != null) {
        bool forward = current.isMoveForward;
        final target = _getTargetPageRoute(
            current.currentItem!, current, forward, context);
        _navigatorKey.currentState!.pushReplacement(target);
      }
    }

    return super.buildWhen(previous, current, context);
  }

  PageRoute _getTargetPageRoute(FlowItem item, WorkoutFlowState state,
      bool forward, BuildContext context) {
    if (item.getNavPath() == NavPath.countdownPath && !state.isPlayVoiceStartSound) {
      return _getRoute(
        CountDownPage(
          startVoice: () => getBloc(context).playVoiceCountDown(),
          count: (item.data as CountDownModel).count,
          onNext: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            getBloc(context).moveForward();
          },
        ),
        forward
      );
    }

    if (item.getNavPath().startsWith(NavPath.exercisePath)) {
      return _getRoute(
        ExercisePage(
          hintTitle: getBloc(context)
            .localization
            .workout_flow_exercise_overlay_title,
          exercise: (item.data as ExerciseData).exercise,
          onNext: () => getBloc(context).moveForward(),
          onDelayDone: () {
            getBloc(context).playLongSound();
            getBloc(context).changeDelayDoneValue(true);
          }
        ),
        forward
      );
    }

    if (item.getNavPath().startsWith(NavPath.restPath)) {
      return _getRoute(
        RestPage(
          onRestEnd: () => getBloc(context).moveForward(),
          nextStage: (item.data as RestData).nextStage,
          nextStageExercises: (item.data as RestData).nextStageExercises,
          restTimeMillis: (item.data as RestData).rest.quantity * 1000,
          quote: (item.data as RestData).quote,
        ),
        forward
      );
    }
    if (item.getNavPath().startsWith(NavPath.congratulationPath)) {
      return _getRoute(
        CongratulationPage(
          title: getBloc(context).localization.workout_congratulation_title,
          subTitle:
            getBloc(context).localization.workout_congratulation_subtitle,
          actionBtnText: getBloc(context)
            .localization
            .workout_congratulation_action_btn_text,
          model: item.data,
          watchResult: () {
            getBloc(context).disableAlwaysOn();
            getBloc(context).moveForward();
          }),
        forward
      );
    }

    if (item.getNavPath().startsWith(NavPath.summaryPath)) {
      return _getRoute(
        SummaryScreen(
          model: item.data,
          onBackPressed: workoutSummaryPayload != null
              ? () {
                  getBloc(context).onWorkoutFinish();
                  Navigator.of(context).pop("Finished");
                }
              : null,
          onFinish: () {
            getBloc(context).moveForward();
          },
        ),
        forward
      );
    }

    if (item.getNavPath().startsWith(NavPath.shareResultsPath)) {
      return _getRoute(
        ShareResultScreen(
          model: item.data,
          onFinish: () {
            getBloc(context).onWorkoutFinish();
            Navigator.of(context).pop("Finished");
          },
        ),
        forward
      );
    }

    if (item.getNavPath().startsWith(NavPath.stageTimeEditPath)) {
      return _getRoute(
        ExerciseTimeEditPage(
          initialDuration: item.data.duration,
          onSubmitResult: (v) {
            getBloc(context).onTimeResultEdited(v);
            getBloc(context).moveForward();
          },
        ),
        forward);
    }

    if (item.getNavPath().startsWith(NavPath.stageRoundCountEditPath)) {
      return _getRoute(
          RoundNumberInputPage(
            initialRoundCount:
                item.data.editedRoundCount ?? item.data.roundCount,
            onSubmit: (v) {
              getBloc(context).onRoundCountEdited(v);
              getBloc(context).moveForward();
            },
            editedRoundCount: item.data.editedRoundCount,
          ),
          forward);
    }

    throw 'Unknown navigation path: ${item.getNavPath()}';
  }

  PageRoute _getRoute(Widget page, bool moveForward) {
    return PageTransition(
        duration:
            const Duration(milliseconds: exercisePageTransitionDurationMillis),
        reverseDuration:
            const Duration(milliseconds: exercisePageTransitionDurationMillis),
        type: moveForward
            ? PageTransitionType.rightToLeft
            : PageTransitionType.leftToRight,
        child: page);
  }

  @override
  Widget buildPage(
      BuildContext context, WorkoutFlowCubit bloc, WorkoutFlowState state) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(bloc),
      child: Material(
        child: GestureDetector(
          onTapDown: (details) {
            if (bloc.isScrollLocked()) {
              return;
            }
            if (details.globalPosition.dx >
                    MediaQuery.of(context).size.width - 100 &&
                !bloc.state.isPaused) {
              bloc.moveForward();
            } else if (details.globalPosition.dx < 100 &&
                !bloc.state.isPaused) {
              if (bloc.isScrollBackLocked()) return;
              _handleBackSwipe(bloc, context);
            }
          },
          onVerticalDragStart: (details) {},
          onVerticalDragEnd: (details) {},
          onPanUpdate: (DragUpdateDetails details) {
            if (bloc.isScrollLocked()) {
              return;
            }

            if (details.delta.dx > 0 && !bloc.state.isPaused) {
              if (bloc.isScrollBackLocked()) return;

              _handleBackSwipe(bloc, context);
            } else if (details.delta.dx < 0 && !bloc.state.isPaused) {
              bloc.moveForward();
            }
          },
          child: Stack(
            children: [
              Navigator(
                  key: _navigatorKey,
                  onGenerateInitialRoutes: (navigator, initialRoute) {
                    final root = bloc.getRoot();
                    root.enter(bloc);
                    return [
                      _getTargetPageRoute(root, bloc.state, true, context)
                    ];
                  },
                  initialRoute: bloc.getRoot().getNavPath()),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: FlowIndicator(
                    onPause: () => bloc.onPause(showPauseScreen: true),
                    isPaused: bloc.state.isPaused,
                    segmentIndicatorType: bloc.getExerciseFlowIndicatorType(),
                    enabledFlowIndicator: bloc.isExerciseOrRest(),
                    enabledSegmentIndicator: bloc.isExerciseOrRestInStage(),
                    enabledPauseControl: bloc.isExerciseOrRest(),
                    enabledTimer: bloc.isExerciseOrRestInStage(),
                    reversedTimer: bloc.isCurrentStageAMRAP(),
                    stageAMRAPDuration: bloc.isCurrentStageAMRAP()
                        ? bloc.getWorkoutStageDuration()
                        : null,
                    onEndAMRAPStage: () => bloc.moveToStageRoundCount(),
                    segmentCount: bloc.getCurrentStageLength(),
                    selectedSegment: bloc.getCurrentStageIndex(),
                    rests: bloc.getStageRest(),
                    nextExerciseName: bloc.isCurrentStageAMRAP()
                        ? bloc.localization.exercise_button_result
                        : bloc.isNextExercise()
                            ? (bloc.state.currentItem?.next!.data
                                    as ExerciseData)
                                .exercise
                                .name
                            : bloc.isNextRest()
                                ? bloc.localization.exercise_category_title_rest
                                : bloc.isNextStageTimeEditItem()
                                    ? bloc.localization.exercise_button_result
                                    : bloc.isNextStageRoundCountEditItem()
                                        ? bloc
                                            .localization.exercise_button_result
                                        : bloc.isNextCongratulationItem()
                                            ? bloc.localization
                                                .exercise_button_finish
                                            : null,
                    nextButtonType: bloc.getNextButtonType(),
                    nextButtonText: bloc.localization.exercise_button_skip_rest,
                    nextButtonAction: bloc.isNextButtonActionAMRAP()
                        ? () => bloc.moveToStageRoundCount()
                        : bloc.isExerciseOrRest()
                            ? () => bloc.moveForward()
                            : null),
              ),
              Positioned.fill(
                child: PauseModalWidget(
                  title: bloc.getCurrentExerciseName(),
                  isPaused: bloc.state.showPauseScreen,
                  onPlayTap: () => bloc.onPlay(),
                  onQuitWorkout: () => Navigator.of(context).popUntil(
                      ModalRoute.withName(WorkoutRoute.workoutPreview)),
                  onWatchTutorial: () => Navigator.pushNamed(
                    context,
                    WorkoutRoute.exerciseTutorial,
                    arguments: TutorialModel(
                      title: bloc.getCurrentExerciseName(),
                      url: bloc.getCurrentExerciseVideo(),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 24.0,
                child: ExerciseQuantityIndicator(
                  key: ValueKey('item${bloc.getCurrentExerciseId()}'),
                  id: bloc.getCurrentExerciseId(),
                  quantity: bloc.getCurrentExerciseQuantity(),
                  metrics: bloc.getCurrentExerciseMetrics(),
                  title: bloc.getCurrentExerciseName(),
                  show: bloc.state.currentItem is ExerciseItem,
                  delayDone: state.delayDone,
                  isPaused: bloc.state.isPaused,
                  moveToNext: () => bloc.moveForward(),
                ),
              ),
              Positioned(
                left: 16.0,
                bottom: 16.0,
                child: TutorialIconWidget(
                    show: bloc.state.currentItem is ExerciseItem &&
                        !bloc.state.isPaused,
                    delayDone: bloc.state.delayDone,
                    onWatchTutorial: () async {
                      bloc.onPause(showPauseScreen: bloc.state.showPauseScreen);
                      bloc.setTutorialActivated(true);
                      await Navigator.pushNamed(
                        context,
                        WorkoutRoute.exerciseTutorial,
                        arguments: TutorialModel(
                          title: bloc.getCurrentExerciseName(),
                          url: bloc.getCurrentExerciseVideo(),
                        ),
                      );

                      bloc.setTutorialActivated(false);
                      if (!bloc.state.showPauseScreen) {
                        bloc.onPlay();
                      }
                    }),
              ),
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: bloc.state.isLoading ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: const CircularLoadingIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleBackSwipe(WorkoutFlowCubit bloc, BuildContext context) {
    BackNavMode mode = bloc.moveBack();
    if (mode == BackNavMode.appStack) {
      Navigator.pop(context);
    }
  }

  Future<bool> _onBackPressed(WorkoutFlowCubit bloc) {
    BackNavMode mode = bloc.moveBack();
    return Future.sync(() => mode == BackNavMode.appStack);
  }
}
