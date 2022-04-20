import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/event_actions.dart';
import 'package:totalfit/redux/states/session_state.dart';

final sessionReducer = combineReducers<SessionState>([
  TypedReducer<SessionState, SessionStartAction>(_onSessionStartAction),
]);

SessionState _onSessionStartAction(SessionState state, SessionStartAction action) => state;
