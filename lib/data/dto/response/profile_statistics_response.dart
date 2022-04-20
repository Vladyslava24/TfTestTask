class ProfileStatisticsResponse {
  final int totalPoints;
  final int totalTime;
  final int totalWorkouts;

  ProfileStatisticsResponse({
    this.totalPoints,
    this.totalTime,
    this.totalWorkouts,
  });

  ProfileStatisticsResponse.fromJson(json)
      : totalPoints = json["totalPoints"],
        totalWorkouts = json["totalWorkouts"],
        totalTime = json["totalTime"];
}
