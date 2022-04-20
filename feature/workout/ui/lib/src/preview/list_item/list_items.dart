import 'package:workout_ui/src/model/workout_status.dart';
import 'package:workout_use_case/use_case.dart';

class SpaceWorkoutListItem {}

class HeaderItem {
  final String uid;
  final String title;
  final String image;
  final WorkoutStatus workoutStatus;

  HeaderItem({
    required this.uid,
    required this.title,
    required this.workoutStatus,
    required this.image
  });
}

class InfoItem {
  final List<String> equipment;
  final String level;
  final String duration;

  InfoItem({
    required this.equipment,
    required this.level,
    required this.duration,
  });
}

class ExerciseItem {
  final List<ExerciseModel> exercises;
  final WorkoutStatus workoutStatus;
  final WorkoutModel workout;
  final String title;
  final String? subTitle;
  final bool isCompleted;

  ExerciseItem({
    required this.exercises,
    required this.isCompleted,
    required this.workout,
    required this.workoutStatus,
    required this.title,
    required this.subTitle,
  });
}
