import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/states/sign_up_state.dart';

final signUpReducer = combineReducers<SignUpState>([
  TypedReducer<SignUpState, UpdateUserStateAction>(_onUserSavedAction),
  TypedReducer<SignUpState, LogoutAction>(_logoutAction),
  TypedReducer<SignUpState, CountryErrorAction>(_countryErrorAction),
  TypedReducer<SignUpState, OnUserSignUpAction>(_onUserSignUpAction),
]);

SignUpState _logoutAction(SignUpState state, LogoutAction action) =>
    state.copyWith(user: null);

SignUpState _onUserSavedAction(
        SignUpState state, UpdateUserStateAction action) =>
    state.copyWith(user: action.user);

SignUpState _onUserSignUpAction(SignUpState state, OnUserSignUpAction action) =>
    state.copyWith(user: action.user);

SignUpState _countryErrorAction(SignUpState state, CountryErrorAction action) {
  return state.copyWith(countryError: action.message);
}
