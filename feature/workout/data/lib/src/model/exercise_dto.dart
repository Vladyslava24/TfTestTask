import 'package:json_annotation/json_annotation.dart';

part 'exercise_dto.g.dart';

@JsonSerializable(createToJson: true)
class ExerciseDto {
  final String type;
  final String name;
  final String image;
  final int quantity;
  final String video480;
  final String video720;
  final String video1080;
  final String videoVertical;
  final String tag;
  final String metrics;

  const ExerciseDto({
    required this.type,
    required this.video480,
    required this.video720,
    required this.video1080,
    required this.tag,
    required this.metrics,
    required this.name,
    required this.quantity,
    required this.image,
    required this.videoVertical,
  });

  factory ExerciseDto.fromJson(Map<String, dynamic> json) => _$ExerciseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseDtoToJson(this);
}
