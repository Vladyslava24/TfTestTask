import 'package:core/core.dart';
import 'package:workout_data/data.dart';
import 'package:workout_ui/l10n/workout_localizations.dart';
import 'package:workout_ui/src/flow/utils/extensions.dart';
import 'package:workout_ui/src/flow/visitor.dart';
import 'package:workout_ui/src/model/congratulation_model.dart';
import 'package:workout_ui/src/model/countdown_model.dart';
import 'package:workout_ui/src/model/share_result_data.dart';
import 'package:workout_ui/src/flow/workout_flow_state.dart';
import 'package:workout_ui/src/model/exercise_data.dart';
import 'package:workout_ui/src/model/rest_data.dart';
import 'package:workout_ui/src/model/summary_model.dart';
import 'package:workout_ui/workout_ui.dart';
import 'package:workout_use_case/use_case.dart';
import 'flow_item.dart';

const int lastStageIndex = -1;
const int defaultCountDown = 3;
const String doubleShortSound = 'double_short_sound.mp3';
const String longSound = 'long_sound.mp3';
const String voiceCountDown = '321GO.mp3';

class WorkoutFlowCubit extends BaseCubit<WorkoutFlowState> with Visitor {
  static const _tag = 'WorkoutFlowCubit';
  late TFLogger _logger;
  WorkoutLocalizations localization;
  UpdateProgressUseCase progressUseCase;
  AudioService audioService;
  QuoteRepository quoteRepository;
  AppNavigator navigator;
  FlowItem? root;
  FlowItem? head;
  bool _moveToProgressTab = true;
  AlwaysOn alwaysOnService;

  WorkoutFlowCubit({
    required this.localization,
    required this.navigator,
    required this.progressUseCase,
    required this.audioService,
    required this.quoteRepository,
    required TFLogger logger,
    required this.alwaysOnService,
  }) : super(WorkoutFlowState.initial()) {
    _logger = logger;
  }

  void buildFlowList(WorkoutModel workout, String workoutId, int? userWeight,
      WorkoutSummaryPayload? workoutSummaryPayload) {
    alwaysOnService.enable();

    if (workoutSummaryPayload != null) {
      _moveToProgressTab = workoutSummaryPayload.moveToProgressOnClose;
    } else {
      _moveToProgressTab = true;
    }

    int index = 0;

    if (workoutSummaryPayload != null) {
      root = SummaryItem(
          SummaryModel.initialWithPayload(workoutSummaryPayload), index++);
      head = root;
      setNextItem(ShareResultsItem(
          ShareResultData.initialWithPayload(workoutSummaryPayload), index++));
      head = root;
      emit(state.copyWith(
          isPaused: false,
          currentItem: head,
          workout: workout,
          workoutId: workoutId));
      return;
    }

    // start items from CountDownPage
    root = CountDownItem(CountDownModel(count: defaultCountDown), index++);
    head = root;

    for (int i = 0; i < workout.stages.length; i++) {
      final stage = workout.stages[i];

      /// Todo we should build correct Workout Flow for different types.
      final rounds = stage.stageType == WorkoutStageType.FOR_TIME &&
              stage.stageOption.metricType == 'ROUNDS'
          ? stage.stageOption.metricQuantity.toInt()
          : 1;

      // add final Rest
      for (int round = 0; round < rounds; round++) {
        for (var exercise in stage.exercises) {
          setNextItem(ExerciseItem(
              ExerciseData(
                  exercise: exercise,
                  stage: stage.stageName,
                  stageType: stage.stageType,
                  workoutStageDuration: stage.stageOption.metricQuantity),
              index++));
        }

        if (round < rounds - 1) {
          final innerRest = rounds - 1 != stage.stageOption.rests.length
              ? const Rest(quantity: 30, order: 0)
              : stage.stageOption.rests[round];

          setNextItem(RestItem(
              RestData(
                  rest: innerRest,
                  stage: stage.stageName,
                  restType: RestType.inner),
              index++));
        }
      }

      /// Todo: Block should be changed for dynamic values in the future
      ///  Rest after stage - 30 seconds by default
      if (i != workout.stages.length - 1 &&
          workout.stages[i].stageName != WorkoutStage.WOD) {
        setNextItem(
          RestItem(
              RestData(
                  rest: const Rest(quantity: 30, order: lastStageIndex),
                  stage: WorkoutStage.IDLE,
                  quote: quoteRepository.getNextQuote(),
                  nextStage: (i + 1) < workout.stages.length
                      ? workout.stages[i + 1].stageName
                      : null,
                  restType: RestType.external),
              index++),
        );
      }

      if (stage.stageType == WorkoutStageType.FOR_TIME &&
          stage.stageName == workout.priorityStage) {
        setNextItem(StageTimeEditItem.initial(index++));
      }
      if (stage.stageType == WorkoutStageType.AMRAP &&
          stage.stageName == workout.priorityStage) {
        setNextItem(StageRoundCountEditItem.initial(index++));
      }
    }

    setNextItem(CongratulationItem(CongratulationModel.initial(), index++));
    setNextItem(SummaryItem(SummaryModel.initial(userWeight), index++));
    setNextItem(ShareResultsItem(ShareResultData.initial(), index++));

    _logBuildItemFlow();

    head = root;
    emit(state.copyWith(
        isPaused: false,
        currentItem: head,
        workout: workout,
        workoutId: workoutId));
  }

  void _logBuildItemFlow() {
    FlowItem? item = root;
    final buffer = StringBuffer('');
    while (item != null) {
      buffer.write(
          '\nindex : ${item.index}, type: ${item.runtimeType}, restType: ${item is RestItem ? item.data.restType : 'No Rest'}, next: ${item.next != null ? item.next.runtimeType : ''}');
      item = item.next;
    }
    _logger.logInfo(buffer.toString());
  }

  void onPause({bool showPauseScreen = false}) {
    emit(state.copyWith(
        isPaused: true, showPauseScreen: showPauseScreen, currentItem: head));
  }

  void onPlay({bool showPauseScreen = false}) {
    emit(state.copyWith(
        isPaused: false, showPauseScreen: showPauseScreen, currentItem: head));
  }

  void changeDelayDoneValue(bool value) {
    emit(state.copyWith(delayDone: value));
  }

  FlowItem? getNextRest(FlowItem item) {
    return item.next != null && item.next is! RestItem
        ? getNextRest(item.next!)
        : item.next;
  }

  UpdateProgressPayload _createPayloadForUpdateProgress() {
    Map<String, int> exerciseDurationMap = {};
    Map<String, int> stageDurationMap = {};

    FlowItem? root = getRoot();
    FlowItem? head;

    head = root;

    int editedRoundCount = 0;
    int editedDuration = 0;

    final priorityStageOption = workoutModel.stages.firstWhere(
        (element) => element.stageName == workoutModel.priorityStage);
    final WorkoutStageType priorityWorkoutStageType =
        priorityStageOption.stageType;

    while (head != null) {
      if (head is ExerciseItem) {
        exerciseDurationMap.putIfAbsent(head.data.exercise.name, () => 0);
        exerciseDurationMap[head.data.exercise.name] =
            (exerciseDurationMap[head.data.exercise.name]! +
                head.totalDuration);

        String stageType = fromWorkoutStageEnumToString(head.data.stage);
        stageDurationMap.putIfAbsent(stageType, () => 0);
        stageDurationMap[stageType] =
            (stageDurationMap[stageType]! + head.totalDuration);
      } else if (head is StageRoundCountEditItem &&
          priorityWorkoutStageType == WorkoutStageType.AMRAP) {
        editedRoundCount = head.data.editedRoundCount ?? head.data.roundCount;
      } else if (head is StageTimeEditItem &&
          priorityWorkoutStageType == WorkoutStageType.FOR_TIME) {
        editedDuration = head.data.editedForTimeDuration ?? head.data.duration;
      }
      head = head.next;
    }

    List<StageProgress> listStageProgress = <StageProgress>[];
    for (var stage in workoutModel.stages) {
      bool isPriorityStage = stage.stageName == workoutModel.priorityStage;
      List<ExerciseDuration> listExercises = <ExerciseDuration>[];
      String stageNameItem = fromWorkoutStageEnumToString(stage.stageName);
      for (var exercise in stage.exercises) {
        ExerciseDuration exerciseDuration = ExerciseDuration(
          exerciseDuration: exerciseDurationMap[exercise.name]!,
          exerciseName: exercise.name,
          workoutStage: fromStringToWorkoutStageEnum(exercise.type),
        );
        listExercises.add(exerciseDuration);
      }
      StageProgress stageProgress = StageProgress(
        stageDuration: (isPriorityStage &&
                priorityWorkoutStageType == WorkoutStageType.FOR_TIME)
            ? editedDuration.toString()
            : stageDurationMap[stageNameItem].toString(),
        type: stage.stageName,
        roundCount: (isPriorityStage &&
                priorityWorkoutStageType == WorkoutStageType.AMRAP)
            ? editedRoundCount.toString()
            : stage.exercises.length.toString(),
        stageExerciseDurations: listExercises,
      );
      listStageProgress.add(stageProgress);
    }

    return UpdateProgressPayload(
      wodStageDuration: stageDurationMap["WOD"],
      cooldownStageDuration: stageDurationMap["COOLDOWN"],
      warmupStageDuration: stageDurationMap["WARMUP"],
      workoutStageProgresses: listStageProgress,
      workoutStage: "WP_FULL",
      workoutId: workoutModel.id,
    );
  }

  onWorkoutFinish() {
    final streamController = progressUseCase.workoutFinishStream();
    if (_moveToProgressTab) {
      streamController.add("moveToProgressTab");
    }
  }

  moveForward() async {
    if (head?.next is ExerciseItem) {
      playDoubleShortSound();
    }
    try {
      head?.leave(this);
      if (isAmrapRoundCompleted() && !isAmrapStageCompleted()) {
        restartAmrapRound();
      } else {
        if (head is SendPriorityStageResultItem) {
          emit(state.copyWith(isLoading: true));

          Result<UpdateProgressNewResponse> result =
              await progressUseCase.updatePriorityStage();

          if (result.error != null) {
            throw Exception(result.error);
          }
        }

        if (head is SendWorkoutResultItem) {
          emit(state.copyWith(isLoading: true));
          SummaryModel data = head?.data as SummaryModel;
          if (data.workoutSummaryPayload == null) {
            Result<UpdateProgressNewResponse> result = await progressUseCase
                .updateProgress(_createPayloadForUpdateProgress());
            if (result.error != null) {
              throw Exception(result.error);
            }
          }
        }

        head = head?.next;
      }
      head?.enter(this);
      emit(state.copyWith(
        isPaused: false,
        currentItem: head,
        delayDone: false,
        isMoveForward: true,
        error: '',
        isLoading: false,
      ));
    } catch (e) {
      _logger.logError("$_tag moveForward - error : ${e.toString()}");
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  void moveToStageRoundCount() {
    FlowItem? item = head;
    _logger.logInfo(
        "$_tag moveToStageRoundCount - current type : ${item != null ? item.runtimeType : "Null"}");
    while (item is! StageRoundCountEditItem) {
      _logger.logInfo(
          "$_tag moveToStageRoundCount - item is not StageRoundCountEditItem. next item: ${item?.next != null ? item?.next.runtimeType : "Null"}");
      item = item?.next;
    }
    head?.leave(this);
    head = item;
    head?.enter(this);
    emit(state.copyWith(currentItem: head));
  }

  BackNavMode moveBack() {
    if ((head is !CongratulationItem &&
      head is !RoundCountEditItem &&
      head is !StageTimeEditItem &&
      head is !RestItem)
      && head?.prev is ExerciseItem) {
      playDoubleShortSound();
    }
    if ((head?.prev != null && head?.prev is! ExerciseItem) ||
        (head != null && head is CongratulationItem) ||
        (head != null && head is StageTimeEditItem) ||
        (head != null && head is StageRoundCountEditItem) ||
        (head != null &&
            head is ExerciseItem &&
            head?.data != null &&
            (head!.data as ExerciseData).stageType == WorkoutStageType.AMRAP) ||
        ((head != null &&
            head is RestItem &&
            head?.data != null &&
            (head!.data as RestData).restType == RestType.inner)) ||
        ((head != null &&
            head is RestItem &&
            head?.data != null &&
            (head!.data as RestData).restType == RestType.external)) ||
        (state.isPaused && head is ExerciseItem)) {
      _logger.logInfo(
          "$_tag moveBack - BackNavMode is locked. current item type: ${head!.runtimeType}");
      return BackNavMode.locked;
    }
    _logger.logInfo("$_tag moveBack - current item: ${head?.runtimeType}");
    head?.leave(this);
    head?.prev?.enter(this);
    head = head?.prev;
    emit(state.copyWith(
        isMoveForward: false,
        isPaused: false,
        currentItem: head,
        delayDone: false));
    bool allowed = head == null;
    return allowed ? BackNavMode.appStack : BackNavMode.nestedStack;
  }

  @override
  FlowItem getRoot() => root!;

  bool isScrollLocked() {
    return head is LockScrollItem;
  }

  bool isScrollBackLocked() {
    return head is LockScrollBackItem;
  }

  void onTimeResultEdited(int v) {
    head!.data = head!.data.copyWith(editedForTimeDuration: v);
  }

  void onRoundCountEdited(int v) {
    head!.data = head!.data.copyWith(editedRoundCount: v);
  }

  void disableAlwaysOn() {
    alwaysOnService.disable();
  }

  void playLongSound() {
    if (!state.isTutorialActivated) {
      audioService.playSound(longSound);
    }
  }

  void playDoubleShortSound() {
    if (!state.isTutorialActivated) {
      audioService.playSound(doubleShortSound);
    }
  }

  void playVoiceCountDown() {
    if (!state.isPlayVoiceStartSound) {
      audioService.playSound(voiceCountDown);
      emit(state.copyWith(isPlayVoiceStartSound: true));
    }
  }

  void setTutorialActivated(bool value) {
    emit(state.copyWith(isTutorialActivated: value));
  }

  @override
  WorkoutModel get workoutModel => state.workout!;
}

class NavPath {
  static const exercisePath = 'exercise_path';
  static const restPath = 'rest_path';
  static const summaryPath = 'summary_path';
  static const roundCountEditPath = 'round_count_edit_path';
  static const stageTimeEditPath = 'stage_time_edit_path';
  static const stageRoundCountEditPath = 'stage_round_count_edit_path';
  static const shareResultsPath = 'share_results_path';
  static const congratulationPath = 'congratulation_path';
  static const countdownPath = 'countdown_path';
}

enum BackNavMode { locked, nestedStack, appStack }
