import 'package:workout_data_legacy/src/workout_dto.dart';

class WorkoutCollectionDto {
  final String id;
  final String name;
  final List<WorkoutDto>? workouts;

  WorkoutCollectionDto({
    required this.id,
    required this.name,
    required this.workouts,
  });

  WorkoutCollectionDto.fromJson(jsonMap)
      : id = jsonMap['id'],
        name = jsonMap['name'],
        workouts = jsonMap['workouts'] != null
            ? (jsonMap['workouts'] as List).map((w) => WorkoutDto.fromMap(w)).toList()
            : null;
}
