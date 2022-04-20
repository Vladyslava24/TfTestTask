import 'dart:convert';
import 'package:workout_data/src/model/breah_practice_response.dart';
import 'package:workout_data/src/model/hexagon_state_dto.dart';
import 'package:workout_data/src/model/story_dto.dart';
import 'package:workout_data/src/model/wisdom_of_the_day_dto.dart';
import 'package:workout_data/src/model/wisdom_quiz_of_the_day_dto.dart';
import 'package:workout_data/src/model/workout_progress_response.dart';
import '../../data.dart';
import 'enviroment_dto.dart';
import 'dart:convert';

UpdateProgressNewResponse updateProgressNewResponseFromJson(String str) =>
    UpdateProgressNewResponse.fromJson(json.decode(str));

String updateProgressNewResponseToJson(UpdateProgressNewResponse data) =>
    json.encode(data.toJson());

class UpdateProgressNewResponse {
  UpdateProgressNewResponse({
    this.date,
    this.hexagonState,
    this.storyDone,
    this.iWillStatements,
    this.wisdomDone,
    this.recommendedWorkout,
    this.healthyLifestyleHabitProgress,
    this.story,
    this.wisdomOfTheDay,
    this.wisdomQuizOfTheDay,
    this.environmental,
    this.workoutProgress,
    this.breathPractice,
    this.priority,
  });

  DateTime? date;
  HexagonStateDto? hexagonState;
  bool? storyDone;
  List<dynamic>? iWillStatements;
  bool? wisdomDone;
  WorkoutDto? recommendedWorkout;
  List<dynamic>? healthyLifestyleHabitProgress;
  StoryDto? story;
  WisdomOfTheDayDto? wisdomOfTheDay;
  WisdomQuizOfTheDayDto? wisdomQuizOfTheDay;
  Environmental? environmental;
  List<WorkoutProgress>? workoutProgress;
  BreathPracticeResponse? breathPractice;
  String? priority;

  factory UpdateProgressNewResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProgressNewResponse(
        date: DateTime.parse(json["date"]),
        hexagonState: HexagonStateDto.fromMap(json["hexagonState"]),
        storyDone: json["storyDone"],
        iWillStatements:
            List<dynamic>.from(json["iWillStatements"].map((x) => x)),
        wisdomDone: json["wisdomDone"],
        recommendedWorkout: WorkoutDto.fromJson(json["recommendedWorkout"]),
        healthyLifestyleHabitProgress: List<dynamic>.from(
            json["healthyLifestyleHabitProgress"].map((x) => x)),
        story: StoryDto.fromMap(json["story"]),
        wisdomOfTheDay: WisdomOfTheDayDto.fromJson(json["wisdomOfTheDay"]),
        wisdomQuizOfTheDay: json["wisdomQuizOfTheDay"] == null
            ? null
            : WisdomQuizOfTheDayDto.fromJson(json["wisdomQuizOfTheDay"]),
        environmental: Environmental.fromJson(json["environmental"]),
        workoutProgress: List<WorkoutProgress>.from(
            json["workoutProgress"].map((x) => WorkoutProgress.fromMap(x))),
        breathPractice: BreathPracticeResponse.fromJson(json["breathPractice"]),
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "hexagonState": hexagonState == null ? null : hexagonState!.toJson(),
        "storyDone": storyDone,
        "iWillStatements": iWillStatements == null
            ? null
            : List<dynamic>.from(iWillStatements!.map((x) => x)),
        "wisdomDone": wisdomDone,
        "recommendedWorkout":
            recommendedWorkout == null ? null : jsonDecode(jsonEncode(recommendedWorkout!)),
        "healthyLifestyleHabitProgress": healthyLifestyleHabitProgress == null
            ? null
            : List<dynamic>.from(healthyLifestyleHabitProgress!.map((x) => x)),
        "story": story == null ? null : story!.toJson(),
        "wisdomOfTheDay": wisdomOfTheDay == null ? null : wisdomOfTheDay!.toJson(),
        "wisdomQuizOfTheDay": wisdomQuizOfTheDay == null ? null : wisdomQuizOfTheDay!.toJson(),
        "environmental": environmental == null ? null : environmental!.toJson(),
        "workoutProgress": workoutProgress == null
            ? null
            : workoutProgress!.map((x) => x.toJson()),
        "breathPractice":
            breathPractice == null ? null : breathPractice!.toJson(),
        "priority": priority,
      };
}
