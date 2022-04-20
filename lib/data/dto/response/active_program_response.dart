import 'package:totalfit/data/dto/response/program_schedule_response.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';

import '../program_progress_dto.dart';
import '../program_this_week_workout_list_dto.dart';
import 'feed_program_list_item_response.dart';

class ActiveProgramResponse {
  final bool allWorkoutsDone;
  final int daysAWeek;
  final int numberOfWeeks;
  final String difficultyLevel;
  final String id;
  final String name;
  final List<ProgramScheduleResponse> schedule;
  final List<ProgramThisWeekWorkoutListDto> thisWeekWorkouts;
  final WorkoutProgressDto workoutProgress;
  final ProgramProgressDto programProgress;
  final List<int> daysOfTheWeek;
  final int maxWeekNumber;
  final List<LevelType> levels;

  ActiveProgramResponse({
    this.allWorkoutsDone,
    this.daysAWeek,
    this.numberOfWeeks,
    this.difficultyLevel,
    this.id,
    this.name,
    this.schedule,
    this.thisWeekWorkouts,
    this.workoutProgress,
    this.programProgress,
    this.daysOfTheWeek,
    this.maxWeekNumber,
    this.levels,
  });

  ActiveProgramResponse.fromJson(json)
      : schedule = (json["schedule"] as List)
            .map((e) => ProgramScheduleResponse.fromJson(e))
            .toList(),
        thisWeekWorkouts = (json["thisWeekWorkouts"] as List)
            .map((e) => ProgramThisWeekWorkoutListDto.fromJson(e))
            .toList(),
        workoutProgress = json["workoutProgress"] != null
            ? WorkoutProgressDto.fromMap(json["workoutProgress"])
            : null,
        programProgress = ProgramProgressDto.fromJson(json["workoutsProgress"]),
        allWorkoutsDone = json["allWorkoutsDone"],
        difficultyLevel = json["difficultyLevel"],
        id = json["id"],
        numberOfWeeks = json["numberOfWeeks"],
        name = json["name"],
        levels = (json["levels"] as List)
            ?.map((e) => LevelType.fromJson(e))
            ?.toList(),
        maxWeekNumber = json["maxWeekNumber"],
        daysOfTheWeek =
            (json["daysOfTheWeek"] as List).map((e) => e as int).toList(),
        daysAWeek = json["daysAWeek"];
}
