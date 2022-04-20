import 'package:workout_data_legacy/data.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/model/profile/list_items.dart';

class ProgramProgressWODItem implements FeedItem {
  final WorkoutDto workout;
  final WorkoutProgressDto workoutProgress;

  ProgramProgressWODItem({this.workout, this.workoutProgress});

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgramProgressWODItem &&
          runtimeType == other.runtimeType &&
          workout == other.workout &&
          workoutProgress == other.workoutProgress;

  @override
  int get hashCode => workout.hashCode ^ workoutProgress.hashCode;
}
