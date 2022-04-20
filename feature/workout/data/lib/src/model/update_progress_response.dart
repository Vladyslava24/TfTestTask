import 'package:workout_data/src/model/workout_progress_new_dto.dart';

import 'hexagon_state_dto.dart';

class UpdateProgressResponseDto {
  String? date;
  List<WorkoutProgressNewDto>? workoutProgress;
  HexagonStateDto? hexagonState;

  UpdateProgressResponseDto({
    this.date,
    this.workoutProgress,
    this.hexagonState
  });

  UpdateProgressResponseDto copyWith({
    String? date,
    List<WorkoutProgressNewDto>? workoutProgress,
    HexagonStateDto? hexagonState,
  }){
    return UpdateProgressResponseDto(
      date: date ?? this.date,
      workoutProgress: workoutProgress ?? this.workoutProgress,
      hexagonState: hexagonState ?? this.hexagonState
    );
  }

  UpdateProgressResponseDto.fromJson(json){
    date = json["date"];
    workoutProgress = (json["workoutProgress"] as List)
        .map((e) => WorkoutProgressNewDto.fromMap(e)).toList();
    hexagonState = HexagonStateDto.fromMap(json["hexagonState"]);
  }

}