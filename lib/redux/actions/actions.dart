import 'dart:convert';

import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/model/active_program.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';

class OnProgramUpdatedAction extends TrackableAction {
  final ActiveProgram program;

  OnProgramUpdatedAction(this.program);

  @override
  Event event() => Event.PROGRAM_EDITED;

  @override
  Map<String, String> parameters() => {
        "programId": program.id,
        "numberOfWeeks": program.numberOfWeeks.toString(),
        "name": program.name,
        "daysOfTheWeek": json.encode(program.daysOfTheWeek),
        "daysAWeek": program.daysAWeek.toString(),
        "difficultyLevel": program.difficultyLevel,
      };
}

class OnProgramInterruptedAction extends TrackableAction {
  final String programId;

  OnProgramInterruptedAction(this.programId);

  @override
  Event event() => Event.PROGRAM_INTERRUPTED;

  @override
  Map<String, String> parameters() => {"programId": programId};
}

class OnNewFeatureShownAction {
  final int featureHash;

  OnNewFeatureShownAction(this.featureHash);
}
