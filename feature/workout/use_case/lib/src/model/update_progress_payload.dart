import '../../use_case.dart';

class UpdateProgressPayload {
  final String? workoutId;
  final List<StageProgress> workoutStageProgresses;
  final int? warmupStageDuration;
  final int? skillStageDuration;
  final int? wodStageDuration;
  final int? cooldownStageDuration;
  final String workoutStage;
  final String? workoutProgressId;

  // nullable for AMRAP and EMOM

  UpdateProgressPayload({
    this.workoutId,
    required this.workoutStageProgresses,
    this.warmupStageDuration,
    this.skillStageDuration,
    this.wodStageDuration,
    this.cooldownStageDuration,
    this.workoutProgressId,
    required this.workoutStage,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.putIfAbsent("workoutStage", () => workoutStage);
    map.putIfAbsent(
        "workoutStageProgresses",
        () =>
            List<dynamic>.from(workoutStageProgresses.map((x) => x.toJson())));

    if (workoutId != null) {
      map.putIfAbsent("workoutId", () => workoutId);
    }

    if (warmupStageDuration != null) {
      map.putIfAbsent("warmupStageDuration", () => warmupStageDuration);
    }

    if (skillStageDuration != null) {
      map.putIfAbsent("skillStageDuration", () => skillStageDuration);
    }

    if (wodStageDuration != null) {
      map.putIfAbsent("wodStageDuration", () => wodStageDuration);
    }

    if (cooldownStageDuration != null) {
      map.putIfAbsent("cooldownStageDuration", () => cooldownStageDuration);
    }
    if (workoutProgressId != null) {
      map.putIfAbsent("workoutProgressId", () => workoutProgressId);
    }
    return map;
  }
}

class StageProgress {
  final List<ExerciseDuration> stageExerciseDurations;
  final WorkoutStage type;
  final String? roundCount;
  final String? stageDuration;

  StageProgress({
    required this.stageExerciseDurations,
    required this.type,
    required this.roundCount,
    required this.stageDuration,
  });

  factory StageProgress.fromJson(Map<String, dynamic> json) => StageProgress(
        roundCount: json["roundCount"].toString(),
        stageDuration: json["stageDuration"].toString(),
        stageExerciseDurations: List<ExerciseDuration>.from(
            json["stageExerciseDurations"]
                .map((x) => ExerciseDuration.fromMap(x))),
        type: fromStringToWorkoutStageEnum(json["type"]),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map.putIfAbsent(
        "stageExerciseDurations",
        () =>
            List<dynamic>.from(stageExerciseDurations.map((x) => x.toJson())));

    map.putIfAbsent("type", () => fromWorkoutStageEnumToString(type));

    if (roundCount != null) {
      map.putIfAbsent("roundCount", () => roundCount);
    }

    if (stageDuration != null) {
      map.putIfAbsent("wodStageDuration", () => stageDuration);
    }

    return map;
  }
}

class ExerciseDuration {
  final int exerciseDuration;
  final String exerciseName;
  final WorkoutStage workoutStage;

  ExerciseDuration(
      {required this.exerciseDuration,
      required this.exerciseName,
      required this.workoutStage});

  ExerciseDuration.fromMap(jsonMap)
      : exerciseDuration = jsonMap['exerciseDuration'],
        exerciseName = jsonMap['exerciseName'],
        workoutStage = fromStringToWorkoutStageEnum(jsonMap['workoutStage']);

  Map<String, dynamic> toJson() => {
        'exerciseDuration': exerciseDuration,
        'exerciseName': exerciseName,
        'workoutStage': fromWorkoutStageEnumToString(workoutStage)
      };
}
