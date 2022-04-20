import 'package:totalfit/data/dto/response/profile_completed_workout_item_response.dart';

class ProfileCompletedWorkoutsResponse {
  final List<ProfileCompletedWorkoutItemResponse> objects;
  final int pagesCount;
  final String totalElements;

  ProfileCompletedWorkoutsResponse({
    this.objects,
    this.pagesCount,
    this.totalElements,
  });

  ProfileCompletedWorkoutsResponse.fromJson(json)
      : objects = (json["objects"] as List).map((e) => ProfileCompletedWorkoutItemResponse.fromJson(e)).toList(),
        pagesCount = json["pagesCount"],
        totalElements = json["totalElements"];
}
