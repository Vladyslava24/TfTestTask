import 'package:profile_data/data.dart';

import '../../profile.dart';
import '../model/body_mind_spirit_statistic.dart';

class ProfileUseCase {
  final ProfileRepository _repository;

  ProfileUseCase(this._repository);

  Future<BodyMindSpiritStatistic> getBodyMindSpiritStatistic(
      int daysCount) async {
    final dto = await _repository.getBodyMindSpiritStatistic(daysCount);
    return BodyMindSpiritStatistic(dto.body, dto.mind, dto.spirit);
  }

  Future<Map<String, int>> getMoodTrackingStatistic(
      String startDate, String endDate, StatisticMeasure measureType) async {
    final dto = await _repository.getMoodTrackingStatistic(
        startDate, endDate, measureType);

    Map<String, int> moodStat = {};

    dto.items.forEach((item) {
      item.moodStates.forEach((state) {
        moodStat.putIfAbsent(state.moodMame, () => 0);
        moodStat.update(state.moodMame, (value) => value + state.count);
      });
    });

    return moodStat;
  }

  Future<MoodState> getWorkoutStatistic(
      String startDate, String endDate, StatisticMeasure measureType) async {
    final dto =
        await _repository.getWorkoutStatistic(startDate, endDate, measureType);
    return MoodState(dto.count, dto.moodMame, dto.image);
  }
}
