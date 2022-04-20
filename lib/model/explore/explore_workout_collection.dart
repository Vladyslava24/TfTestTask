import 'package:workout_data_legacy/data.dart';
import 'package:flutter/cupertino.dart';

class ExploreWorkoutCollection {
  final String id;
  final String name;
  final List<WorkoutDto> workouts;

  ExploreWorkoutCollection({
    @required this.id,
    @required this.name,
    @required this.workouts
  });
}