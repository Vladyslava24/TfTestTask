import 'package:json_annotation/json_annotation.dart';
part 'rest_dto.g.dart';

@JsonSerializable(createToJson: true)
class RestDto {
  int order;
  int quantity;

  RestDto({
    required this.order,
    required this.quantity,
  });

  factory RestDto.fromJson(Map<String, dynamic> json) =>
      _$RestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RestDtoToJson(this);
}
