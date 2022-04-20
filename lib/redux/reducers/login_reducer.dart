import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/states/login_state.dart';

final loginReducer = combineReducers<LoginState>([
  TypedReducer<LoginState, UpdateUserStateAction>(_onUserSavedAction),
  TypedReducer<LoginState, OnUserLoginAction>(_onUserLoginAction),
  TypedReducer<LoginState, OnUserSignUpAction>(_onUserSignUpAction),
  TypedReducer<LoginState, LogoutAction>(_logoutAction),
]);

LoginState _logoutAction(LoginState state, LogoutAction action) => state.copyWith(user: null);

LoginState _onUserSavedAction(LoginState state, UpdateUserStateAction action) => state.copyWith(user: action.user);

LoginState _onUserLoginAction(LoginState state, OnUserLoginAction action) => state.copyWith(user: action.user);

LoginState _onUserSignUpAction(LoginState state, OnUserSignUpAction action) => state.copyWith(user: action.user);
