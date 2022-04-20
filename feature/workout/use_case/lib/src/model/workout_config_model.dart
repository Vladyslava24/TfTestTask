import 'package:json_annotation/json_annotation.dart';
import 'package:workout_use_case/src/model/workout_item_model.dart';

part 'workout_config_model.g.dart';

@JsonSerializable()
class WorkoutConfigModel {
  final String uid;
  List<WorkoutItemModel> config;

  WorkoutConfigModel({
    required this.uid,
    required this.config,
  });

  factory WorkoutConfigModel.fromJson(Map<String, dynamic> json) =>
    _$WorkoutConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutConfigModelToJson(this);
}