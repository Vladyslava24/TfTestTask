import 'package:mood_usecase/model/feeling_group.dart';
import 'package:mood_usecase/model/feeling_item.dart';

class MoodData {
  final List<FeelingGroup> feelingsGroups;
  final List<FeelingItem> reasons;

  const MoodData({
    required this.feelingsGroups,
    required this.reasons
  });
}