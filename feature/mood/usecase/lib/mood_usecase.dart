import 'package:mood_usecase/model/mood_data.dart';
import 'package:mood_usecase/model/request/send_mood_data_usecase_request.dart';
import 'package:mood_usecase/model/response/send_mood_data_usecase_response.dart';

abstract class MoodUseCase {
  Future<MoodData> fetchMoodData();
  Future<SendMoodDataUseCaseResponse> sendMoodData(SendMoodDataUseCaseRequest model);
}