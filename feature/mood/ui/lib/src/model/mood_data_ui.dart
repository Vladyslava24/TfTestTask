import 'package:mood_ui/src/model/feeling_group_ui.dart';
import 'package:mood_ui/src/model/feeling_item_ui.dart';

class MoodDataUI {
  final List<FeelingGroupUI> feelingsGroups;
  final List<FeelingItemUI> reasons;

  const MoodDataUI({
    required this.feelingsGroups,
    required this.reasons
  });
}