import 'package:workout_data_legacy/data.dart';

abstract class WorkoutApi {
  Future<WorkoutResponse> fetchWorkouts();

  Future<WorkoutDto> fetchWorkout(int id);

  Future<WorkoutResponse> filterWorkouts(Map<String, dynamic> queryParams);

  Future<WorkoutDto> fetchWODOfTheMonth();

  Future<WorkoutDto> getOnboardingFirstWorkout();

  Future<WorkoutCollectionResponse> fetchWODCollectionPriority();
}
