import 'package:core/core.dart';
import 'package:mood_data/src/model/request/send_mood_request.dart';
import 'package:mood_data/src/model/response/mood_data_response.dart';
import 'package:mood_data/src/model/response/send_mood_response.dart';
import 'package:mood_data/src/repository/mood_repository.dart';

class MoodRepositoryImpl implements MoodRepository {

  static const _pathFetchMood = '/api/v1/progress/mood-tracking';
  static const _pathAddMood = '/api/v1/progress/mood-tracking';

  final NetworkClient networkClient;
  final JwtProvider jwtProvider;

  const MoodRepositoryImpl({
    required this.networkClient,
    required this.jwtProvider
  });

  @override
  Future<MoodDataResponse> fetchMoodData() async {
    final jwt = await jwtProvider.read();
    final networkRequest = NetworkRequest.get(endpoint: _pathFetchMood, jwt: jwt);
    return networkClient.executeRequest(networkRequest).then((response) =>
      MoodDataResponse.fromJson(response.body));
  }

  @override
  Future<SendMoodResponse> sendMoodData(SendMoodRequest model) async {
    final jwt = await jwtProvider.read();
    final networkRequest = NetworkRequest.post(
      endpoint: _pathAddMood,
      jwt: jwt,
      body: model.toJson()
    );
    return networkClient.executeRequest(networkRequest).then((response) =>
      SendMoodResponse.fromJson(response.body));
  }
}