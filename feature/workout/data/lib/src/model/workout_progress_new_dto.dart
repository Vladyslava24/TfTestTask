import '../../data.dart';

class WorkoutProgressNewDto {
  WorkoutDto? workout;
  int? points;
  bool? finished;
  String? startedAt;
  String? workoutPhase;
  String? id;

  WorkoutProgressNewDto({
    this.workout,
    this.points,
    this.finished,
    this.startedAt,
    this.workoutPhase,
    this.id
  });

  WorkoutProgressNewDto copyWith({
    WorkoutDto? workout,
    int? points,
    bool? finished,
    String? startedAt,
    String? workoutPhase,
    String? id,
  }){
    return WorkoutProgressNewDto(
      workout: workout ?? this.workout,
      points: points ?? this.points,
      finished: finished ?? this.finished,
      startedAt: startedAt ?? this.startedAt,
      workoutPhase: workoutPhase ?? this.workoutPhase,
      id: id ?? this.id,
    );
  }

  WorkoutProgressNewDto.fromMap(jsonMap)
      : points = jsonMap["points"],
        finished = jsonMap["finished"] ?? false,
        startedAt = jsonMap["startedAt"],
        workoutPhase = jsonMap["workoutStage"],
        id = jsonMap["id"],
        workout = WorkoutDto.fromJson(jsonMap["workout"]);

}