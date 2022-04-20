import 'package:core/core.dart';
import 'package:profile_data/src/model/body_mind_spirit_statistic_dto.dart';
import 'package:profile_data/src/model/mood_state_dto.dart';
import 'package:profile_data/src/model/mood_tracking_statistic_dto.dart';
import 'package:profile_data/src/model/statistic_measure.dart';
import 'package:profile_data/src/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  static const _pathMoodTracking = "/api/v1/statistic/mood-tracking";
  static const _pathBodyMindSpirit = "/api/v1/statistic/body-mind-spirit";
  static const _pathWorkoutStatistic = "/api/v1/statistic/workout";

  final NetworkClient _networkClient;
  final JwtProvider _jwtProvider;
  final TFLogger _logger;

  ProfileRepositoryImpl(this._networkClient, this._jwtProvider, this._logger);

  @override
  Future<BodyMindSpiritStatisticDto> getBodyMindSpiritStatistic(
      int daysCount) async {
    final jwt = await _jwtProvider.read();
    final networkRequest = NetworkRequest.get(
      endpoint: _pathBodyMindSpirit,
      queryParameters: {"daysCount": daysCount.toString()},
      jwt: jwt,
    );

    _logger.logInfo(
        "ProfileRepositoryImpl. getBodyMindSpiritStatistic: ${networkRequest.url}");
    return _networkClient.executeRequest(networkRequest).then((response) {
      _logger.logInfo(
          "ProfileRepositoryImpl. getBodyMindSpiritStatistic response: ${response.body}");
      return BodyMindSpiritStatisticDto.fromJson(response.body);
    });
  }

  @override
  Future<MoodTrackingStatisticDto> getMoodTrackingStatistic(
      String startDate, String endDate, StatisticMeasure measureType) async {
    final jwt = await _jwtProvider.read();
    final networkRequest = NetworkRequest.get(
      endpoint: _pathMoodTracking,
      queryParameters: {
        "startDate": startDate,
        "endDate": endDate,
        "measureType": measureType.toShortString()
      },
      jwt: jwt,
    );

    _logger.logInfo(
        "ProfileRepositoryImpl. getMoodTrackingStatistic: ${networkRequest.url}");
    return _networkClient.executeRequest(networkRequest).then((response) {
      _logger.logInfo(
          "ProfileRepositoryImpl. getMoodTrackingStatistic response: ${response.body}");

      if (response.body.isEmpty) {
        return MoodTrackingStatisticDto([]);
      } else {
        final list = <MoodItemDto>[];
        (response.body as List).forEach((json) {
          list.add(MoodItemDto.fromJson(json));
        });
        return MoodTrackingStatisticDto(list);
      }
    });
  }

  @override
  Future<MoodStateDto> getWorkoutStatistic(
      String startDate, String endDate, StatisticMeasure measureType) async {
    final jwt = await _jwtProvider.read();
    final networkRequest = NetworkRequest.get(
      endpoint: _pathWorkoutStatistic,
      queryParameters: {
        "startDate": startDate,
        "endDate": endDate,
        "measureType": measureType.toShortString()
      },
      jwt: jwt,
    );

    _logger.logInfo(
        "ProfileRepositoryImpl. getWorkoutStatistic: ${networkRequest.url}");
    return _networkClient.executeRequest(networkRequest).then((response) {
      _logger.logInfo(
          "ProfileRepositoryImpl. getWorkoutStatistic response: ${response.body}");
      return MoodStateDto.fromJson(response.body);
    });
  }
}
