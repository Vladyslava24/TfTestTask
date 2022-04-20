import 'package:json_annotation/json_annotation.dart';

part 'workout_item_model.g.dart';

@JsonSerializable()
class WorkoutItemModel {

  final String id;
  final String label;
  final bool value;

  WorkoutItemModel({
    required this.id,
    required this.label,
    required this.value
  });

  factory WorkoutItemModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutItemModelToJson(this);
}