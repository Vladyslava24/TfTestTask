import 'package:flutter/foundation.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';

class OnHideWorkoutQuestionTipAction {}

class OnHideAmrapFinishTipAction {}

class OnHideWorkoutOnboardingAction {}

class UpdateShowHexagonOnBoardingAction extends TrackableAction{
  final bool status;
  UpdateShowHexagonOnBoardingAction({@required this.status});

  @override
  Event event() => Event.SAW_HEXAGON_ONBOARDING;
}
