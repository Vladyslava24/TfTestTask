import 'package:workout_data_legacy/data.dart';
import 'package:totalfit/data/dto/exercise_duration_dto.dart';
import 'package:totalfit/data/workout_phase.dart';

class UpdateProgressRequest {
  final String workoutId;
  final WorkoutPhase workoutPhase;
  final String zoneId;
  final List<ExerciseDurationDto> exerciseDurations;
  final int warmupStageDuration;
  final int skillStageDuration;
  final int wodStageDuration;
  final int cooldownStageDuration;
  final bool shared;
  final int skillTechniqueRate;
  final int points;
  final int environmentalProgress;
  final String workoutProgressId;

  final String targetId;

  // STORY, WISDOM, HABIT
  final String dailyProgressStage;
  final String iWillStatement;

  /// server expects - 'questions'
  List<Answer> questions;

  // nullable for AMRAP and EMOM
  int roundCount;

  UpdateProgressRequest({
    this.workoutId,
    this.workoutPhase,
    this.zoneId,
    this.exerciseDurations,
    this.warmupStageDuration,
    this.skillStageDuration,
    this.wodStageDuration,
    this.cooldownStageDuration,
    this.shared,
    this.questions,
    this.targetId,
    this.dailyProgressStage,
    this.skillTechniqueRate,
    this.points,
    this.iWillStatement,
    this.roundCount,
    this.environmentalProgress,
    this.workoutProgressId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (workoutId != null) {
      map.putIfAbsent("workoutId", () => workoutId);
    }
    if (environmentalProgress != null) {
      map.putIfAbsent("environmentalProgress", () => environmentalProgress);
    }
    if (workoutPhase != null) {
      map.putIfAbsent("workoutStage", () => workoutPhase.toString());
    }

    if (zoneId != null) {
      map.putIfAbsent("zoneId", () => zoneId);
    }

    if (exerciseDurations != null) {
      map.putIfAbsent("exerciseDurations", () => exerciseDurations);
    }

    if (points != null) {
      map.putIfAbsent("points", () => points);
    }

    if (warmupStageDuration != null) {
      map.putIfAbsent("warmupStageDuration", () => warmupStageDuration);
    }

    if (skillStageDuration != null) {
      map.putIfAbsent("skillStageDuration", () => skillStageDuration);
    }

    if (wodStageDuration != null) {
      map.putIfAbsent("wodStageDuration", () => wodStageDuration);
    }

    if (cooldownStageDuration != null) {
      map.putIfAbsent("cooldownStageDuration", () => cooldownStageDuration);
    }

    if (questions != null) {
      map.putIfAbsent("questions", () => questions);
    }
    if (shared != null) {
      map.putIfAbsent("shared", () => shared.toString());
    }
    if (targetId != null) {
      map.putIfAbsent("targetId", () => targetId);
    }
    if (dailyProgressStage != null) {
      map.putIfAbsent("dailyProgressStage", () => dailyProgressStage);
    }
    if (iWillStatement != null) {
      map.putIfAbsent("iWillStatement", () => iWillStatement);
    }
    if (roundCount != null) {
      map.putIfAbsent("roundCount", () => roundCount);
    }
    if (skillTechniqueRate != null) {
      map.putIfAbsent("skillTechniqueRate", () => skillTechniqueRate);
    }
    if (workoutProgressId != null) {
      map.putIfAbsent("workoutProgressId", () => workoutProgressId);
    }
    return map;
  }
}
