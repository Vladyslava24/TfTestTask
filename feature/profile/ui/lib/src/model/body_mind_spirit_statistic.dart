import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_mind_spirit_statistic.freezed.dart';

@freezed
class BodyMindSpiritStatistic with _$BodyMindSpiritStatistic {
  const factory BodyMindSpiritStatistic(int body, int mind, int spirit) =
      _BodyMindSpiritStatistic;
}
