import 'package:core/core.dart';
import 'package:profile_data/data.dart';
import 'package:profile_ui/src/screen/profile_state.dart';
import 'package:profile_ui/src/screen/screen_item/body_mind_spirit_statistic_item.dart';
import 'package:profile_ui/src/screen/screen_item/header_item.dart';
import 'package:profile_ui/src/screen/screen_item/test_button_item.dart';
import '../use_case/use_case.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  final ProfileUseCase _useCase;
  final TFLogger _logger;

  ProfileCubit(this._useCase, this._logger)
      : super(ProfileState(
            headerItem: HeaderItem(),
            bodyMindSpiritStatisticItem: BodyMindSpiritStatisticItem(0, 0, 0),
            testButtonItem: TestButtonItem(),
            loading: false,
            error: ''));

  init(User user) {
    emit(state.copyWith.headerItem(user: user));
  }

  Future<void> getBodyMindSpiritStatistic(int daysCount) async {
    try {
      emit(state.copyWith(loading: true));
      final statistic = await _useCase.getBodyMindSpiritStatistic(7);

    } catch (e) {
      _logger.logError('Failed to getBodyMindSpiritStatistic: $e');
      emit(state.copyWith(
          loading: false, error: 'Failed to get BodyMindSpiritStatistic'));
    }
  }

  Future<void> getMoodTrackingStatistic(
      String startDate, String endDate, StatisticMeasure measureType) async {
    try {
      emit(state.copyWith(loading: true));
      final result = await _useCase.getMoodTrackingStatistic(
          startDate, endDate, measureType);

    } catch (e) {
      emit(state.copyWith(
          loading: false, error: 'Failed to getMoodTrackingStatistic'));
      _logger.logError('Failed to getMoodTrackingStatistic: $e');
    }
  }

  Future<void> getWorkoutStatistic(
      String startDate, String endDate, StatisticMeasure measureType) async {
    try {
      final result =
          await _useCase.getWorkoutStatistic(startDate, endDate, measureType);
    } catch (e) {
      _logger.logError('Failed to getWorkoutStatistic: $e');
    }
  }

  navigateToSettings() {}

  navigateToEditProfile() {}
}
