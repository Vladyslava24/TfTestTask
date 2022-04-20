import 'dart:async';
import 'package:core/core.dart';
import 'package:workout_data/data.dart';
import 'package:workout_use_case/use_case.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  static const _pathWorkouts = "/api/v2/online-workouts";
  final StreamController<dynamic> _streamController =
      StreamController.broadcast();
  final StreamController<dynamic> _streamControllerWorkoutFinish =
      StreamController.broadcast();
  final NetworkClient _networkClient;
  final JwtProvider _jwtProvider;
  final TFLogger _logger;

  WorkoutRepositoryImpl(this._networkClient, this._jwtProvider, this._logger);

  @override
  Future<List<WorkoutDto>> fetchWorkouts() async {
    _logger.logInfo(
        "fetchWorkouts in WorkoutRepositoryImpl fetch ----> $_pathWorkouts");
    final jwt = await _jwtProvider.read();
    final networkRequest = NetworkRequest.get(
        endpoint: _pathWorkouts, jwt: jwt);
    return _networkClient
        .executeRequest(networkRequest)
        .then((response) => WorkoutApiResponse.fromJson(response.body))
        .then((response) => response.workouts);
  }

  static const PATH_UPDATE_PROGRESS = "/api/v1/progress";
  static const KEY_JWT = "KEY_JWT";

  @override
  Future<Result<UpdateProgressNewResponse>> updateProgress(
      UpdateProgressRequestDto request) async {
    _logger.logInfo(
        "updateProgress in WorkoutRepositoryImpl fetch ----> $PATH_UPDATE_PROGRESS");
    var json = request.toJson();
    final jwt = await _jwtProvider.read();
    final networkRequest = NetworkRequest.post(
      endpoint: '$PATH_UPDATE_PROGRESS',
      queryParameters: {"date": today()},
      jwt: jwt,
      body: json,
    );

    try {
      final response = await _networkClient.executeRequest(networkRequest);
      final resp = UpdateProgressNewResponse.fromJson(response.body);
      var res = Result.success(resp);
      _streamController.add(response.body);
      return res;
    } catch (error) {
      _logger.logError(
          "updateProgress in WorkoutRepositoryImpl error : ${error.toString()}");
      _streamController.add(Result.error(error));
      return Result.error(error);
    }
  }

  @override
  Stream<dynamic> progressUpdateStream() => _streamController.stream;

  @override
  StreamController<dynamic> workoutFinishStream() => _streamControllerWorkoutFinish;

  @override
  Future<Result<UpdateProgressNewResponse>> updatePriorityStage() async {
    _logger.logInfo(
        "updatePriorityStage in WorkoutRepositoryImpl fetch ----> $PATH_UPDATE_PROGRESS");
    final jwt = await _jwtProvider.read();
    final networkRequest = NetworkRequest.post(
        endpoint: '$PATH_UPDATE_PROGRESS',
        jwt: jwt,
        queryParameters: {"date": today()},
        body: {"workoutStage": "WP_PART"});
    try {
      final response = await _networkClient.executeRequest(networkRequest);
      final resp = UpdateProgressNewResponse.fromJson(response.body);
      var res = Result.success(resp);
      _streamController.add(response.body);
      return res;
    } catch (error) {
      _logger.logError(
          "updatePriorityStage in WorkoutRepositoryImpl error : ${error.toString()}");
      _streamController.add(Result.error(error));
      return Result.error(error);
    }
  }

  @override
  Future<WorkoutDto> fetchWorkoutById(int id) async {
    final jwt = await _jwtProvider.read();
    final networkRequest = NetworkRequest.get(
      endpoint: '$_pathWorkouts/$id/',
      jwt: jwt
    );
    return _networkClient
        .executeRequest(networkRequest)
        .then((response) => WorkoutDto.fromJson(response.body));
  }
}
