import 'package:json_annotation/json_annotation.dart';
import 'package:workout_data/src/model/exercise_dto.dart';
import 'package:workout_data/src/model/stage_option_dto.dart';

part 'workout_stage_dto.g.dart';

@JsonSerializable(createToJson: true)
class WorkoutStageDto {
  String stageName;
  String stageType;
  List<ExerciseDto> exercises;
  StageOptionDto stageOption;

  WorkoutStageDto({
    required this.stageName,
    required this.stageType,
    required this.exercises,
    required this.stageOption,
  });

  factory WorkoutStageDto.fromJson(Map<String, dynamic> json) => _$WorkoutStageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutStageDtoToJson(this);
}
