import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/redux/actions/app_state_actions.dart';
import 'package:totalfit/redux/actions/event_actions.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';

List<Middleware<AppState>> sessionMiddleware(RemoteStorage remoteStorage, TFLogger logger) {
  final onAppStateChanged = _onAppStateChangedAction(remoteStorage, logger);

  return [
    TypedMiddleware<AppState, OnAppStateChangedAction>(onAppStateChanged)
  ];
}

Middleware<AppState> _onAppStateChangedAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    final stateChangedAction = action as OnAppStateChangedAction;

    logger.logInfo("sessionMiddleware: onAppStateChangedAction: ${stateChangedAction.state}");
    if (stateChangedAction.state == AppLifecycleState.detached) {
      final duration = DateTime.now().millisecondsSinceEpoch - store.state.sessionState.startTime;
      next(SessionEndAction(duration));
    }

    if (stateChangedAction.state == AppLifecycleState.resumed &&
        !store.state.isPremiumUser()) {
      next(DiscountChangeValueAction(value: true));
    }

    next(action);
  };
}


