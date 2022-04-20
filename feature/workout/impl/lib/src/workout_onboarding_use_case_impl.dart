import 'package:core/core.dart';
import 'package:workout_use_case/use_case.dart';

class WorkoutOnBoardingUseCaseImpl extends WorkoutOnBoardingUseCase{
  final PrefsStorage prefsStorage;

  static const String onBoardingStatusKey = 'onBoardingStatusKey';

  WorkoutOnBoardingUseCaseImpl(this.prefsStorage);

  @override
  Future<bool> getOnBoardingStatus() async {
    return prefsStorage.prefs.getBool(onBoardingStatusKey) ?? false;
  }

  @override
  Future<void> setOnBoardingStatus(bool value) async {
    prefsStorage.prefs.setBool(onBoardingStatusKey, value);
  }
}