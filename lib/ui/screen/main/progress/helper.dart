import 'dart:io';

import 'package:core/core.dart';
import 'package:totalfit/model/loading_state/progress_state.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/model/progress_page_model.dart';
import 'package:totalfit/ui/screen/main/workout/widgets/summary_progress_indicator.dart';
import 'package:totalfit/ui/widgets/hexagon/hexagon_utils.dart';
import 'package:totalfit/utils/locales_service.dart';

final LocalesService _localesService = DependencyProvider.get<LocalesService>();

List<ProgressItem> emptyProgressList = [
  ProgressItem(0.0, name: _localesService.locales.body, value: 0.0, color: MetaHexSegment.BODY.color),
  ProgressItem(0.0, name: _localesService.locales.mind, value: 0.0, color: MetaHexSegment.MIND.color),
  ProgressItem(0.0, name: _localesService.locales.spirit, value: 0.0, color: MetaHexSegment.SPIRIT.color)
];

List<ProgressListItem> buildItemList(ProgressPageModel model) {
  List<ProgressListItem> items = [];
  Map<MetaHexSegment, double> rateMap;

  if (!model.isLoading() && !model.isInErrorState()) {
    rateMap = {
      MetaHexSegment.BODY: model.hexagonState.body.toDouble(),
      MetaHexSegment.MIND: model.hexagonState.mind.toDouble(),
      MetaHexSegment.SPIRIT: model.hexagonState.spirit.toDouble(),
    };

    List<ProgressItem> progressList = [
      ProgressItem(rateMap[MetaHexSegment.BODY] / 100,
          name: _localesService.locales.body,
          value: rateMap[MetaHexSegment.BODY] / 100,
          color: MetaHexSegment.BODY.color),
      ProgressItem(rateMap[MetaHexSegment.MIND] / 100,
          name: _localesService.locales.mind,
          value: rateMap[MetaHexSegment.MIND] / 100,
          color: MetaHexSegment.MIND.color),
      ProgressItem(rateMap[MetaHexSegment.SPIRIT] / 100,
          name: _localesService.locales.spirit,
          value: rateMap[MetaHexSegment.SPIRIT] / 100,
          color: MetaHexSegment.SPIRIT.color)
    ];

    final headerItem = ProgressHeaderListItem(rateMap: rateMap, date: model.date, progressItems: progressList);
    items.add(headerItem);

    if (model.workoutProgressList.isNotEmpty) {
      ProgressState progressState;
      if (model.workoutProgressList.length == 1 && model.workoutProgressList[0].startedAt == null) {
        progressState = ProgressState.IDLE;
      } else {
        final uncompleted =
            model.workoutProgressList.firstWhere((e) => e.finished != null && !e.finished, orElse: () => null);
        progressState = uncompleted == null ? ProgressState.COMPLETED : ProgressState.IDLE;
      }

      final workoutItem = WorkoutListItem(workoutProgressList: model.workoutProgressList, progressState: progressState);
      items.add(workoutItem);
    }

    if (isToday(model.date) && model.discountModel.isShowing) {
      final discountItem = ProgressDiscountListItem();
      items.add(discountItem);
    }

    if (model.environmentModel != null) {
      final environmentItem = EnvironmentalListItem(environmentModel: model.environmentModel);
      items.add(environmentItem);
    }

    if (model.wisdomModel != null) {
      final wisdomItem = WisdomListItem(wisdomModel: model.wisdomModel);
      items.add(wisdomItem);
    }

    if (model.breathingModel != null) {
      final breathingItem = BreathingListItem(breathingModel: model.breathingModel);
      items.add(breathingItem);
    }

    if (model.habitModels != null) {
      final habitItem = HabitListItem(habits: model.habitModels);
      items.add(habitItem);
    }

    if (model.storyModel != null) {
      final storyItem = StoryAndStatementListItem(storyModel: model.storyModel);
      items.add(storyItem);
    }

    if (model.moodTrackingList != null) {
      final moodItem = MoodListProgressItem(moodList: model.moodTrackingList);
      items.add(moodItem);
    }

    if (model.workoutProgressList.isEmpty &&
        (model.storyModel.story == null && model.storyModel.isRead == false && model.storyModel.statements.isEmpty) &&
        model.environmentModel == null &&
        model.wisdomModel == null &&
        model.habitModels == null &&
        (model.breathingModel == null || !model.breathingModel.done) &&
        (model.moodTrackingList == null || model.moodTrackingList.isEmpty)) {
      items.add(EmptyStateItem());
    } else {
      //items.sort((a, b) => a.getPriority().index - b.getPriority().index);
    }
  } else {
    rateMap = emptySegments();
    final headerItem = ProgressHeaderListItem(rateMap: rateMap, progressItems: emptyProgressList, date: model.date);
    items.add(headerItem);
    if (model.isInErrorState()) {
      items.add(ErrorItem(error: model.loadProgressError));
    } else {
      items.add(LoadingIndicatorItem());
    }
  }
  items.add(SpaceItem());

  final firstItem = items.first;
  final lastItem = items.last;
  final middleItems = items.sublist(1, items.length - 1);

  final priority = model.priority ?? 'Body';

  final discountItem = items.singleWhere((e) =>
    e is ProgressDiscountListItem, orElse: () => null);

  final bodyItemsList = middleItems.where((e) =>
    e is WorkoutListItem || e is EnvironmentalListItem).toList();
  final mindItemsList = middleItems.where((e) => e is WisdomListItem ||
    e is BreathingListItem || e is HabitListItem).toList();
  final spiritItemsList = middleItems.where((e) =>
    e is StoryAndStatementListItem).toList();

  final otherItemsList = middleItems.where((e) =>
    e is !WorkoutListItem && e is !EnvironmentalListItem &&
    e is !BreathingListItem && e is !HabitListItem && e is !WisdomListItem &&
    e is !StoryAndStatementListItem && e is !ProgressDiscountListItem).toList();

  final sortedItemsList = <ProgressListItem>[];

  sortedItemsList.add(firstItem);

  if (discountItem != null) {
    sortedItemsList.add(discountItem);
  }

  if (priority == 'Mind') {
    sortedItemsList.addAll(mindItemsList);
    sortedItemsList.addAll(bodyItemsList);
    sortedItemsList.addAll(spiritItemsList);
  } else if (priority == 'Spirit') {
    sortedItemsList.addAll(spiritItemsList);
    sortedItemsList.addAll(bodyItemsList);
    sortedItemsList.addAll(mindItemsList);
  } else {
    sortedItemsList.addAll(bodyItemsList);
    sortedItemsList.addAll(mindItemsList);
    sortedItemsList.addAll(spiritItemsList);
  }
  sortedItemsList.addAll(otherItemsList);
  sortedItemsList.add(lastItem);

  print('sortedItemsList');
  print(sortedItemsList);

  return sortedItemsList;
}
