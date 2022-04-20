import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/settings_actions.dart';
import 'package:totalfit/redux/states/settings_screen_state.dart';

final settingsScreenReducer = combineReducers<SettingsScreenState>([
  TypedReducer<SettingsScreenState, UpdateVideoStorageSizeAction>(_completeAction),
]);

SettingsScreenState _completeAction(
    SettingsScreenState state, UpdateVideoStorageSizeAction action) =>
    state.copyWith(videoCacheSize: action.size);