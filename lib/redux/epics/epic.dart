import 'package:redux_epics/redux_epics.dart';
import 'package:totalfit/domain/ab_test/ab_test_service.dart';
import 'package:totalfit/redux/epics/deep_links_epic.dart';
import 'package:totalfit/redux/epics/purchase_epic.dart';
import 'package:totalfit/redux/epics/push_notificaions_epic.dart';
import 'package:totalfit/redux/epics/app_tracking_epic.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:workout_data/data.dart';

Epic<AppState> createEpics(ABTestService abTestService) {
  return combineEpics<AppState>([
    //++++ should we add epic for workout repository stream??? updateProgressEpic()
    appTrackingEpic(),
    deepLinksEpic(),
    purchaseEpic(),
    offeringsEpic(abTestService),
    pushNotificationsEpic(),
  ]);
}
