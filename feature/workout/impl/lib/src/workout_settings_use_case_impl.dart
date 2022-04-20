import 'dart:convert';
import 'package:core/core.dart';
import 'package:workout_use_case/use_case.dart';
import 'package:collection/collection.dart';

class WorkoutSettingsUseCaseImpl extends WorkoutSettingsUseCase {
  static const String audioConfig = 'AUDIO_CONFIG';
  static const String workoutConfig = 'WORKOUT_CONFIG';

  final PrefsStorage prefsStorage;

  WorkoutSettingsUseCaseImpl(this.prefsStorage);

  @override
  Future<AudioConfigModel?> getAudioConfig() async {
    final result = prefsStorage.prefs.getString(audioConfig);
    if (result != null) return AudioConfigModel.fromJson(jsonDecode(result));
    return null;
  }

  @override
  Future<void> setAudioConfig(AudioConfigModel audioConfigModel) async {
    await prefsStorage.prefs.setString(
      audioConfig,
      jsonEncode(audioConfigModel.toJson())
    );
  }

  @override
  Future<WorkoutConfigModel?> getWorkoutConfig(String uid) async {
    final result = prefsStorage.prefs.getString(workoutConfig);
    if (result != null) {
      final jsonResult = jsonDecode(result) as List;
      final workoutList = List<WorkoutConfigModel>.of(jsonResult.map((r) =>
        WorkoutConfigModel.fromJson(r)));
      final workoutConfig = workoutList.singleWhereOrNull((w) => w.uid == uid);
      return workoutConfig;
    }
    return null;
  }

  @override
  Future<void> setWorkoutConfig(WorkoutConfigModel workoutConfigModel) async {
    final result = prefsStorage.prefs.getString(workoutConfig);
    if (result == null) {
      prefsStorage.prefs.setString(
        workoutConfig,
        jsonEncode([workoutConfigModel.toJson()])
      );
    } else {
      final jsonResult = jsonDecode(result) as List;
      final workoutList = List<WorkoutConfigModel>.of(jsonResult.map((r) =>
          WorkoutConfigModel.fromJson(r)));
      final workoutSet = workoutList.singleWhereOrNull((w) =>
        w.uid == workoutConfigModel.uid);
      if (workoutSet == null) {
        workoutList.add(workoutConfigModel);
        workoutList.map((w) => w.toJson()).toList();
        prefsStorage.prefs.setString(
          workoutConfig,
          jsonEncode(workoutList)
        );
      } else {
        workoutList.removeWhere((e) => e.uid == workoutConfigModel.uid);
        workoutList.add(workoutConfigModel);
        workoutList.map((e) => e.toJson()).toList();

        prefsStorage.prefs.setString(
          workoutConfig,
          jsonEncode(workoutList)
        );
      }
    }
  }
}