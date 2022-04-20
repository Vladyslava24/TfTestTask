import 'package:workout_data_legacy/src/workout_collection_dto.dart';

class WorkoutCollectionResponse {
  List<WorkoutCollectionDto>? workoutCollections;

  WorkoutCollectionResponse({required this.workoutCollections});

  WorkoutCollectionResponse.fromJson(jsonMap)
      : workoutCollections = jsonMap != null
            ? List<WorkoutCollectionDto>.of((jsonMap as List).map((c) => WorkoutCollectionDto.fromJson(c)))
            : null;
}
