import 'package:flutter/cupertino.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/model/profile/pagination_data.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';
import 'package:totalfit/model/profile/profile_error_type.dart';

import '../../model/profile/list_items.dart';

class ClearAppendedItemsAction {}

class MarkProfileRequireUpdate {
  final bool mark;
  MarkProfileRequireUpdate(this.mark);
}

class ClearPaginationControllerAction {
  final bool clear;

  ClearPaginationControllerAction(this.clear);
}

class ClearSetNewListFlagAction {}

class ClearProfileExceptionAction {
  final ProfileError error;

  ClearProfileExceptionAction({@required this.error});
}

class LoadCompletedWorkoutsHistoryAction {
  int pageOffset;

  LoadCompletedWorkoutsHistoryAction(this.pageOffset);
}

class SetProfileCompletedWorkoutsAction {
  final PaginationData paginationData;
  final List<FeedItem> listItems;

  SetProfileCompletedWorkoutsAction({@required this.paginationData, @required this.listItems});
}

class SetProfileWorkoutsListAction {
  final List<FeedItem> listItems;

  SetProfileWorkoutsListAction({@required this.listItems});
}

class OnProfileErrorAction {
  final ProfileError error;

  OnProfileErrorAction(this.error);
}

class ShowLoadingIndicatorAction {
  bool showLoadingIndicator;

  ShowLoadingIndicatorAction(this.showLoadingIndicator);
}

class OnDeleteCompletedWorkoutAction {
  final CompletedWorkoutListItem item;

  OnDeleteCompletedWorkoutAction({@required this.item});
}

class OnViewProgressAction extends TrackableAction {
  final CompletedWorkoutListItem item;

  OnViewProgressAction({@required this.item});

  @override
  Event event() => Event.PRESSED_WORKOUT_FROM_PROFILE;

  @override
  Map<String, String> parameters() => {"name": item.name, "workoutProgressId": item.workoutProgressId};
}

class OnShareProgressAction {
  final CompletedWorkoutListItem item;

  OnShareProgressAction({@required this.item});
}

class UpdateUserPhoto {
  final String url;

  UpdateUserPhoto(this.url);
}
