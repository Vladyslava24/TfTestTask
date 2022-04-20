import 'package:workout_data_legacy/data.dart';
import 'package:totalfit/data/dto/enviromental_dto.dart';
import 'package:totalfit/data/dto/exercise_duration_dto.dart';
import 'package:totalfit/data/dto/story_dto.dart';
import 'package:totalfit/data/dto/wisdom_dto.dart';
import 'package:totalfit/data/hexagon_state.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/model/statement.dart';
import 'package:totalfit/ui/utils/utils.dart';

class ProgressResponse {
  String date;
  HexagonState hexagonState;
  StoryDto story;
  WisdomDto wisdom;
  EnvironmentDto environmental;
  List<WorkoutProgress> workoutProgress;

  /// if workoutProgress.isEmpty - use recommendedWorkout
  WorkoutDto recommendedWorkout;

  List<Statement> iWillStatements;
  List<HabitModel> habits;
  bool storyDone;
  bool wisdomDone;
  String priority;

  ProgressResponse();

  ProgressResponse.fromMap(jsonMap) {
    date = jsonMap["date"];
    hexagonState = HexagonState.fromMap(jsonMap["hexagonState"]);
    environmental = EnvironmentDto.fromMap(jsonMap["environmental"]);
    story = StoryDto.fromMap(jsonMap["story"]);
    wisdom = WisdomDto.fromMap(jsonMap["wisdomOfTheDay"]);
    iWillStatements = (jsonMap["iWillStatements"] as List).map((s) => Statement.fromMap(s)).toList();
    storyDone = jsonMap["storyDone"] ?? false;
    wisdomDone = jsonMap["wisdomDone"] ?? false;
    recommendedWorkout = WorkoutDto.fromMap(jsonMap["recommendedWorkout"]);
    workoutProgress = (jsonMap["workoutProgress"] as List).map((e) => WorkoutProgress.fromMap(e)).toList();
    habits = (jsonMap["healthyLifestyleHabitProgress"] as List).map((e) => HabitModel.fromMap(e)).toList();
    priority = jsonMap["priority"];
  }

  bool isLoaded() => date != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProgressResponse && runtimeType == other.runtimeType && date == other.date;

  @override
  int get hashCode => date.hashCode;
}

class HabitModel {
  String id;
  bool chosen;
  bool recommended;
  bool completed;
  Habit habit;

  HabitModel({this.id, this.chosen, this.habit, this.recommended, this.completed});

  // in ProgressResponse always comes as 'recommended'
  HabitModel.fromMap(jsonMap)
      : id = jsonMap["id"],
        chosen = jsonMap["chosen"],
        recommended = jsonMap["recommended"],
        completed = jsonMap["completed"],
        habit = Habit.fromMap(jsonMap["healthyLifestyleHabit"]);

  int get hashCode => id.hashCode ^ chosen.hashCode ^ recommended.hashCode ^ habit.hashCode;

  @override
  bool operator ==(Object other) =>
      other is HabitModel &&
      runtimeType == other.runtimeType &&
      id == other.id &&
      chosen == other.chosen &&
      recommended == other.recommended &&
      habit == other.habit;
}

class Habit {
  String id;
  String name;
  String tag;

  Habit({
    this.id,
    this.name,
    this.tag,
  });

  Habit.fromMap(jsonMap)
      : id = jsonMap["id"],
        name = jsonMap["name"],
        tag = jsonMap["tag"];

  int get hashCode => id.hashCode ^ name.hashCode ^ tag.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Habit && runtimeType == other.runtimeType && id == other.id && name == other.name && tag == other.tag;
}

class HabitCompletionToggleResponse {
  String id;
  String date;
  bool done;

  HabitCompletionToggleResponse.fromMap(jsonMap)
      : id = jsonMap["id"],
        date = jsonMap["date"],
        done = jsonMap["done"];
}

class WorkoutProgress {
  WorkoutDto workout;
  List<AnsweredQuestion> answeredQuestions;
  List<ExerciseDurationDto> warmupExerciseDurations;
  List<ExerciseDurationDto> skillExerciseDurations;
  List<ExerciseDurationDto> wodExerciseDurations;
  List<ExerciseDurationDto> cooldownExerciseDurations;
  int points;
  int workoutDuration;
  int warmupStageDuration;
  int skillStageDuration;
  int wodStageDuration;
  int cooldownStageDuration;
  bool finished;
  String startedAt;
  WorkoutPhase workoutPhase;
  int skillTechniqueRate;
  int roundCount;
  String id;

  WorkoutProgress({
    WorkoutDto workout,
    List<AnsweredQuestion> answeredQuestions,
    List<ExerciseDurationDto> warmupExerciseDurations,
    List<ExerciseDurationDto> skillExerciseDurations,
    List<ExerciseDurationDto> wodExerciseDurations,
    List<ExerciseDurationDto> cooldownExerciseDurations,
    int points,
    int workoutDuration,
    int warmupStageDuration,
    int skillStageDuration,
    int wodStageDuration,
    int cooldownStageDuration,
    bool finished,
    String startedAt,
    WorkoutPhase workoutPhase,
    int skillTechniqueRate,
    int roundCount,
    String id,
  });

  WorkoutProgress.fromMap(jsonMap)
      : answeredQuestions = (jsonMap["answeredQuestions"] as List).map((e) => AnsweredQuestion.fromMap(e)).toList(),
        warmupExerciseDurations =
            (jsonMap["warmupExerciseDurations"] as List).map((e) => ExerciseDurationDto.fromMap(e)).toList(),
        skillExerciseDurations =
            (jsonMap["skillExerciseDurations"] as List).map((e) => ExerciseDurationDto.fromMap(e)).toList(),
        wodExerciseDurations =
            (jsonMap["wodExerciseDurations"] as List).map((e) => ExerciseDurationDto.fromMap(e)).toList(),
        cooldownExerciseDurations =
            (jsonMap["cooldownExerciseDurations"] as List).map((e) => ExerciseDurationDto.fromMap(e)).toList(),
        points = jsonMap["points"],
        workoutDuration = jsonMap["workoutDuration"],
        warmupStageDuration = jsonMap["warmupStageDuration"],
        skillStageDuration = jsonMap["skillStageDuration"],
        wodStageDuration = jsonMap["wodStageDuration"],
        cooldownStageDuration = jsonMap["cooldownStageDuration"],
        finished = jsonMap["finished"] ?? false,
        startedAt = jsonMap["startedAt"],
        workoutPhase = WorkoutPhase.fromString(jsonMap["workoutPhase"]),
        roundCount = jsonMap["roundCount"],
        skillTechniqueRate = jsonMap["skillTechniqueRate"],
        id = jsonMap["id"],
        workout = WorkoutDto.fromMap(jsonMap["workout"]);

  WorkoutProgress copyWith({
    WorkoutDto workout,
    List<AnsweredQuestion> answeredQuestions,
    List<ExerciseDurationDto> warmupExerciseDurations,
    List<ExerciseDurationDto> skillExerciseDurations,
    List<ExerciseDurationDto> wodExerciseDurations,
    List<ExerciseDurationDto> cooldownExerciseDurations,
    int points,
    int workoutDuration,
    int warmupStageDuration,
    int skillStageDuration,
    int wodStageDuration,
    int cooldownStageDuration,
    bool finished,
    String startedAt,
    WorkoutPhase workoutPhase,
    int skillTechniqueRate,
    int roundCount,
    String id,
  }) {
    return WorkoutProgress(
      workout: workout ?? this.workout,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      warmupExerciseDurations: warmupExerciseDurations ?? this.warmupExerciseDurations,
      skillExerciseDurations: skillExerciseDurations ?? this.skillExerciseDurations,
      wodExerciseDurations: wodExerciseDurations ?? this.wodExerciseDurations,
      cooldownExerciseDurations: cooldownExerciseDurations ?? this.cooldownExerciseDurations,
      points: points ?? this.points,
      workoutDuration: workoutDuration ?? this.workoutDuration,
      warmupStageDuration: warmupStageDuration ?? this.warmupStageDuration,
      skillStageDuration: skillStageDuration ?? this.skillStageDuration,
      wodStageDuration: wodStageDuration ?? this.wodStageDuration,
      cooldownStageDuration: cooldownStageDuration ?? this.cooldownStageDuration,
      finished: finished ?? this.finished,
      startedAt: startedAt ?? this.startedAt,
      workoutPhase: workoutPhase ?? this.workoutPhase,
      skillTechniqueRate: skillTechniqueRate ?? this.skillTechniqueRate,
      roundCount: roundCount ?? this.roundCount,
      id: id ?? this.id,
    );
  }

  int get hashCode =>
      workout.hashCode ^
      points.hashCode ^
      workoutDuration.hashCode ^
      finished.hashCode ^
      startedAt.hashCode ^
      skillTechniqueRate.hashCode ^
      warmupStageDuration.hashCode ^
      skillStageDuration.hashCode ^
      wodStageDuration.hashCode ^
      cooldownStageDuration.hashCode ^
      roundCount.hashCode ^
      deepHash(warmupExerciseDurations) ^
      deepHash(skillExerciseDurations) ^
      deepHash(wodExerciseDurations) ^
      deepHash(cooldownExerciseDurations) ^
      workoutPhase.hashCode;

  @override
  bool operator ==(Object other) =>
      other is WorkoutProgress &&
      workout == other.workout &&
      points == other.points &&
      workoutDuration == other.workoutDuration &&
      finished == other.finished &&
      startedAt == other.startedAt &&
      skillTechniqueRate == other.skillTechniqueRate &&
      warmupStageDuration == other.warmupStageDuration &&
      skillStageDuration == other.skillStageDuration &&
      wodStageDuration == other.wodStageDuration &&
      cooldownStageDuration == other.cooldownStageDuration &&
      roundCount == other.roundCount &&
      deepEquals(warmupExerciseDurations, other.warmupExerciseDurations) &&
      deepEquals(skillExerciseDurations, other.skillExerciseDurations) &&
      deepEquals(wodExerciseDurations, other.wodExerciseDurations) &&
      deepEquals(cooldownExerciseDurations, other.cooldownExerciseDurations) &&
      workoutPhase == other.workoutPhase;

  int getExerciseCount() {
    final warmUpExerciseCount = warmupExerciseDurations.length;
    final wodExerciseCount = wodExerciseDurations.length;
    final coolDownExerciseCount = cooldownExerciseDurations.length;
    final skillExerciseCount = skillExerciseDurations.length;
    return warmUpExerciseCount + wodExerciseCount + coolDownExerciseCount + skillExerciseCount;
  }
}

// class WorkoutDto {
//   String id;
//   String image;
//   String theme;
//   String wodType;
//   String skillImage;
//   String difficultyLevel;
//   int estimatedTime;
//   List<String> equipment;
//
//   WorkoutDto.fromMap(jsonMap)
//       : id = jsonMap["id"],
//         image = jsonMap["image"],
//         theme = jsonMap["theme"],
//         wodType = jsonMap["wodType"],
//         skillImage = jsonMap["skillImage"],
//         estimatedTime = jsonMap["estimatedTime"],
//         equipment = (jsonMap["equipment"] as List).map((e) => e as String).toList(),
//         difficultyLevel = jsonMap["difficultyLevel"];
//
//   int get hashCode => id.hashCode ^ image.hashCode ^ theme.hashCode ^ wodType.hashCode ^ difficultyLevel.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       other is WorkoutDto &&
//       id == other.id &&
//       image == other.image &&
//       theme == other.theme &&
//       wodType == other.wodType &&
//       difficultyLevel == other.difficultyLevel;
// }

class AnsweredQuestion {
  String id;
  String answer;
  String question;
  String questionId;

  AnsweredQuestion();

  AnsweredQuestion.fromMap(jsonMap)
      : id = jsonMap["id"],
        answer = jsonMap["answer"],
        question = jsonMap["question"],
        questionId = jsonMap["questionId"];

  int get hashCode => id.hashCode ^ answer.hashCode ^ question.hashCode ^ questionId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is AnsweredQuestion &&
      id == other.id &&
      answer == other.answer &&
      question == other.question &&
      questionId == other.questionId;
}
