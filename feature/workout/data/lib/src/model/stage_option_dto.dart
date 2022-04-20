import 'package:json_annotation/json_annotation.dart';
import 'package:workout_data/src/model/rest_dto.dart';

part 'stage_option_dto.g.dart';

@JsonSerializable(createToJson: true)
class StageOptionDto {
  String metricType;
  int metricQuantity;
  List<RestDto> rests;

  StageOptionDto({
    required this.metricType,
    required this.metricQuantity,
    required this.rests,
  });

  factory StageOptionDto.fromJson(Map<String, dynamic> json) =>
      _$StageOptionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StageOptionDtoToJson(this);
}
