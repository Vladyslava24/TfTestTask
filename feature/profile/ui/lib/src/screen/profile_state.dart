import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:profile_ui/profile.dart';
import 'package:profile_ui/src/screen/screen_item/body_mind_spirit_statistic_item.dart';
import 'package:profile_ui/src/screen/screen_item/header_item.dart';
import 'package:profile_ui/src/screen/screen_item/health_balance_item.dart';
import 'package:profile_ui/src/screen/screen_item/test_button_item.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required HeaderItem headerItem,
    required HealthBalanceItem healthBalanceItem,
    required BodyMindSpiritStatisticItem bodyMindSpiritStatisticItem,
    required TestButtonItem testButtonItem,
    required bool loading,
    required String error,
    required BodyMindSpiritStatistic bodyMindSpiritStatistic,
  }) = _ProfileState;
}
