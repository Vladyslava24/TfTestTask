import 'package:workout_use_case/use_case.dart';

abstract class WorkoutSettingsUseCase {
  Future<AudioConfigModel?> getAudioConfig();
  Future<WorkoutConfigModel?> getWorkoutConfig(String uid);
  Future<void> setAudioConfig(AudioConfigModel audioConfigModel);
  Future<void> setWorkoutConfig(WorkoutConfigModel workoutConfigModel);
}