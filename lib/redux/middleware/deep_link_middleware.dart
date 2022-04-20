import 'package:core/core.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/redux/actions/deep_link_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/splash/links_mapper.dart';
import 'package:totalfit/ui/screen/splash/links_navigation.dart';

List<Middleware<AppState>> deepLinkMiddleware(RemoteStorage remoteStorage, TFLogger logger) {
  final deepLinkMiddleware = _deepLinkMiddleware(remoteStorage, logger);

  return [
    TypedMiddleware<AppState, SetCurrentDeepLinkAction>(deepLinkMiddleware)
  ];
}

Middleware<AppState> _deepLinkMiddleware(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo(action.toString());
    next(action);
    final result = action as SetCurrentDeepLinkAction;
    final parsedLink = await remoteStorage.parseUrl(result.deepLink);
    final mapper = LinksMapper();
    final appLink = mapper.mapLink(parsedLink);
    final linkNavigator = LinksNavigator();

    linkNavigator.navigate(appLink, store);
  };
}