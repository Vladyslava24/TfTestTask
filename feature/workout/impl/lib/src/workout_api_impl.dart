import 'package:core/core.dart';
import 'package:workout_api/api.dart';
import 'package:workout_data_legacy/data.dart';

class WorkoutApiImpl implements WorkoutApi {
  static const _pathWorkouts = "/api/v2/online-workouts";
  static const _pathWodOfMonth = '/api/v2/online-workouts/workout-of-the-month';
  static const _pathWodCollectionPriority = '/api/v2/online-workouts/workout-collection/priority';
  static const _pathOnboardingFirstWorkout = '/api/v1/onboarding/first-workout';

  final NetworkClient _networkClient;
  final JwtProvider _jwtProvider;

  WorkoutApiImpl(this._networkClient, this._jwtProvider);

  @override
  Future<WorkoutResponse> fetchWorkouts() async {
    final jwt = await _jwtProvider.read();
    final networkRequest = NetworkRequest.get(endpoint: _pathWorkouts, jwt: jwt);
    return _networkClient.executeRequest(networkRequest).then((response) => WorkoutResponse.fromMap(response.body));
  }

  @override
  Future<WorkoutDto> fetchWorkout(int id) async {
    final jwt = await _jwtProvider.read();
    final networkRequest = NetworkRequest.get(endpoint: '$_pathWorkouts/$id', jwt: jwt);
    return _networkClient.executeRequest(networkRequest).then((response) => WorkoutDto.fromMap(response.body));
  }

  @override
  Future<WorkoutResponse> filterWorkouts(Map<String, dynamic> queryParams) async {
    final jwt = await _jwtProvider.read();
    final networkRequest = NetworkRequest.get(
        endpoint: _pathWorkouts, queryParameters: queryParams, jwt: jwt);
    return _networkClient.executeRequest(networkRequest).then((response) => WorkoutResponse.fromMap(response.body));
  }

  @override
  Future<WorkoutDto> fetchWODOfTheMonth() async {
    final jwt = await _jwtProvider.read();
    final networkRequest = NetworkRequest.get(endpoint: _pathWodOfMonth, jwt: jwt);
    return _networkClient.executeRequest(networkRequest).then((response) => WorkoutDto.fromMap(response.body));
  }

  @override
  Future<WorkoutDto> getOnboardingFirstWorkout() async {
    final jwt = await _jwtProvider.read();
    final networkRequest =
        NetworkRequest.get(endpoint: _pathOnboardingFirstWorkout, jwt: jwt);
    return _networkClient.executeRequest(networkRequest).then((response) => WorkoutDto.fromMap(response.body));
  }

  @override
  Future<WorkoutCollectionResponse> fetchWODCollectionPriority() async {
    final jwt = await _jwtProvider.read();
    final networkRequest =
        NetworkRequest.get(endpoint: _pathWodCollectionPriority, jwt: jwt);
    return _networkClient
        .executeRequest(networkRequest)
        .then((response) => WorkoutCollectionResponse.fromJson(response.body));
  }
}
