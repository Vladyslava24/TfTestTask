import 'package:totalfit/redux/actions/push_notifications_actions.dart';
import 'package:totalfit/redux/states/push_notifications_state.dart';
import 'package:redux/redux.dart';

final pushNotificationsReducer = combineReducers<PushNotificationsState>([
  TypedReducer<PushNotificationsState, SetupPushNotificationsSettingsAction>(_onSetupPushNotificationsSettingsAction),
  TypedReducer<PushNotificationsState, OnChangedLoadingStatus>(_onChangedLoadingStatus),
  TypedReducer<PushNotificationsState, OnSetupPushNotificationsConfigErrorAction>(_onSetupPushNotificationsConfigErrorAction),
  TypedReducer<PushNotificationsState, ClearConfigErrorAction>(_clearConfigErrorAction),

]);

PushNotificationsState _onSetupPushNotificationsSettingsAction(PushNotificationsState state, SetupPushNotificationsSettingsAction action) =>
  state.copyWith(wod: action.wod, dailyReading: action.dailyReading, updatesAndNews: action.updatesAndNews);

PushNotificationsState _onChangedLoadingStatus(PushNotificationsState state, OnChangedLoadingStatus action) =>
  state.copyWith(isLoading: action.status);

PushNotificationsState _onSetupPushNotificationsConfigErrorAction(PushNotificationsState state, OnSetupPushNotificationsConfigErrorAction action) =>
    state.copyWith(errorMessage: action.error);

PushNotificationsState _clearConfigErrorAction(PushNotificationsState state, ClearConfigErrorAction action) =>
    state.copyWith(errorMessage: '');

