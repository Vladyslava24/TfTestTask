import 'package:flutter/foundation.dart';
import 'package:totalfit/model/workout_page_type.dart';
import 'package:totalfit/model/workout_voice_message.dart';

class PlayFinishExerciseSoundAction {}

class PlayStartExerciseAfterDelaySoundAction {}

class PlayMusicAction {
  final WorkoutPageType page;

  PlayMusicAction({@required this.page});
}

class ResumeMusicAction {
  final WorkoutPageType page;

  ResumeMusicAction({@required this.page});
}

class MusicStoppedAction {}

class MusicPausedAction {}

class VoiceStoppedAction {}

class VoicePausedAction {}

class VoiceResumedAction {}

class PlayVoiceAction {
  final WorkoutVoiceMessage voiceMessage;

  PlayVoiceAction({@required this.voiceMessage});
}

class SwitchAudioModeAction {}

class DisposeAudioService {}
