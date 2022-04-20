import 'package:profile_data/src/model/body_mind_spirit_statistic_dto.dart';
import 'package:profile_data/src/model/mood_state_dto.dart';
import 'package:profile_data/src/model/mood_tracking_statistic_dto.dart';
import 'package:profile_data/src/model/statistic_measure.dart';

abstract class ProfileRepository {
  Future<BodyMindSpiritStatisticDto> getBodyMindSpiritStatistic(int daysCount);

  Future<MoodTrackingStatisticDto> getMoodTrackingStatistic(
      String startDate, String endDate, StatisticMeasure measureType);

  Future<MoodStateDto> getWorkoutStatistic(
      String startDate, String endDate, StatisticMeasure measureType);
}
