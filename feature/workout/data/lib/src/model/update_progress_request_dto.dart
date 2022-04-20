class UpdateProgressRequestDto {
  final String? workoutId;
  final String workoutStage;
  final List<StageProgressDto> workoutStageProgresses;

  UpdateProgressRequestDto({
    this.workoutId,
    required this.workoutStage,
    required this.workoutStageProgresses,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (workoutId != null) {
      map.putIfAbsent("workoutId", () => workoutId);
    }

    map.putIfAbsent("workoutStage", () => workoutStage);

    map.putIfAbsent("workoutStageProgresses", () => List<dynamic>.from(workoutStageProgresses.map((e) => e.toJson())));

    return map;
  }
}

class ExerciseDurationDto {
  final int exerciseDuration;
  final String exerciseName;
  final String workoutStage;

  ExerciseDurationDto(
      {required this.exerciseDuration,
      required this.exerciseName,
      required this.workoutStage});

  ExerciseDurationDto.fromMap(jsonMap)
      : exerciseDuration = jsonMap['exerciseDuration'],
        exerciseName = jsonMap['exerciseName'],
        workoutStage = jsonMap['workoutStage'];

  Map<String, dynamic> toJson() => {
        'exerciseDuration': exerciseDuration,
        'exerciseName': exerciseName,
        'workoutStage': workoutStage
      };

  int get hashCode =>
      exerciseDuration.hashCode ^ exerciseName.hashCode ^ workoutStage.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ExerciseDurationDto &&
      runtimeType == other.runtimeType &&
      exerciseDuration == other.exerciseDuration &&
      exerciseName == other.exerciseName &&
      workoutStage == other.workoutStage;
}

class StageProgressDto {
  final List<ExerciseDurationDto> stageExerciseDurations;
  final String type;
  final int? roundCount;
  final int? stageDuration;

  StageProgressDto({
    required this.stageExerciseDurations,
    required this.type,
    required this.roundCount,
    required this.stageDuration,
  });

  factory StageProgressDto.fromJson(Map<String, dynamic> json) =>
      StageProgressDto(
        roundCount: json["roundCount"],
        stageDuration: json["stageDuration"],
        stageExerciseDurations: List<ExerciseDurationDto>.from(
            json["stageExerciseDurations"]
                .map((x) => ExerciseDurationDto.fromMap(x))),
        type: json["type"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map.putIfAbsent(
        "stageExerciseDurations",
        () =>
            List<dynamic>.from(stageExerciseDurations.map((x) => x.toJson())));

    map.putIfAbsent("type", () => type);

    if (roundCount != null) {
      map.putIfAbsent("roundCount", () => roundCount);
    }

    if (stageDuration != null) {
      map.putIfAbsent("stageDuration", () => stageDuration);
    }

    return map;
  }
}
