import 'package:totalfit/data/dto/program_this_week_workout_list_dto.dart';
import 'package:totalfit/ui/utils/utils.dart';

class ProgramScheduleResponse {
  final String dateRange;
  final List<ProgramThisWeekWorkoutListDto> workouts;

  ProgramScheduleResponse({
    this.dateRange,
    this.workouts,
  });

  ProgramScheduleResponse.fromJson(json)
      : workouts = (json["workouts"] as List).map((e) => ProgramThisWeekWorkoutListDto.fromJson(e)).toList(),
        dateRange = json["dateRange"];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgramScheduleResponse &&
          runtimeType == other.runtimeType &&
          dateRange == other.dateRange &&
          deepEquals(workouts, other.workouts);

  @override
  int get hashCode => dateRange.hashCode ^ deepHash(workouts);
}
