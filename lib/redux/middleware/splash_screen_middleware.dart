import 'package:core/core.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/splash_screen_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:uni_links/uni_links.dart';

import '../../ui/screen/splash/links_mapper.dart';
import '../../ui/screen/splash/links_navigation.dart';

List<Middleware<AppState>> splashScreenMiddleware(
    UserRepository userRepository, RemoteStorage remoteStorage, TFLogger logger) {
  return [
    TypedMiddleware<AppState, SetupAppOnStartAction>(
        _setupAppOnStartAction(userRepository, remoteStorage, logger)),
  ];
}

Middleware<AppState> _setupAppOnStartAction(
    UserRepository userRepository, RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _setupAppOnStartAction");

    try {
      final user = await userRepository.getAuthenticatedUser();
      store.dispatch(UpdateUserStateAction(user));
    } catch (e) {
      store.dispatch(UpdateUserStateAction(null));
    }

    var data = (action as SetupAppOnStartAction).link;
    try {
      String link = data == null ? await getInitialLink() : data;
      if (link != null) {
        next(ShowLoadingAction(true));
        final parsedLink = await remoteStorage.parseUrl(link);
        var mapper = LinksMapper();
        var appLink = mapper.mapLink(parsedLink);
        var linkNavigator = LinksNavigator();
        linkNavigator.navigate(appLink, store);

        logger.logInfo("parseUrl request success");
        next(ShowLoadingAction(false));
      } else if (store.state.loginState.isLoggedIn()) {
        store.dispatch(NavigateToMainScreenAction());
      } else {
        store.dispatch(ShowWelcomeOnBoardingAction(true));
      }
    } catch (e) {
      logger.logError("$action _setupAppOnStartAction ${e.toString()}");
      next(ShowLoadingAction(false));
      if (store.state.loginState.isLoggedIn()) {
        store.dispatch(NavigateToMainScreenAction());
      } else {
        store.dispatch(ShowWelcomeOnBoardingAction(true));
      }
      next(ErrorReportAction(
          where: "splash_screen_middleware",
          errorMessage: e.toString(),
          trigger: action.runtimeType));
    }
  };
}
