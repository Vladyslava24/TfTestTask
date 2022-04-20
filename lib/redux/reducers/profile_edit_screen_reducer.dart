import 'package:redux/redux.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/states/profile_edit_screen_state.dart';

final profileEditScreenReducer = combineReducers<ProfileEditScreenState>([
  TypedReducer<ProfileEditScreenState, ShowEditProfileLoadingAction>(_showLoadingAction),
  TypedReducer<ProfileEditScreenState, ClearEditProfileExceptionAction>(_clearEditProfileExceptionAction),
  TypedReducer<ProfileEditScreenState, OnEditProfileErrorAction>(_onEditProfileErrorAction),
]);

ProfileEditScreenState _showLoadingAction(ProfileEditScreenState state, ShowEditProfileLoadingAction action) =>
    state.copyWith(isLoading: action.isLoading);

ProfileEditScreenState _clearEditProfileExceptionAction(
        ProfileEditScreenState state, ClearEditProfileExceptionAction action) =>
    state.copyWith(isLoading: false, error: IdleException());

ProfileEditScreenState _onEditProfileErrorAction(ProfileEditScreenState state, OnEditProfileErrorAction action) =>
    state.copyWith(isLoading: false, error: action.error);
