enum WorkoutStage { IDLE, WARMUP, WOD, COOLDOWN, SKILL }

enum WorkoutStageType { IDLE, FOR_TIME, AMRAP }

bool isWorkoutStageIdle(WorkoutStage workoutStage) {
  if (workoutStage == WorkoutStage.IDLE) {
    return true;
  } else {
    return false;
  }
}

String fromWorkoutStageEnumToString(WorkoutStage workoutStage) {
  switch (workoutStage) {
    case WorkoutStage.SKILL:
      return "SKILL";
    case WorkoutStage.WARMUP:
      return "WARMUP";
    case WorkoutStage.WOD:
      return "WOD";
    case WorkoutStage.COOLDOWN:
      return "COOLDOWN";
    case WorkoutStage.IDLE:
      return "IDLE";
  }
}

WorkoutStage fromStringToWorkoutStageEnum(String workoutStageString) {
  switch (workoutStageString) {
    case "SKILL":
      return WorkoutStage.SKILL;
    case "WARMUP":
      return WorkoutStage.WARMUP;
    case "WOD":
      return WorkoutStage.WOD;
    case "COOLDOWN":
      return WorkoutStage.COOLDOWN;
    default:
      return WorkoutStage.IDLE;
  }
}

String fromWorkoutStageTypeEnumToString(
  WorkoutStageType workoutStageType,
  {bool forUI = false}
) {
  switch (workoutStageType) {
    case WorkoutStageType.FOR_TIME:
      return forUI ? "For time" : "FOR_TIME";
    case WorkoutStageType.AMRAP:
      return "AMRAP";
    case WorkoutStageType.IDLE:
      return "IDLE";
  }
}

WorkoutStageType fromStringToWorkoutStageTypeEnum(
    String workoutStageTypeString) {
  switch (workoutStageTypeString) {
    case "FOR_TIME":
      return WorkoutStageType.FOR_TIME;
    case "AMRAP":
      return WorkoutStageType.AMRAP;
    default:
      return WorkoutStageType.IDLE;
  }
}
