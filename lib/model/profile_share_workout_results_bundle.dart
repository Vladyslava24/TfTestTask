import 'package:workout_data_legacy/data.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';

class ProfileShareWorkoutResultsScreenBundle {
  final WorkoutDto workout;
  final WorkoutProgressDto progress;

  ProfileShareWorkoutResultsScreenBundle({
    this.workout,
    this.progress,
  });

  ProfileShareWorkoutResultsScreenBundle copyWith({WorkoutDto workout, WorkoutProgressDto progress}) {
    return ProfileShareWorkoutResultsScreenBundle(
      workout: workout ?? this.workout,
      progress: progress ?? this.progress,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileShareWorkoutResultsScreenBundle &&
          runtimeType == other.runtimeType &&
          workout == other.workout &&
          progress == other.progress;

  @override
  int get hashCode => workout.hashCode ^ progress.hashCode;
}
