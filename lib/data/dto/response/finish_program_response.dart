
import 'learned_skill_item_response.dart';

class FinishProgramResponse {
  final List<LearnedSkillItemResponse> learnedSkills;
  final int exercisesDone;
  final String image;
  final String name;
  final int points;
  final int workoutsDone;
  final int workoutsDuration;

  FinishProgramResponse({
    this.learnedSkills,
    this.exercisesDone,
    this.image,
    this.name,
    this.points,
    this.workoutsDone,
    this.workoutsDuration,
  });

  FinishProgramResponse.fromJson(json)
      : learnedSkills = (json["learnedSkills"] as List).map((e) => LearnedSkillItemResponse.fromJson(e)).toList(),
        exercisesDone = json["exercisesDone"],
        name = json["name"],
        points = json["points"],
        workoutsDone = json["workoutsDone"],
        workoutsDuration = json["workoutsDuration"],
        image = json["image"];
}