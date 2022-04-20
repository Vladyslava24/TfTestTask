abstract class WorkoutOnBoardingUseCase {
  Future<bool> getOnBoardingStatus();
  Future<void> setOnBoardingStatus(bool value);
}