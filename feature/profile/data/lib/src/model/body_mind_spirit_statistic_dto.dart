import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_mind_spirit_statistic_dto.freezed.dart';

part 'body_mind_spirit_statistic_dto.g.dart';

@freezed
class BodyMindSpiritStatisticDto with _$BodyMindSpiritStatisticDto {
  factory BodyMindSpiritStatisticDto(int body, int mind, int spirit) =
      _BodyMindSpiritStatisticDto;

  factory BodyMindSpiritStatisticDto.fromJson(Map<String, dynamic> json) =>
      _$BodyMindSpiritStatisticDtoFromJson(json);
}
