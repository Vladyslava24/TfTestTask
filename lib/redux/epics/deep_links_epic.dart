import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:totalfit/redux/actions/app_state_actions.dart';
import 'package:totalfit/redux/actions/deep_link_actions.dart';
import 'package:totalfit/redux/actions/reset_password_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:uni_links/uni_links.dart';
import 'package:rxdart/rxdart.dart';

Epic<AppState> deepLinksEpic() {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions
    .whereType<OnAppStateChangedAction>()
    .switchMap((action) => _handlerActions(action))
    .takeUntil(actions.whereType<CompletedPasswordChanges>());
  };
}

_handlerActions(OnAppStateChangedAction action) async* {
  if (action.state == AppLifecycleState.resumed) {
    final link = await getInitialLink();
    if (link != null) {
      yield SetCurrentDeepLinkAction(deepLink: link);
    }
  }
}
