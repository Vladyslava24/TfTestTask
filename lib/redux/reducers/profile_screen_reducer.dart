import 'package:redux/redux.dart';
import 'package:totalfit/model/profile/pagination_data.dart';
import 'package:totalfit/redux/actions/profile_actions.dart';
import 'package:totalfit/model/profile/profile_error_type.dart';
import 'package:totalfit/redux/states/profile_screen_state.dart';

import '../../model/profile/list_items.dart';

final profileScreenReducer = combineReducers<ProfileScreenState>([
  TypedReducer<ProfileScreenState, ShowLoadingIndicatorAction>(_showLoadingIndicatorAction),
  TypedReducer<ProfileScreenState, SetProfileCompletedWorkoutsAction>(_setProfileCompletedWorkoutsAction),
  TypedReducer<ProfileScreenState, SetProfileWorkoutsListAction>(_setProfileWorkoutsListAction),
  TypedReducer<ProfileScreenState, ClearProfileExceptionAction>(_clearProfileExceptionAction),
  TypedReducer<ProfileScreenState, OnProfileErrorAction>(_onProfileErrorAction),
  TypedReducer<ProfileScreenState, ClearAppendedItemsAction>(_clearAppendedItemsAction),
  TypedReducer<ProfileScreenState, MarkProfileRequireUpdate>(_markRequireUpdateAction),
  TypedReducer<ProfileScreenState, ClearPaginationControllerAction>(_clearListItemsAction),
  TypedReducer<ProfileScreenState, ClearSetNewListFlagAction>(_clearSetNewListFlagAction),
  TypedReducer<ProfileScreenState, UpdateUserPhoto>(_onUpdateUserPhoto)
]);

ProfileScreenState _onUpdateUserPhoto(ProfileScreenState state, UpdateUserPhoto action) {
  if (state.listItems.isNotEmpty) {
    List<FeedItem> toUpdate = List.of(state.listItems);
    ProfileHeaderListItem header = toUpdate.firstWhere((e) => e is ProfileHeaderListItem, orElse: () => null);
    if (header != null) {
      header.user = header.user.copyWith(photo: action.url);
      return state.copyWith(listItems: toUpdate);
    }
  }
  return state;
}

ProfileScreenState _markRequireUpdateAction(ProfileScreenState state, MarkProfileRequireUpdate action) =>
  state.copyWith(markRequireUpdate: action.mark);

ProfileScreenState _clearAppendedItemsAction(ProfileScreenState state, ClearAppendedItemsAction action) =>
    state.copyWith(paginationData: PaginationData.initial());

ProfileScreenState _clearListItemsAction(ProfileScreenState state, ClearPaginationControllerAction action) =>
    state.copyWith(clearPaginationController: action.clear);

ProfileScreenState _clearSetNewListFlagAction(ProfileScreenState state, ClearSetNewListFlagAction action) =>
    state.copyWith(setNewList: false);

ProfileScreenState _showLoadingIndicatorAction(ProfileScreenState state, ShowLoadingIndicatorAction action) =>
    state.copyWith(showLoadingIndicator: action.showLoadingIndicator);

ProfileScreenState _setProfileCompletedWorkoutsAction(
        ProfileScreenState state, SetProfileCompletedWorkoutsAction action) =>
    state.copyWith(showLoadingIndicator: false, listItems: action.listItems, paginationData: action.paginationData);

ProfileScreenState _setProfileWorkoutsListAction(ProfileScreenState state, SetProfileWorkoutsListAction action) =>
    state.copyWith(showLoadingIndicator: false, listItems: action.listItems, setNewList: true);

ProfileScreenState _clearProfileExceptionAction(ProfileScreenState state, ClearProfileExceptionAction action) =>
    state.copyWith(error: EmptyProfileError());

ProfileScreenState _onProfileErrorAction(ProfileScreenState state, OnProfileErrorAction action) =>
    state.copyWith(showLoadingIndicator: false, error: action.error);
