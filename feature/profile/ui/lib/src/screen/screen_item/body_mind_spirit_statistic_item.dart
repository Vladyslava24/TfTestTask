import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_mind_spirit_statistic_item.freezed.dart';

@freezed
class BodyMindSpiritStatisticItem with _$BodyMindSpiritStatisticItem {
  const factory BodyMindSpiritStatisticItem(int body, int mind, int spirit) =
  _BodyMindSpiritStatisticItem;
}
