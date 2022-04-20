import 'package:totalfit/data/dto/workout_progress_dto.dart';

class ProgramThisWeekWorkoutListDto {
  final String id;
  final String date;
  WorkoutProgressDto workoutProgress;

  ProgramThisWeekWorkoutListDto({
    this.id,
    this.date,
    this.workoutProgress,
  });

  ProgramThisWeekWorkoutListDto.fromJson(json)
      : workoutProgress = WorkoutProgressDto.fromMap(json["workoutProgress"]),
        id = json["id"],
        date = json["date"];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgramThisWeekWorkoutListDto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          workoutProgress == other.workoutProgress;

  @override
  int get hashCode => id.hashCode ^ date.hashCode ^ workoutProgress.hashCode;
}
