import 'package:workout_data_legacy/data.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/data/hexagon_state.dart';
import 'package:totalfit/data/workout_phase.dart';

class WorkoutSummaryBundle {
  final WorkoutDto workout;
  final WorkoutProgressDto progress;
  final WorkoutPhase workoutPhase;
  final HexagonState hexagonState;

  WorkoutSummaryBundle({
    this.workout,
    this.progress,
    this.workoutPhase,
    this.hexagonState,
  });

  WorkoutSummaryBundle copyWith({
    WorkoutDto workout,
    WorkoutProgressDto progress,
    bool afterCompleteWorkout,
    WorkoutPhase workoutPhase,
    HexagonState hexagonState,
  }) {
    return WorkoutSummaryBundle(
      workout: workout ?? this.workout,
      progress: progress ?? this.progress,
      workoutPhase: workoutPhase ?? this.workoutPhase,
      hexagonState: hexagonState ?? this.hexagonState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutSummaryBundle &&
          runtimeType == other.runtimeType &&
          workout == other.workout &&
          workoutPhase == other.workoutPhase &&
          hexagonState == other.hexagonState &&
          progress == other.progress;

  @override
  int get hashCode => workout.hashCode ^ progress.hashCode ^ workoutPhase.hashCode ^ hexagonState.hashCode;
}
