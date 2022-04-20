import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/services.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/src/transformers/switch_map.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';

Epic<AppState> updateProgressEpic() {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.switchMap((action) => _handlerActions(action));
  };
}

_handlerActions(action) async* {
  if (action is NavigateToEntryScreenAction && Platform.isIOS ||
      action is NavigateToMainScreenAction && Platform.isIOS) {
    await _initAppTracking();
  }
}

_initAppTracking () async {
  try {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  } on PlatformException catch(e) {
    print('error: $e');
  }
}
