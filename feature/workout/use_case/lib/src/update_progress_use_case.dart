import 'dart:async';

import 'package:core/core.dart';
import 'package:workout_data/data.dart';
import 'package:workout_use_case/src/model/update_progress_payload.dart';

abstract class UpdateProgressUseCase {
  Future<Result<UpdateProgressNewResponse>> updateProgress(
      UpdateProgressPayload payload);

  Future<Result<UpdateProgressNewResponse>> updatePriorityStage();

  StreamController<dynamic> workoutFinishStream();
}
