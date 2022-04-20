class ProgramProgressDto {
  final int workoutsQuantity;
  final int workoutsDone;

  ProgramProgressDto({
    this.workoutsQuantity,
    this.workoutsDone,
  });

  ProgramProgressDto.fromJson(json)
      : workoutsQuantity = json["workoutsQuantity"],
        workoutsDone = json["workoutsDone"];

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgramProgressDto &&
          runtimeType == other.runtimeType &&
          workoutsQuantity == other.workoutsQuantity &&
          workoutsDone == other.workoutsDone;

  @override
  int get hashCode => workoutsQuantity.hashCode ^ workoutsDone.hashCode;
}
