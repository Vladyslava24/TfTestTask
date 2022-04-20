import 'package:workout_data/src/model/workout_phase.dart';

import '../../data.dart';

class WorkoutProgress {
  WorkoutDto? workout;
  List<ExerciseDurationDto>? warmupExerciseDurations;
  List<ExerciseDurationDto>? skillExerciseDurations;
  List<ExerciseDurationDto>? wodExerciseDurations;
  List<ExerciseDurationDto>? cooldownExerciseDurations;
  int? points;
  int? workoutDuration;
  int? warmupStageDuration;
  int? skillStageDuration;
  int? wodStageDuration;
  int? cooldownStageDuration;
  bool? finished;
  String? startedAt;
  WorkoutPhase? workoutPhase;
  int? skillTechniqueRate;
  int? roundCount;
  String? id;


  WorkoutProgress({
    this.workout,
    this.warmupExerciseDurations,
    this.skillExerciseDurations,
    this.wodExerciseDurations,
    this.cooldownExerciseDurations,
    this.points,
    this.workoutDuration,
    this.warmupStageDuration,
    this.skillStageDuration,
    this.wodStageDuration,
    this.cooldownStageDuration,
    this.finished,
    this.startedAt,
    this.workoutPhase,
    this.skillTechniqueRate,
    this.roundCount,
    this.id
  });

  WorkoutProgress.fromMap(jsonMap)
      : warmupExerciseDurations =
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
        workoutPhase = WorkoutPhase.fromString(jsonMap["workoutPhase"]),
        roundCount = jsonMap["roundCount"],
        skillTechniqueRate = jsonMap["skillTechniqueRate"],
        id = jsonMap["id"],
        workout = WorkoutDto.fromJson(jsonMap["workout"]);

  Map<String, dynamic> toJson() => {
    "id": id,
    "points": points,
    "startedAt": startedAt,
    "roundCount": roundCount,
    "workoutDuration": workoutDuration,
    "skillTechniqueRate": skillTechniqueRate,
    "warmupStageDuration": warmupStageDuration,
    "skillStageDuration": skillStageDuration,
    "wodStageDuration": wodStageDuration,
    "cooldownStageDuration": cooldownStageDuration,
    "warmupExerciseDurations": List<dynamic>.from(warmupExerciseDurations!.map((x) => x)),
    "skillExerciseDurations": List<dynamic>.from(skillExerciseDurations!.map((x) => x)),
    "wodExerciseDurations": List<dynamic>.from(wodExerciseDurations!.map((x) => x)),
    "cooldownExerciseDurations": List<dynamic>.from(cooldownExerciseDurations!.map((x) => x)),
    "workout": workout!.toJson(),
    "finished": finished,
  };

  WorkoutProgress copyWith({
    WorkoutDto? workout,
    List<ExerciseDurationDto>? warmupExerciseDurations,
    List<ExerciseDurationDto>? skillExerciseDurations,
    List<ExerciseDurationDto>? wodExerciseDurations,
    List<ExerciseDurationDto>? cooldownExerciseDurations,
    int? points,
    int? workoutDuration,
    int? warmupStageDuration,
    int? skillStageDuration,
    int? wodStageDuration,
    int? cooldownStageDuration,
    bool? finished,
    String? startedAt,
    WorkoutPhase? workoutPhase,
    int? skillTechniqueRate,
    int? roundCount,
    String? id,
  }) {
    return WorkoutProgress(
      workout: workout ?? this.workout,
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
    );
  }

  int getExerciseCount() {
    final warmUpExerciseCount = warmupExerciseDurations!.length;
    final wodExerciseCount = wodExerciseDurations!.length;
    final coolDownExerciseCount = cooldownExerciseDurations!.length;
    final skillExerciseCount = skillExerciseDurations!.length;
    return warmUpExerciseCount + wodExerciseCount + coolDownExerciseCount + skillExerciseCount;
  }
}