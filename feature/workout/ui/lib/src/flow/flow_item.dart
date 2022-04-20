import 'package:workout_ui/src/flow/visitor.dart';
import 'package:workout_ui/src/model/congratulation_model.dart';
import 'package:workout_ui/src/model/share_result_data.dart';
import 'package:workout_ui/src/flow/workout_flow_cubit.dart';
import 'package:workout_ui/src/model/exercise_data.dart';
import 'package:workout_ui/src/model/rest_data.dart';
import 'package:workout_ui/src/model/summary_model.dart';
import 'package:workout_use_case/use_case.dart';

import '../model/flow_item_data.dart';

abstract class FlowItem<T> {
  int index;

  T data;

  FlowItem? next;

  FlowItem? prev;

  FlowItem(this.data, this.index);

  String getNavPath();

  enter(Visitor visitor);

  leave(Visitor visitor);
}

abstract class StageAwareItem {
  WorkoutStage getStageName();
}

class ExerciseItem extends FlowItem<ExerciseData> implements StageAwareItem {
  int? entered;

  int totalDuration = 0;

  ExerciseItem(ExerciseData data, int index) : super(data, index);

  @override
  String getNavPath() => NavPath.exercisePath;

  @override
  enter(Visitor visitor) {
    entered = DateTime.now().millisecondsSinceEpoch;
    visitor.enter(this);
  }

  @override
  leave(Visitor visitor) {
    if (entered != null) {
      totalDuration += (DateTime.now().millisecondsSinceEpoch - entered!);
    }
    visitor.leave(this);
  }

  @override
  WorkoutStage getStageName() => data.stage;

  WorkoutStageType getStageType() => data.stageType;
}

class RestItem extends FlowItem<RestData> implements
  StageAwareItem, LockScrollBackItem {
  int? entered;

  int totalDuration = 0;

  RestItem(RestData data, int index) : super(data, index);

  @override
  String getNavPath() => NavPath.restPath;

  @override
  enter(Visitor visitor) {
    entered = DateTime.now().millisecondsSinceEpoch;
    visitor.enter(this);
  }

  @override
  leave(Visitor visitor) {
    if (entered != null) {
      totalDuration += (DateTime.now().millisecondsSinceEpoch - entered!);
    }
    visitor.leave(this);
  }

  @override
  WorkoutStage getStageName() => data.stage;
}

class SummaryItem extends FlowItem<SummaryModel> with
  SendWorkoutResultItem, LockScrollItem {
  SummaryItem(SummaryModel data, int index) : super(data, index);

  @override
  enter(Visitor visitor) {
    visitor.enter(this);
  }

  @override
  leave(Visitor visitor) {
    visitor.leave(this);
  }

  @override
  String getNavPath() => NavPath.summaryPath;

  @override
  int? getAmrapRoundCount() => data.roundCount;

  @override
  List<ExerciseDuration> getStageExerciseDuration() =>
      data.stageExerciseDuration;

  @override
  int? getDuration() => data.duration;

  int getUserWeight() => data.userWeight == null || data.userWeight == 0 ?
    70 : data.userWeight!;
}

class RoundCountEditItem extends FlowItem<int> implements LockScrollItem {
  factory RoundCountEditItem.initial(int index) =>
      RoundCountEditItem(-1, index);

  RoundCountEditItem(int data, int index) : super(data, index);

  @override
  enter(Visitor visitor) {}

  @override
  String getNavPath() => NavPath.roundCountEditPath;

  @override
  leave(Visitor visitor) {}
}

class StageTimeEditItem extends FlowItem<StageTimeEditData>
    with SendPriorityStageResultItem
    implements LockScrollItem {
  factory StageTimeEditItem.initial(int index) => StageTimeEditItem(
      StageTimeEditData(
        duration: -1,
        editedForTimeDuration: 1,
        workoutStage: WorkoutStage.IDLE,
      ),
      index);

  StageTimeEditItem(StageTimeEditData data, int index) : super(data, index);

  @override
  enter(Visitor visitor) {
    visitor.enter(this);
  }

  @override
  String getNavPath() => NavPath.stageTimeEditPath;

  @override
  leave(Visitor visitor) {
    visitor.leave(this);
  }
}

class StageRoundCountEditItem extends FlowItem<StageRoundCountEditData>
    with SendPriorityStageResultItem
    implements LockScrollItem {
  factory StageRoundCountEditItem.initial(int index) => StageRoundCountEditItem(
      StageRoundCountEditData(
          roundCount: 0, stageExerciseDuration: [], workoutStage: WorkoutStage.IDLE),
      index);

  StageRoundCountEditItem(StageRoundCountEditData data, int index)
      : super(data, index);

  @override
  enter(Visitor visitor) {
    visitor.enter(this);
  }

  @override
  String getNavPath() => NavPath.stageRoundCountEditPath;

  @override
  leave(Visitor visitor) {
    visitor.leave(this);
  }
}

class ShareResultsItem extends FlowItem<ShareResultData>
    implements LockScrollItem {
  ShareResultsItem(data, int index) : super(data, index);

  @override
  enter(Visitor visitor) {
    visitor.enter(this);
  }

  @override
  String getNavPath() => NavPath.shareResultsPath;

  @override
  leave(Visitor visitor) {
    visitor.leave(this);
  }
}

class CongratulationItem extends FlowItem<CongratulationModel>
    implements LockScrollItem {
  CongratulationItem(data, int index) : super(data, index);

  @override
  enter(Visitor visitor) {
    visitor.enter(this);
  }

  @override
  String getNavPath() => NavPath.congratulationPath;

  @override
  leave(Visitor visitor) {
    visitor.leave(this);
  }
}

abstract class LockScrollItem {}

abstract class LockScrollBackItem {}

mixin SendPriorityStageResultItem {}

mixin SendWorkoutResultItem {
  int? getDuration();

  int? getAmrapRoundCount();

  List<ExerciseDuration> getStageExerciseDuration();
}

class CountDownItem extends FlowItem implements LockScrollItem {
  CountDownItem(data, int index) : super(data, index);

  @override
  String getNavPath() => NavPath.countdownPath;

  @override
  enter(Visitor visitor) {
    visitor.enter(this);
  }

  @override
  leave(Visitor visitor) {
    visitor.leave(this);
  }
}
