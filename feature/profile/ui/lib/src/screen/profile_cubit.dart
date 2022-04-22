import 'dart:math';

import 'package:core/core.dart';
import 'package:profile_data/data.dart';
import 'package:profile_ui/profile.dart';
import 'package:profile_ui/src/screen/profile_state.dart';
import 'package:profile_ui/src/screen/screen_item/body_mind_spirit_statistic_item.dart';
import 'package:profile_ui/src/screen/screen_item/header_item.dart';
import 'package:profile_ui/src/screen/screen_item/health_balance_item.dart';
import 'package:profile_ui/src/screen/screen_item/test_button_item.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  final ProfileUseCase _useCase;
  final TFLogger _logger;
  Random random = Random();

  ProfileCubit(this._useCase, this._logger)
      : super(
          ProfileState(
            headerItem: HeaderItem(),
            healthBalanceItem: HealthBalanceItem(),
            bodyMindSpiritStatisticItem: BodyMindSpiritStatisticItem(0, 0, 0),
            testButtonItem: TestButtonItem(),
            loading: false,
            error: '',
            bodyMindSpiritStatistic: BodyMindSpiritStatistic(0, 0, 0),
          ),
        );

  init(User user) {
    emit(state.copyWith.headerItem(user: user));
  }

  Future<void> getBodyMindSpiritStatistic(int daysCount) async {
    try {
      final randomBodyValue = random.nextInt(101);
      final randomSpiritValue = random.nextInt(101 - randomBodyValue);
      final randomMindValue = 100 - randomBodyValue - randomSpiritValue;
      emit(state.copyWith(loading: true));
      //final statistic = await _useCase.getBodyMindSpiritStatistic(7);
      emit(state.copyWith(
        loading: false,
        bodyMindSpiritStatistic: BodyMindSpiritStatistic(
          randomBodyValue,
          randomMindValue,
          randomSpiritValue,
        ), //statistic));
      ));
    } catch (e) {
      _logger.logError('Failed to getBodyMindSpiritStatistic: $e');
      emit(state.copyWith(loading: false, error: 'Failed to get BodyMindSpiritStatistic'));
    }
  }

  Future<void> getMoodTrackingStatistic(
      String startDate, String endDate, StatisticMeasure measureType) async {
    try {
      emit(state.copyWith(loading: true));
      final result = await _useCase.getMoodTrackingStatistic(startDate, endDate, measureType);
    } catch (e) {
      emit(state.copyWith(loading: false, error: 'Failed to getMoodTrackingStatistic'));
      _logger.logError('Failed to getMoodTrackingStatistic: $e');
    }
  }

  Future<void> getWorkoutStatistic(
      String startDate, String endDate, StatisticMeasure measureType) async {
    try {
      final result = await _useCase.getWorkoutStatistic(startDate, endDate, measureType);
    } catch (e) {
      _logger.logError('Failed to getWorkoutStatistic: $e');
    }
  }

  navigateToSettings() {}

  navigateToEditProfile() {}
}
