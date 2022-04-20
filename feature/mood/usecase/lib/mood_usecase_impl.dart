import 'package:intl/intl.dart';
import 'package:mood_data/data.dart';
import 'package:mood_usecase/model/feeling_group.dart';
import 'package:mood_usecase/model/feeling_item.dart';
import 'package:mood_usecase/model/mood_data.dart';
import 'package:mood_usecase/model/request/send_mood_data_usecase_request.dart';
import 'package:mood_usecase/model/response/send_mood_data_usecase_response.dart';
import 'package:mood_usecase/mood_usecase.dart';


class MoodUseCaseImpl implements MoodUseCase {

  final MoodRepository repository;

  const MoodUseCaseImpl({ required this.repository });

  @override
  Future<MoodData> fetchMoodData() async {
    final result = await repository.fetchMoodData();
    final moodData = MoodData(
      feelingsGroups: List<FeelingGroup>.of(result.feelingsGroups.map((f) =>
        FeelingGroup(
          id: int.parse(f.id),
          name: f.name,
          color: f.colour,
          image: f.image,
          feelings: List<FeelingItem>.of(f.feelings.map((i) =>
            FeelingItem(name: i.name, id: int.parse(i.id), emoji: i.emoji)))
        ))),
      reasons: List<FeelingItem>.of(result.reasons.map((i) =>
        FeelingItem(id: int.parse(i.id), name: i.name, emoji: i.emoji)))
    );

    return moodData;
  }

  @override
  Future<SendMoodDataUseCaseResponse> sendMoodData(SendMoodDataUseCaseRequest model) async {

    final date = DateTime.now();
    final dateString = DateFormat('yyyy-MM-dd').format(date);
    final timeString = DateFormat('hh:mm').format(date);

    final result = await repository.sendMoodData(
      SendMoodRequest(
        moodReasonsIds: model.moodReasonsIds.map((e) => e.toString()).toList(),
        feelingId: model.feelingId.toString(),
        feelingsGroupId: model.feelingsGroupId.toString(),
        date: dateString,
        time: timeString,
      )
    );

    return SendMoodDataUseCaseResponse(
      time: result.time,
      emoji: result.emoji,
      feelingName: result.feelingName
    );
  }
}