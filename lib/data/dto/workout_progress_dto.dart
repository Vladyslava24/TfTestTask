import 'package:totalfit/data/dto/exercise_duration_dto.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:totalfit/ui/utils/utils.dart';
import 'package:workout_use_case/use_case.dart';
import '../answered_question_dto.dart';

class WorkoutProgressDto {
  WorkoutDto workout;
  List<AnsweredQuestionDto> answeredQuestions;
  List<ExerciseDurationDto> warmupExerciseDurations;
  List<ExerciseDurationDto> skillExerciseDurations;
  List<ExerciseDurationDto> wodExerciseDurations;
  List<ExerciseDurationDto> cooldownExerciseDurations;
  int points;
  int workoutDuration;
  int warmupStageDuration;
  int skillStageDuration;
  int wodStageDuration;
  int cooldownStageDuration;
  bool finished;
  String startedAt;
  WorkoutPhase workoutPhase;
  int skillTechniqueRate;
  int roundCount;
  String id;
  List<StageProgress> stageProgress;

  WorkoutProgressDto({
    WorkoutDto workout,
    List<AnsweredQuestionDto> answeredQuestions,
    List<ExerciseDurationDto> warmupExerciseDurations,
    List<ExerciseDurationDto> skillExerciseDurations,
    List<ExerciseDurationDto> wodExerciseDurations,
    List<ExerciseDurationDto> cooldownExerciseDurations,
    int points,
    int workoutDuration,
    int warmupStageDuration,
    int skillStageDuration,
    int wodStageDuration,
    int cooldownStageDuration,
    bool finished,
    String startedAt,
    WorkoutPhase workoutPhase,
    int skillTechniqueRate,
    int roundCount,
    String id,
    List<StageProgress> stageProgress,
  });

  WorkoutProgressDto.fromMap(Map<String, dynamic> jsonMap)
      : answeredQuestions = ((jsonMap["answeredQuestions"] ?? <Object>[]) as List).map((e) => AnsweredQuestionDto.fromMap(e)).toList(),
        warmupExerciseDurations =
            (jsonMap["warmupExerciseDurations"] as List).map((e) => ExerciseDurationDto.fromMap(e)).toList(),
        skillExerciseDurations =
            (jsonMap["skillExerciseDurations"] as List).map((e) => ExerciseDurationDto.fromMap(e)).toList(),
        wodExerciseDurations =
            (jsonMap["wodExerciseDurations"] as List).map((e) => ExerciseDurationDto.fromMap(e)).toList(),
        cooldownExerciseDurations =
            (jsonMap["cooldownExerciseDurations"] as List).map((e) => ExerciseDurationDto.fromMap(e)).toList(),
        points = jsonMap["points"],
        workoutDuration = jsonMap["workoutDuration"],
        warmupStageDuration = jsonMap["warmupStageDuration"],
        skillStageDuration = jsonMap["skillStageDuration"],
        wodStageDuration = jsonMap["wodStageDuration"],
        cooldownStageDuration = jsonMap["cooldownStageDuration"],
        finished = jsonMap["finished"] ?? false,
        startedAt = jsonMap["startedAt"],
        workoutPhase = WorkoutPhase.fromString(jsonMap["workoutStage"]),
        roundCount = jsonMap["roundCount"],
        skillTechniqueRate = jsonMap["skillTechniqueRate"],
        id = jsonMap["id"],
        workout = WorkoutDto.fromMap(jsonMap["workout"]),
        stageProgress = List<StageProgress>.from(jsonMap["workoutStageProgresses"].map((x) => StageProgress.fromJson(x)));

  WorkoutProgressDto copyWith({
    WorkoutDto workout,
    List<AnsweredQuestionDto> answeredQuestions,
    List<ExerciseDurationDto> warmupExerciseDurations,
    List<ExerciseDurationDto> skillExerciseDurations,
    List<ExerciseDurationDto> wodExerciseDurations,
    List<ExerciseDurationDto> cooldownExerciseDurations,
    int points,
    int workoutDuration,
    int warmupStageDuration,
    int skillStageDuration,
    int wodStageDuration,
    int cooldownStageDuration,
    bool finished,
    String startedAt,
    WorkoutPhase workoutPhase,
    int skillTechniqueRate,
    int roundCount,
    String id,
    StageProgress stageProgress,
  }) {
    return WorkoutProgressDto(
      workout: workout ?? this.workout,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      warmupExerciseDurations: warmupExerciseDurations ?? this.warmupExerciseDurations,
      skillExerciseDurations: skillExerciseDurations ?? this.skillExerciseDurations,
      wodExerciseDurations: wodExerciseDurations ?? this.wodExerciseDurations,
      cooldownExerciseDurations: cooldownExerciseDurations ?? this.cooldownExerciseDurations,
      points: points ?? this.points,
      workoutDuration: workoutDuration ?? this.workoutDuration,
      warmupStageDuration: warmupStageDuration ?? this.warmupStageDuration,
      skillStageDuration: skillStageDuration ?? this.skillStageDuration,
      wodStageDuration: wodStageDuration ?? this.wodStageDuration,
      cooldownStageDuration: cooldownStageDuration ?? this.cooldownStageDuration,
      finished: finished ?? this.finished,
      startedAt: startedAt ?? this.startedAt,
      workoutPhase: workoutPhase ?? this.workoutPhase,
      skillTechniqueRate: skillTechniqueRate ?? this.skillTechniqueRate,
      roundCount: roundCount ?? this.roundCount,
      id: id ?? this.id,
      stageProgress: stageProgress ?? this.stageProgress
    );
  }

  int get hashCode =>
      workout.hashCode ^
      points.hashCode ^
      workoutDuration.hashCode ^
      finished.hashCode ^
      startedAt.hashCode ^
      skillTechniqueRate.hashCode ^
      warmupStageDuration.hashCode ^
      skillStageDuration.hashCode ^
      wodStageDuration.hashCode ^
      cooldownStageDuration.hashCode ^
      roundCount.hashCode ^
      deepHash(warmupExerciseDurations) ^
      deepHash(skillExerciseDurations) ^
      deepHash(wodExerciseDurations) ^
      deepHash(cooldownExerciseDurations) ^
      workoutPhase.hashCode;

  @override
  bool operator ==(Object other) =>
      other is WorkoutProgressDto &&
      workout == other.workout &&
      points == other.points &&
      workoutDuration == other.workoutDuration &&
      finished == other.finished &&
      startedAt == other.startedAt &&
      skillTechniqueRate == other.skillTechniqueRate &&
      warmupStageDuration == other.warmupStageDuration &&
      skillStageDuration == other.skillStageDuration &&
      wodStageDuration == other.wodStageDuration &&
      cooldownStageDuration == other.cooldownStageDuration &&
      roundCount == other.roundCount &&
      deepEquals(warmupExerciseDurations, other.warmupExerciseDurations) &&
      deepEquals(skillExerciseDurations, other.skillExerciseDurations) &&
      deepEquals(wodExerciseDurations, other.wodExerciseDurations) &&
      deepEquals(cooldownExerciseDurations, other.cooldownExerciseDurations) &&
      workoutPhase == other.workoutPhase;

  int getExerciseCount() {
    final warmUpExerciseCount = warmupExerciseDurations.length;
    final wodExerciseCount = wodExerciseDurations.length;
    final coolDownExerciseCount = cooldownExerciseDurations.length;
    final skillExerciseCount = skillExerciseDurations.length;
    return warmUpExerciseCount + wodExerciseCount + coolDownExerciseCount + skillExerciseCount;
  }
}
