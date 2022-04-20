class ProfileCompletedWorkoutItemResponse {
  final String workoutProgressId;
  final String date;
  final String name;
  final String month;
  final int workoutDuration;
  final int roundCount;
  final String wodType;

  ProfileCompletedWorkoutItemResponse({
    this.workoutProgressId,
    this.date,
    this.name,
    this.workoutDuration,
    this.roundCount,
    this.month,
    this.wodType,
  });

  ProfileCompletedWorkoutItemResponse.fromJson(json)
      : workoutProgressId = json["id"],
        date = json["date"],
        month = json["month"],
        name = json["theme"],
        roundCount = json["roundCount"],
        wodType = json["wodType"],
        workoutDuration = json["workoutDuration"];
}
