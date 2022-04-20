import 'package:json_annotation/json_annotation.dart';
import 'package:workout_use_case/src/model/workout_item_model.dart';

part 'audio_config_model.g.dart';

@JsonSerializable()
class AudioConfigModel {

  List<WorkoutItemModel> config;

  AudioConfigModel({
    required this.config,
  });

  factory AudioConfigModel.fromJson(Map<String, dynamic> json) =>
      _$AudioConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$AudioConfigModelToJson(this);
}