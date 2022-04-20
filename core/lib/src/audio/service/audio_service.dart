import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:core/core.dart';
import 'package:just_audio/just_audio.dart';

/*
*  Class use package just_audio and audio_session
*  for play sounds.
*/
class AudioService {
  static const String tag = "TFAudioService";
  static AudioService? _instance;

  factory AudioService(TFLogger logger) => _instance ??= AudioService._(logger);

  late AudioPlayer _soundPlayer;
  late AudioSession _audioSession;
  late TFLogger _logger;

  AudioService._(TFLogger logger) {
    _initSoundPlayer();
    _logger = logger;
  }

  Future<void> _initSoundPlayer() async {
    _soundPlayer = AudioPlayer();
    _audioSession = await AudioSession.instance;
    await _audioSession.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.music,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.media,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
      androidWillPauseWhenDucked: true,
    ));
  }

  Future playSound(String fileName) async {
    _logger.logInfo('$tag play sound $fileName');
    try {
      await _soundPlayer.setAsset('assets/sounds/$fileName', preload: true);
      await _soundPlayer.play();
    } catch (e) {
      print('$tag error: $e');
    }
  }

  Future<void> stopSound() async {
    _logger.logInfo('$tag stop sound');
    return _soundPlayer.dispose();
  }

  void dispose() {
    _logger.logInfo('dispose $tag service');
    stopSound();
  }
}