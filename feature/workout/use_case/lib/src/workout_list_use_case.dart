import 'model/workout_model.dart';

abstract class WorkoutListUseCase {
  Future<List<WorkoutModel>> getWorkouts();
  Future<WorkoutModel> getWorkoutById(int id);
}
