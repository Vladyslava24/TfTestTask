import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:totalfit/data/dto/mood_dto.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/model/environment_model.dart';
import 'package:totalfit/model/story_model.dart';
import 'package:totalfit/model/wisdom_model.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/workout/widgets/summary_progress_indicator.dart';
import 'package:totalfit/ui/utils/utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/ui/widgets/hexagon/hexagon_utils.dart';
import 'package:ui_kit/ui_kit.dart';

import 'breathing_model.dart';
import 'loading_state/progress_state.dart';

class ProgressHeaderListItem implements ProgressListItem {
  final Map<MetaHexSegment, double> rateMap;
  final List<ProgressItem> progressItems;
  final String date;

  @override
  ItemPriority getPriority() => ItemPriority.Default;

  ProgressHeaderListItem({
    @required this.rateMap,
    @required this.progressItems,
    @required this.date
  });

  bool operator ==(Object other) =>
    identical(this, other) ||
    other is ProgressHeaderListItem &&
      runtimeType == other.runtimeType &&
      rateMap == other.rateMap &&
      date == other.date;

  @override
  int get hashCode => rateMap.hashCode ^ date.hashCode;
}

class WorkoutListItem implements ProgressListItem {
  final List<WorkoutProgressDto> workoutProgressList;
  final ProgressState progressState;

  @override
  ItemPriority getPriority() => progressState == ProgressState.COMPLETED ?
    ItemPriority.Low : ItemPriority.Default;

  WorkoutListItem({
    @required this.workoutProgressList,
    @required this.progressState
  });

  bool operator ==(Object other) =>
    identical(this, other) ||
    other is WorkoutListItem &&
      runtimeType == other.runtimeType &&
      progressState == other.progressState &&
      deepEquals(workoutProgressList, other.workoutProgressList);

  @override
  int get hashCode => deepHash(workoutProgressList) ^ progressState.hashCode;
}

class HabitListItem implements ProgressListItem {
  final List<HabitDto> habits;

  @override
  ItemPriority getPriority() => ItemPriority.Default;

  HabitListItem({@required this.habits});

  bool operator ==(Object other) =>
    identical(this, other) ||
    other is HabitListItem &&
      runtimeType == other.runtimeType &&
      deepEquals(habits, other.habits);

  @override
  int get hashCode => hashCode ^ deepHash(habits);
}

class StoryAndStatementListItem implements ProgressListItem {
  final StoryModel storyModel;

  @override
  ItemPriority getPriority() => storyModel.isRead ?
    ItemPriority.High : ItemPriority.Default;

  StoryAndStatementListItem({@required this.storyModel});

  bool operator ==(Object other) =>
    identical(this, other) ||
    other is StoryAndStatementListItem &&
      runtimeType == other.runtimeType && storyModel == other.storyModel;

  @override
  int get hashCode => storyModel.hashCode;
}

class BreathingListItem implements ProgressListItem {
  final BreathingModel breathingModel;

  const BreathingListItem({
    @required this.breathingModel
  });

  @override
  ItemPriority getPriority() => breathingModel.done ?
    ItemPriority.High : ItemPriority.Default;

  bool operator ==(Object other) =>
    identical(this, other) ||
      other is BreathingListItem &&
        runtimeType == other.runtimeType &&
        breathingModel == other.breathingModel;

  @override
  int get hashCode => breathingModel.hashCode;
}

class MoodListProgressItem implements ProgressListItem {

  final List<MoodDTO> moodList;

  const MoodListProgressItem({
    @required this.moodList
  });

  @override
  ItemPriority getPriority() => ItemPriority.Default;

  bool operator ==(Object other) =>
    identical(this, other) ||
      other is MoodListProgressItem &&
        runtimeType == other.runtimeType &&
        deepEquals(moodList, other.moodList);

  @override
  int get hashCode => hashCode ^ deepHash(moodList);
}

class WisdomListItem implements ProgressListItem {
  final WisdomModel wisdomModel;

  @override
  ItemPriority getPriority() => wisdomModel.isRead ?
    ItemPriority.Medium : ItemPriority.Default;

  WisdomListItem({@required this.wisdomModel});

  bool operator ==(Object other) =>
    identical(this, other) ||
    other is WisdomListItem &&
      runtimeType == other.runtimeType && wisdomModel == other.wisdomModel;

  @override
  int get hashCode => wisdomModel.hashCode;
}

class EnvironmentalListItem implements ProgressListItem {
  final EnvironmentModel environmentModel;

  @override
  ItemPriority getPriority() => environmentModel.isDone() ?
    ItemPriority.High : ItemPriority.Default;

  EnvironmentalListItem({@required this.environmentModel});

  bool operator ==(Object other) =>
    identical(this, other) ||
    other is EnvironmentalListItem &&
      runtimeType == other.runtimeType &&
      environmentModel == other.environmentModel;

  @override
  int get hashCode => environmentModel.hashCode;
}

class LoadingIndicatorItem implements ProgressListItem {
  @override
  ItemPriority getPriority() => ItemPriority.Default;
}

class ErrorItem implements ProgressListItem {
  final String error;

  ErrorItem({@required this.error});

  @override
  ItemPriority getPriority() => ItemPriority.Default;
}

class SpaceItem implements ProgressListItem {
  @override
  ItemPriority getPriority() => ItemPriority.Default;

  @override
  int get hashCode => ItemPriority.Default.hashCode;

  bool operator ==(Object other) =>
    identical(this, other) ||
    other is SpaceItem &&
      runtimeType == other.runtimeType &&
      getPriority() == other.getPriority();
}

class EmptyStateItem implements ProgressListItem {
  @override
  ItemPriority getPriority() => ItemPriority.Default;
}

class HexagonTestControllerItem implements ProgressListItem {
  @override
  ItemPriority getPriority() => ItemPriority.Default;
}

class ProgressDiscountListItem implements ProgressListItem {
  @override
  ItemPriority getPriority() => ItemPriority.Low;
}

abstract class ProgressListItem extends FeedItem {
  ItemPriority getPriority();
}

enum ItemPriority { Default, High, Medium, Low }

class HexagonTestControllerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true, converter: _ViewModel.fromStore, builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) {
    return Container(child: ActionButton(onPressed: () => vm.updateHexagon(), text: "Update Hexagon"));
  }
}

class _ViewModel {
  final Function updateHexagon;

  _ViewModel({@required this.updateHexagon});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      updateHexagon: () => store.dispatch(UpdateHexagonAction(store.state.mainPageState.progressPageIndex)),
    );
  }
}

class UpdateHexagonAction {
  int index;

  UpdateHexagonAction(this.index);
}

