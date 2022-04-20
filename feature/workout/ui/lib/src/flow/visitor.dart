import 'package:workout_ui/src/common/time_utils.dart';
import 'package:workout_ui/src/flow/utils/calories_utils.dart';
import 'package:workout_ui/src/flow/workout_flow_state.dart';
import 'package:workout_ui/src/model/rest_data.dart';
import 'package:workout_ui/src/model/share_result_data.dart';
import 'package:workout_ui/src/model/summary_model.dart';
import 'package:workout_ui/src/utils/exercise_utils.dart';
import 'package:workout_use_case/use_case.dart';
import 'package:workout_ui/src/model/workout_summary_payload.dart';
import 'flow_item.dart';

abstract class Visitor {
  FlowItem getRoot();

  WorkoutModel get workoutModel;

  WorkoutFlowState get state;

  void enter(FlowItem item) async {
    if (item is RestItem) {
      if (item.data.restType == RestType.external) {
        if (item.data.nextStage != null) {
          final nextStageOption = workoutModel.stages.firstWhere(
              (element) => element.stageName == item.data.nextStage);

          final exercises = nextStageOption.exercises.map((e) {
            return ExercisesItem(
                name: e.name,
                image: e.image,
                duration: getQuantityByMetricsInText(e.quantity, e.metrics));
          }).toList();
          item.data.nextStageExercises = exercises;
        }
      }
    }
    if (item is SummaryItem) {
      if (item.data.workoutSummaryPayload != null) {
        item.data = _buildSummaryItemDataWithPayload(item);
      } else {
        item.data = _getSummaryItemData(item);
      }
    }
    if (item is ShareResultsItem) {
      if (item.data.workoutSummaryPayload != null) {
        item.data = _getShareResultItemDataWithPayload(item);
      } else {
        item.data = _getShareResultItemData(item);
      }
    }

    if (item is StageTimeEditItem) {
      FlowItem? tail = item.prev;
      WorkoutStage workoutStage = workoutModel.priorityStage;

      int duration = 0;

      /// Loop should be stopped when it visited RestItem with
      /// type RestType.external
      while (tail != null) {
        if (tail is ExerciseItem) {
          duration += tail.totalDuration;
        } else if (tail is RestItem && tail.data.restType == RestType.inner) {
          //duration += tail.totalDuration;
          tail = tail.prev;
          continue;
        } else {
          break;
        }
        tail = tail.prev;
      }
      item.data = item.data.copyWith(
        duration: duration,
        workoutStage: workoutStage,
      );
    }

    if (item is StageRoundCountEditItem) {
      FlowItem? tail = item.prev;
      WorkoutStage workoutStage = workoutModel.priorityStage;
      List<ExerciseDuration> stageExerciseDuration = [];

      while (tail != null) {
        if (tail is ExerciseItem) {
          final stageDuration = ExerciseDuration(
            workoutStage: tail.data.stage,
            exerciseName: tail.data.exercise.name,
            exerciseDuration: tail.totalDuration,
          );
          stageExerciseDuration.add(stageDuration);
        } else {
          break;
        }
        tail = tail.prev;
      }

      item.data = item.data.copyWith(
        stageExerciseDuration: stageExerciseDuration,
        workoutStage: workoutStage,
      );
    }
  }

  void leave(FlowItem item) {
    if (item is StageTimeEditItem) {}
  }

  ShareResultData _getShareResultItemDataWithPayload(ShareResultsItem item) {
    Map<String, int> priorityExerciseDuration = {};

    WorkoutSummaryPayload summaryPayload = item.data.workoutSummaryPayload!;

    final priorityStageOption = summaryPayload.workoutModel.stages.firstWhere(
        (element) =>
            element.stageName == summaryPayload.workoutModel.priorityStage);

    for (var stage in summaryPayload.stageProgress) {
      if (summaryPayload.workoutModel.priorityStage == stage.type) {
        if (priorityStageOption.stageType == WorkoutStageType.FOR_TIME) {
          item.data.priorityStageTime =
              TimeUtils.formatExerciseDuration(int.parse(stage.stageDuration!));
        } else {
          item.data.amrapRoundCount = int.parse(stage.roundCount!);
        }
        for (var exercise in stage.stageExerciseDurations) {
          priorityExerciseDuration.putIfAbsent(exercise.exerciseName, () => 0);
          priorityExerciseDuration[exercise.exerciseName] =
              exercise.exerciseDuration;
        }
      }
    }

    item.data.priorityExercisesDurationMap = priorityExerciseDuration;
    item.data.priorityStageType = priorityStageOption.stageType;
    item.data.priorityStage = summaryPayload.workoutModel.priorityStage;
    item.data.totalTime =
        TimeUtils.formatWorkoutDuration(summaryPayload.workoutDuration);

    return item.data;
  }

  ShareResultData _getShareResultItemData(ShareResultsItem item) {
    Map<String, int> exerciseDuration = {};

    FlowItem? root = getRoot();
    FlowItem? head;
    int editedForTimeDuration = 0;

    head = root;

    FlowItem? currentItem = root;
    while (currentItem != null &&
        currentItem is! StageRoundCountEditItem &&
        currentItem is! StageTimeEditItem) {
      currentItem = currentItem.next;
    }
    final priorityStageOption = workoutModel.stages.firstWhere(
        (element) => element.stageName == workoutModel.priorityStage);

    int realTotalTime = 0;
    int realPriorityStageTime = 0;

    while (head != null) {
      if (head is ExerciseItem) {
        exerciseDuration.putIfAbsent(head.data.exercise.name, () => 0);
        exerciseDuration[head.data.exercise.name] =
            (exerciseDuration[head.data.exercise.name]! + head.totalDuration);
        if (head.getStageName() == workoutModel.priorityStage) {
          realPriorityStageTime += head.totalDuration;
        }
        realTotalTime += head.totalDuration;
      }
      head = head.next;
    }

    int finalTotalTime = 0;

    if (priorityStageOption.stageType == WorkoutStageType.AMRAP) {
      if (currentItem is StageRoundCountEditItem) {
        finalTotalTime = realTotalTime;
        item.data.amrapRoundCount = currentItem.data.editedRoundCount;
      }
    } else {
      if (currentItem is StageTimeEditItem) {
        editedForTimeDuration = currentItem.data.editedForTimeDuration ?? 0;
        finalTotalTime = realTotalTime - realPriorityStageTime;
        finalTotalTime = finalTotalTime + editedForTimeDuration;

        item.data.priorityStageTime = TimeUtils.formatExerciseDuration(
            currentItem.data.editedForTimeDuration ?? 0);
      }
    }

    FlowItem? newHead;
    newHead = root;
    item.data.priorityExercisesDurationMap =
        _getPriorityMajorStageExerciseDuration(newHead);
    item.data.priorityStageType = priorityStageOption.stageType;
    item.data.priorityStage = workoutModel.priorityStage;
    item.data.totalTime = TimeUtils.formatWorkoutDuration(finalTotalTime);

    return item.data;
  }

  Map<String, int> _getPriorityMajorStageExerciseDuration(FlowItem? head) {
    Map<String, int> priorityExercisesDuration = {};
    while (head != null) {
      if (head is ExerciseItem &&
          head.getStageName() == workoutModel.priorityStage) {
        priorityExercisesDuration.putIfAbsent(head.data.exercise.name, () => 0);
        priorityExercisesDuration[head.data.exercise.name] =
            (priorityExercisesDuration[head.data.exercise.name]! +
                head.totalDuration);
      }

      head = head.next;
    }
    return priorityExercisesDuration;
  }

  SummaryModel _buildSummaryItemDataWithPayload(SummaryItem item) {
    Map<String, int> exerciseDuration = {};

    WorkoutSummaryPayload summaryPayload = item.data.workoutSummaryPayload!;

    final List<Object> listItems = [
      HeaderItem(
        image: workoutModel.image,
        workoutName: workoutModel.theme,
      ),
    ];

    final priorityStageOption = summaryPayload.workoutModel.stages.firstWhere(
        (element) =>
            element.stageName == summaryPayload.workoutModel.priorityStage);
    final WorkoutStageType priorityWorkoutStageType =
        priorityStageOption.stageType;

    int priorityStageTime = 0;
    String priorityStageRoundCount = "0";
    int workoutDurationTotal = 1;
    WorkoutStageType workoutStageTypePriority = WorkoutStageType.IDLE;

    for (var stage in summaryPayload.workoutModel.stages) {
      if (stage.stageName == summaryPayload.workoutModel.priorityStage) {
        workoutStageTypePriority = stage.stageType;
      }
    }

    if (summaryPayload.workoutModel.priorityStage == WorkoutStage.WOD) {
      priorityStageTime = summaryPayload.wodStageDuration;
    } else if (summaryPayload.workoutModel.priorityStage ==
        WorkoutStage.WARMUP) {
      priorityStageTime = summaryPayload.warmupStageDuration;
    } else if (summaryPayload.workoutModel.priorityStage ==
        WorkoutStage.COOLDOWN) {
      priorityStageTime = summaryPayload.cooldownStageDuration;
    }

    for (var stage in summaryPayload.stageProgress) {
      workoutDurationTotal =
          workoutDurationTotal + int.parse(stage.stageDuration!);
      if (summaryPayload.workoutModel.priorityStage == stage.type) {
        if (priorityWorkoutStageType == WorkoutStageType.FOR_TIME) {
          priorityStageTime = int.parse(stage.stageDuration!);
        } else if (priorityWorkoutStageType == WorkoutStageType.AMRAP) {
          priorityStageRoundCount = stage.roundCount!;
        }
      }
    }

    listItems.add(TimeScoreItem(
        time: TimeUtils.formatWorkoutDuration(priorityStageTime),
        rounds: priorityStageRoundCount,
        stageType: workoutStageTypePriority));

    int exerciseCount = 0;
    for (var element in workoutModel.stages) {
      exerciseCount += element.exercises.length;
    }

    listItems.add(
      WorkoutResultItem(
          exercises: exerciseCount,
          duration: TimeUtils.formatWorkoutDuration(workoutDurationTotal),
          calories: CaloriesUtils.calculateCalories(
              workoutDurationTotal, item.getUserWeight())),
    );

    final sortedStages = List.of(workoutModel.stages);
    sortedStages.sort((a, b) {
      if (a.stageName == workoutModel.priorityStage ||
          b.stageName == workoutModel.priorityStage) {
        return 1;
      } else {
        return 0;
      }
    });

    for (var stage in summaryPayload.stageProgress) {
      for (var exercise in stage.stageExerciseDurations) {
        exerciseDuration.putIfAbsent(exercise.exerciseName, () => 0);
        exerciseDuration[exercise.exerciseName] =
            (exerciseDuration[exercise.exerciseName]! +
                exercise.exerciseDuration);
      }
    }

    for (var stage in sortedStages) {
      final exerciseHeader = ExercisesHeaderItem(
          rounds: stage.stageOption.rests.length + 1,
          exercises: stage.exercises.length,
          name: stage.stageName,
          type: stage.stageType);

      listItems.add(exerciseHeader);
      final exercises = stage.exercises.map((e) {
        final duration = exerciseDuration[e.name];
        return ExercisesItem(
            name: e.name,
            image: e.image,
            duration: TimeUtils.formatExerciseDuration(duration ?? 0));
      });
      listItems.addAll(exercises);
    }

    listItems.add(BottomPaddingItem());

    //////////

    List<ExerciseDuration> stageExerciseDuration = [];

    int duration = 0;

    return SummaryModel(
        listItems: listItems,
        roundCount: 0,
        duration: duration,
        stageExerciseDuration: stageExerciseDuration,
        workoutSummaryPayload: summaryPayload);
  }

  SummaryModel _getSummaryItemData(SummaryItem item) {
    FlowItem? root = getRoot();
    FlowItem? head;
    Map<String, int> exerciseDuration = {};

    head = root;

    final List<Object> listItems = [
      HeaderItem(
        image: workoutModel.image,
        workoutName: workoutModel.theme,
      ),
    ];

    int workoutDuration = 0;
    int priorityStageTime = 0;

    final priorityStageOption = workoutModel.stages.firstWhere(
        (element) => element.stageName == workoutModel.priorityStage);
    final WorkoutStageType priorityWorkoutStageType =
        priorityStageOption.stageType;
    int editedRounds = 0;
    int editedTime = 0;

    while (head != null) {
      if (head is ExerciseItem) {
        exerciseDuration.putIfAbsent(head.data.exercise.name, () => 0);
        exerciseDuration[head.data.exercise.name] =
            (exerciseDuration[head.data.exercise.name]! + head.totalDuration);

        if (head.getStageName() == workoutModel.priorityStage) {
          priorityStageTime += head.totalDuration;
        }
        workoutDuration += head.totalDuration;
      } else if (head is StageRoundCountEditItem &&
          priorityWorkoutStageType == WorkoutStageType.AMRAP) {
        editedRounds = head.data.editedRoundCount ?? head.data.roundCount;
      } else if (head is StageTimeEditItem &&
          priorityWorkoutStageType == WorkoutStageType.FOR_TIME) {
        editedTime = head.data.editedForTimeDuration ?? head.data.duration;
      }
      head = head.next;
    }

    listItems.add(
      TimeScoreItem(
          rounds: editedRounds.toString(),
          stageType: priorityWorkoutStageType,
          time: TimeUtils.formatWorkoutDuration(editedTime)),
    );

    int exerciseCount = 0;
    for (var element in workoutModel.stages) {
      exerciseCount += element.exercises.length;
    }

    listItems.add(
      WorkoutResultItem(
          exercises: exerciseCount,
          duration: TimeUtils.formatWorkoutDuration(workoutDuration),
          calories: CaloriesUtils.calculateCalories(
              workoutDuration, item.getUserWeight())),
    );

    final sortedStages = List.of(workoutModel.stages);
    sortedStages.sort((a, b) {
      if (a.stageName == workoutModel.priorityStage ||
          b.stageName == workoutModel.priorityStage) {
        return 1;
      } else {
        return 0;
      }
    });
    for (var stage in sortedStages) {
      final exerciseHeader = ExercisesHeaderItem(
          rounds: stage.stageOption.rests.length + 1,
          exercises: stage.exercises.length,
          name: stage.stageName,
          type: stage.stageType);

      listItems.add(exerciseHeader);
      final exercises = stage.exercises.map((e) {
        final duration = exerciseDuration[e.name];
        return ExercisesItem(
            name: e.name,
            image: e.image,
            duration: TimeUtils.formatExerciseDuration(duration ?? 0));
      });
      listItems.addAll(exercises);
    }

    listItems.add(BottomPaddingItem());

    //////////

    List<ExerciseDuration> stageExerciseDuration = [];

    int duration = 0;

    return SummaryModel(
        listItems: listItems,
        roundCount: 0,
        duration: duration,
        stageExerciseDuration: stageExerciseDuration);
  }
}
