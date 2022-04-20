import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/splash_screen_actions.dart';
import 'package:totalfit/redux/states/splash_screen_state.dart';

final splashScreenReducer = combineReducers<SplashScreenState>([
  TypedReducer<SplashScreenState, ShowLoadingAction>(_showLoadingAction),
  TypedReducer<SplashScreenState, ShowWelcomeOnBoardingAction>(_showWelcomeOnboardingAction),
]);

SplashScreenState _showWelcomeOnboardingAction(SplashScreenState state, ShowWelcomeOnBoardingAction action) =>
    state.copyWith(showWelcomeOnboarding: action.showWelcomeOnBoarding);

SplashScreenState _showLoadingAction(SplashScreenState state, ShowLoadingAction action) =>
    state.copyWith(showWelcomeOnboarding: false, isLoading: action.isLoading);
