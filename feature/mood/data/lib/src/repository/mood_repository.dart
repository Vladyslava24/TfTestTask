import 'package:mood_data/data.dart';
import 'package:mood_data/src/model/request/send_mood_request.dart';
import 'package:mood_data/src/model/response/mood_data_response.dart';

abstract class MoodRepository {
  Future<MoodDataResponse> fetchMoodData();
  Future<SendMoodResponse> sendMoodData(SendMoodRequest model);
}