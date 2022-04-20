import 'package:workout_data_legacy/data.dart';
import 'package:totalfit/data/dto/program_progress_dto.dart';
import 'package:totalfit/data/dto/program_this_week_workout_list_dto.dart';
import 'package:totalfit/data/dto/response/program_schedule_response.dart';
import 'package:totalfit/data/dto/response/feed_program_list_item_response.dart';
import 'package:totalfit/ui/utils/utils.dart';

class ActiveProgram {
  final bool allWorkoutsDone;
  final int daysAWeek;
  final String difficultyLevel;
  final int numberOfWeeks;
  final String id;
  final String name;
  final List<ProgramScheduleResponse> schedule;
  final List<ProgramThisWeekWorkoutListDto> thisWeekWorkouts;
  final WorkoutDto workoutOfTheDay;
  final ProgramProgressDto programProgress;
  final List<int> daysOfTheWeek;
  final int maxWeekNumber;
  final List<LevelType> levels;

  ActiveProgram({
    this.allWorkoutsDone,
    this.daysAWeek,
    this.difficultyLevel,
    this.id,
    this.numberOfWeeks,
    this.name,
    this.schedule,
    this.thisWeekWorkouts,
    this.workoutOfTheDay,
    this.programProgress,
    this.daysOfTheWeek,
    this.maxWeekNumber,
    this.levels,
  });

  ActiveProgram copyWith({
    bool allWorkoutsDone,
    int daysAWeek,
    int numberOfWeeks,
    String difficultyLevel,
    String id,
    String name,
    List<ProgramScheduleResponse> schedule,
    List<ProgramThisWeekWorkoutListDto> thisWeekWorkouts,
    WorkoutDto workoutOfTheDay,
    ProgramProgressDto programProgress,
    List<int> daysOfTheWeek,
    int maxWeekNumber,
    List<LevelType> levels,
  }) {
    return ActiveProgram(
      allWorkoutsDone: allWorkoutsDone ?? this.allWorkoutsDone,
      daysAWeek: daysAWeek ?? this.daysAWeek,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      id: id ?? this.id,
      numberOfWeeks: numberOfWeeks ?? this.numberOfWeeks,
      name: name ?? this.name,
      schedule: schedule ?? this.schedule,
      thisWeekWorkouts: thisWeekWorkouts ?? this.thisWeekWorkouts,
      workoutOfTheDay: workoutOfTheDay ?? this.workoutOfTheDay,
      programProgress: programProgress ?? this.programProgress,
      daysOfTheWeek: daysOfTheWeek ?? this.daysOfTheWeek,
      maxWeekNumber: maxWeekNumber ?? this.maxWeekNumber,
      levels: levels ?? this.levels,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveProgram &&
          runtimeType == other.runtimeType &&
          allWorkoutsDone == other.allWorkoutsDone &&
          daysAWeek == other.daysAWeek &&
          difficultyLevel == other.difficultyLevel &&
          id == other.id &&
          numberOfWeeks == other.numberOfWeeks &&
          maxWeekNumber == other.maxWeekNumber &&
          deepEquals(schedule, other.schedule) &&
          deepEquals(thisWeekWorkouts, other.thisWeekWorkouts) &&
          deepEquals(daysOfTheWeek, other.daysOfTheWeek) &&
          workoutOfTheDay == other.workoutOfTheDay &&
          programProgress == other.programProgress &&
          levels == other.levels;

  @override
  int get hashCode =>
      allWorkoutsDone.hashCode ^
      daysAWeek.hashCode ^
      difficultyLevel.hashCode ^
      id.hashCode ^
      numberOfWeeks.hashCode ^
      maxWeekNumber.hashCode ^
      deepHash(schedule) ^
      deepHash(thisWeekWorkouts) ^
      deepHash(daysOfTheWeek) ^
      workoutOfTheDay.hashCode ^
      levels.hashCode ^
      programProgress.hashCode;
}
