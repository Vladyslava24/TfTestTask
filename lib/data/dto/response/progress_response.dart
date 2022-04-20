import 'dart:convert';

import 'package:totalfit/data/dto/breathing_dto.dart';
import 'package:totalfit/data/dto/enviromental_dto.dart';
import 'package:totalfit/data/dto/mood_dto.dart';
import 'package:totalfit/data/dto/story_dto.dart';
import 'package:totalfit/data/dto/wisdom_dto.dart';
import 'package:totalfit/model/statement.dart';

import 'package:totalfit/data/hexagon_state.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';

class ProgressResponse {
  String date;
  HexagonState hexagonState;
  StoryDto story;
  WisdomDto wisdom;
  EnvironmentDto environmental;
  List<WorkoutProgressDto> workoutProgress;
  BreathingDto breathPractice;

  /// if workoutProgress.isEmpty - use recommendedWorkout
  WorkoutDto recommendedWorkout;
  List<Statement> iWillStatements;
  List<HabitDto> habits;
  List<MoodDTO> moodTrackingData;
  bool storyDone;
  bool wisdomDone;
  String priority;

  ProgressResponse(
      {this.date,
      this.hexagonState,
      this.story,
      this.wisdom,
      this.environmental,
      this.workoutProgress,
      this.breathPractice,
      this.recommendedWorkout,
      this.iWillStatements,
      this.habits,
      this.moodTrackingData,
      this.storyDone,
      this.wisdomDone,
      this.priority});

  ProgressResponse.fromMap(jsonMap) {
    date = jsonMap["date"];
    hexagonState = HexagonState.fromMap(jsonMap["hexagonState"]);
    environmental = EnvironmentDto.fromMap(jsonMap["environmental"]);
    story = StoryDto.fromMap(jsonMap["story"]);
    wisdom = WisdomDto.fromMap(jsonMap["wisdomOfTheDay"]);
    breathPractice = BreathingDto.fromMap(jsonMap['breathPractice']);
    iWillStatements = (jsonMap["iWillStatements"] as List)
        .map((s) => Statement.fromMap(s))
        .toList();
    storyDone = jsonMap["storyDone"] ?? false;
    wisdomDone = jsonMap["wisdomDone"] ?? false;
    recommendedWorkout = WorkoutDto.fromMap(jsonMap["recommendedWorkout"]);
    workoutProgress = (jsonMap["workoutProgress"] as List)
      .map((e) => WorkoutProgressDto.fromMap(e))
      .toList();
    habits = (jsonMap["healthyLifestyleHabitProgress"] as List)
        .map((e) => HabitDto.fromMap(e))
        .toList();
    priority = jsonMap["priority"];
    moodTrackingData = [];
  }

  bool isLoaded() => date != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressResponse &&
          runtimeType == other.runtimeType &&
          date == other.date;

  @override
  int get hashCode => date.hashCode;
}
